-- Terminals: three independent, single-instance terminals built on the
-- built-in :terminal. Each mapping owns exactly one buffer:
--
--   <leader>th  horizontal split (bottom)
--   <leader>tv  vertical split (right)
--   <leader>tt  current window (no split)
--
-- Pressing a mapping opens its terminal, focuses it if it is visible but not
-- focused, and hides it (process keeps running) when it is focused. They never
-- share a buffer with each other, and terminals opened by hand with :terminal
-- are never touched by these mappings.
--
-- Every terminal starts in the editor's root directory (the global :pwd), not
-- the directory of the current buffer.

local M = {}

-- slot name -> bufnr of the terminal that slot owns
local terms = {}

-- Global cwd, ignoring any window-local :lcd.
local function root()
    return vim.fn.getcwd(-1, -1)
end

-- Window in the current tab page displaying `buf`, if any.
local function win_of(buf)
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(win) == buf then return win end
    end
end

-- Terminal buffers get no line numbers, no sign column and no spell check.
local function dress_window(win)
    vim.wo[win].number = false
    vim.wo[win].relativenumber = false
    vim.wo[win].signcolumn = "no"
    vim.wo[win].spell = false
end

-- Open the window a slot lives in. "window" reuses the current one.
local function open_window(slot)
    if slot == "horizontal" then
        vim.cmd("botright split")
        vim.api.nvim_win_set_height(0, math.max(math.floor(vim.o.lines * 0.35), 8))
    elseif slot == "vertical" then
        vim.cmd("botright vsplit")
        vim.api.nvim_win_set_width(0, math.max(math.floor(vim.o.columns * 0.4), 40))
    end
end

-- Leave the slot's window: close the split, or restore the previous buffer for
-- the full-window slot.
local function hide(slot, win)
    if slot == "window" then
        if vim.fn.bufnr("#") ~= -1 and vim.api.nvim_buf_is_valid(vim.fn.bufnr("#")) then
            vim.cmd("buffer #")
        else
            vim.cmd("enew")
        end
    elseif #vim.api.nvim_tabpage_list_wins(0) > 1 then
        vim.api.nvim_win_close(win, false)
    end
end

function M.toggle(slot)
    local buf = terms[slot]

    if buf and vim.api.nvim_buf_is_valid(buf) then
        local win = win_of(buf)
        if win == vim.api.nvim_get_current_win() then
            hide(slot, win)
            return
        end
        if win then
            vim.api.nvim_set_current_win(win)
        else
            open_window(slot)
            vim.api.nvim_win_set_buf(0, buf)
        end
        dress_window(0)
        vim.cmd("startinsert")
        return
    end

    open_window(slot)
    vim.cmd("enew")
    terms[slot] = vim.api.nvim_get_current_buf()
    vim.bo.bufhidden = "hide"
    vim.fn.jobstart({ vim.o.shell }, { term = true, cwd = root() })
    dress_window(0)
    vim.cmd("startinsert")
end

-- Kill the terminal in the current window, split and all.
function M.kill()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].buftype ~= "terminal" then
        vim.notify("Not in a terminal", vim.log.levels.WARN)
        return
    end
    M.close(buf)
end

-- Close every window showing `buf` and wipe it. Used by :TermClose too.
function M.close(buf)
    for slot, b in pairs(terms) do
        if b == buf then terms[slot] = nil end
    end
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == buf
            and #vim.api.nvim_tabpage_list_wins(vim.api.nvim_win_get_tabpage(win)) > 1 then
            vim.api.nvim_win_close(win, true)
        end
    end
    if vim.api.nvim_buf_is_valid(buf) then
        vim.api.nvim_buf_delete(buf, { force = true })
    end
end

-- Strip the editor chrome from any terminal buffer, hand-made ones included.
vim.api.nvim_create_autocmd({ "TermOpen", "BufWinEnter" }, {
    callback = function(ev)
        if vim.bo[ev.buf].buftype == "terminal" then
            dress_window(vim.api.nvim_get_current_win())
        end
    end,
})

-- Shell exited: drop the buffer instead of leaving a dead [Process exited] one.
vim.api.nvim_create_autocmd("TermClose", {
    callback = function(ev)
        if terms.horizontal ~= ev.buf and terms.vertical ~= ev.buf and terms.window ~= ev.buf then
            return
        end
        vim.schedule(function() M.close(ev.buf) end)
    end,
})

vim.keymap.set("n", "<leader>th", function() M.toggle("horizontal") end, { desc = "Terminal (horizontal)" })
vim.keymap.set("n", "<leader>tv", function() M.toggle("vertical") end, { desc = "Terminal (vertical)" })
vim.keymap.set("n", "<leader>tt", function() M.toggle("window") end, { desc = "Terminal (window)" })
vim.keymap.set("n", "<leader>td", M.kill, { desc = "Kill terminal" })

vim.keymap.set("n", "<C-\\>", function() M.toggle("horizontal") end, { desc = "Terminal (horizontal)" })
vim.keymap.set("t", "<C-\\>", [[<C-\><C-n><Cmd>lua require("terminal").toggle("horizontal")<CR>]],
    { desc = "Terminal (horizontal)" })

return M
