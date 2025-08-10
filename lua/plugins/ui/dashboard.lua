-- Function to get orgmode todos
local function get_orgmode_todos()
	local todos = {}
	local org_files = {
		vim.fn.expand("~/orgfiles/tasks.org"),
		vim.fn.expand("~/orgfiles/refile.org"),
		vim.fn.expand("~/orgfiles/meetings.org"),
	}
	
	for _, file in ipairs(org_files) do
		if vim.fn.filereadable(file) == 1 then
			local lines = vim.fn.readfile(file)
			for _, line in ipairs(lines) do
				-- Match TODO, NEXT, WAITING items
				if line:match("^%*+%s+TODO") or line:match("^%*+%s+NEXT") or line:match("^%*+%s+WAITING") then
					local todo = line:gsub("^%*+%s+", ""):gsub("%s+$", "")
					if #todo > 0 and #todos < 5 then -- Limit to 5 todos for display
						table.insert(todos, "• " .. todo)
					end
				end
			end
		end
	end
	
	if #todos == 0 then
		return { "No pending todos found" }
	end
	
	-- Add a header and return todos
	local result = { "📋 Upcoming Tasks:" }
	for _, todo in ipairs(todos) do
		table.insert(result, todo)
	end
	
	return result
end

return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				theme = "doom",
				config = {
					header = {
						"                                   ",
						"                                   ",
						"                                   ",
						"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
						"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
						"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
						"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
						"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
						"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
						"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
						" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
						" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
						"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
						"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
						"                                   ",
					},
					center = {
						{ action = "Telescope find_files", desc = " Find File", icon = "", key = "f" },
						{ action = "Telescope oldfiles", desc = " Recent Files", icon = "", key = "r" },
						{ action = "Telescope live_grep", desc = " Live Grep", icon = "", key = "g" },
						{ action = "Yazi", desc = "File Manager", icon = "", key = "cw" },
					},
					footer = get_orgmode_todos(),
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
