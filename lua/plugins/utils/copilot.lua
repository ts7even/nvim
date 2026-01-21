return {
    -- Copilot.lua - Inline code suggestions (ghost text autocompletion)
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<Tab>",
                    accept_word = false,
                    accept_line = false,
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = {
                enabled = true,
                auto_refresh = false,
                keymap = {
                    jump_prev = "[[",
                    jump_next = "]]",
                    accept = "<CR>",
                    refresh = "gr",
                    open = "<M-CR>",
                },
            },
            filetypes = {
                yaml = false,
                markdown = false,
                help = false,
                gitcommit = false,
                gitrebase = false,
                ["."] = false,
            },
        },
    },

    -- Claude Code - AI coding agent with terminal integration
    {
        "coder/claudecode.nvim",
        dependencies = { "folke/snacks.nvim" },
        keys = {
            { "<leader>ait", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
            { "<leader>aif", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
            { "<leader>air", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
            { "<leader>aiR", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
            { "<leader>aim", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Model" },
            { "<leader>aib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Buffer to Claude" },
            { "<leader>ais", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send Selection to Claude" },
            { "<leader>aid", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
            { "<leader>aix", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Reject Diff" },
        },
        cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSend", "ClaudeCodeAdd", "ClaudeCodeSelectModel", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
        opts = {
            terminal = {
                split_side = "right",
                split_width_percentage = 0.40,
                provider = "snacks",
            },
            diff_opts = {
                auto_close_on_accept = true,
                vertical_split = true,
            },
        },
    },

    -- CodeCompanion.nvim - AI coding assistant with multiple LLM and agent support
    {
        "olimorris/codecompanion.nvim",
        version = "v17.33.0", -- Pin to avoid breaking changes
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>aic", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat", mode = { "n", "v" } },
            { "<leader>aii", "<cmd>CodeCompanion<cr>", desc = "AI Inline", mode = { "n", "v" } },
            { "<leader>aia", "<cmd>CodeCompanionActions<cr>", desc = "AI Actions", mode = { "n", "v" } },
        },
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
        opts = {
            -- Default strategies for different use cases
            strategies = {
                chat = {
                    adapter = "copilot", -- Default to Copilot for chat
                    model = "claude-opus-4.5"
                },
                inline = {
                    adapter = "copilot", -- Default to Copilot for inline assistance
                    model = "gemini-3-pro-preview"
                },
            },
            -- Display configuration
            display = {
                action_palette = {
                    provider = "default", -- Options: 'default', 'telescope', 'mini_pick', 'snacks'
                },
                chat = {
                    window = {
                        layout = "float", -- Options: 'float', 'vertical', 'horizontal'
                        width = 0.8, -- Float width (0-1 for percentage, >1 for fixed)
                        height = 0.8, -- Float height
                        border = "rounded", -- Border style
                        title = "CodeCompanion Chat",
                        zindex = 100,
                    },
                    show_settings = false, -- Show settings in chat buffer
                    show_token_count = true, -- Show token count
                },
            },
            -- Options configuration
            opts = {
                log_level = "INFO", -- Options: 'ERROR', 'WARN', 'INFO', 'DEBUG', 'TRACE'
                send_code = true, -- Send code context automatically
                use_default_actions = true, -- Enable default actions in action palette
                use_default_prompts = true, -- Enable default prompts
            },
        },
    },
}
