-- Directory of the current buffer (falls back to cwd for unnamed buffers).
local function buf_dir()
    local name = vim.api.nvim_buf_get_name(0)
    local d = name ~= "" and vim.fn.fnamemodify(name, ":p:h") or vim.fn.getcwd()
    if vim.fn.isdirectory(d) == 1 then return d end
    return vim.fn.getcwd()
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        { "<C-\\>",     function() require("toggleterm").toggle(0, nil, nil, "horizontal") end, mode = { "n", "t" }, desc = "Toggle Terminal" },
        { "<leader>tt", function()
            local buf = vim.g._term_buf
            -- Currently showing the terminal? hide it (back to previous buffer).
            if buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
                if vim.fn.bufnr("#") ~= -1 then
                    vim.cmd("buffer #")
                else
                    vim.cmd("enew")
                end
                return
            end
            -- Exists but hidden? show it in the current window.
            if buf and vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_win_set_buf(0, buf)
                vim.cmd("startinsert")
                return
            end
            -- Create it.
            vim.cmd("terminal")
            vim.g._term_buf = vim.api.nvim_get_current_buf()
            vim.cmd("startinsert")
        end, desc = "Toggle Terminal (buffer)" },
        { "<leader>tn", function()
            local Terminal = require("toggleterm.terminal")
            local terms = Terminal.get_all()
            -- Find direction of currently open terminal, close it first
            local dir = "horizontal"
            for _, t in ipairs(terms) do
                if t:is_open() then
                    dir = t.direction or "horizontal"
                    t:close()
                    break
                end
            end
            -- Create next terminal (find highest number + 1)
            local next_id = 1
            for _, t in ipairs(terms) do
                if t.id >= next_id then next_id = t.id + 1 end
            end
            require("toggleterm").toggle(next_id, nil, nil, dir)
        end, desc = "New Terminal" },
        { "<leader>tl", function()
            local Terminal = require("toggleterm.terminal")
            local terms = Terminal.get_all()
            if #terms == 0 then
                vim.notify("No terminals open", vim.log.levels.INFO)
                return
            end
            local items = {}
            for _, t in ipairs(terms) do
                local dir = t.direction or "horizontal"
                table.insert(items, {
                    text = (t.display_name or ("Terminal " .. t.id)) .. " [" .. dir .. "]",
                    id = t.id,
                    dir = dir,
                    name = t.display_name or ("Terminal " .. t.id),
                })
            end
            Snacks.picker.pick({
                title = "Terminals",
                items = items,
                format = function(item)
                    return {
                        { item.name .. "  ", "SnacksPickerLabel" },
                        { "[" .. item.dir .. "]", "SnacksPickerComment" },
                    }
                end,
                confirm = function(picker, item)
                    picker:close()
                    if item then
                        -- Close any currently open terminal first
                        for _, t in ipairs(Terminal.get_all()) do
                            if t:is_open() then t:close() end
                        end
                        local term = Terminal.get(item.id)
                        if term then term:open() end
                    end
                end,
            })
        end, desc = "List Terminals" },
        { "<leader>tr", function()
            vim.ui.input({ prompt = "Rename terminal: " }, function(name)
                if not name or name == "" then return end
                -- Find the currently visible terminal
                local terms = require("toggleterm.terminal").get_all()
                for _, t in ipairs(terms) do
                    if t:is_open() then
                        t.display_name = name
                        vim.notify("Terminal renamed to: " .. name, vim.log.levels.INFO)
                        return
                    end
                end
            end)
        end, desc = "Rename Terminal" },
        { "<leader>td", function()
            -- Kill the currently open managed terminal (process + buffer).
            local terms = require("toggleterm.terminal").get_all()
            for _, t in ipairs(terms) do
                if t:is_open() then
                    local name = t.display_name or ("Terminal " .. t.id)
                    t:shutdown()
                    vim.notify("Deleted " .. name, vim.log.levels.INFO)
                    return
                end
            end
            vim.notify("No open terminal to delete", vim.log.levels.WARN)
        end, desc = "Delete Terminal" },
        -- Standalone vertical terminal: NOT managed by toggleterm, not part of the tab ecosystem
        { "<leader>tv", function()
            local dir = buf_dir()
            local buf = vim.g._vertical_term_buf
            if buf and vim.api.nvim_buf_is_valid(buf) then
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    if vim.api.nvim_win_get_buf(win) == buf then
                        vim.api.nvim_win_close(win, false)
                        return
                    end
                end
                vim.cmd("vsplit")
                vim.api.nvim_win_set_buf(0, buf)
                local chan = vim.bo[buf].channel
                if chan and chan > 0 then
                    vim.fn.chansend(chan, "cd " .. vim.fn.shellescape(dir) .. "\n")
                end
                vim.cmd("startinsert")
                return
            end
            vim.cmd("vsplit")
            vim.cmd("lcd " .. vim.fn.fnameescape(dir))
            vim.cmd("terminal")
            local new_buf = vim.api.nvim_get_current_buf()
            vim.bo[new_buf].bufhidden = "hide"
            vim.g._vertical_term_buf = new_buf
            vim.cmd("startinsert")
        end, desc = "Terminal (vertical, standalone)" },
        { "<leader>th", function()
            local dir = buf_dir()
            local terms = require("toggleterm.terminal").get_all()
            for _, t in ipairs(terms) do
                if t:is_open() then
                    vim.g._last_horizontal_term = t.id
                    t:close()
                    return
                end
            end
            local last = vim.g._last_horizontal_term or 99
            local term = require("toggleterm.terminal").get(last)
            if term then
                term:open()
                term:change_dir(dir)
            else
                require("toggleterm").toggle(last, nil, dir, "horizontal")
            end
        end, desc = "Terminal (horizontal)" },
        -- Cycle terminals
        { "<leader>t]", function()
            local terms = require("toggleterm.terminal").get_all()
            if #terms <= 1 then return end
            -- Find current open terminal
            local current_idx = nil
            for i, t in ipairs(terms) do
                if t:is_open() then current_idx = i break end
            end
            if not current_idx then return end
            local next_idx = (current_idx % #terms) + 1
            terms[current_idx]:close()
            terms[next_idx]:open()
        end, desc = "Next Terminal" },
        { "<leader>t[", function()
            local terms = require("toggleterm.terminal").get_all()
            if #terms <= 1 then return end
            local current_idx = nil
            for i, t in ipairs(terms) do
                if t:is_open() then current_idx = i break end
            end
            if not current_idx then return end
            local prev_idx = ((current_idx - 2) % #terms) + 1
            terms[current_idx]:close()
            terms[prev_idx]:open()
        end, desc = "Prev Terminal" },
    },
    opts = {
        size = function(term)
            if term.direction == "horizontal" then
                return math.floor(vim.o.lines * 0.45)
            elseif term.direction == "vertical" then
                return math.floor(vim.o.columns * 0.5)
            end
        end,
        shade_terminals = false,
        start_in_insert = true,
        persist_size = true,
        persist_mode = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved",
        },
        winbar = {
            enabled = true,
            name_formatter = function(term)
                return term.display_name or ("Terminal " .. term.id)
            end,
        },
    },
}
