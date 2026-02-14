return {
    -- Mason: LSP installer
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
                    "lua_ls",        -- Lua (for Neovim config)
                    "clangd",        -- C and CPP
                    "ruff",          -- Python linting/formatting
                    "rust_analyzer", -- Rust
                    "zls",           -- Zig
                    "marksman",      -- Markdown
                    "taplo",         -- TOML
                    "yamlls",        -- YAML
                    "jsonls",        -- JSON
                    "ts_ls",         -- TypeScript (needed by Svelte)
                    "svelte",        -- Svelte
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
            "saghen/blink.cmp",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()

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
                vim.keymap.set("n", "<leader>cd", function() Snacks.picker.lsp_definitions() end,
                    { desc = "Goto Definition" })
                vim.keymap.set("n", "<leader>cr", function() Snacks.picker.lsp_references() end, { desc = "References" })
                vim.keymap.set("n", "<leader>ci", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
                vim.keymap.set("n", "<leader>cy", vim.lsp.buf.type_definition, { desc = "Goto Type Definition" })
                vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
                vim.keymap.set("n", "<leader>ck", vim.lsp.buf.hover, { desc = "Hover Documentation" })
                vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
                vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
                vim.keymap.set({ "n", "x" }, "<leader>cl", vim.lsp.codelens.run, { desc = "Run Codelens" })
                vim.keymap.set("n", "<leader>cL", vim.lsp.codelens.refresh, { desc = "Refresh Codelens" })
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
                init_options = {
                    settings = {
                        format = { preview = true },
                        lint = { preview = true },
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

            -- Rust
            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                            loadOutDirsFromCheck = true,
                        },
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                        },
                        procMacro = {
                            enable = true,
                        },
                        inlayHints = {
                            enable = true,
                            chainingHints = true,
                            parameterHints = true,
                            typeHints = true,
                        },
                    },
                },
            })
            vim.lsp.enable("rust_analyzer")

            -- TypeScript
            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                init_options = {
                    plugins = {
                        {
                            name = "typescript-svelte-plugin",
                            location = vim.fn.stdpath("data") ..
                                "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
                        },
                    },
                },
            })
            vim.lsp.enable("ts_ls")

            -- Svelte
            vim.lsp.config("svelte", { capabilities = capabilities })
            vim.lsp.enable("svelte")

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
                        validate = { enable = true },
                    },
                },
            })
            vim.lsp.enable("jsonls")
        end,
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo", "ConformEnable", "ConformDisable" },
        keys = {
            {
                "<leader>cf",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format code",
            },
        },
        opts = {
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = false,
            },
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
                svelte = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
            },
            formatters = {
                ["clang-format"] = {
                    prepend_args = {
                        "--style={BasedOnStyle: LLVM, IndentWidth: 4, ColumnLimit: 80, BinPackParameters: false, AllowAllParametersOfDeclarationOnNextLine: false, AlignAfterOpenBracket: AlwaysBreak, BreakAfterReturnType: None, PenaltyReturnTypeOnItsOwnLine: 1000}",
                    },
                },
                prettier = {
                    prepend_args = function(_, ctx)
                        local args = {
                            "--tab-width", "2",
                            "--print-width", "80",
                            "--prose-wrap", "always",
                        }
                        -- Add svelte plugin when formatting svelte files
                        if vim.bo[ctx.buf].filetype == "svelte" then
                            local root = vim.fs.root(ctx.buf, { "package.json" }) or "."
                            local plugin_path = root .. "/node_modules/prettier-plugin-svelte"
                            if vim.uv.fs_stat(plugin_path) then
                                vim.list_extend(args, { "--plugin", "prettier-plugin-svelte" })
                            end
                        end
                        return args
                    end,
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
        build = ":TSUpdate",
        lazy = false,
        config = function()
            require("nvim-treesitter").setup()

            -- Install parsers if missing
            local langs = {
                "lua", "c", "cpp", "python", "rust", "zig",
                "markdown", "markdown_inline", "make", "cmake",
                "toml", "yaml", "json", "svelte", "typescript",
                "javascript", "html", "css",
            }
            local installed = require("nvim-treesitter.config").get_installed()
            local to_install = vim.tbl_filter(function(lang)
                return not vim.list_contains(installed, lang)
            end, langs)
            if #to_install > 0 then
                require("nvim-treesitter").install(to_install)
            end

            -- Enable treesitter highlighting and indentation
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    if pcall(vim.treesitter.start) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
            })
        end,
    },

    -- Completion engine
    {
        'saghen/blink.cmp',
        version = '1.*',

        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'super-tab' },

            appearance = {
                -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                nerd_font_variant = 'mono'
            },

            -- (Default) Only show the documentation popup when manually triggered
            completion = { documentation = { auto_show = false } },

            -- Default list of enabled providers defined so that you can extend it
            -- elsewhere in your config, without redefining it, due to `opts_extend`
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                providers = {
                    snippets = {
                        opts = {
                            search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                        },
                    },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
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
            vim.keymap.set("n", "<leader>ump", ":PeekOpen<CR>", { desc = "Markdown preview" })
            vim.keymap.set("n", "<leader>umc", ":PeekClose<CR>", { desc = "Close preview" })
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
