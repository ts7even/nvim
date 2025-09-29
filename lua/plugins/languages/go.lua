return {
    {
        "neovim/nvim-lspconfig",
        ft = "go",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config.gopls({
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                        usePlaceholders = true,
                        completeUnimported = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                    },
                },
            })
        end,
    },
}
