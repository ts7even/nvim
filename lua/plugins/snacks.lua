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
                { "<leader>c",  group = "code" },
                { "<leader>d",  group = "debug/diagnostics" },
                { "<leader>f",  group = "file/search" },
                { "<leader>g",  group = "git" },
                { "<leader>o",  group = "org" },
                { "<leader>q",  group = "quickfix" },
                { "<leader>s",  group = "spelling" },
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
                win = {
                    input = {
                        keys = {
                            ["<Tab>"] = { "list_up", mode = { "i", "n" } },
                            ["<S-Tab>"] = { "list_down", mode = { "i", "n" } },
                        },
                    },
                },
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
            { "<leader>e",  function() Snacks.explorer({ hidden = true }) end, desc = "Explorer" },
            { "<leader>ff", function() Snacks.picker.files() end,              desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.grep() end,               desc = "Grep" },
            { "<leader>fb", function() Snacks.picker.buffers() end,            desc = "Buffers" },
            { "<leader>fr", function() Snacks.picker.recent() end,             desc = "Recent Files" },
            { "<leader>fs", function() Snacks.picker.grep_word() end,          desc = "Search Word", mode = { "n", "x" } },
            {
                "<leader>fp",
                function()
                    local projects = {
                        { name = "Neovim Config", path = "~/.config/nvim" },
                        { name = "Dotfiles",      path = "~/.config/cli-dots" },
                        -- Add more projects here
                    }
                    Snacks.picker.pick({
                        title = "Projects",
                        items = vim.tbl_map(function(p)
                            local expanded = vim.fn.expand(p.path)
                            return { text = p.name .. "  " .. p.path, file = expanded, name = p.name }
                        end, projects),
                        format = function(item)
                            return {
                                { item.name .. "  ", "SnacksPickerLabel" },
                                { item.file,         "SnacksPickerComment" },
                            }
                        end,
                        confirm = function(picker, item)
                            picker:close()
                            if item and item.file then
                                vim.cmd("cd " .. item.file)
                                -- Auto-activate Python venv if present
                                local venv_path = item.file .. "/.venv"
                                if vim.fn.isdirectory(venv_path) == 1 then
                                    vim.env.VIRTUAL_ENV = venv_path
                                    vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
                                    vim.notify("Activated venv: " .. venv_path, vim.log.levels.INFO)
                                end
                                Snacks.picker.files()
                            end
                        end,
                    })
                end,
                desc = "Projects"
            },
            -- Bookmarked files (harpoon replacement)
            {
                "<leader>fm",
                function()
                    local bookmarks = {
                        { name = "Neovim Keybinds", path = "~/.config/nvim/keybindings.org" },
                        { name = "Ghostty Config",  path = "~/.config/ghostty/config" },
                        -- Add more bookmarks here
                    }
                    Snacks.picker.pick({
                        title = "Bookmarks",
                        items = vim.tbl_map(function(b)
                            return { text = b.name, file = vim.fn.expand(b.path) }
                        end, bookmarks),
                        format = function(item)
                            return { { item.text } }
                        end,
                        confirm = function(picker, item)
                            picker:close()
                            if item then vim.cmd("edit " .. item.file) end
                        end,
                    })
                end,
                desc = "Bookmarks"
            },
            { "<leader>pk",  function() Snacks.picker.keymaps({ layout = "ivy" }) end,         desc = "Keymaps" },
            { "<leader>qf",  function() Snacks.picker.qflist() end,                            desc = "Quickfix" },
            -- Git
            { "<leader>gl",  function() Snacks.lazygit() end,                                  desc = "Lazygit" },
            { "<leader>gbr", function() Snacks.picker.git_branches({ layout = "select" }) end, desc = "Git Branches" },
            { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
        },
    },
}
