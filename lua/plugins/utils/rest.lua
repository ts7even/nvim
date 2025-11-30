return {
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		config = function()
			require("kulala").setup({
				default_view = "body",
				default_env = "dev",
				debug = false,
			})

			-- Custom function to open HTTP files directory in a new tab
			vim.keymap.set("n", "<leader>rh", function()
				-- Get the project root or use a default path
				local http_dir = vim.fn.getcwd() .. "/api"

				-- Check if directory exists, fallback to static/
				if vim.fn.isdirectory(http_dir) == 0 then
					http_dir = vim.fn.stdpath("config") .. "/static"
				end

				-- Open new tab with netrw file browser
				vim.cmd("tabnew")
				vim.cmd("lcd " .. http_dir)
				vim.cmd("e .")
			end, { desc = "Open HTTP files in new tab" })
		end,
		keys = {
			{ "<leader>rr", function() require("kulala").run() end, desc = "Send request", ft = { "http", "rest" } },
			{ "<leader>ra", function() require("kulala").run_all() end, desc = "Send all requests", ft = { "http", "rest" } },
			{ "<leader>rl", function() require("kulala").replay() end, desc = "Replay last request", ft = { "http", "rest" } },
			{ "<leader>ri", function() require("kulala").inspect() end, desc = "Inspect request", ft = { "http", "rest" } },
			{ "<leader>rt", function() require("kulala").toggle_view() end, desc = "Toggle body/headers", ft = { "http", "rest" } },
			{ "<leader>rh", desc = "Open HTTP files directory" }, -- Defined in config
		},
	},
}

