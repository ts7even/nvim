return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                pickers = {
                    oldfiles = {
                        cwd_only = true, -- Show only recent files from current project
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })

            -- Telescope keymaps
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fr", function()
                builtin.oldfiles({ cwd_only = true })
            end, { desc = "Recent files (project only)" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
        end,
    },

    -- UI select integration for telescope
    {
        "nvim-telescope/telescope-ui-select.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("ui-select")
        end,
    },
}