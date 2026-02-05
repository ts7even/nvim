return {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    dependencies = {
        {
            "nvim-orgmode/org-bullets.nvim",
            config = function()
                require("org-bullets").setup({
                    concealcursor = false,
                    symbols = {
                        list = "•",
                        headlines = { "◉", "○", "✸", "✿" },
                        checkboxes = {
                            half = { "", "@org.checkbox.halfchecked" },
                            done = { "✓", "@org.keyword.done" },
                            todo = { "˟", "@org.keyword.todo" },
                        },
                    },
                })
            end,
        },
    },
    config = function()
        require("orgmode").setup({
            org_agenda_files = "~/Notes/orgfiles/**/*",
            org_default_notes_file = "~/Notes/orgfiles/refile.org",
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

        -- Custom heading colors (since terminal can't do different font sizes)
        vim.api.nvim_set_hl(0, "@org.headline.level1", { fg = "#ff79c6", bold = true })
        vim.api.nvim_set_hl(0, "@org.headline.level2", { fg = "#bd93f9", bold = true })
        vim.api.nvim_set_hl(0, "@org.headline.level3", { fg = "#8be9fd", bold = true })
        vim.api.nvim_set_hl(0, "@org.headline.level4", { fg = "#50fa7b" })
    end,
    keys = {
        { "<leader>oa", "<cmd>OrgAgenda<cr>",  desc = "Org agenda" },
        { "<leader>oc", "<cmd>OrgCapture<cr>", desc = "Org capture" },
        {
            "<leader>of",
            function()
                vim.cmd("tabnew")
                vim.cmd("lcd ~/Notes/orgfiles")
                vim.cmd("e .")
            end,
            desc = "Open orgfiles",
        },
        { "<leader>ot", "<cmd>e ~/Notes/orgfiles/tasks.org<cr>",               desc = "Open tasks.org" },
        { "<leader>op", "<cmd>e ~/Notes/orgfiles/business/parametric.org<cr>", desc = "Open Parametric Docs" },
        { "<leader>oc", "<cmd>e ~/Notes/orgfiles/languages/c.org<cr>",         desc = "Open C Learning Guide" },
        { "<leader>or", "<cmd>e ~/Notes/orgfiles/refile.org<cr>",              desc = "Open refile.org" },
        {
            "<leader>ol",
            function()
                vim.cmd("tabnew")
                vim.cmd("lcd ~/Notes/orgfiles/languages/")
                vim.cmd("e .")
            end,
            desc = "Open learn dir",
        },
    },
}
