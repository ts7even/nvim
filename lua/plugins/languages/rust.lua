return {
    -- Rust-specific LSP tools
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        ft = "rust",
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(client, bufnr)
                        -- Keep the original Rust code actions keymap since it's specific to rustaceanvim
                        vim.keymap.set("n", "<leader>ca", function()
                            vim.cmd.RustLsp("codeAction")
                        end, { buffer = bufnr, desc = "Rust code actions" })
                    end,
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                },
                tools = {
                    hover_actions = {
                        auto_focus = true,
                    },
                },
            }
        end,
    },
    -- Rust Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.rust = { "rustfmt" }
        end,
    },
}
