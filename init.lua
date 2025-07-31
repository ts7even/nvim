--[[
================================================================================
                              NEOVIM CONFIGURATION
================================================================================
A consolidated Neovim configuration with all plugins, options, and keymaps
in a single init.lua file for easy management and portability.

Author: bourbon
Date: July 30, 2025
================================================================================
--]]

--[[
================================================================================
                                 VIM OPTIONS
================================================================================
Core Neovim settings and editor behavior configuration
--]]

-- Set leader key (must be set before lazy.nvim)
vim.g.mapleader = " "

-- Indentation settings
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Number of spaces that a tab counts for
vim.opt.softtabstop = 4       -- Number of spaces for tab in insert mode
vim.opt.shiftwidth = 4        -- Number of spaces for each step of autoindent

-- Editor behavior
vim.opt.relativenumber = true         -- Show relative line numbers
vim.opt.number = true                 -- Show absolute line number on current line
vim.opt.clipboard = "unnamedplus"     -- Use system clipboard
vim.opt.textwidth = 120                -- Automatically wrap text at 120 characters
vim.opt.conceallevel = 1              -- Conceal level for special characters
vim.opt.ignorecase = true             -- Ignore case in search patterns
vim.opt.smartcase = true              -- Override ignorecase if search contains uppercase
vim.opt.scrolloff = 8                 -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8             -- Keep 8 columns visible left/right of cursor

-- Auto format on save for various file types
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.lua", "*.js", "*.ts", "*.md", "*.rs", "*.c", "*.toml", "*.yaml", "*.py" },
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

--[[
================================================================================
                                 VIM KEYMAPS
================================================================================
Custom key mappings for enhanced workflow and plugin integration
--]]

-- Diagnostic keymaps for LSP error/warning navigation
vim.keymap.set("n", "<leader>dl", vim.diagnostic.open_float, { 
    noremap = true, 
    silent = true, 
    desc = "Show line diagnostics" 
})
vim.keymap.set("n", "<leader>df", vim.diagnostic.setqflist, { 
    noremap = true, 
    silent = true, 
    desc = "Show all diagnostics in quickfix" 
})

-- Rust-specific keymaps
vim.keymap.set("n", "<leader>a", "<Plug>RustHoverAction", { desc = "Rust hover actions" })

-- GitHub Copilot keymaps
vim.keymap.set("n", "<leader>ce", ":Copilot enable<CR>", { desc = "Enable Copilot" })
vim.keymap.set("n", "<leader>cd", ":Copilot disable<CR>", { desc = "Disable Copilot" })
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>", { desc = "Toggle Copilot Chat" })
vim.keymap.set("v", "<leader>cq", ":CopilotChatVisual<CR>", { desc = "Ask Copilot about selection" })
vim.keymap.set("n", "<leader>cq", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })

-- File tree navigation
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

--[[
================================================================================
                              LAZY.NVIM SETUP
================================================================================
Plugin manager initialization and auto-installation
--]]

-- Initialize lazy.nvim plugin manager
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

--[[
================================================================================
                              PLUGIN CONFIGURATION
================================================================================
All plugin definitions, configurations, and plugin-specific settings
--]]

-- Plugin configuration
require("lazy").setup({

--[[
================================================================================
                              FILE MANAGEMENT
================================================================================
--]]

  -- File tree explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

--[[
================================================================================
                                 UI COMPONENTS
================================================================================
--]]

  -- Dashboard/startup screen with ASCII art
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
    ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆
    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦
          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄
           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄
          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀
   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄
  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄
 ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄
 ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄
      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆
       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃
]]

      logo = string.rep("\n", 5) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = "find file", icon = " ", key = "<space>ff" },
            { action = "Telescope oldfiles", desc = "recent files", icon = " ", key = "<space>fr" },
            { action = "Telescope buffers", desc = "buffers", icon = " ", key = "<space>fb" },
            { action = "Telescope live_grep", desc = "find text", icon = " ", key = "<space>fg" },
            { action = "NvimTreeToggle", desc = "file tree", icon = " ", key = "<space>e" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
        button.key_format = string.gsub(button.key, "<space>", "   SPC ")
      end

      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  -- Color scheme/theme
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme onedark")
    end,
  },

  -- Status line at bottom of screen
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'everforest'
        }
      })
    end
  },

--[[
================================================================================
                              FUZZY FINDING
================================================================================
--]]

  -- Main telescope plugin for fuzzy finding files, text, etc.
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        pickers = {
          oldfiles = {
            cwd_only = true,  -- Show only recent files from current project
          }
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      -- Telescope keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fr", function()
        builtin.oldfiles({ cwd_only = true })
      end, { desc = "Recent files (project only)" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    end,
  },

  -- UI select integration for telescope
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },

--[[
================================================================================
                               SYNTAX HIGHLIGHTING
================================================================================
--]]

  -- Treesitter for advanced syntax highlighting and parsing
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,               -- Automatically install parsers
        highlight = { enable = true },     -- Enable syntax highlighting
        indent = { enable = true },        -- Enable treesitter-based indentation
      })
    end
  },

