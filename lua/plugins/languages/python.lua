return {
    -- Python LSP
    {
        "neovim/nvim-lspconfig",
        ft = "python",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            -- LSP attach function for Python (Ruff + Pyright setup)
            local on_attach = function(client, bufnr)
                -- Disable hover for Ruff to let Pyright handle it
                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end
            end

            -- Python LSP setup (dual setup for linting + type checking)
            vim.lsp.config.pyright({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    pyright = {
                        disableOrganizeImports = true, -- Let Ruff handle imports
                    },
                    python = {
                        analysis = {
                            ignore = { "*" }, -- Let Ruff handle linting
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            vim.lsp.config.ruff({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    ruff = {
                        format = { enable = true },
                        lint = { enable = true },
                        organizeImports = true,
                    },
                },
            })
        end,
    },
    -- Python Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.python = { "ruff_format", "ruff_organize_imports" }
        end,
    },
}
