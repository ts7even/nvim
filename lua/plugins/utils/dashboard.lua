-- Custom Dashboard Configuration
local M = {}

-- Helper function to execute shell command and get output
local function execute_command(cmd)
	local handle = io.popen(cmd)
	if not handle then return {} end
	local result = handle:read("*all")
	handle:close()
	
	if not result or result == "" then return {} end
	
	local lines = {}
	for line in result:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end
	return lines
end

-- Get current date and time
local function get_datetime()
	return {
		"📅 " .. os.date("%A, %B %d, %Y"),
		"🕒 " .. os.date("%I:%M %p"),
		""
	}
end

-- Parse org files for TODO items
local function get_org_todos()
	local todos = {}
	local cmd = "awk '/^\\* TODO/ { gsub(/^\\* TODO /, \"\", $0); task=$0; getline; if(/DEADLINE:/) { gsub(/.*DEADLINE: </, \"\", $0); gsub(/>.*/, \"\", $0); printf \"• %s (Due: %s)\\n\", task, $0 } else { printf \"• %s\\n\", task } }' ~/orgfiles/tasks.org 2>/dev/null | head -8"
	
	local result = execute_command(cmd)
	if #result == 0 then
		return {"  No TODO items found"}
	end
	
	for _, line in ipairs(result) do
		table.insert(todos, "  " .. line)
	end
	return todos
end

-- Get GitHub notifications
local function get_github_notifications()
	local notifications = execute_command("gh notify -s -a -n5 2>/dev/null")
	if #notifications == 0 then
		return {"  No notifications"}
	end
	
	local formatted = {}
	for i, line in ipairs(notifications) do
		if i > 5 then break end
		-- Truncate long lines
		if #line > 45 then
			line = string.sub(line, 1, 42) .. "..."
		end
		table.insert(formatted, "  " .. line)
	end
	return formatted
end

-- Get GitHub issues assigned to me
local function get_github_issues()
	local issues = execute_command("gh issue list -a @me -L 5 2>/dev/null")
	if #issues == 0 then
		return {"  No issues assigned"}
	end
	
	local formatted = {}
	for i, line in ipairs(issues) do
		if i > 5 then break end
		-- Truncate and format
		if #line > 45 then
			line = string.sub(line, 1, 42) .. "..."
		end
		table.insert(formatted, "  " .. line)
	end
	return formatted
end

-- Get GitHub PRs
local function get_github_prs()
	local prs = execute_command("gh pr list -L 5 2>/dev/null")
	if #prs == 0 then
		return {"  No open PRs"}
	end
	
	local formatted = {}
	for i, line in ipairs(prs) do
		if i > 5 then break end
		-- Truncate and format
		if #line > 45 then
			line = string.sub(line, 1, 42) .. "..."
		end
		table.insert(formatted, "  " .. line)
	end
	return formatted
end

-- Get Pokemon ASCII - using proper terminal approach
local function create_pokemon_terminal(main_buf, pokemon_row, pokemon_col)
	-- Create a terminal buffer for Pokemon
	local pokemon_buf = vim.api.nvim_create_buf(false, true)
	
	-- Set up buffer options for terminal
	vim.api.nvim_buf_set_option(pokemon_buf, 'bufhidden', 'wipe')
	vim.api.nvim_buf_set_option(pokemon_buf, 'buftype', 'nofile')
	
	-- Open terminal in the buffer
	local chan = vim.api.nvim_open_term(pokemon_buf, {})
	
	-- Execute pokemon command and send output to terminal
	local jid = vim.fn.jobstart({
		"bash", "-c", "pokemon-colorscripts -r --no-title 2>/dev/null || echo -e '     ⚡ No Pokémon available\\n   Install pokemon-colorscripts\\n   for random Pokémon display!'"
	}, {
		pty = true,
		width = 50,
		height = 20,
		on_stdout = function(_, data)
			if data and #data > 0 then
				for _, line in ipairs(data) do
					if line and line ~= "" then
						pcall(vim.api.nvim_chan_send, chan, line .. "\r\n")
					end
				end
			end
		end,
		on_exit = function(job_id, exit_code)
			-- Terminal output is already handled in on_stdout
			-- Just clean up the job reference
		end,
	})
	
	-- Create floating window for Pokemon terminal
	local main_win = vim.api.nvim_get_current_win()
	local pokemon_win = vim.api.nvim_open_win(pokemon_buf, false, {
		relative = 'win',
		win = main_win,
		row = pokemon_row,
		col = pokemon_col,
		width = 50,
		height = 20,
		style = 'minimal',
		focusable = false,
		zindex = 50,
		border = 'none'
	})
	
	-- Set terminal styling to blend with dashboard
	vim.api.nvim_win_set_option(pokemon_win, 'winhighlight', 'Normal:Normal,NormalFloat:Normal,EndOfBuffer:Normal')
	
	-- Store cleanup function
	local cleanup = function()
		if jid and jid > 0 then
			pcall(vim.fn.jobstop, jid)
		end
		if vim.api.nvim_win_is_valid(pokemon_win) then
			pcall(vim.api.nvim_win_close, pokemon_win, true)
		end
		if vim.api.nvim_buf_is_valid(pokemon_buf) then
			pcall(vim.api.nvim_buf_delete, pokemon_buf, {force = true})
		end
	end
	
	-- Clean up when main buffer is deleted
	vim.api.nvim_create_autocmd({"BufWipeout", "BufDelete"}, {
		buffer = main_buf,
		callback = cleanup,
		once = true
	})
	
	-- Clean up when main buffer becomes invalid
	vim.api.nvim_create_autocmd({"BufHidden", "WinClosed"}, {
		buffer = main_buf,
		callback = cleanup,
		once = true
	})
	
	return pokemon_buf, pokemon_win, cleanup
