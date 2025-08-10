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
				org_capture_templates = {
					-- Quick captures
					t = {
						description = "Task",
						template = "* TODO %?\n  SCHEDULED: %T",
						target = "~/orgfiles/tasks.org",
					},
					n = {
						description = "Quick Note",
						template = "* %?\n  %U",
						target = "~/orgfiles/notes.org",
					},

					-- Template-based captures
					m = {
						description = "Meeting (from template)",
						template = "* Meeting - %^{Meeting Name}\n  :PROPERTIES:\n  :ABOUT: %^{About Meeting}\n  :DATE: %t\n  :TIME: %^{Time}\n  :PARTICIPANTS: %^{Participants}\n  :END:\n\n** Notes\n*** Key Discussion Points\n%?\n\n*** Decisions Made\n\n\n*** Concerns/Issues Raised\n\n\n** Action Items\n*** TODO %^{Action Item 1} :meeting:\n    SCHEDULED: %^{Follow-up Date}T\n    - TPM: %^{Owner}\n    - Engineer: %^{Engineer}\n    - Due: %^{Due Date}T\n\n** Related Links\n- GitHub Issue: %^{GitHub Link}",
						target = "~/orgfiles/meetings.org",
					},
					l = {
						description = "Learning Note (from template)",
						template = "%(file)~/orgfiles/templates/learning.org",
						target = "~/orgfiles/refile.org",
					},

					-- Project captures
					p = {
						description = "Project Task",
						template = "* TODO %?\n  SCHEDULED: %T\n  :PROPERTIES:\n  :PROJECT: %^{Project}\n  :END:",
						target = "~/orgfiles/refile.org",
					},

					-- Refile for organizing later
					r = {
						description = "Refile (organize later)",
						template = "* %?\n  %U\n  :PROPERTIES:\n  :CREATED: %U\n  :END:",
						target = "~/orgfiles/refile.org",
					},
				},
			})

			-- Quick file access keymaps
			vim.keymap.set("n", "<leader>of", ":edit ~/orgfiles/<CR>", { desc = "Open orgfiles directory" })
			vim.keymap.set("n", "<leader>ot", ":edit ~/orgfiles/tasks.org<CR>", { desc = "Open tasks file" })
			vim.keymap.set("n", "<leader>on", ":edit ~/orgfiles/notes.org<CR>", { desc = "Open notes file" })
			vim.keymap.set("n", "<leader>ol", ":edit ~/orgfiles/learn/<CR>", { desc = "Open learn directory" })
			vim.keymap.set("n", "<leader>om", ":edit ~/orgfiles/meetings.org<CR>", { desc = "Open meetings file" })
			vim.keymap.set("n", "<leader>or", ":edit ~/orgfiles/refile.org<CR>", { desc = "Open refile file" })
			vim.keymap.set("n", "<leader>op", ":edit ~/orgfiles/projects/", { desc = "Open projects directory" })
			vim.keymap.set("n", "<leader>onp", function()
				local project_name = vim.fn.input("Project name: ")
				if project_name ~= "" then
					vim.cmd("edit ~/orgfiles/projects/" .. project_name .. ".org")
					vim.cmd("read ~/orgfiles/templates/project.org")
					vim.cmd("1delete") -- Remove first empty line
				end
			end, { desc = "Create new project from template" })

			vim.keymap.set("n", "<leader>onc", function()
				local poc_name = vim.fn.input("POC name: ")
				if poc_name ~= "" then
					vim.cmd("edit ~/orgfiles/projects/poc-" .. poc_name .. ".org")
					vim.cmd("read ~/orgfiles/templates/poc.org")
					vim.cmd("1delete") -- Remove first empty line
				end
			end, { desc = "Create new POC from template" })

			vim.keymap.set("n", "<leader>onl", function()
				local learning_path = vim.fn.input("Learning file (e.g., python/async or kubernetes): ")
				if learning_path ~= "" then
					local full_path = "~/orgfiles/learn/" .. learning_path .. ".org"
					vim.cmd("edit " .. full_path)
					vim.cmd("read ~/orgfiles/templates/learning.org")
					vim.cmd("1delete") -- Remove first empty line
				end
			end, { desc = "Create new learning file from template" })
		end,
	},
}
