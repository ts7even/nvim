-- Leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = "en_us"

-- Editor behavior
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 1
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt_local.colorcolumn = "100"
vim.opt.foldenable = false -- Don't auto-fold files
vim.opt.autoread = true    -- Auto-reload files changed outside of Neovim

-- Tab navigation
vim.keymap.set("n", "<C-M-h>", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "<C-M-l>", "gt", { desc = "Next tab" })

-- Terminal: escape to normal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
