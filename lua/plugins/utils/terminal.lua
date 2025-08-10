return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				size = 20,
				open_mapping = [[<c-\>]],
				hide_numbers = true,
				shade_filetypes = {},
				shade_terminals = true,
				shading_factor = 2,
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				direction = "float",
				close_on_exit = true,
				shell = vim.o.shell,
				float_opts = {
					border = "curved",
					winblend = 0,
					highlights = {
						border = "Normal",
						background = "Normal",
					},
				},
			})

			-- Floating terminal keymap
			vim.keymap.set(
				"n",
				"<leader>t",
				"<cmd>ToggleTerm direction=float<cr>",
				{ desc = "Toggle floating terminal" }
			)

			-- Terminal-specific keymaps
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				-- Exit terminal mode with escape
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			end

			-- Apply terminal keymaps when opening terminal
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
