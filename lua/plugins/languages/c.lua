return {
    {
        "neovim/nvim-lspconfig",
        ft = { "c", "cpp", "h", "hpp","cuda"},
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config.clangd({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            })
        end,
    },
}
