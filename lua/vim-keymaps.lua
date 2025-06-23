-- Optionally, you can show all diagnostics in a floating window for the current line
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { noremap = true, silent = true })

-- Optionally, you can set up a keybinding to show the list of all diagnostics (e.g., in the quickfix list)
vim.keymap.set("n", "<leader>df", vim.diagnostic.setqflist, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>a", "<Plug>RustHoverAction")

-- Keymaps for Copilot
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Copilot Enable" })
vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Copilot Disable" })
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
vim.keymap.set("v", "<leader>cq", ":CopilotChatVisual<CR>", { desc = "Ask Copilot (Visual)" })
vim.keymap.set("n", "<leader>cq", ":CopilotChat<CR>", { desc = "Ask Copilot (Prompt)" })
