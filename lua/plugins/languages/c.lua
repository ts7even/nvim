return {
    -- C/C++ LSP
    {
        "neovim/nvim-lspconfig",
        ft = { "c", "cpp", "h", "hpp","cuda"},
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            
            vim.lsp.config('clangd', {
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
            vim.lsp.enable('clangd')
        end,
    },
    -- C/C++ Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters = opts.formatters or {}
            
            opts.formatters_by_ft.c = { "clang-format" }
            opts.formatters_by_ft.cpp = { "clang-format" }
            
            opts.formatters["clang-format"] = {
                prepend_args = {
                    "--style={IndentWidth: 4, UseTab: Never, TabWidth: 4, BreakBeforeBraces: Attach, ColumnLimit: 80, IndentCaseLabels: true, AlignConsecutiveAssignments: false, AlignConsecutiveDeclarations: false, AllowShortFunctionsOnASingleLine: None, BinPackParameters: false, AlignAfterOpenBracket: AlwaysBreak, AllowAllParametersOfDeclarationOnNextLine: false}",
                },
            }
        end,
    },
}
