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

require("lazy").setup({
    -- Core plugins
    { import = "plugins.snacks" },
    { import = "plugins.mini" },

    -- Languages (unified: C/C++, Python, Rust, Zig, Markdown, Org, TOML, YAML, JSON, Make/CMake)
    { import = "plugins.languages" },

    -- UI
    { import = "plugins.ui" },

    -- Utilities (debug, database, rest, snippets, copilot)
    { import = "plugins.utils" },
}, {
    ui = { border = "rounded" },
    change_detection = { notify = false },
    git = { timeout = 300 },
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
