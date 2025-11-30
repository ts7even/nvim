return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                transparent_background = false, -- disables setting the background color
            })
            -- Set the color scheme to Catppuccin Mocha
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
