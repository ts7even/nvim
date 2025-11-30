return {
    -- SQL Formatter
    {
        "stevearc/conform.nvim",
        optional = true,
        ft = "sql",
        opts = function(_, opts)
            opts.formatters_by_ft = opts.formatters_by_ft or {}
            opts.formatters_by_ft.sql = { "sqlfmt" }
        end,
    },
}
