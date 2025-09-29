return {
    {
        "neovim/nvim-lspconfig",
        ft = "zig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config('zls', {
                capabilities = capabilities,
                settings = {
                    zls = {
                        enable_snippets = true,
                        enable_argument_placeholders = true,
                        enable_build_on_save = true,
                        enable_autofix = true,
                        semantic_tokens = "full",
                    },
                },
            })
        end,
    },
}
