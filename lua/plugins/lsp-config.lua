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
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({capabilities = capabilities})
            lspconfig.bashls.setup({capabilities = capabilities})
            lspconfig.clangd.setup({capabilities = capabilities})
            lspconfig.cssls.setup({capabilities = capabilities})
            lspconfig.dockerls.setup({capabilities = capabilities})
            lspconfig.gopls.setup({capabilities = capabilities})
            lspconfig.html.setup({capabilities = capabilities})
            lspconfig.tsserver.setup({capabilities = capabilities})
            lspconfig.julials.setup({capabilities = capabilities})
            lspconfig.ltex.setup({capabilities = capabilities})
            lspconfig.marksman.setup({capabilities = capabilities})
            lspconfig.pyright.setup({capabilities = capabilities})
            lspconfig.rust_analyzer.setup({capabilities = capabilities})
            lspconfig.svelte.setup({capabilities = capabilities})
            lspconfig.taplo.setup({capabilities = capabilities})
            lspconfig.vuels.setup({capabilities = capabilities})
            lspconfig.yamlls.setup({capabilities = capabilities})

            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        end
    },
}
