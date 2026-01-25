return {
    -- Which-key: shows keybindings popup after pressing leader
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = 300, -- delay in ms before showing popup
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            spec = {
                { "<leader>ai", group = "ai" },
                { "<leader>d",  group = "debug/diagnostics" },
                { "<leader>f",  group = "file/search" },
                { "<leader>g",  group = "goto/git" },
                { "<leader>l",  group = "lsp" },
                { "<leader>o",  group = "org" },
                { "<leader>t",  group = "terminal" },
                { "<leader>u",  group = "utilities" },
            },
        },
    },

    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            input = { enabled = true },
            quickfile = { enabled = true },
            picker = {
                enabled = true,
                matchers = { frecency = true },
                layout = { preset = "telescope" },
            },
            explorer = { enabled = true },
            dashboard = {
                enabled = true,
                width = 60,
                preset = {
                    header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],

                },
                sections = { { section = "header" } },
            },
            terminal = {
                enabled = true,
                win = {
                    keys = {
                        ["<C-/>"] = "hide",
                        term_normal = {
                            "<esc>",
                            function() vim.cmd("stopinsert") end,
                            mode = "t",
                            desc = "Normal mode",
                        },
                    },
                },
            },
        },
        keys = {
            -- File operations
            { "<leader>e",   function() Snacks.explorer({ hidden = true }) end,                                                 desc = "Explorer" },
            { "<leader>ff",  function() Snacks.picker.files() end,                                                              desc = "Find Files" },
            { "<leader>fg",  function() Snacks.picker.grep() end,                                                               desc = "Grep" },
            { "<leader>fb",  function() Snacks.picker.buffers() end,                                                            desc = "Buffers" },
            { "<leader>fr",  function() Snacks.picker.recent() end,                                                             desc = "Recent Files" },
            { "<leader>fs",  function() Snacks.picker.grep_word() end,                                                          desc = "Search Word",        mode = { "n", "x" } },
            { "<leader>pk",  function() Snacks.picker.keymaps({ layout = "ivy" }) end,                                          desc = "Keymaps" },
            { "<leader>qf",  function() Snacks.picker.qflist() end,                                                             desc = "Quickfix" },
            -- Git
            { "<leader>lg",  function() Snacks.lazygit() end,                                                                   desc = "Lazygit" },
            { "<leader>gl",  function() Snacks.lazygit.log() end,                                                               desc = "Git Log" },
            { "<leader>gbr", function() Snacks.picker.git_branches({ layout = "select" }) end,                                  desc = "Git Branches" },
            -- Terminals with toggle support
            {
                "<leader>tv",
                function()
                    local term_buf = vim.g.term_vsplit_buf
                    -- Check if terminal buffer exists and is valid
                    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
                        -- Find window displaying this buffer
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            if vim.api.nvim_win_get_buf(win) == term_buf then
                                vim.api.nvim_win_close(win, true)
                                return
                            end
                        end
                        -- Buffer exists but not visible, show it
                        vim.cmd("vsplit")
                        vim.api.nvim_set_current_buf(term_buf)
                    else
                        -- Create new terminal
                        vim.cmd("vsplit | terminal")
                        vim.g.term_vsplit_buf = vim.api.nvim_get_current_buf()
                        vim.wo.spell = false
                    end
                end,
                desc = "Terminal (vertical)"
            },
            {
                "<leader>th",
                function()
                    local term_buf = vim.g.term_hsplit_buf
                    if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
                        for _, win in ipairs(vim.api.nvim_list_wins()) do
                            if vim.api.nvim_win_get_buf(win) == term_buf then
                                vim.api.nvim_win_close(win, true)
                                return
                            end
                        end
                        vim.cmd("split")
                        vim.api.nvim_set_current_buf(term_buf)
                    else
                        vim.cmd("split | terminal")
                        vim.g.term_hsplit_buf = vim.api.nvim_get_current_buf()
                        vim.wo.spell = false
                    end
                end,
                desc = "Terminal (horizontal)"
            },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        },
    },
}
