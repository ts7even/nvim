return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.prettier.with({
                    filetypes = { "javascript", "typescript" },
                }),

                null_ls.builtins.formatting.mdformat.with({
                    filetypes = { "markdown" },
                    extra_args = { "--wrap", "80" },
                }),
                null_ls.builtins.formatting.markdownlint,
                null_ls.builtins.formatting.cmake_format,
                null_ls.builtins.formatting.sqlfmt,
                null_ls.builtins.formatting.yamlfmt,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.completion.spell,
            },
        })
        vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, {})
    end,
}
