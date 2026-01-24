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
            { "<leader>e",   function() Snacks.explorer({ hidden = true }) end,                                    desc = "Explorer" },
            { "<leader>ff",  function() Snacks.picker.files() end,                                                 desc = "Find Files" },
            { "<leader>fg",  function() Snacks.picker.grep() end,                                                  desc = "Grep" },
            { "<leader>fb",  function() Snacks.picker.buffers() end,                                               desc = "Buffers" },
            { "<leader>fr",  function() Snacks.picker.recent() end,                                                desc = "Recent Files" },
            { "<leader>fs",  function() Snacks.picker.grep_word() end,                                             desc = "Search Word",            mode = { "n", "x" } },
            { "<leader>pk",  function() Snacks.picker.keymaps({ layout = "ivy" }) end,                             desc = "Keymaps" },
            { "<leader>qf",  function() Snacks.picker.qflist() end,                                                desc = "Quickfix" },
            -- Git
            { "<leader>lg",  function() Snacks.lazygit() end,                                                      desc = "Lazygit" },
            { "<leader>gl",  function() Snacks.lazygit.log() end,                                                  desc = "Git Log" },
            { "<leader>gbr", function() Snacks.picker.git_branches({ layout = "select" }) end,                     desc = "Git Branches" },
            -- Terminals
            { "<leader>tt",  function() Snacks.terminal() end,                                                     desc = "Toggle terminal (float)" },
            { "<leader>tv",  function() Snacks.terminal(nil, { win = { position = "right", width = 0.4 } }) end,   desc = "Terminal (vsplit)" },
            { "<leader>ts",  function() Snacks.terminal(nil, { win = { position = "bottom", height = 0.3 } }) end, desc = "Terminal (split)" },
            { "<leader>bd",  function() Snacks.bufdelete() end,                                                    desc = "Delete Buffer" },
        },
    },
}
