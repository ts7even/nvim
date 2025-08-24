return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Bridge between mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",      -- Lua
                    "bashls",      -- Bash
                    "clangd",      -- C/C++
                    "cssls",       -- CSS
                    "dockerls",    -- Docker
                    "gopls",       -- Go
                    "html",        -- HTML
                    "ts_ls",       -- TypeScript/JavaScript
                    "marksman",    -- Markdown
                    "ruff",        -- Python linting
                    "pyright",     -- Python type checking
                    "svelte",      -- Svelte
                    "sqlls",       -- SQL
                    "taplo",       -- TOML
                    "vuels",       -- Vue
                    "yamlls",      -- YAML
                    "zls",         -- Zig
                },
                automatic_installation = true, -- Auto-install missing servers
            })
        end,
    },

    -- Main LSP configuration (common setup)
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Diagnostic configuration
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Global LSP keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
            vim.keymap.set("n", "<leader>fc", function()
                local bufnr = vim.api.nvim_get_current_buf()
                vim.lsp.buf.format({ 
                    async = false,  -- Use synchronous for manual formatting
                    bufnr = bufnr,
                    filter = function(client)
                        -- Allow null-ls and other formatting clients
                        return client.supports_method("textDocument/formatting")
                    end
                })
            end, { desc = "Format code" })

            -- Diagnostic keymaps for LSP error/warning navigation
            vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, {
                noremap = true,
                silent = true,
                desc = "Show line diagnostics",
            })
            vim.keymap.set("n", "<leader>df", vim.diagnostic.setqflist, {
                noremap = true,
                silent = true,
                desc = "Show all diagnostics in quickfix",
            })

            -- Setup basic language servers that don't need special configuration
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            
            lspconfig.lua_ls.setup({ capabilities = capabilities })
            lspconfig.bashls.setup({ capabilities = capabilities })
            lspconfig.cssls.setup({ capabilities = capabilities })
            lspconfig.dockerls.setup({ capabilities = capabilities })
            lspconfig.html.setup({ capabilities = capabilities })
            lspconfig.marksman.setup({ capabilities = capabilities })
            lspconfig.svelte.setup({ capabilities = capabilities })
            lspconfig.taplo.setup({ capabilities = capabilities })
            lspconfig.vuels.setup({ capabilities = capabilities })
            lspconfig.yamlls.setup({ capabilities = capabilities })
        end,
    },
}
