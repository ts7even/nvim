return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- NOTE: Options
		opts = {
			-- Snacks Modules
			input = {
				enabled = true,
			},
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
			picker = {
				enabled = true,
				select = {
					enabled = true,
				},
				matchers = {
					frecency = true,
					cwd_bonus = false,
				},
				formatters = {
					file = {
						filename_first = false,
						filename_only = false,
						icon_width = 2,
					},
				},
				layout = {
					preset = "telescope",
					cycle = false,
				},
				layouts = {
					select = {
						preview = false,
						layout = {
							backdrop = false,
							width = 0.6,
							min_width = 80,
							height = 0.4,
							min_height = 10,
							box = "vertical",
							border = "rounded",
							title = "{title}",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
						},
					},
					telescope = {
						reverse = true, -- set to false for search bar to be on top
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.8,
							height = 0.9,
							border = "none",
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.50,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							width = 0,
							height = 0.4,
							position = "bottom",
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "bottom" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
							},
						},
					},
				},
			},
			image = {
				enabled = true,
				doc = {
					float = true, -- show image on cursor hover
					inline = false, -- show image inline
					max_width = 50,
					max_height = 30,
					wo = {
						wrap = false,
					},
				},
				convert = {
					notify = true,
					command = "magick",
				},
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments",
					"Archives/All-Vault-Images/",
					"~/Library",
					"~/Downloads",
				},
			},
			dashboard = {
				enabled = true,
				width = 60,
				preset = {
					header = [[
           O          
          _|_         
   ,_.-_' _ '_-._,  
    \ (.)(.)(.) /   
 _,  `\_-===-_/`  ,_
>  |----"""""----|  <
`""`--/   _-@-\--`""`
     |===L_I===|    
      \       /     
      _\__|__/_     
     `""""`""""`    
]],
				},
				sections = {
					{ section = "header" },
				},
			},
			terminal = {
				enabled = true,
				start_insert = false, -- Don't start in insert mode when creating terminal
				auto_insert = false, -- Don't enter insert mode when entering the terminal buffer
				win = {
					keys = {
						-- Custom terminal keybinds
						["<C-/>"] = "hide", -- Ctrl+/ to hide terminal (common shortcut)
						term_normal = {
							"<esc>",
							function(self)
								vim.cmd("stopinsert")
							end,
							mode = "t",
							desc = "Escape to normal mode",
						},
					},
				},
			},
		},
		-- Keybindings defined outside of opts to avoid conflicts,
	keys = {
		-- Snacks Picker
		{
			"<leader>e",
			function()
				-- Include hidden files only for explorer
				Snacks.explorer({ hidden = true })
			end,
			desc = "Find Files (Snacks Picker)",
		},

			{
				"<leader>ff",
				function()
					Snacks.picker.files({
						-- Only tab for up and down instead of select
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_up", mode = { "i", "n" } },
									["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Find Files (Snacks Picker)",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep({
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_up", mode = { "i", "n" } },
									["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Grep word",
			},
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers({
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_up", mode = { "i", "n" } },
									["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Find Buffers",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.recent({
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_up", mode = { "i", "n" } },
									["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Recent Files",
			},
			{ -- Search instances of word
				"<leader>sw",
				function()
					Snacks.picker.grep_word({
						win = {
							input = {
								keys = {
									["<Tab>"] = { "list_up", mode = { "i", "n" } },
									["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
				desc = "Search Visual Selection or Word",
				mode = { "n", "x" },
			},
			{
				"<leader>pk",
				function()
					Snacks.picker.keymaps({ layout = "ivy" })
				end,
				desc = "Search Keymaps (Snacks Picker)",
			},
			{
				"<leader>qf",
				function()
					Snacks.picker.qflist()
				end,
				desc = "Quickfix List (Snacks Picker)",
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "Lazygit",
			},
			{
				"<leader>gl",
				function()
					Snacks.lazygit.log()
				end,
				desc = "Lazygit Logs",
			},
			-- Git Stuff
			{
				"<leader>gbr",
				function()
					Snacks.picker.git_branches({ layout = "select" })
				end,
				desc = "Pick and Switch Git Branches",
			},
			-- Utilities
			{
				"<leader>t",
				function()
					Snacks.terminal()
				end,
				desc = "Toggle Terminal",
			},
			{ -- Might delete this 
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
		},
	},
}