end

-- Simplified placeholder for text layout - Pokemon will be in terminal
local function get_pokemon_placeholder()
	return {
		"", "", "", "", "", "", "", "", "", "",
		"", "", "", "", "", "", "", "", "", ""
	}
end-- Get system stats
local function get_system_stats()
	local stats = {}
	
	-- Git status if in a git repo
	local git_status = execute_command("git status --porcelain 2>/dev/null | wc -l")
	if git_status[1] and tonumber(git_status[1]) then
		table.insert(stats, "  📊 Git changes: " .. git_status[1])
	end
	
	-- File count in current directory
	local file_count = execute_command("find . -maxdepth 1 -type f | wc -l")
	if file_count[1] then
		table.insert(stats, "  📁 Files in dir: " .. file_count[1])
	end
	
	-- System load
	local load_avg = execute_command("uptime | grep -oP 'load average: \\K[0-9.]+' | head -1")
	if load_avg[1] then
		table.insert(stats, "  ⚡ Load avg: " .. load_avg[1])
	end
	
	-- Memory usage
	local mem_usage = execute_command("free -h | awk '/^Mem:/ {print $3\"/\"$2}'")
	if mem_usage[1] then
		table.insert(stats, "  💾 Memory: " .. mem_usage[1])
	end
	
	if #stats == 0 then
		stats = {"  No stats available"}
	end
	
	return stats
end

