return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		ft = { "markdown" },
		config = function()
			require("render-markdown").setup({
				-- Enable rendering by default
				enabled = true,
				-- Auto-enable when opening markdown files
				start_enabled = true,
				-- Maximum file size to render (in MB)
				max_file_size = 10.0,
				-- Render only in normal and visual modes (not insert mode)
				render_modes = { "n", "v" }, -- Normal and visual modes only
				-- Anti-conceal settings
				anti_conceal = {
					enabled = true,
				},
				-- Heading settings
				heading = {
					enabled = true,
					sign = true,
					icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
				},
				-- Code block settings
				code = {
					enabled = true,
					sign = true,
					style = "full",
					width = "full",
				},
				-- Checkbox settings
				checkbox = {
					enabled = true,
					unchecked = { icon = "󰄱 " },
					checked = { icon = "󰱒 " },
				},
				-- Bullet point settings
				bullet = {
					enabled = true,
					icons = { "●", "○", "◆", "◇" },
				},
			})
		end,
	},

	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

			-- Peek markdown preview keymaps
			vim.keymap.set("n", "<leader>mp", ":PeekOpen<CR>", { desc = "Markdown preview open" })
			vim.keymap.set("n", "<leader>mc", ":PeekClose<CR>", { desc = "Markdown preview close" })
		end,
	},
}
