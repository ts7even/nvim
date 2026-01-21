-- Unified language support for: C, C++, Python, Rust, Zig, Markdown, TOML, YAML, JSON, Lua
return {
    -- Mason: LSP/Formatter installer
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason-LSPConfig bridge
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",   -- Lua (for Neovim config)
                    -- clangd: use system clang package (pacman -S clang)
                    "pyright",  -- Python type checking
                    "ruff",     -- Python linting/formatting
                    "zls",      -- Zig
                    "marksman", -- Markdown
                    "taplo",    -- TOML
                    "yamlls",   -- YAML
                    "jsonls",   -- JSON
                    -- cmake: requires Python <3.14, install via pipx if needed
                },
                automatic_installation = true,
            })
        end,
    },

    -- Main LSP configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Diagnostics configuration
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                signs = true,
            })

            -- Global LSP keymaps
            local function setup_keymaps()
                vim.keymap.set("n", "<leader>cl", function() Snacks.picker.lsp_config() end, { desc = "LSP Info" })
                vim.keymap.set("n", "<leader>gd", function() Snacks.picker.lsp_definitions() end,
                    { desc = "Goto Definition" })
                vim.keymap.set("n", "<leader>gr", function() Snacks.picker.lsp_references() end, { desc = "References" })
                vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
                vim.keymap.set("n", "<leader>gy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
                vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
                vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover Documentation" })
                vim.keymap.set("n", "<leader>gk", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                vim.keymap.set({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
                vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh Codelens" })
                vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
                vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
                vim.keymap.set("n", "<leader>df", vim.diagnostic.setqflist, { desc = "All Diagnostics" })
            end
            setup_keymaps()

            -- Lua (for Neovim config)
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                        hint = { enable = true },
                    },
                },
            })
            vim.lsp.enable("lua_ls")

            -- C/C++ with clangd
            vim.lsp.config("clangd", {
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                    "--function-arg-placeholders",
                    "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            })
            vim.lsp.enable("clangd")

            -- Python (Pyright + Ruff)
            local python_on_attach = function(client, bufnr)
                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false
                end
            end

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                on_attach = python_on_attach,
                settings = {
                    pyright = { disableOrganizeImports = true },
                    python = {
                        analysis = {
                            ignore = { "*" },
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })
            vim.lsp.enable("pyright")

            vim.lsp.config("ruff", {
                capabilities = capabilities,
                on_attach = python_on_attach,
                settings = {
                    ruff = {
                        format = { enable = true },
                        lint = { enable = true },
                        organizeImports = true,
                    },
                },
            })
            vim.lsp.enable("ruff")

            -- Zig
            vim.lsp.config("zls", {
                capabilities = capabilities,
                settings = {
                    zls = {
                        enable_snippets = true,
                        enable_argument_placeholders = true,
                        enable_build_on_save = true,
                        enable_autofix = true,
                        semantic_tokens = "full",
                    },
                },
            })
            vim.lsp.enable("zls")

            -- Markdown
            vim.lsp.config("marksman", {
                capabilities = capabilities,
                filetypes = { "markdown", "markdown.mdx" },
            })
            vim.lsp.enable("marksman")

            -- TOML
            vim.lsp.config("taplo", { capabilities = capabilities })
            vim.lsp.enable("taplo")

            -- YAML
            vim.lsp.config("yamlls", {
                capabilities = capabilities,
                settings = {
                    yaml = {
                        schemas = {
                            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                            ["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
                        },
                    },
                },
            })
            vim.lsp.enable("yamlls")

            -- JSON
            vim.lsp.config("jsonls", {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")
        end,
    },

    -- JSON schemas
    { "b0o/schemastore.nvim", lazy = true },

    -- Rust (rustaceanvim handles LSP internally)
    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
        ft = "rust",
        config = function()
            vim.g.rustaceanvim = {
                server = {
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<leader>ca", function()
                            vim.cmd.RustLsp("codeAction")
                        end, { buffer = bufnr, desc = "Rust code actions" })
                    end,
                    capabilities = require("cmp_nvim_lsp").default_capabilities(),
                },
                tools = {
                    hover_actions = { auto_focus = true },
                },
            }
        end,
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "ConformEnable", "ConformDisable" },
        keys = {
            {
                "<leader>fc",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format code",
            },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                python = { "ruff_format", "ruff_organize_imports" },
                rust = { "rustfmt" },
                zig = { "zigfmt" },
                markdown = { "prettier" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                yml = { "yamlfmt" },
                json = { "prettier" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "--style={IndentWidth: 4, UseTab: Never, TabWidth: 4, BreakBeforeBraces: Attach, ColumnLimit: 80, IndentCaseLabels: true}",
                    },
                },
                prettier = {
                    prepend_args = {
                        "--tab-width", "2",
                        "--print-width", "80",
                        "--prose-wrap", "preserve",
                    },
                },
            },
        },
        init = function()
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },

    -- Treesitter (parsers installed via :TSInstall or build hook)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSInstall lua c cpp python rust zig markdown markdown_inline make cmake toml yaml json",
        lazy = false,
    },

    -- Completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Markdown rendering
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        config = function()
            require("render-markdown").setup({
                enabled = true,
                max_file_size = 10.0,
                render_modes = { "n", "v" },
                heading = {
                    enabled = true,
                    sign = true,
                    icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                },
                code = {
                    enabled = true,
                    style = "full",
                    width = "full",
                },
                checkbox = {
                    enabled = true,
                    unchecked = { icon = "󰄱 " },
                    checked = { icon = "󰱒 " },
                },
                bullet = {
                    enabled = true,
                    icons = { "●", "○", "◆", "◇" },
                },
            })
        end,
    },

    -- Markdown preview
    {
        "toppair/peek.nvim",
        event = "VeryLazy",
        build = "deno task --quiet build:fast",
        config = function()
            require("peek").setup()
            vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
            vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
            vim.keymap.set("n", "<leader>mp", ":PeekOpen<CR>", { desc = "Markdown preview" })
            vim.keymap.set("n", "<leader>mc", ":PeekClose<CR>", { desc = "Close preview" })
        end,
    },

    -- Markdown extras (folding disabled)
    {
        "preservim/vim-markdown",
        ft = { "markdown" },
        config = function()
            vim.g.vim_markdown_folding_disabled = 1 -- Disable folding
            vim.g.vim_markdown_conceal = 0
            vim.g.vim_markdown_conceal_code_blocks = 0
            vim.g.vim_markdown_frontmatter = 1
            vim.g.vim_markdown_no_default_key_mappings = 1
        end,
    },
}
