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

            -- Show the signature/docs for the selected item automatically, so
            -- the completion list explains what each method takes instead of
            -- needing <C-space> a second time. <C-b>/<C-f> scroll it.
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 250,
                },
            },

            -- Parameter hints while typing inside a call. <C-k> toggles it.
            signature = { enabled = true },

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
