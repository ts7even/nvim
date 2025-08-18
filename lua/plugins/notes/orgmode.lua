-- Function to load capture templates from JSON file
local function load_capture_templates(template_name)
	local config_path = vim.fn.stdpath("config")
	local templates_file = config_path .. "/snippets/org-capture-templates.json"
	
	local file = io.open(templates_file, "r")
	if not file then
		vim.notify("Could not find org capture templates file: " .. templates_file, vim.log.levels.WARN)
		return template_name and {} or {}
	end
	
	local content = file:read("*all")
	file:close()
	
	local ok, templates = pcall(vim.json.decode, content)
	if not ok then
		vim.notify("Error parsing org capture templates JSON: " .. templates, vim.log.levels.ERROR)
		return template_name and {} or {}
	end
	
	-- If a specific template is requested, return just that one
	if template_name then
		return templates[template_name] or {}
	end
	
	-- Convert to orgmode format with single letter keys
	local org_templates = {}
	org_templates.t = templates.task
	org_templates.n = templates.note
	org_templates.m = templates.meeting
	org_templates.l = templates.learning
	org_templates.p = templates.project
	org_templates.r = templates.refile
	
	return org_templates
end

-- Helper function for individual template access (example usage)
local function get_template(name)
	return load_capture_templates(name)
end

return {
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
				org_todo_keywords = { "TODO", "NEXT", "WAITING", "|", "DONE", "CANCELLED" },
				org_agenda_start_on_weekday = 1, -- Start week on Monday
				org_deadline_warning_days = 14,
				org_agenda_skip_scheduled_if_done = true,
				org_agenda_skip_deadline_if_done = true,
				-- Refile configuration
				org_refile_targets = "~/orgfiles/**/*",
				org_refile_use_outline_path = "file",
				org_refile_allow_creating_parent_nodes = "confirm",
				org_capture_templates = load_capture_templates(),
			})

			-- Set up formatexpr for table formatting
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "org",
				callback = function()
					vim.bo.formatexpr = "v:lua.require'orgmode'.formatexpr()"
					-- Set org-mode specific formatting options for <leader>fc
					vim.bo.textwidth = 120
					vim.bo.wrapmargin = 0
					vim.bo.formatoptions = "tcqjn"
				end,
			})

			-- Quick file access keymaps
			vim.keymap.set("n", "<leader>of", ":edit ~/orgfiles/<CR>", { desc = "Open orgfiles directory" })
			vim.keymap.set("n", "<leader>ot", ":edit ~/orgfiles/tasks.org<CR>", { desc = "Open tasks file" })
			vim.keymap.set("n", "<leader>on", ":edit ~/orgfiles/notes.org<CR>", { desc = "Open notes file" })
			vim.keymap.set("n", "<leader>ol", ":edit ~/orgfiles/learn/<CR>", { desc = "Open learn directory" })
			vim.keymap.set("n", "<leader>om", ":edit ~/orgfiles/meetings.org<CR>", { desc = "Open meetings file" })
			vim.keymap.set("n", "<leader>or", ":edit ~/orgfiles/refile.org<CR>", { desc = "Open refile file" })
			vim.keymap.set("n", "<leader>op", ":edit ~/orgfiles/projects/", { desc = "Open projects directory" })
		end,
	},
}
