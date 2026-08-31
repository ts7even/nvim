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
                    "pyright",       -- Python types/completions
                    "ruff",          -- Python linting/formatting
                    "rust_analyzer", -- Rust
                    "zls",           -- Zig
                    "marksman",      -- Markdown
                    "taplo",         -- TOML
                    "yamlls",        -- YAML
                    "jsonls",        -- JSON
                    "ts_ls",         -- TypeScript (needed by Svelte)
                    "svelte",        -- Svelte
                    "html",          -- HTML
                    "cssls",         -- CSS/SCSS/LESS
                    "emmet_language_server", -- Emmet abbreviations (html/css/svelte)
                },
                -- mason-lspconfig v2 auto-enables every installed server
                -- (`automatic_enable`, on by default); the explicit
                -- vim.lsp.enable() calls below just make that intent visible.
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
                -- No insert-mode <C-k> here: it would shadow blink.cmp's own
                -- <C-k> (show_signature/hide_signature), which toggles rather
                -- than only opening, and falls back when no server answers.
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
                    -- Honour .clangd / compile_flags.txt in the project root,
                    -- so a tree without compile_commands.json still resolves
                    -- includes instead of silently completing nothing.
                    "--enable-config",
                    -- Complete symbols from headers that aren't included yet
                    -- (paired with --header-insertion=iwyu above).
                    "--all-scopes-completion",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            })
            vim.lsp.enable("clangd")

            -- Python (Pyright for types/completions, Ruff for linting/formatting)
            --
            -- Pyright resolves imports against a single interpreter. Without
            -- being told which one, it uses the first `python3` on $PATH and
            -- therefore sees none of the project's site-packages -- the usual
            -- reason completion for a third-party class comes up empty. Find
            -- the venv per project root and hand over its interpreter.
            --
            -- The root's own venv wins over VIRTUAL_ENV. Both are consulted
            -- because VIRTUAL_ENV covers the venv-outside-the-tree case (and
            -- the shell having activated one before nvim started), but it is a
            -- single session-wide value: with a client per root, checking it
            -- first would give every project the interpreter of whichever one
            -- was activated last.
            local function python_path(root)
                for _, name in ipairs({ ".venv", "venv", ".env" }) do
                    local p = vim.fs.joinpath(root, name, "bin", "python")
                    if vim.uv.fs_stat(p) then
                        return p
                    end
                end
                if vim.env.VIRTUAL_ENV then
                    return vim.env.VIRTUAL_ENV .. "/bin/python"
                end
                return vim.fn.exepath("python3")
            end

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                before_init = function(_, config)
                    -- Mutate the settings table in place. The client captures
                    -- this exact table before before_init runs, so assigning a
                    -- new one (config.settings = ...) is silently dropped.
                    local settings = config.settings
                    settings.python = settings.python or {}
                    settings.python.pythonPath = python_path(config.root_dir or vim.fn.getcwd())
                end,
                settings = {
                    pyright = { disableOrganizeImports = true },
                    python = {
                        analysis = {
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
                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
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
            local ra_capabilities = vim.deepcopy(capabilities)
            ra_capabilities.workspace = ra_capabilities.workspace or {}
            ra_capabilities.workspace.didChangeWatchedFiles = ra_capabilities.workspace.didChangeWatchedFiles or {}
            ra_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

            vim.lsp.config("rust_analyzer", {
                capabilities = ra_capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = false,
                            loadOutDirsFromCheck = true,
                        },
                        numThreads = 4,
                        checkOnSave = true,
                        check = {
                            command = "clippy",
                            extraArgs = { "--no-deps" },
                        },
                        procMacro = {
                            enable = true,
                        },
                        files = {
                            excludeDirs = {
                                ".direnv",
                                ".git",
                                ".github",
                                ".gitlab",
                                "node_modules",
                                "target",
                            },
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

            -- HTML. vscode-html-language-server only returns completions when
            -- the client advertises snippet support; blink's capabilities do.
            -- Inside .svelte files the svelte server covers markup instead.
            vim.lsp.config("html", { capabilities = capabilities })
            vim.lsp.enable("html")

            -- CSS / SCSS / LESS
            vim.lsp.config("cssls", { capabilities = capabilities })
            vim.lsp.enable("cssls")

            -- Emmet abbreviations (div.foo>ul>li*3<Tab>) for markup filetypes,
            -- including svelte.
            vim.lsp.config("emmet_language_server", { capabilities = capabilities })
            vim.lsp.enable("emmet_language_server")

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
                    if vim.bo.filetype == "org" then
                        local view = vim.fn.winsaveview()
                        vim.cmd("normal! gggqG")
                        vim.fn.winrestview(view)
                    elseif vim.bo.filetype == "zig" then
                        -- zig fmt never reflows comments, so format the code
                        -- first (sync), then reflow only contiguous comment
                        -- blocks (//, ///, //!). Reflowing the whole buffer
                        -- (gggqG) would absorb code into the doc comment above
                        -- it, so each comment block is gq'd in isolation.
                        require("conform").format({ async = false, lsp_fallback = true })
                        local view = vim.fn.winsaveview()
                        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                        local blocks, i = {}, 1
                        while i <= #lines do
                            if lines[i]:match("^%s*//") then
                                local s = i
                                while i <= #lines and lines[i]:match("^%s*//") do
                                    i = i + 1
                                end
                                table.insert(blocks, { s, i - 1 })
                            else
                                i = i + 1
                            end
                        end
                        -- bottom-to-top so earlier line numbers stay valid as
                        -- blocks grow/shrink during reflow.
                        for b = #blocks, 1, -1 do
                            local s, e = blocks[b][1], blocks[b][2]
                            vim.cmd(string.format("silent! normal! %dG%dgqq", s, e - s + 1))
                        end
                        vim.fn.winrestview(view)
                    else
                        require("conform").format({ async = true, lsp_fallback = true })
                    end
                end,
                mode = "",
                desc = "Format code",
            },
        },
        opts = {
            format_on_save = false,
            formatters_by_ft = {
                lua = { "stylua" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                python = { "ruff_format", "ruff_organize_imports" },
                rust = { "rustfmt" },
                zig = { "zigfmt" },
                markdown = { "injected" },
                toml = { "taplo" },
                yaml = { "yamlfmt" },
                yml = { "yamlfmt" },
                json = { "prettier" },
                svelte = { "prettier" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                org = { "injected" },
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
                    local dominated_by_cindent = { c = true, cpp = true }
                    if dominated_by_cindent[vim.bo.filetype] then
                        return
                    end
                    if pcall(vim.treesitter.start) then
                        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
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

    -- Markdown tables: on-demand alignment with <leader>mt (:TableModeRealign).
    -- No live/auto formatting and no <Tab> cell navigation by choice; loads
    -- lazily when one of its commands is used. <leader>mt is mapped per
    -- markdown buffer in settings.lua.
    {
        "dhruvasagar/vim-table-mode",
        cmd = { "TableModeToggle", "TableModeEnable", "TableModeRealign", "Tableize" },
        init = function()
            -- GitHub-flavoured corners so separators render as | --- | --- |
            vim.g.table_mode_corner = "|"
            -- Keep its default mappings off the <Leader>t terminal group.
            vim.g.table_mode_map_prefix = "<Leader>T"
        end,
    },

    -- Markdown preview
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- Markdown preview #2: peek renders through Deno and scroll-syncs with the
    -- buffer as you type. `app = "browser"` sends the page to $BROWSER instead
    -- of peek's own webview window, which is the reason to pick it over the
    -- webview default -- the webview build needs libwebkit2gtk at runtime.
    --
    -- Deno comes from mise. The build step runs in whatever environment lazy
    -- was started in, so `deno` has to be on PATH there; the mise shim at
    -- ~/.local/share/mise/shims/deno is the stable path if a desktop launcher
    -- ever starts nvim without mise activated.
    --
    -- Defines no commands of its own, so they are created below.
    {
        "toppair/peek.nvim",
        build = "deno task --quiet build:fast",
        ft = { "markdown" },
        cmd = { "PeekOpen", "PeekClose", "PeekToggle" },
        config = function()
            local peek = require("peek")
            peek.setup({
                app = "browser",
                theme = "dark",       -- matches kanagawa-wave
                update_on_change = true,
                close_on_bdelete = true,
            })
            vim.api.nvim_create_user_command("PeekOpen", peek.open, { desc = "Peek: preview in browser" })
            vim.api.nvim_create_user_command("PeekClose", peek.close, { desc = "Peek: close preview" })
            vim.api.nvim_create_user_command("PeekToggle", function()
                if peek.is_open() then peek.close() else peek.open() end
            end, { desc = "Peek: toggle preview" })
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
