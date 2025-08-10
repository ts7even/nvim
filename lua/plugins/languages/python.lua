return {
    {
        "neovim/nvim-lspconfig",
        ft = "python",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            
            -- LSP attach function for Python (Ruff + Pyright setup)
            local on_attach = function(client, bufnr)
                -- Disable hover for Ruff to let Pyright handle it
                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end
            end

            -- Python LSP setup (dual setup for linting + type checking)
            lspconfig.pyright.setup({
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

            lspconfig.ruff.setup({
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
}
