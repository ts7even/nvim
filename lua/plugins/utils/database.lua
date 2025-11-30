return {
	{
		"tpope/vim-dadbod",
		lazy = true,
	},

	-- UI for vim-dadbod with connection management
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
			"kristijanhusak/vim-dadbod-completion",
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
		init = function()
			-- Database UI configuration
			vim.g.db_ui_use_nerd_fonts = 1 -- Use nerd fonts for icons
			vim.g.db_ui_show_database_icon = 1 -- Show database icons
			vim.g.db_ui_force_echo_notifications = 1 -- Force echo notifications
			vim.g.db_ui_win_position = "left" -- Position UI on the left
			vim.g.db_ui_winwidth = 40 -- Width of the UI window

			-- Auto-execute table helpers
			vim.g.db_ui_auto_execute_table_helpers = 1

			-- Save location for connections
			vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/static"

			-- Database completion setup
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "sql", "mysql", "plsql", "pgsql", "sqlite", "clickhouse", "duckdb" },
				callback = function()
					require("cmp").setup.buffer({
						sources = {
							{ name = "vim-dadbod-completion" },
							{ name = "buffer" },
							{ name = "nvim_lsp" },
						},
					})
				end,
			})

			-- Custom function to open DBUI in full window
			local function open_dbui_fullscreen()
				-- Open in a new tab to get full window
				vim.cmd("tabnew")
				vim.cmd("DBUI")
			end

			-- Database keymaps
			vim.keymap.set("n", "<leader>ddb", open_dbui_fullscreen, { desc = "Open Database UI in Full Window" })
			vim.keymap.set("n", "<leader>ddc", ":DBUIAddConnection<CR>", { desc = "Add Database Connection" })
			vim.keymap.set("n", "<leader>ddq", ":DBUIFindBuffer<CR>", { desc = "Find Database Buffer" })
		end,
	},

	-- Auto-completion for database queries
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = { "tpope/vim-dadbod" },
		lazy = true,
	},
}
