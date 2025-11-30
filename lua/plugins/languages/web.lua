return {
    -- HTML/CSS/Tailwind LSP
    {
        "neovim/nvim-lspconfig",
        ft = { "html", "css", "scss", "less", "javascriptreact", "typescriptreact" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- HTML LSP
            vim.lsp.config.html({
                capabilities = capabilities,
                filetypes = { "html" },
                settings = {
                    html = {
                        format = {
                            enable = false, -- Use prettier instead
                        },
                    },
                },
            })

            -- CSS LSP
            vim.lsp.config.cssls({
                capabilities = capabilities,
                filetypes = { "css", "scss", "less" },
                settings = {
                    css = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore", -- For Tailwind @apply, @layer, etc.
                        },
                    },
                    scss = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                    less = {
                        validate = true,
                        lint = {
                            unknownAtRules = "ignore",
                        },
                    },
                },
            })

            -- Tailwind CSS LSP
            vim.lsp.config.tailwindcss({
                capabilities = capabilities,
                filetypes = {
                    "html",
                    "css",
                    "scss",
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
                                { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                            },
                        },
                        validate = true,
                        classAttributes = { "class", "className", "classList", "ngClass" },
                    },
                },
            })
        end,
    },
    -- HTML/CSS Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters = opts.formatters or {}
            
            opts.formatters_by_ft.html = { "prettier" }
            opts.formatters_by_ft.css = { "prettier" }
            opts.formatters_by_ft.scss = { "prettier" }
            
            -- Prettier config is already defined in javascript.lua, 
            -- but we ensure it exists here too
            opts.formatters.prettier = opts.formatters.prettier or {
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
