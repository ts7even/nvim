return {
    {
        "https://github.com/github/copilot.vim",
        lazy = false,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", -- optional, for fuzzy search
        },
        cmd = "CopilotChat",
        config = true,
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
    },
    {
        "kylechui/nvim-surround",
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},

        config = function(_, opts)
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")

            npairs.setup(opts)

            -- Add custom rule for /* */
            npairs.add_rules({
                Rule("/*", "*/", { "c", "cpp", "java", "javascript", "typescript", "rust", "go" })
                    :with_move(function(opts)
                        return opts.char == "*"
                    end)
                    :with_pair(function(opts)
                        local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
                        return prev_char ~= "*"
                    end),
            })
        end,
    },
}
