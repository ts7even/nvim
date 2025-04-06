vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.cmd("set textwidth=80") -- Automatically wrap text at 80 characters
-- vim.cmd("set formatoptions+=a") -- Auto-wrap paragraphs in Insert mode
-- vim.opt_local.conceallevel = 2
vim.opt.conceallevel = 1 -- This is for obsidian.lua -- Wired stuff happening
-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.js", "*.ts", "*.md","*.rs","*.c","*.toml","*.yaml","*.py"}, -- add filetypes as needed
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
