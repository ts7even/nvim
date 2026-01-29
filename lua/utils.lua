-- Custom utilities

-- Spell suggestions: small floating window, bottom-left, 5 choices
vim.keymap.set("n", "<leader>ss", function()
    local word = vim.fn.expand("<cword>")
    local suggestions = vim.fn.spellsuggest(word, 5)
    if #suggestions == 0 then
        vim.notify("No suggestions for: " .. word, vim.log.levels.WARN)
        return
    end
    vim.ui.select(suggestions, {
        prompt = "Spelling: " .. word,
    }, function(choice)
        if choice then
            vim.cmd("normal! ciw" .. choice)
            vim.cmd("stopinsert")
        end
    end)
end, { desc = "Spelling suggestions" })
