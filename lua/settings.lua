-- Set leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation settings
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4      -- Number of spaces that a tab counts for
vim.opt.softtabstop = 4  -- Number of spaces for tab in insert mode
vim.opt.shiftwidth = 4   -- Number of spaces for each step of autoindent

-- Editor behavior
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.number = true             -- Show absolute line number on current line
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.textwidth = 120           -- Automatically wrap text at 120 characters
vim.opt.conceallevel = 1          -- Conceal level for special characters
vim.opt.ignorecase = true         -- Ignore case in search patterns
vim.opt.smartcase = true          -- Override ignore case if search contains uppercase
vim.opt.scrolloff = 8             -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8         -- Keep 8 columns visible left/right of cursor

-- Auto format on save for various file types
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.js", "*.ts", "*.md", "*.rs", "*.c", "*.toml", "*.yaml", "*.py" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- Enable Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- File explorer keymap (netrw)
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })

-- Last File
vim.keymap.set("n", "<leader>l", "<C-^>")