-- Create dashboard content with perfect alignment and cohesive sections
local function get_dashboard_content()
	-- Get terminal dimensions
	local width = vim.o.columns
	local height = vim.o.lines
	
	local content = {
		"",
		"  ███╗   ███╗██╗   ██╗██╗   ██╗██╗███╗   ███╗",
		"  ████╗ ████║╚██╗ ██╔╝██║   ██║██║████╗ ████║",
		"  ██╔████╔██║ ╚████╔╝ ██║   ██║██║██╔████╔██║",
		"  ██║╚██╔╝██║  ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
		"  ██║ ╚═╝ ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║",
		"  ╚═╝     ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝",
		"",
		"",
	}
	
	-- Get data for all columns
	local datetime = get_datetime()
	local org_todos = get_org_todos()
	local github_notifications = get_github_notifications()
	local github_issues = get_github_issues()
	local github_prs = get_github_prs()
	local pokemon_placeholder = get_pokemon_placeholder()
	local system_stats = get_system_stats()
	
	-- Calculate dynamic column widths based on terminal width
	local total_width = width - 8 -- Leave padding
	local col_width = math.floor(total_width / 3) - 1
	local spacing = 3
	
	-- Helper function to create perfectly aligned columns
	local function create_line(col1, col2, col3)
		col1 = col1 or ""
		col2 = col2 or ""
		col3 = col3 or ""
		
		-- Ensure we don't exceed column width
		local function truncate(str, max_width)
			if vim.api.nvim_strwidth(str) > max_width then
				return string.sub(str, 1, max_width - 3) .. "..."
			end
			return str
		end
		
		col1 = truncate(col1, col_width)
		col2 = truncate(col2, col_width)
		col3 = truncate(col3, col_width)
		
		-- Calculate exact padding needed
		local col1_padding = col_width - vim.api.nvim_strwidth(col1)
		local col2_padding = col_width - vim.api.nvim_strwidth(col2)
		
		-- Create perfectly aligned line
		return "  " .. col1 .. string.rep(" ", col1_padding) .. 
		       string.rep(" ", spacing) .. col2 .. string.rep(" ", col2_padding) .. 
		       string.rep(" ", spacing) .. col3
	end
	
	-- Section headers with perfect alignment
	table.insert(content, create_line("▍Commands", "▍GitHub Activity", "▍Info & Stats"))
	table.insert(content, "")
	
	-- File operations section
	table.insert(content, create_line("📁 [ff] Find File", "🔔 Notifications", datetime[1]))
	table.insert(content, create_line("🔍 [fg] Find Text (Grep)", github_notifications[1] or "   No notifications", datetime[2]))
	table.insert(content, create_line("⏱️  [fr] Recent Files", github_notifications[2] or "", ""))
	table.insert(content, create_line("📋 [fb] Find Buffers", github_notifications[3] or "", ""))
	table.insert(content, create_line("", github_notifications[4] or "", ""))
	table.insert(content, create_line("", github_notifications[5] or "", ""))
	table.insert(content, "")
	
	-- Debug commands section
	table.insert(content, create_line("🐛 Debug Commands", "🔧 Issues Assigned", "📋 Org TODOs"))
	table.insert(content, create_line("   [db] Toggle BP", github_issues[1] or "   No issues assigned", org_todos[1] or ""))
	table.insert(content, create_line("   [dc] Continue", github_issues[2] or "", org_todos[2] or ""))
	table.insert(content, create_line("   [du] Debug UI", github_issues[3] or "", org_todos[3] or ""))
	table.insert(content, create_line("", github_issues[4] or "", org_todos[4] or ""))
	table.insert(content, create_line("", github_issues[5] or "", org_todos[5] or ""))
	table.insert(content, "")
	
	-- Quick actions section
	table.insert(content, create_line("⚡ Quick Actions", "🔀 Open PRs", "📊 System Stats"))
	table.insert(content, create_line("   [ca] Code Actions", github_prs[1] or "   No open PRs", system_stats[1] or ""))
	table.insert(content, create_line("   [fc] Format Code", github_prs[2] or "", system_stats[2] or ""))
	table.insert(content, create_line("🌐 [Rs] REST Send", github_prs[3] or "", system_stats[3] or ""))
	table.insert(content, create_line("", github_prs[4] or "", system_stats[4] or ""))
	table.insert(content, create_line("", github_prs[5] or "", ""))
	table.insert(content, "")
	
	-- Database & Org commands section
	table.insert(content, create_line("🗄️  Database & Org", "", "📚 More TODOs"))
	table.insert(content, create_line("   [ddb] Database UI", "", org_todos[6] or ""))
	table.insert(content, create_line("   [ot] Org Tasks", "", org_todos[7] or ""))
	table.insert(content, create_line("   [oa] Org Agenda", "", org_todos[8] or ""))
	table.insert(content, "")
	table.insert(content, "")
	
	-- Add Pokemon placeholder area (actual Pokemon will be in terminal overlay)
	local pokemon_width = 50
	local right_padding = math.max(8, width - pokemon_width - 8)
	
	-- Add extra spacing before Pokemon area to avoid overlap with system stats
	table.insert(content, "")
	table.insert(content, "")
	
	-- Add placeholder lines for Pokemon area
	for i = 1, #pokemon_placeholder do
		table.insert(content, string.rep(" ", right_padding) .. (pokemon_placeholder[i] or ""))
	end
	
	-- Add footer spacing
	table.insert(content, "")
	table.insert(content, "")
	
	return content
end

