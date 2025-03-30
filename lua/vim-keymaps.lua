-- Optionally, you can show all diagnostics in a floating window for the current line
vim.keymap.set('n', '<leader>el', vim.diagnostic.open_float, { noremap = true, silent = true })

-- Optionally, you can set up a keybinding to show the list of all diagnostics (e.g., in the quickfix list)
vim.keymap.set('n', '<leader>ef', vim.diagnostic.setqflist, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>a', '<Plug>RustHoverAction')

