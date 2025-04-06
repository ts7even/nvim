# Nvim Config

<!--toc:start-->

- [Nvim Config](#nvim-config)
  - [vim option's (vim-options.lua)](#vim-options-vim-optionslua)
  - [Plugins](#plugins)
    - [alpha.lua](#alphalua)
    - [autopairs.lua](#autopairslua)
    - [lualine.lua](#lualinelua)
    - [lsp-config.lua](#lsp-configlua)
    - [none-ls.lua](#none-lslua)
    - [telescope.lua](#telescopelua)
    - [treesitter.lua](#treesitterlua)
    - [markdown-preview.lua](#markdown-previewlua)
    - [obsidian.lua](#obsidianlua)
  - [Commands](#commands) - [Linter Commands](#linter-commands) - [vim-keymaps.lua (Error Warning Suggestion's)](#vim-keymapslua-error-warning-suggestions) - [Markdown Preview](#markdown-preview) - [Obsidian](#obsidian)
  <!--toc:end-->

## vim option's (vim-options.lua)

```lua

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.wo.relativenumber = true
vim.api.nvim_set_option("clipboard", "unnamedplus")
vim.cmd("set textwidth=80") -- Automatically wrap text at 80 characters
vim.cmd("set formatoptions+=a") -- Auto-wrap paragraphs in Insert mode

```

## Plugins

### alpha.lua

This is the splash screen with the commands to find files. There is no file tree
since that is useless if you can just read the paths.

You can change the ascii logo to somehthing else if you want.

### autopairs.lua

This allows you to autoclose brackets, braces, quotation marks, etc..

### lualine.lua

This is the bottom comfiguation line that shows the status of the program.

### lsp-config.lua

This is the language server configuration. For some languages, you will have to
do additional installations for your system.

### none-ls.lua

This allows you to use code formating by using '<leader>fc' with the installed
and configured linter

### telescope.lua

This allows you to fuzzy find or have a search box with different methods such
as recent files, open buffers, text, or project files

### treesitter.lua

Tree-sitter is a parsing library and tool that provides efficient, incremental
parsing for programming languages. It is widely used in modern code editor's
for syntax highlighting, code navigation, and structural editing.

### markdown-preview.lua

This allows you to open rendered markdown files in the browser.

### obsidian.lua

This allows you to open and take obsidian notes inside neovim. Then you can use
the graphical editior for visualizaitons.

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

### Markdown Preview

:MarkdownPreview -> Open Markdown Preview

:MarkdownPreviewStop -> Close Markdown Preview

### Obsidian

I created a C executible that opens an Obsisdian directory to take notes.

1. You would need to adjust the C file global variable for the path of the vault
   directory.

2. Then compile the file using `gcc -o ob ob.c` which `ob` is the executable.

3. Change the permission and create an executable using `chmod +x ob`

4. Move `ob` executable to `~/.local/bin` and make sure `~/.local/bin` is in
   your path (zsh or bash rc file)
