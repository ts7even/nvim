return {
    -- Neogit - Magit-like git interface
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
        },
        -- Only need gg to open Neogit - use its built-in keys after:
        -- s=stage, u=unstage, c=commit, P=push, F=pull, b=branch, ?=help
        keys = {
            { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit status" },
        },
        cmd = "Neogit",
        opts = {
            kind = "tab",
            signs = {
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            integrations = {
                diffview = true,
            },
            sections = {
                untracked = { folded = false },
                unstaged = { folded = false },
                staged = { folded = false },
                stashes = { folded = true },
                unpulled = { folded = true, hidden = false },
                unmerged = { folded = false, hidden = false },
                recent = { folded = true },
            },
        },
    },

    -- Diffview - Enhanced diff viewer
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
            { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
            { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Branch history" },
            { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
        },
        cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
        opts = {
            enhanced_diff_hl = true,
            view = {
                default = { layout = "diff2_horizontal" },
                merge_tool = { layout = "diff3_mixed" },
            },
        },
    },

    --  git signs - Show git signs in the gutter
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        vim.keymap.set("n", "<leader>gi", "<cmd>Gitsigns preview_hunk_inline<cr>", { desc = "Stage hunk" })
        end,
    },
}
