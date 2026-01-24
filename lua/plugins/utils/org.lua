return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
        require("orgmode").setup({
            org_agenda_files = "~/orgfiles/**/*",
            org_default_notes_file = "~/orgfiles/refile.org",
            org_todo_keywords = { "TODO", "NEXT", "WAITING", "|", "DONE", "CANCELLED" },
            org_hide_leading_stars = true,
            org_indent_mode = "indent",
            org_startup_folded = "content",
            mappings = {
                org = {
                    org_toggle_checkbox = "<C-Space>",
                    org_todo = "cit",
                    org_schedule = ",s",
                    org_deadline = ",d",
                    org_time_stamp = ",t",
                },
            },
        })
    end,
    keys = {
        { "<leader>oa", "<cmd>OrgAgenda<cr>", desc = "Org agenda" },
        { "<leader>oc", "<cmd>OrgCapture<cr>", desc = "Org capture" },
        {
            "<leader>of",
            function()
                vim.cmd("tabnew")
                vim.cmd("lcd ~/orgfiles")
                vim.cmd("e .")
            end,
            desc = "Open orgfiles",
        },
        { "<leader>ot", "<cmd>e ~/orgfiles/tasks.org<cr>", desc = "Open tasks.org" },
        { "<leader>on", "<cmd>e ~/orgfiles/notes.org<cr>", desc = "Open notes.org" },
        { "<leader>om", "<cmd>e ~/orgfiles/meetings.org<cr>", desc = "Open meetings.org" },
        { "<leader>or", "<cmd>e ~/orgfiles/refile.org<cr>", desc = "Open refile.org" },
        {
            "<leader>ol",
            function()
                vim.cmd("tabnew")
                vim.cmd("lcd ~/orgfiles/learn")
                vim.cmd("e .")
            end,
            desc = "Open learn dir",
        },
        {
            "<leader>op",
            function()
                vim.cmd("tabnew")
                vim.cmd("lcd ~/orgfiles/projects")
                vim.cmd("e .")
            end,
            desc = "Open projects dir",
        },
    },
}
