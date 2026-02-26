-- Mini.nvim: Lightweight text manipulation
return {
    {
        "echasnovski/mini.nvim",
        version = "*",
        lazy = false,
        config = function()
            -- Surround text (sa=add, sd=delete, sr=replace)
            require("mini.surround").setup({
                mappings = {
                    add = "sa",
                    delete = "sd",
                    find = "sf",
                    find_left = "sF",
                    highlight = "sh",
                    replace = "sr",
                    update_n_lines = "sn",
                },
            })

            -- Commenting (gc, gcc)
            require("mini.comment").setup({
                mappings = {
                    comment = "gc",
                    comment_line = "gcc",
                    comment_visual = "gc",
                    textobject = "gc",
                },
            })
        end,
    },

    -- Auto-pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            npairs.setup({
                check_ts = true,
            })

            -- Auto-close /* to /**/  with cursor between
            npairs.add_rules({
                Rule("/*", "*/", { "c", "cpp", "java", "javascript", "typescript", "css", "svelte" }),
            })
        end,
    },
}
