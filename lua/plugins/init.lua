local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and load all plugin configurations
require("lazy").setup({
    -- AI plugins
    { import = "plugins.ai" },
    
    -- Formatting plugins
    { import = "plugins.formatting" },
    
    -- Language plugins
    { import = "plugins.languages" },
    
    -- Navigation plugins
    { import = "plugins.navigation" },
    
    -- Notes plugins
    { import = "plugins.notes" },
    
    -- UI plugins
    { import = "plugins.ui" },
    
    -- Utility plugins
    { import = "plugins.utils" },
}, {
    -- Lazy.nvim configuration options
    ui = {
        border = "rounded",
    },
    change_detection = {
        notify = false,
    },
})
