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
    -- Snacks 
    { import = "plugins.snacks"},
    
    -- Mini.nvim - text manipulation
    { import = "plugins.mini" },
    
    -- Language plugins
    { import = "plugins.languages" },
    
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
    -- Increase timeout for slow connections
    git = {
        timeout = 300, -- 5 minutes timeout (default is 120 seconds)
        url_format = "https://github.com/%s.git",
    },
    install = {
        missing = true,
        colorscheme = { "habamax" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "matchit",
                "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
