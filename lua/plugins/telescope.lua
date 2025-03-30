return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },

        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            -- Configure Telescope
            telescope.setup({
                pickers = {
                    oldfiles = {
                        cwd_only = true,  -- Show only files from the current working directory (project)
                    }
                }
            })

            -- Keybindings
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live Grep" })
            vim.keymap.set("n", "<leader>fr", function()
                builtin.oldfiles({ cwd_only = true }) -- Limit recent files to the current project
            end, { desc = "Telescope Recent Files (Project Only)" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Recent Buffers" })
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
