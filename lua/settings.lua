-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Editor behavior
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 1
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt_local.colorcolumn = "100"
vim.opt.foldenable = false -- Don't auto-fold files
vim.opt.autoread = true    -- Auto-reload files changed outside of Neovim

-- Tab navigation
vim.keymap.set("n", "<C-M-h>", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "<C-M-l>", "gt", { desc = "Next tab" })

-- Terminal: escape to normal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Auto format on save (supported languages only)
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.lua", "*.c", "*.cpp", "*.h", "*.hpp",
        "*.py", "*.rs", "*.zig",
        "*.md", "*.toml", "*.yaml", "*.yml", "*.json",
    },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})
