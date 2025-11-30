return {
	-- Markdown LSP
	{
		"neovim/nvim-lspconfig",
		ft = "markdown",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config.marksman({
				capabilities = capabilities,
				filetypes = { "markdown", "markdown.mdx" },
			})
		end,
	},

	-- Markdown Formatter
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = function(_, opts)
			opts.formatters_by_ft = opts.formatters_by_ft or {}
			opts.formatters_by_ft.markdown = { "prettier" }

			-- Prettier config shared with javascript.lua
			opts.formatters = opts.formatters or {}
			opts.formatters.prettier = opts.formatters.prettier or {
				prepend_args = {
					"--tab-width",
					"2",
					"--use-tabs",
					"false",
					"--print-width",
					"81",
					"--prose-wrap",
					"always",
					"--embedded-language-formatting",
					"auto",
					"--single-attribute-per-line",
					"false",
				},
			}
		end,
	},

	-- Markdown rendering
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

	-- Markdown folding - uses syntax-based folding that works with render-markdown
	{
		"preservim/vim-markdown",
		ft = { "markdown" },
		config = function()
			-- Disable all features except folding
			vim.g.vim_markdown_folding_disabled = 0 -- Enable folding
			vim.g.vim_markdown_folding_style_pythonic = 1 -- Python-style folding
			vim.g.vim_markdown_override_foldtext = 0
			vim.g.vim_markdown_folding_level = 6 -- Fold all heading levels
			
			-- Disable other features to avoid conflicts with render-markdown
			vim.g.vim_markdown_conceal = 0
			vim.g.vim_markdown_conceal_code_blocks = 0
			vim.g.vim_markdown_frontmatter = 1
			vim.g.vim_markdown_no_default_key_mappings = 1
			
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function()
					vim.opt_local.foldmethod = "expr"
					vim.opt_local.foldexpr = "MarkdownFold()"
					vim.opt_local.foldenable = true
					vim.opt_local.foldlevel = 99 -- Start with all folds open
				end,
			})
		end,
	},
}
