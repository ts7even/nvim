return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},

    config = function(_, opts)
        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")

        npairs.setup(opts)

        -- Add custom rule for /* */
        npairs.add_rules({
            Rule("/*", "*/", { "c", "cpp", "java", "javascript", "typescript", "rust", "go" }):with_move(function(opts)
                return opts.char == "*"
            end):with_pair(function(opts)
                local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
                return prev_char ~= "*"
            end),
        })
    end,
}
