# Neovim Configuration - Custom Keymaps Reference

<!--toc:start-->

- [Neovim Configuration - Custom Keymaps Reference](#neovim-configuration---custom-keymaps-reference)
  - [Leader Key](#leader-key)
  - [File Operations](#file-operations)
  - [Fuzzy Finding (Telescope)](#fuzzy-finding-telescope)
  - [LSP (Language Server Protocol)](#lsp-language-server-protocol)
  - [Diagnostics](#diagnostics)
  - [AI Assistance (GitHub Copilot)](#ai-assistance-github-copilot)
  - [Markdown](#markdown)
  - [Org-Mode](#org-mode)
  - [Terminal](#terminal)
  - [Database Management](#database-management)
  - [Language-Specific](#language-specific)
  - [Completion System](#completion-system)
  - [Auto-formatting](#auto-formatting)
  - [Default Vim Keymaps (Reference)](#default-vim-keymaps-reference)
  - [Plugin-Specific Features](#plugin-specific-features)
  - [Quick Reference Card](#quick-reference-card)
## Leader Key

**Leader key is set to `Space`**

All custom keymaps use `<leader>` which means you press `Space` followed by the key combination.

## File Operations

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>e` | Normal | `<cmd>Yazi<cr>` | Open yazi file manager |
| `<leader>-` | Normal, Visual | `<cmd>Yazi<cr>` | Open yazi at current file |
| `<leader>cw` | Normal | `<cmd>Yazi cwd<cr>` | Open yazi in working directory |
| `<C-up>` | Normal | `<cmd>Yazi toggle<cr>` | Resume last yazi session |

### Yazi File Manager

Yazi is a modern terminal file manager with vim-like keybindings:

**Navigation:**
- `h/j/k/l` - Navigate files and directories
- `<CR>` - Enter directory or open file
- `<Backspace>` - Go to parent directory
- `q` - Quit yazi

**File Operations:**
- `d` - Delete file/directory
- `r` - Rename file/directory
- `c` - Copy file/directory
- `x` - Cut file/directory
- `p` - Paste file/directory
- `n` - Create new file
- `N` - Create new directory

**View Options:**
- `z` - Toggle hidden files
- `s` - Sort files
- `v` - Toggle preview panel
- `t` - Toggle dual pane mode

**Selection:**
- `<Space>` - Select/deselect file
- `a` - Select all files
- `A` - Deselect all files
- `v` - Enter visual mode for multi-selection

## Fuzzy Finding (Telescope)

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>ff` | Normal | `find_files` | Find files in current directory |
| `<leader>fg` | Normal | `live_grep` | Search text across all files |
| `<leader>fr` | Normal | `oldfiles` | Recent files (project only) |
| `<leader>fb` | Normal | `buffers` | Find open buffers |

### Telescope Navigation

When telescope is open:
- `<C-j>` / `<C-k>` - Move up/down in results
- `<CR>` - Open selected file
- `<C-x>` - Open in horizontal split
- `<C-v>` - Open in vertical split
- `<C-t>` - Open in new tab
- `<Esc>` - Close telescope

## LSP (Language Server Protocol)

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `K` | Normal | `vim.lsp.buf.hover` | Show hover documentation |
| `gd` | Normal | `vim.lsp.buf.definition` | Go to definition |
| `<leader>ca` | Normal, Visual | `vim.lsp.buf.code_action` | Show code actions |
| `<leader>fc` | Normal | `vim.lsp.buf.format` | Format current file |

### Additional LSP Navigation

Default LSP keymaps that work automatically:
- `gr` - Go to references
- `gi` - Go to implementation
- `<C-k>` - Signature help (in insert mode)

## Diagnostics

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>dl` | Normal | `vim.diagnostic.open_float` | Show line diagnostics |
| `<leader>df` | Normal | `vim.diagnostic.setqflist` | Show all diagnostics in quickfix |

### Default Diagnostic Navigation

- `[d` - Previous diagnostic
- `]d` - Next diagnostic

## AI Assistance (GitHub Copilot)

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>ce` | Normal | `:Copilot enable` | Enable Copilot |
| `<leader>cd` | Normal | `:Copilot disable` | Disable Copilot |
| `<leader>cc` | Normal | `:CopilotChatToggle` | Toggle Copilot Chat |
| `<leader>cq` | Normal | `:CopilotChat` | Open Copilot Chat |
| `<leader>cq` | Visual | `:CopilotChatVisual` | Ask Copilot about selection |

### Copilot Completion

In insert mode:
- `<Tab>` - Accept Copilot suggestion
- `<C-]>` - Dismiss suggestion
- `<C-[>` - Previous suggestion
- `<C-\>` - Next suggestion

## Markdown

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>mp` | Normal | `:PeekOpen` | Open markdown preview |
| `<leader>mc` | Normal | `:PeekClose` | Close markdown preview |

### Markdown Features

- Automatic rendering in normal/visual mode
- Live preview with Peek
- Auto-formatting on save
- Syntax highlighting with Treesitter

## Org-Mode

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>oa` | Normal | `orgmode.action("agenda.prompt")` | Open Org Agenda |
| `<leader>oc` | Normal | `orgmode.action("capture.prompt")` | Open Org Capture |

### Org-Mode Files Location

- Agenda files: `~/orgfiles/**/*`
- Default notes file: `~/orgfiles/refile.org`

For detailed org-mode commands, see the [Org-Mode Guide](./org-mode-guide.md).

## Terminal

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>t` | Normal | `<cmd>ToggleTerm direction=float<cr>` | Toggle floating terminal |
| `<C-\>` | Normal | `:ToggleTerm` | Alternative terminal toggle |

### Terminal Navigation

When inside the terminal:

- `<Esc>` - Exit terminal mode (go to normal mode)
- `jk` - Alternative exit terminal mode
- `<C-h/j/k/l>` - Navigate between windows
- `<C-w>` - Window commands

The terminal will:
- Open as a floating window with curved borders
- Start in insert mode
- Persist across sessions
- Close when the shell exits

## Database Management

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>db` | Normal | `:DBUIToggle` | Toggle Database UI |
| `<leader>dc` | Normal | `:DBUIAddConnection` | Add Database Connection |
| `<leader>dq` | Normal | `:DBUIFindBuffer` | Find Database Buffer |

### Database UI Navigation

When DBUI is open:
- `<CR>` - Expand/collapse or execute
- `S` - Select database
- `R` - Rename connection
- `D` - Delete connection

## Language-Specific

### Rust

| Keymap | Mode | Action | Description |
|--------|------|--------|-------------|
| `<leader>a` | Normal | `RustHoverAction` | Rust hover actions |
| `<leader>ca` | Normal | `RustLsp("codeAction")` | Rust code actions |

### Auto-formatting Languages

The following languages auto-format on save:
- Lua (stylua)
- JavaScript/TypeScript (prettier)
- Markdown (mdformat + markdownlint)
- C/C++ (clang-format)
- Python (ruff)
- Rust (rustfmt)
- YAML (yamlfmt)
- SQL (sqlfmt)
- TOML (taplo)

## Completion System

### In Insert Mode

| Keymap | Action | Description |
|--------|--------|-------------|
| `<Tab>` | Next completion / Expand snippet | Navigate completions or expand/jump in snippets |
| `<S-Tab>` | Previous completion / Jump back | Navigate completions or jump back in snippets |
| `<C-Space>` | Trigger completion | Manually trigger completion menu |
| `<C-e>` | Abort completion | Close completion menu |
| `<CR>` | Confirm completion | Accept selected completion |
| `<C-b>` | Scroll docs up | Scroll completion documentation up |
| `<C-f>` | Scroll docs down | Scroll completion documentation down |

### Completion Sources

1. LSP completions (highest priority)
2. Snippet completions
3. Buffer completions
4. Database completions (in SQL files)

## Auto-formatting

Auto-formatting is enabled for these file types and runs on save:
- `*.lua` - Lua files
- `*.js` - JavaScript files  
- `*.ts` - TypeScript files
- `*.md` - Markdown files
- `*.rs` - Rust files
- `*.c` - C files
- `*.toml` - TOML files
- `*.yaml` - YAML files
- `*.py` - Python files

## Default Vim Keymaps (Reference)

For comprehensive vim motion commands, see [vim-motions.md](./vim-motions.md).

### Essential Commands

| Keymap | Mode | Description |
|--------|------|-------------|
| `:w` | Command | Save file |
| `:q` | Command | Quit |
| `:wq` | Command | Save and quit |
| `:q!` | Command | Quit without saving |
| `u` | Normal | Undo |
| `<C-r>` | Normal | Redo |
| `dd` | Normal | Delete line |
| `yy` | Normal | Yank (copy) line |
| `p` | Normal | Paste after cursor |
| `P` | Normal | Paste before cursor |

## Plugin-Specific Features

### Surround (nvim-surround)

- `ys{motion}{char}` - Add surround
- `ds{char}` - Delete surround  
- `cs{old}{new}` - Change surround

Examples:
- `ysiw"` - Surround word with quotes
- `ds"` - Delete surrounding quotes
- `cs"'` - Change double quotes to single quotes

### Autopairs

Automatically closes:
- `()` - Parentheses
- `[]` - Brackets
- `{}` - Braces
- `""` - Double quotes
- `''` - Single quotes
- `/* */` - Block comments (C/C++/JS/TS/Rust/Go)

### Comment Toggle

Using treesitter-based commenting:
- `gcc` - Toggle line comment
- `gc{motion}` - Toggle comment for motion
- `gbc` - Toggle block comment
- `gb{motion}` - Toggle block comment for motion

## Quick Reference Card

### Most Used Keymaps

| Category | Keymap | Action |
|----------|--------|--------|
| **Files** | `<Space>ff` | Find files |
| **Files** | `<Space>fg` | Search in files |
| **Files** | `<Space>e` | Yazi file manager |
| **LSP** | `gd` | Go to definition |
| **LSP** | `K` | Show documentation |
| **LSP** | `<Space>ca` | Code actions |
| **AI** | `<Space>cc` | Copilot chat |
| **Format** | `<Space>fc` | Format code |
| **Diagnostics** | `<Space>dl` | Show diagnostics |
| **Terminal** | `<Space>t` | Floating terminal |

### Dashboard Quick Actions

When you start Neovim, the dashboard shows these quick actions:
- `<Space>ff` - Find file
- `<Space>fr` - Recent files  
- `<Space>fb` - Buffers
- `<Space>fg` - Find text
- `<Space>e` - Yazi file manager

### Plugin Installation & Management

Managed by lazy.nvim:
- `:Lazy` - Open plugin manager
- `:Lazy update` - Update all plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy sync` - Sync plugins

### LSP Server Management

Managed by Mason:
- `:Mason` - Open Mason UI
- `:MasonInstall <server>` - Install LSP server
- `:MasonUninstall <server>` - Uninstall LSP server

### Installed LSP Servers

- **lua_ls** - Lua
- **bashls** - Bash
- **clangd** - C/C++
- **cssls** - CSS
- **dockerls** - Docker
- **gopls** - Go
- **html** - HTML
- **ts_ls** - TypeScript/JavaScript
- **marksman** - Markdown
- **ruff** - Python linting
- **pyright** - Python type checking
- **svelte** - Svelte
- **sqlls** - SQL
- **taplo** - TOML
- **vuels** - Vue
- **yamlls** - YAML

### Theme and UI

- **Theme**: OneDark Pro
- **Status line**: Lualine with Everforest theme
- **File icons**: nvim-web-devicons
- **Dashboard**: Custom with ASCII art

---

## Configuration File Location

Main configuration: `~/.config/nvim/init.lua`

This is a single-file configuration that includes:
- All plugin definitions
- All keymaps
- All LSP configurations
- All formatting rules
- All custom settings

## Backup and Sync

To backup your configuration:
```bash
# Backup
cp -r ~/.config/nvim ~/nvim-backup

# Or sync to git
cd ~/.config/nvim
git init
git add .
git commit -m "Initial nvim config"
```

## Getting Help

- `:help <command>` - Vim help system
- `:checkhealth` - Neovim health check
- `:LspInfo` - LSP server information
- `:Mason` - LSP server management
- `:Lazy` - Plugin management

For questions about specific plugins, check their documentation or GitHub repositories.
