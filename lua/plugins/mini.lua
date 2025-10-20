return {
	{
		"echasnovski/mini.nvim",
		version = "*",
		lazy = false, -- Load immediately to avoid lag
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

			-- Mini.extra for additional pickers including spelling
			require("mini.extra").setup()
		end,
		keys = {
			{
				"<leader>ss",
				function()
					require("mini.extra").pickers.spellsuggest(
						{ n_suggestions = 5 },
						{ window = { config = { height = 7, width = 40 } } }
					)
				end,
				desc = "Spelling Suggestions",
			},
		},
	}
}
