-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation
-- Global default: 4 spaces (Python, C/C++, Lua, Rust, ...).
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Per-filetype indent width while editing. These match the on-save formatter
-- output (e.g. prettier uses --tab-width 2) so manual indent and saved files
-- agree. Filetypes not listed fall back to the 4-space default above.
local indent_by_ft = {
    json = 2,
    jsonc = 2,
    yaml = 2,
    html = 2,
    css = 2,
    svelte = 2,
    javascript = 2,
    typescript = 2,
}
vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.tbl_keys(indent_by_ft),
    callback = function(ev)
        local width = indent_by_ft[vim.bo[ev.buf].filetype]
        vim.bo[ev.buf].tabstop = width
        vim.bo[ev.buf].softtabstop = width
        vim.bo[ev.buf].shiftwidth = width
    end,
})

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Editor behavior
vim.opt.relativenumber = true
vim.opt.number = true
-- Allows you to use clipboard in ssh
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 1
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.foldenable = false -- Don't auto-fold files
vim.opt.autoread = true    -- Auto-reload files changed outside of Neovim
vim.opt.cmdheight = 0
vim.g.markdown_folding = 1

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
        vim.bo[ev.buf].textwidth = 80
        -- Align the table under the cursor on demand (loads vim-table-mode).
        vim.keymap.set("n", "<leader>mt", "<cmd>TableModeRealign<cr>",
            { buffer = ev.buf, desc = "Align markdown table" })
    end,
})

-- Zig: `zig fmt` never reflows comments/doc comments (//, ///, //!), so wrap
-- them in the editor instead. textwidth + the `c` flag (already in
-- formatoptions) auto-wraps comments while typing. Clearing formatexpr makes
-- `gq` use Vim's built-in comment reflow instead of routing to zig fmt.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "zig",
    callback = function(ev)
        vim.bo[ev.buf].textwidth = 80
        vim.bo[ev.buf].formatexpr = ""
    end,
})

-- Tab navigation
vim.keymap.set("n", "<C-M-h>", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "<C-M-l>", "gt", { desc = "Next tab" })

-- Terminal: escape to normal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Command-line completion: make the native wildmenu feel like a file browser
-- (Doom/ido style). With ':e ~/' press <Tab> once to open the popup, then:
--   <Up>/<Down> : cycle through the entries in the current directory
--   <Tab>       : descend into the highlighted directory and list it
--   <Up> at the top / continued typing narrows as usual
-- The mappings only take effect while the wildmenu is open; outside of it the
-- arrows still do command-line history and <Tab> still opens the menu.
-- 'wildcharm' lets a <Tab> emitted *from a mapping* trigger completion (the
-- live <Tab> key uses 'wildchar'); without it the mapped <Tab> inserts ^I.
vim.o.wildcharm = vim.fn.char2nr("\t")
local function wild(active, inactive)
    return function()
        return vim.fn.wildmenumode() == 1 and active or inactive
    end
end
vim.keymap.set("c", "<Down>", wild("<C-n>", "<Down>"), { expr = true })
vim.keymap.set("c", "<Up>", wild("<C-p>", "<Up>"), { expr = true })
vim.keymap.set("c", "<Tab>", wild("<Down>", "<Tab>"), { expr = true })

-- Spell suggestions: small floating window, bottom-left, 5 choices
vim.keymap.set("n", "<leader>ss", function()
    local word = vim.fn.expand("<cword>")
    local suggestions = vim.fn.spellsuggest(word, 5)
    if #suggestions == 0 then
        vim.notify("No suggestions for: " .. word, vim.log.levels.WARN)
        return
    end
    vim.ui.select(suggestions, {
        prompt = "Spelling: " .. word,
    }, function(choice)
        if choice then
            vim.cmd("normal! ciw" .. choice)
            vim.cmd("stopinsert")
        end
    end)
end, { desc = "Spelling suggestions" })


-- Projects / bookmarks, shared with Emacs via ~/.projects and ~/.bookmarks
-- (see lua/paths.lua)
vim.api.nvim_create_user_command("ProjectAdd", function()
    require("paths").add_interactive("projects", vim.fn.getcwd())
end, { desc = "Append cwd to ~/.projects" })
vim.api.nvim_create_user_command("BookmarkAdd", function()
    require("paths").add_interactive("bookmarks", vim.fn.expand("%:p"))
end, { desc = "Append the current file to ~/.bookmarks" })


-- Activate Python Virtual Environment
vim.api.nvim_create_user_command("VenvActivate", function(opts)
  local path = opts.args ~= "" and opts.args or (vim.fn.getcwd() .. "/.venv")
  local venv = require("venv")
  if venv.activate(path) then
    print("Activated " .. path)
  else
    print("No venv at " .. path .. " (deactivated the previous one)")
  end
  venv.restart_python_lsp()
end, { nargs = "?", complete = "dir" })


-- Scratch buffer: like :enew | set filetype=<ft>, e.g. :Scratch json
vim.api.nvim_create_user_command("Scratch", function(opts)
  vim.cmd("enew")
  if opts.args ~= "" then
    vim.bo.filetype = opts.args
  end
end, { nargs = "?", complete = "filetype", desc = "Open a scratch buffer (optional filetype)" })


-- Print Directory Path
vim.keymap.set('n', '<leader>ud', function()
  local dir = vim.fn.expand('%:p:h')
  vim.fn.setreg('+', dir)        -- yank to system clipboard
  print(dir)                      -- also show it
end, { desc = 'Copy file directory' })

