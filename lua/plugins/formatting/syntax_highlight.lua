return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local config = require("nvim-treesitter.configs")
            config.setup({
                auto_install = true, -- Automatically install parsers
                highlight = { enable = true }, -- Enable syntax highlighting
                indent = { enable = true }, -- Enable treesitter-based indentation
            })
        end,
    },
}