-- Function to create dashboard buffer with enhanced features
function M.create_dashboard()
	-- Create a new buffer
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_get_current_win()
	
	-- Set buffer options (similar to Snacks pattern)
	local bo_opts = {
		bufhidden = 'wipe',
		buftype = 'nofile',
		swapfile = false,
		buflisted = false,
		filetype = 'dashboard',
		undofile = false,
	}
	for k, v in pairs(bo_opts) do
		vim.api.nvim_buf_set_option(buf, k, v)
	end
	
	-- Set window options (similar to Snacks pattern)
	local wo_opts = {
		cursorline = false,
		cursorcolumn = false,
		colorcolumn = "",
		number = false,
		relativenumber = false,
		signcolumn = "no",
		wrap = false,
		list = false,
		spell = false,
		statuscolumn = "",
		foldmethod = "manual",
		sidescrolloff = 0,
	}
	for k, v in pairs(wo_opts) do
		vim.api.nvim_win_set_option(win, k, v)
	end
	
	-- Set the content
	local content = get_dashboard_content()
	vim.api.nvim_buf_set_option(buf, 'modifiable', true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
	vim.api.nvim_buf_set_option(buf, 'modifiable', false)
	vim.api.nvim_buf_set_option(buf, 'readonly', true)
	
	-- Set up window and switch to buffer
	vim.api.nvim_set_current_buf(buf)
	
	-- Create Pokemon terminal overlay after a short delay to ensure main buffer is ready
	vim.defer_fn(function()
		if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
			local width = vim.o.columns
			local height = vim.o.lines
			-- Position Pokemon at the very bottom-right corner
			local pokemon_row = height - 22  -- Near bottom of screen, leaving space for status bar
			local pokemon_col = width - 52   -- Right edge with small padding
			create_pokemon_terminal(buf, pokemon_row, pokemon_col)
		end
	end, 100)
	
	-- Add enhanced syntax highlighting
	vim.cmd([[
		syntax clear
		syntax match DashboardHeader "███.*" contains=ALL
		syntax match DashboardIcon "📁\|🔍\|⏱️\|📋\|🐛\|⚡\|🌐\|🗄️\|🔔\|🔧\|🔀\|📊\|📅\|🕒\|▄\|▀\|█\|░\|▒\|🔥\|⚡" contains=ALL
		syntax match DashboardKey "\[.*\]" contains=ALL
		syntax match DashboardSection "▍.*" contains=ALL
		syntax match DashboardCommand "\s*\[.*\]\s.*" contains=ALL
		syntax match DashboardPokemon ".*\(Charizard\|Pikachu\|Pokémon\).*" contains=ALL
		
		" Enhanced highlight groups
		hi def link DashboardHeader Title
		hi def link DashboardIcon Function  
		hi def link DashboardKey Identifier
		hi def link DashboardSection Statement
		hi def link DashboardCommand Comment
		hi def link DashboardPokemon Special
		
		" Additional color enhancements
		hi DashboardIcon guifg=#7aa2f7 ctermfg=75
		hi DashboardKey guifg=#bb9af7 ctermfg=141 gui=bold cterm=bold
		hi DashboardSection guifg=#7dcfff ctermfg=117 gui=bold cterm=bold
		hi DashboardPokemon guifg=#ff9e64 ctermfg=215
	]])
	
	-- Create augroup for this dashboard instance
	local augroup = vim.api.nvim_create_augroup("dashboard_" .. buf, { clear = true })
	
	-- Set up keymaps for the dashboard buffer
	local opts = { buffer = buf, silent = true, nowait = true }
	vim.keymap.set('n', 'q', ':qa<CR>', opts)
	vim.keymap.set('n', '<ESC>', ':bd<CR>', opts)
	vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
	vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
	vim.keymap.set('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>', opts)
	vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
	
	-- Enhanced auto-resize with better debouncing
	local resize_timer = nil
	
	vim.api.nvim_create_autocmd({"VimResized", "WinResized"}, {
		group = augroup,
		buffer = buf,
		callback = function()
			if resize_timer then
				vim.fn.timer_stop(resize_timer)
			end
			resize_timer = vim.fn.timer_start(100, function()
				if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_get_current_buf() == buf then
					local new_content = get_dashboard_content()
					vim.api.nvim_buf_set_option(buf, 'modifiable', true)
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_content)
					vim.api.nvim_buf_set_option(buf, 'modifiable', false)
					
					-- Recreate Pokemon terminal with new positioning
					vim.defer_fn(function()
						if vim.api.nvim_buf_is_valid(buf) then
							local new_width = vim.o.columns
							local new_height = vim.o.lines
							local new_pokemon_row = new_height - 22
							local new_pokemon_col = new_width - 52
							create_pokemon_terminal(buf, new_pokemon_row, new_pokemon_col)
						end
					end, 50)
				end
			end)
		end,
	})
	
	-- Clean up on buffer delete
	vim.api.nvim_create_autocmd({"BufWipeout", "BufDelete"}, {
		buffer = buf,
		callback = function()
			if resize_timer then
				vim.fn.timer_stop(resize_timer)
			end
			vim.api.nvim_del_augroup_by_id(augroup)
		end,
	})
end

-- Auto-command to show dashboard on startup
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- Only show dashboard if no arguments were provided
		if vim.fn.argc() == 0 then
			M.create_dashboard()
		end
	end,
})

return {}