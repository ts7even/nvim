-- Function to get orgmode todos and agenda items
local function get_orgmode_todos()
	local todos = {}
	local agenda_items = {}
	local org_files = {
		vim.fn.expand("~/orgfiles/tasks.org"),
		vim.fn.expand("~/orgfiles/notes.org"),
		vim.fn.expand("~/orgfiles/refile.org"),
		vim.fn.expand("~/orgfiles/meetings.org"),
	}

	-- Get current date and week boundaries
	local current_time = os.time()
	local current_date = os.date("*t", current_time)
	local week_start = current_time - (current_date.wday - 2) * 86400 -- Monday
	local week_end = week_start + 6 * 86400 -- Sunday

	-- Helper function to parse org date
	local function parse_org_date(date_str)
		-- Match formats like <2024-08-09> or <2024-08-09 Fri>
		local year, month, day = date_str:match("<(%d%d%d%d)%-(%d%d)%-(%d%d)")
		if year and month and day then
			return os.time({ year = tonumber(year), month = tonumber(month), day = tonumber(day) })
		end
		return nil
	end

	-- Helper function to get priority (higher number = higher priority)
	local function get_priority(todo_line)
		-- NEXT items have highest priority
		if todo_line:match("NEXT") then
			return 3
		end
		-- Items with [#A] priority marker
		if todo_line:match("%[#A%]") then
			return 2
		end
		-- Regular TODO items
		if todo_line:match("TODO") then
			return 1
		end
		-- WAITING items have lowest priority
		return 0
	end

	for _, file in ipairs(org_files) do
		if vim.fn.filereadable(file) == 1 then
			local lines = vim.fn.readfile(file)
			local current_todo = nil
			local current_todo_line = nil

			for i, line in ipairs(lines) do
				-- Match TODO, NEXT, WAITING items
				if line:match("^%*+%s+TODO") or line:match("^%*+%s+NEXT") or line:match("^%*+%s+WAITING") then
					current_todo = line:gsub("^%*+%s+", ""):gsub("%s+$", "")
					current_todo_line = line
					if #current_todo > 0 and #todos < 5 then -- Limit to 5 todos
						table.insert(todos, {
							text = current_todo,
							priority = get_priority(line),
							line = line,
						})
					end
				end

				-- Check for SCHEDULED and DEADLINE items
				if current_todo and (line:match("SCHEDULED:") or line:match("DEADLINE:")) then
					local date_match = line:match("<[^>]+>")
					if date_match then
						local task_time = parse_org_date(date_match)
						if task_time and task_time >= week_start and task_time <= week_end then
							local day_name = os.date("%a", task_time)
							local date_str = os.date("%m/%d", task_time)
							-- Better emoji choices: 📋 for scheduled, 🚨 for deadline
							local prefix = line:match("SCHEDULED:") and "📋" or "⚠️"
							local priority = get_priority(current_todo_line or "")
							-- Add urgency for deadlines
							if line:match("DEADLINE:") then
								priority = priority + 2
							end

							local agenda_item = {
								text = string.format(
									"%s %s (%s): %s",
									prefix,
									day_name,
									date_str,
									current_todo:sub(1, 40)
								),
								priority = priority,
								time = task_time,
							}
							if #agenda_items < 5 then -- Limit agenda items to 5
								table.insert(agenda_items, agenda_item)
							end
						end
					end
				end

				-- Reset current_todo if we hit another heading
				if line:match("^%*") and not (line:match("TODO") or line:match("NEXT") or line:match("WAITING")) then
					current_todo = nil
					current_todo_line = nil
				end
			end
		end
	end

	-- Sort todos by priority (highest first)
	table.sort(todos, function(a, b)
		return a.priority > b.priority
	end)

	-- Sort agenda items by priority first, then by time
	table.sort(agenda_items, function(a, b)
		if a.priority ~= b.priority then
			return a.priority > b.priority
		end
		return a.time < b.time
	end)

	local result = {}

	-- Add todos section (up to 5, ordered by priority)
	if #todos > 0 then
		table.insert(result, "📋 Active Tasks:")
		for i = 1, math.min(5, #todos) do
			table.insert(result, "• " .. todos[i].text)
		end
	end

	-- Add agenda section (up to 5, ordered by priority then time)
	if #agenda_items > 0 then
		if #result > 0 then
			table.insert(result, "") -- Empty line separator
		end
		table.insert(result, "📆 This Week's Agenda:")
		for i = 1, math.min(5, #agenda_items) do
			table.insert(result, agenda_items[i].text)
		end
	end

	-- Fallback if nothing found
	if #result == 0 then
		return { "No pending todos or agenda items found" }
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
						{ action = "Yazi", desc = " File Manager", icon = "", key = "cw" },
					},
					footer = get_orgmode_todos(),
					"It's not what you know that gets you into trouble, it's what you know for sure that just ain't so. - Mark Twain",
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
