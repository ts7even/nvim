return {
    -- YAML LSP
    {
        "neovim/nvim-lspconfig",
        ft = { "yaml", "yml" },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config.yamlls({
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
                        },
                    },
                },
            })
        end,
    },
    -- YAML Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.yaml = { "yamlfmt" }
            opts.formatters_by_ft.yml = { "yamlfmt" }
        end,
    },
}
