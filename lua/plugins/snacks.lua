return {
	-- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
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
				height = vim.o.lines - 8,
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{
						pane = 2,
						section = "terminal",
						cmd = "colorscript -e square",
						height = 3,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						desc = "Browse Repo",
						padding = 1,
						key = "b",
						action = function()
							Snacks.gitbrowse()
						end,
					},
					function()
						local in_git = Snacks.git.get_root() ~= nil
						local cmds = {
							{
								title = "Notifications",
								cmd = "gh status  ",
								action = function()
									vim.ui.open("https://github.com/notifications")
								end,
								key = "n",
								icon = " ",
								height = 3,
								enabled = true,
							},
							{
								title = "Issues",
								cmd = "gh issue list -L 2 --json title,number --template '{{range .}}#{{.number}} {{.title}}{{\"\\n\"}}{{end}}'",
								key = "i",
								action = function()
									vim.fn.jobstart("gh issue list --web", { detach = true })
								end,
								icon = " ",
								height = 3,
							},
							{
								icon = " ",
								title = "PRs",
								cmd = "gh pr list -L 2 --json title,number --template '{{range .}}#{{.number}} {{.title}}{{\"\\n\"}}{{end}}'",
								key = "P",
								action = function()
									vim.fn.jobstart("gh pr list --web", { detach = true })
								end,
								height = 3,
							},
							{
								icon = " ",
								title = "Git Status",
								cmd = "git --no-pager diff --stat -B -M -C | head -5",
								height = 4,
							},
						}
						return vim.tbl_map(function(cmd)
							return vim.tbl_extend("force", {
								pane = 2,
								section = "terminal",
								enabled = in_git,
								padding = 0,
								ttl = 5 * 60,
								indent = 2,
							}, cmd)
						end, cmds)
					end,
					{ section = "startup" },
				},
			},
			terminal = {
				enabled = true,
				win = {
					style = "terminal",
					position = "bottom",
					height = 0.4,
					width = 0.8,
					border = "rounded",
					title = " Terminal ",
					title_pos = "center",
					backdrop = 60,
					keys = {
						-- Custom terminal keybinds
						["<C-/>"] = "hide", -- Ctrl+/ to hide terminal (common shortcut)
						["<C-q>"] = "close", -- Ctrl+q to close terminal
					},
				},
				-- Interactive settings
				interactive = true, -- start in insert mode, auto-close on exit
				-- Environment variables for better terminal experience
				env = {
					TERM = "xterm-256color",
				},
			},
		},
		-- Keybindings defined outside of opts to avoid conflicts
		keys = {
			-- Snacks Picker
			{
				"<leader>e",
				function()
					Snacks.explorer()
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
			{
				"<leader>rN",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Fast Rename Current File",
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
		},
	},
}