--[[
================================================================================
                           LANGUAGE SERVER PROTOCOL (LSP)
================================================================================
--]]

  -- LSP installer and manager
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
        },
        automatic_installation = true,  -- Auto-install missing servers
      })
    end,
  },

  -- Main LSP configuration
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

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP attach function for Python (Ruff + Pyright setup)
      local on_attach = function(client, bufnr)
        -- Disable hover for Ruff to let Pyright handle it
        if client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
        end
      end

      local lspconfig = require("lspconfig")

      -- Python LSP setup (dual setup for linting + type checking)
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          pyright = {
            disableOrganizeImports = true,  -- Let Ruff handle imports
          },
          python = {
            analysis = {
              ignore = { "*" },  -- Let Ruff handle linting
            },
          },
        },
      })

      lspconfig.ruff.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ruff = {
            format = { enable = true },
          },
        },
      })

      -- Setup other language servers
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.clangd.setup({ 
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
      })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.gopls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
      lspconfig.svelte.setup({ capabilities = capabilities })
      lspconfig.taplo.setup({ capabilities = capabilities })
      lspconfig.vuels.setup({ capabilities = capabilities })
      lspconfig.yamlls.setup({ capabilities = capabilities })

      -- Global LSP keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
      vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, { desc = "Format code" })
    end,
  },

  -- Rust-specific LSP tools
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
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
      }
    end,
  },

--[[
================================================================================
                              AUTO-COMPLETION
================================================================================
--]]

  -- Snippet engine and LSP completion
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",     -- LuaSnip completion source
      "rafamadriz/friendly-snippets",  -- Collection of snippets
    },
  },

  -- Main completion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
      "L3MON4D3/LuaSnip",      -- Snippet engine
    },
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
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
          { name = "nvim_lsp" },  -- LSP completions
          { name = "luasnip" },   -- Snippet completions
        }, {
          { name = "buffer" },    -- Buffer completions
        }),
      })
    end,
  },

--[[
================================================================================
                              AI ASSISTANCE
================================================================================
--]]

  -- GitHub Copilot AI code completion
  {
    "https://github.com/github/copilot.vim",
    lazy = false,
  },

  -- GitHub Copilot Chat interface
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "CopilotChat",
    config = true,
  },

--[[
================================================================================
                              UTILITY PLUGINS
================================================================================
--]]

  -- Surround text objects with quotes, brackets, etc.
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- Auto-close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup(opts)

      -- Custom rule for /* */ comments in various languages
      npairs.add_rules({
        Rule("/*", "*/", { "c", "cpp", "java", "javascript", "typescript", "rust", "go" })
          :with_move(function(opts)
            return opts.char == "*"
          end)
          :with_pair(function(opts)
            local prev_char = opts.line:sub(opts.col - 1, opts.col - 1)
            return prev_char ~= "*"
          end),
      })
    end,
  },

--[[
================================================================================
                            FORMATTING & LINTING
================================================================================
--]]

  -- Additional formatters and linters
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Lua formatter
          null_ls.builtins.formatting.stylua,
          
          -- C/C++ formatter
          null_ls.builtins.formatting.clang_format.with({
            extra_args = { 
              "--style={IndentWidth: 4, UseTab: Never, TabWidth: 4, BreakBeforeBraces: Allman, ColumnLimit: 100, IndentCaseLabels: true, AlignConsecutiveAssignments: false, AlignConsecutiveDeclarations: false}"
            },
          }),
          
          -- JavaScript/TypeScript formatter
          null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "typescript", "json" },
          }),

          -- Markdown formatters
          null_ls.builtins.formatting.mdformat.with({
            filetypes = { "markdown" },
            extra_args = { "--wrap", "100" },
          }),
          null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.diagnostics.markdownlint,

          -- Other formatters
          null_ls.builtins.formatting.cmake_format,  -- CMake
          null_ls.builtins.formatting.sqlfmt,        -- SQL
          null_ls.builtins.formatting.yamlfmt,       -- YAML
          
          -- Spell checking
          null_ls.builtins.completion.spell,
        },
      })
    end,
  },

--[[
================================================================================
                              MARKDOWN SUPPORT
================================================================================
--]]

  -- Live markdown preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

--[[
================================================================================
                              DATABASE TOOLS
================================================================================
--]]

  -- Database interface and query execution
  {
    "tpope/vim-dadbod",
    lazy = true,
  },

  -- UI for vim-dadbod with connection management
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      "tpope/vim-dadbod",
      "kristijanhusak/vim-dadbod-completion",
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Database UI configuration
      vim.g.db_ui_use_nerd_fonts = 1              -- Use nerd fonts for icons
      vim.g.db_ui_show_database_icon = 1          -- Show database icons
      vim.g.db_ui_force_echo_notifications = 1    -- Force echo notifications
      vim.g.db_ui_win_position = "left"           -- Position UI on the left
      vim.g.db_ui_winwidth = 40                   -- Width of the UI window
      
      -- Auto-execute table helpers
      vim.g.db_ui_auto_execute_table_helpers = 1
      
      -- Save location for connections
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
      
      -- Database completion setup
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", "mysql", "plsql" },
        callback = function()
          require("cmp").setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
              { name = "buffer" },
              { name = "nvim_lsp" },
            },
          })
        end,
      })
      
      -- Database keymaps
      vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { desc = "Toggle Database UI" })
      vim.keymap.set("n", "<leader>dc", ":DBUIAddConnection<CR>", { desc = "Add Database Connection" })
      vim.keymap.set("n", "<leader>dq", ":DBUIFindBuffer<CR>", { desc = "Find Database Buffer" })
    end,
  },

  -- Auto-completion for database queries
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
    lazy = true,
  },

})




