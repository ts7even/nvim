return {
    {
        'rebelot/kanagawa.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                compile = false,
                undercurl = true,
                commentStyle = { italic = true },
                keywordStyle = { italic = true },
                transparent = true,
                dimInactive = false,
                terminalColors = true,
                overrides = function(colors)
                    return {
                        -- Keep the line-number gutter transparent
                        LineNr = { bg = "none" },
                        CursorLineNr = { bg = "none" },
                        SignColumn = { bg = "none" },
                        FoldColumn = { bg = "none" },
                    }
                end,
            })
            -- Variants: 'kanagawa-wave' (default), 'kanagawa-dragon', 'kanagawa-lotus' (light)
            vim.cmd.colorscheme('kanagawa-wave')
        end
    }
}
