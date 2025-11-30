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

				-- Formatting and indentation options
				org_startup_indented = false, -- Set to true for virtual indentation
				org_adapt_indentation = false, -- Disable auto-indentation under headlines
				org_tags_column = 80, -- Column to align tags (default: 80)
				org_hide_leading_stars = false, -- Set to true to hide leading stars
			})

			-- Set up proper org-mode formatting and indentation
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "org",
				callback = function()
					vim.bo.formatexpr = "v:lua.require'orgmode'.formatexpr()"
					-- Enable proper indentation and formatting for org-mode
					vim.bo.textwidth = 80
					vim.bo.wrapmargin = 0
					vim.bo.formatoptions = "tcroqn2j" -- Removed 'l' for auto-wrap while typing
					-- Disable auto-indenting to prevent unwanted indentation
					vim.bo.autoindent = false
					vim.bo.smartindent = false
					vim.bo.cindent = false
					-- Use spaces and set proper tab settings
					vim.bo.expandtab = true
					vim.bo.tabstop = 2
					vim.bo.shiftwidth = 2
					vim.bo.softtabstop = 2

					-- Auto-format long lines when opening org files using external fmt command
					vim.api.nvim_create_autocmd("BufReadPost", {
						buffer = vim.api.nvim_get_current_buf(),
						callback = function()
							-- Wait a moment for the buffer to be fully loaded
							vim.defer_fn(function()
								-- Save cursor position
								local cursor_pos = vim.api.nvim_win_get_cursor(0)
								-- Use external fmt command to format text to 80 characters
								vim.cmd("silent! %!fmt -w 80")
								-- Restore cursor position
								pcall(vim.api.nvim_win_set_cursor, 0, cursor_pos)
							end, 100)
						end,
					})
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
