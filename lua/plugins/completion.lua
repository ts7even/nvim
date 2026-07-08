return {
    -- Completion engine
    {
        'saghen/blink.cmp',
        -- Latest released blink (version = '*'): ships a prebuilt fuzzy binary,
        -- so no Rust build step is needed. blink.cmp v2+ requires blink.lib.
        version = '*',
        dependencies = { 'saghen/blink.lib' },

        opts = {
            keymap = { preset = 'super-tab' },

            -- Let Neovim's native wildmenu handle the command line (`:e ~/`).
            -- blink's cmdline path completion is finicky; the native menu has
            -- proper file-browser navigation. See cmdline keys in settings.lua.
            cmdline = { enabled = false },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    snippets = {
                        opts = {
                            search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                        },
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },
}
