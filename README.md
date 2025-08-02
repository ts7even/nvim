# Neovim Configuration

<!--toc:start-->

- [Neovim Configuration](#neovim-configuration)
  - [Overview](#overview)
  - [Installation](#installation)
  - [Configuration Structure](#configuration-structure)
  - [Vim Options](#vim-options)
  - [Key Mappings](#key-mappings)
    - [Leader Key Mappings](#leader-key-mappings)
    - [LSP Key Mappings](#lsp-key-mappings)
    - [Telescope Key Mappings](#telescope-key-mappings)
    - [Copilot Key Mappings](#copilot-key-mappings)
  - [Plugins](#plugins)
    - [File Management](#file-management)
    - [UI Components](#ui-components)
    - [Language Server Protocol (LSP)](#language-server-protocol-lsp)
    - [Auto-completion](#auto-completion)
    - [AI Assistance](#ai-assistance)
    - [Utility Plugins](#utility-plugins)
  - [Language Support](#language-support)
  - [Formatters and Linters](#formatters-and-linters)

<!--toc:end-->

## Overview

A consolidated Neovim configuration with all plugins, options, and keymaps in a single `init.lua`
file for easy management and portability. This configuration provides a modern, feature-rich
development environment with LSP support, AI assistance, and comprehensive tooling.

**Author:** bourbon\
**Date:** July 30, 2025

## Installation

1. Backup your existing Neovim configuration (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

1. Clone or copy this configuration:

   ```bash
   git clone <your-repo> ~/.config/nvim
   # OR copy the init.lua file to ~/.config/nvim/
   ```

1. Start Neovim and let lazy.nvim install all plugins:

   ```bash
   nvim
   ```

## Configuration Structure

- `init.lua` - Single configuration file containing everything
- All plugins, options, and keymaps are organized in logical sections
- Comprehensive documentation within the file

## Vim Options

```lua
-- Leader key
vim.g.mapleader = " "

-- Indentation (4 spaces, no tabs)
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.tabstop = 4           -- Tab appears as 4 characters
vim.opt.softtabstop = 4       -- Tab key inserts 4 spaces
vim.opt.shiftwidth = 4        -- Auto-indent uses 4 spaces

-- Editor behavior
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.number = true          -- Show current line number
vim.opt.clipboard = "unnamedplus"  -- System clipboard
vim.opt.textwidth = 80         -- Auto-wrap at 80 characters
vim.opt.conceallevel = 1       -- Conceal special characters
vim.opt.ignorecase = true      -- Case-insensitive search
vim.opt.smartcase = true       -- Smart case (if uppercase used)
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible left/right
```

## Key Mappings

### Leader Key Mappings

| Keymap | Mode | Description | |--------|------|-------------| | `<Space>` | - | Leader key | |
`<leader>e` | Normal | Toggle file explorer (nvim-tree) | | `<leader>fc` | Normal | Format code | |
`<leader>dl` | Normal | Show line diagnostics | | `<leader>df` | Normal | Show all diagnostics in
quickfix |

### LSP Key Mappings

| Keymap | Mode | Description | |--------|------|-------------| | `K` | Normal | Hover documentation
| | `gd` | Normal | Go to definition | | `<leader>ca` | Normal/Visual | Code actions | | `<leader>a`
| Normal | Rust hover actions |

### Telescope Key Mappings

| Keymap | Mode | Description | |--------|------|-------------| | `<leader>ff` | Normal | Find files
| | `<leader>fg` | Normal | Live grep (search text) | | `<leader>fr` | Normal | Recent files
(project only) | | `<leader>fb` | Normal | Find buffers |

### Copilot Key Mappings

| Keymap | Mode | Description | |--------|------|-------------| | `<leader>ce` | Normal | Enable
Copilot | | `<leader>cd` | Normal | Disable Copilot | | `<leader>cc` | Normal | Toggle Copilot Chat
| | `<leader>cq` | Normal | Open Copilot Chat | | `<leader>cq` | Visual | Ask Copilot about
selection |

## Plugins

### File Management

- **nvim-tree.lua** - File tree explorer with icons
- **dashboard-nvim** - Beautiful startup screen with ASCII art

### UI Components

- **tokyonight.nvim** - Modern dark theme
- **lualine.nvim** - Statusline with theme integration
- **nvim-web-devicons** - File type icons

### Language Server Protocol (LSP)

- **mason.nvim** - LSP installer and manager
- **mason-lspconfig.nvim** - Bridge between mason and lspconfig
- **nvim-lspconfig** - LSP configurations
- **rustaceanvim** - Enhanced Rust support

### Auto-completion

- **nvim-cmp** - Completion engine
- **cmp-nvim-lsp** - LSP completion source
- **LuaSnip** - Snippet engine
- **friendly-snippets** - Collection of snippets

### AI Assistance

- **copilot.vim** - GitHub Copilot AI completion
- **CopilotChat.nvim** - Copilot chat interface

### Utility Plugins

- **telescope.nvim** - Fuzzy finder for files, text, etc.
- **nvim-treesitter** - Advanced syntax highlighting
- **nvim-surround** - Surround text with quotes, brackets
- **nvim-autopairs** - Auto-close brackets, quotes
- **markdown-preview.nvim** - Live markdown preview

## Language Support

The configuration includes LSP support for:

- **Lua** (lua_ls)
- **Python** (pyright + ruff)
- **Rust** (rustaceanvim)
- **JavaScript/TypeScript** (ts_ls)
- **Go** (gopls)
- **C/C++** (clangd)
- **HTML** (html)
- **CSS** (cssls)
- **Bash** (bashls)
- **Docker** (dockerls)
- **Markdown** (marksman)
- **YAML** (yamlls)
- **TOML** (taplo)
- **SQL** (sqlls)
- **Svelte** (svelte)
- **Vue** (vuels)

## Formatters and Linters

- **stylua** - Lua formatter
- **prettier** - JavaScript/TypeScript/JSON formatter
- **mdformat** - Markdown formatter
- **markdownlint** - Markdown linter
- **cmake_format** - CMake formatter
- **sqlfmt** - SQL formatter
- **yamlfmt** - YAML formatter
- **ruff** - Python linter and formatter
- **pyright** - Python type checker

## Auto-format on Save

The configuration automatically formats code on save for these file types:

- `*.lua`
- `*.js`, `*.ts`
- `*.md`
- `*.rs`
- `*.c`
- `*.toml`
- `*.yaml`
- `*.py`

This is the bottom comfiguation line that shows the status of the program.

### lsp-config.lua

This is the language server configuration. For some languages, you will have to do additional
installations for your system.

### none-ls.lua

This allows you to use code formating by using '<leader>fc' with the installed and configured linter

### telescope.lua

This allows you to fuzzy find or have a search box with different methods such as recent files, open
buffers, text, or project files

### treesitter.lua

Tree-sitter is a parsing library and tool that provides efficient, incremental parsing for
programming languages. It is widely used in modern code editor's for syntax highlighting, code
navigation, and structural editing.

### markdown-preview.lua

This allows you to open rendered markdown files in the browser.

### obsidian.lua

This allows you to open and take obsidian notes inside neovim. Then you can use the graphical
editior for visualizaitons.

## Commands

'<leader>ff' -> Fuzy Finder

'<leader>fg' -> Rip Grep Files

'<leader>fr' -> Recent Files

'<leader>fb' -> Opened Buffers

### Linter Commands

normal mode: Shift K -> Show Linter Warnings

normal mode: gd -> Go to Definition **I Might remove this**

'<leader>ca' -> Code Action

'<leader>fc' -> Format Code

### vim-keymaps.lua (Error Warning Suggestion's)

'<leader>dl' -> code diagnostics inline (pop-up window)

'<leader>dl' -> code diagnostics total list

'<leader>a' -> rust hover action
