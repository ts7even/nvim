return {
    -- Snippet engine
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip", -- LuaSnip completion source
            "rafamadriz/friendly-snippets", -- Collection of snippets
        },
        config = function()
            local ls = require("luasnip")
            
            -- Load friendly-snippets
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Load custom snippets from static/snippets.json
            local snippets_path = vim.fn.stdpath("config") .. "/static/snippets.json"
            if vim.fn.filereadable(snippets_path) == 1 then
                local file = io.open(snippets_path, "r")
                if file then
                    local content = file:read("*all")
                    file:close()
                    
                    local snippets = vim.json.decode(content)
                    
                    -- Convert and add snippets for each language
                    for lang, lang_snippets in pairs(snippets) do
                        local snips = {}
                        for name, snippet in pairs(lang_snippets) do
                            table.insert(snips, ls.snippet(
                                snippet.prefix or name,
                                ls.text_node(snippet.body)
                            ))
                        end
                        ls.add_snippets(lang, snips)
                    end
                end
            end
        end,
    },
}
