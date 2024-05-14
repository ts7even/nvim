return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.formatting.markdownlint,

                -- null_ls.builtins.formatting.goimports-reviser,
                -- null_ls.builtins.formatting.clang-format,
                null_ls.builtins.formatting.autopep8,
                null_ls.builtins.formatting.latexindent,
                null_ls.builtins.formatting.sqlfmt,
                null_ls.builtins.formatting.yamlfmt,
                null_ls.builtins.diagnostics.eslint,
                null_ls.builtins.diagnostics.ruff,
                null_ls.builtins.diagnostics.cpplint,
                null_ls.builtins.diagnostics.markdownlint,
                -- null_ls.builtins.diagnostics.golangci-lint,
                null_ls.builtins.completion.spell,
            },
        })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
