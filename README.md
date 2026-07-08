# Neovim Configuration

My neovim configuration. 


## Requirements

### Core

| Package | Needed for |
|---|---|
| neovim (≥ 0.11) | uses the `vim.lsp.config` / `vim.lsp.enable` API |
| git | lazy.nvim bootstrap, plugin/treesitter fetching, git plugins |
| C compiler (clang/gcc) | compiling treesitter parsers |
| Nerd Font | icons (blink.cmp, web-devicons, bufferline, render-markdown) |
| mise | version manager used for node/zig/zls below |

### CLI tools

| Package | Needed for |
|---|---|
| ripgrep | snacks grep pickers (`<leader>fg`, `<leader>fs`) |
| fd | faster file picker (optional) |
| lazygit | `<leader>gl` |

### Language toolchains

LSP servers, formatters, and debug adapters are installed by Mason, but they
ride on these toolchains being present:

| Package | Provides |
|---|---|
| llvm / clang | clangd, clang-format, lldb (codelldb) |
| mise nodejs | ts_ls, svelte, prettier, js-debug-adapter, markdown-preview |
| python3 + pip | pyright, ruff, debugpy |
| rust (cargo, clippy, rustfmt) | rust_analyzer, rustfmt, clippy |
| mise zig | `zig fmt`, debugging |
| mise zls | Zig LSP |
| lua | lua_ls |

### Cleanup Items 

1. Probably only want copilot, and have it automatically disabled? 


### Todos 

1. Learn how to step through and debug
