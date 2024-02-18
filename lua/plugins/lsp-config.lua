return {
    {
    "williamboman/mason.nvim",

    config = function()
        require("mason").setup()
    end
    },

    {
    "williamboman/mason-lspconfig.nvim",

    config = function()
        require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls",
                    "bashls",
                    "clangd",
                    "cssls",
                    "dockerls",
                    "gopls",
                    "html",
                    "tsserver",
                    "julials",
                    "ltex",
                    "marksman",
                    "pyright",
                    "rust_analyzer",
                    "svelte",
                    "sqlls",
                    "taplo",
                    "vuels",
                    "yamlls" }
            })
    end
    },

    {
    "neovim/nvim-lspconfig",

        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            lspconfig.bashls.setup({})
            lspconfig.clangd.setup({})
            lspconfig.cssls.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.gopls.setup({})
            lspconfig.html.setup({})
            lspconfig.tsserver.setup({})
            lspconfig.julials.setup({})
            lspconfig.ltex.setup({})
            lspconfig.marksman.setup({})
            lspconfig.pyright.setup({})
            lspconfig.rust_analyzer.setup({})
            lspconfig.svelte.setup({})
            lspconfig.taplo.setup({})
            lspconfig.vuels.setup({})
            lspconfig.yamlls.setup({})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        end
    },
}
