return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		dashboard = {
			pane_gap = 4, -- Gap between panes
			height = 60,
			preset = {
				keys = {
					-- File Operations
					{ icon = " ", key = "ff", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ 
					title = "REST Commands",
					padding = 1,
					section = "terminal",
					cmd = "printf '🌐 [R] REST Send (<leader>Rs)'",
					height = 2,
					indent = 2
				},
				{ 
					title = "Debug Commands", 
					padding = 1,
					section = "terminal",
					cmd = "printf ' [db] Debug Toggle BP (<leader>db)\\n [dc] Debug Continue (<leader>dc)\\n [du] Debug UI (<leader>du)'",
					height = 4,
					indent = 2
				},
				{
					title = "Code Actions",
					padding = 1,
					section = "terminal",
					cmd = "printf ' [ca] Code Actions (<leader>ca)\\n [fc] Format Code'",
					height = 3,
					indent = 2
				},
				{
					title = "Database Commands",
					padding = 1,
					section = "terminal",
					cmd = "printf ' [Db] Database UI (<leader>ddb)\\n [Dc] DB Connection (<leader>ddc)\\n [Dq] DB Find Buffer (<leader>ddq)'",
					height = 4,
					indent = 2
				},
				{
					title = "Orgmode Commands",
					padding = 1,
					section = "terminal",
					cmd = "printf ' [t] Org Tasks (<leader>ot)\\n [A] Org Agenda (<leader>oa)\\n [o] Org Refile (<leader>or)'",
					height = 4,
					indent = 2
				},
				{ pane = 2, icon = " ", title = "Org Todos", section = "terminal", cmd = "awk '/^\\* TODO/ { gsub(/^\\* TODO /, \"\", $0); task=$0; getline; if(/DEADLINE:/) { gsub(/.*DEADLINE: </, \"\", $0); gsub(/>.*/, \"\", $0); printf \"• %s (Due: %s)\\n\", task, $0 } else { printf \"• %s\\n\", task } }' ~/orgfiles/tasks.org | head -5", height = 6, padding = 1, ttl = 60, indent = 3 },
				{
					pane = 2,
					icon = " ",
					title = "Notifications",
					section = "terminal",
					cmd = "gh notify -s -a -n5",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
				},
				{
					pane = 2,
					icon = " ",
					title = "Open Issues",
					section = "terminal",
					cmd = "gh issue list -L 3",
					height = 7,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
				},
				{
					pane = 2,
					icon = " ",
					title = "Open PRs",
					section = "terminal",
					cmd = "gh pr list -L 3",
					height = 7,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
				},
				{
					pane = 2,
					section = "terminal",
					cmd = "pokemon-colorscripts --random --no-title",
					height = 8,
					padding = 1,
					indent = 22,
				},
				{ section = "startup" },
			},
		},
	},
}
