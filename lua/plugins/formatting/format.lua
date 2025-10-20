return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>fc",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format code",
            },
        },
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },

                -- C/C++
                c = { "clang-format" },
                cpp = { "clang-format" },

                -- JavaScript/TypeScript/JSON
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },

                -- Markdown - only line wrapping at 81 chars
                markdown = { "prettier" },

                -- Other languages
                cmake = { "cmake_format" },
                sql = { "sqlfmt" },
                yaml = { "yamlfmt" },
                yml = { "yamlfmt" },

                -- Python (if you use it)
                python = { "ruff_format", "ruff_organize_imports" },

                -- Go (if you use it)
                go = { "gofmt", "goimports" },

                -- Rust (if you use it)
                rust = { "rustfmt" },
            },

            -- Customize formatters
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "--style={IndentWidth: 4, UseTab: Never, TabWidth: 4, BreakBeforeBraces: Allman, ColumnLimit: 100, IndentCaseLabels: true, AlignConsecutiveAssignments: false, AlignConsecutiveDeclarations: false}",
                    },
                },
                prettier = {
                    prepend_args = { 
                        "--tab-width", "2", 
                        "--use-tabs", "false", 
                        "--print-width", "81", 
                        "--prose-wrap", "preserve",
                        "--embedded-language-formatting", "auto"
                    },
                },
            },

            -- Set up format on save
            format_on_save = function(bufnr)
                -- For all filetypes, use default options
                return {
                    timeout_ms = 500,
                    lsp_fallback = true,
                }
            end,
        },
        init = function()
            -- If you want to use conform for gq formatting
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}