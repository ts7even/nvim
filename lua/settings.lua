-- Set leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation settings
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 4 -- Number of spaces that a tab counts for
vim.opt.softtabstop = 4 -- Number of spaces for tab in insert mode
vim.opt.shiftwidth = 4 -- Number of spaces for each step of autoindent

-- Enable Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Editor behavior
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.number = true -- Show absolute line number on current line
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.textwidth = 81 -- Automatically wrap text at 120 characters
vim.opt.conceallevel = 1 -- Conceal level for special characters
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignore case if search contains uppercase
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
vim.opt.splitright = true -- Open vertical splits to the right
vim.opt.splitbelow = true -- Open horizontal splits below
vim.opt_local.colorcolumn = "100" -- Highlight column at 100 characters

-- Tab navigation with Ctrl + Alt + hl
vim.keymap.set('n', '<C-M-h>', 'gT', { desc = 'Previous tab' })
vim.keymap.set('n', '<C-M-l>', 'gt', { desc = 'Next tab' })

-- Reload Neovim config
vim.keymap.set('n', '<leader>cr', ':source $MYVIMRC<CR>', { desc = 'Reload config' })

-- Auto format on save for various file types
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.js", "*.ts", "*.md", "*.rs", "*.c", "*.toml", "*.yaml", "*.py", "*.org" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

