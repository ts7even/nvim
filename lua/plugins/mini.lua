-- Mini.nvim configuration - text manipulation only
return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			-- Mini.pairs - replaces nvim-autopairs
			require("mini.pairs").setup({
				-- Custom pairs for comments in various languages
				modes = { insert = true, command = false, terminal = false },
				mappings = {
					["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
					["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
					["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },
					[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
					["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
					["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
					['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
					["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
					["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
				},
			})

			-- Mini.surround - replaces nvim-surround
			require("mini.surround").setup({
				-- Add custom surroundings
				custom_surroundings = {
					-- Custom /* */ comment surround for programming languages
					c = {
						input = { "/%*", "%*/" },
						output = { left = "/* ", right = " */" },
					},
				},
				-- Key mappings
				mappings = {
					add = "sa", -- Add surrounding in Normal and Visual modes
					delete = "sd", -- Delete surrounding
					find = "sf", -- Find surrounding (to the right)
					find_left = "sF", -- Find surrounding (to the left)
					highlight = "sh", -- Highlight surrounding
					replace = "sr", -- Replace surrounding
					update_n_lines = "sn", -- Update `n_lines`
				},
			})

			-- Mini.comment for commenting functionality
			require("mini.comment").setup({
				-- Options for different comment styles
				options = {
					custom_commentstring = nil,
					ignore_blank_line = false,
					pad_comment_parts = true,
					start_of_line = false,
				},
				-- Module mappings
				mappings = {
					comment = 'gc',
					comment_line = 'gcc',
					comment_visual = 'gc',
					textobject = 'gc',
				},
			})

			-- Mini.indentscope for indentation guides (disabled)
			-- require("mini.indentscope").setup({
			-- 	-- Draw options
			-- 	draw = {
			-- 		delay = 100,
			-- 		animation = require("mini.indentscope").gen_animation.none(),
			-- 	},
			-- 	-- Module mappings
			-- 	mappings = {
			-- 		object_scope = 'ii',
			-- 		object_scope_with_border = 'ai',
			-- 		goto_top = '[i',
			-- 		goto_bottom = ']i',
			-- 	},
			-- 	-- Options for scope computation
			-- 	options = {
			-- 		border = 'both',
			-- 		indent_at_cursor = true,
			-- 		try_as_border = false,
			-- 	},
			-- 	-- Symbol to use for drawing scope indicator
			-- 	symbol = '╎',
			-- })

			-- Mini.files for file explorer functionality
			require("mini.files").setup({
				-- Customization of explorer behavior
				content = {
					filter = nil, -- Predicate for which file system entries to show
					prefix = nil, -- What prefix to show to the left of file system entry
					sort = nil, -- In which order to show file system entries
				},
				-- Module mappings created only inside explorer
				mappings = {
					close = '<Esc>', -- Use Esc to close
					go_in = '<CR>', -- Enter to go into directory
					go_in_plus = 'L',
					go_out = 'h',
					go_out_plus = 'H',
					reset = '<BS>',
					reveal_cwd = '@',
					show_help = 'g?',
					synchronize = '=',
					trim_left = '<',
					trim_right = '>',
				},
				options = {
					permanent_delete = true,
					use_as_default_explorer = false,
				},
				windows = {
					max_number = math.huge,
					preview = false,
					width_focus = 25,
					width_nofocus = 15,
					width_preview = 25,
				},
			})

			-- Add custom keymaps for mini.files navigation
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Use Tab to navigate between files
					vim.keymap.set("n", "<Tab>", function()
						vim.cmd("normal! j")
					end, { buffer = buf_id })
					vim.keymap.set("n", "<S-Tab>", function()
						vim.cmd("normal! k")
					end, { buffer = buf_id })
				end,
			})

			-- File explorer keymap
			vim.keymap.set("n", "<leader>e", function()
				require("mini.files").open()
			end, { desc = "Open file explorer" })
		end,
	},
}