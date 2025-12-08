return {
    -- JavaScript/TypeScript LSP
    {
        "neovim/nvim-lspconfig",
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            })
            vim.lsp.enable('ts_ls')
        end,
    },
    -- JavaScript/TypeScript Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters = opts.formatters or {}
            
            opts.formatters_by_ft.javascript = { "prettier" }
            opts.formatters_by_ft.typescript = { "prettier" }
            opts.formatters_by_ft.javascriptreact = { "prettier" }
            opts.formatters_by_ft.typescriptreact = { "prettier" }
            opts.formatters_by_ft.json = { "prettier" }
            opts.formatters_by_ft.jsonc = { "prettier" }
            
            opts.formatters.prettier = {
                prepend_args = { 
                    "--tab-width", "2", 
                    "--use-tabs", "false", 
                    "--print-width", "81", 
                    "--prose-wrap", "always",
                    "--embedded-language-formatting", "auto",
                    "--single-attribute-per-line", "false"
                },
            }
        end,
    },
}
