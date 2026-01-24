# Neovim configuration

Neovim configuration for multi-tasking and development.

## Leader Groups

| Prefix | Group |
|:------:|:------|
| `<leader>ai` | AI |
| `<leader>d` | Debug/Diagnostics |
| `<leader>f` | File/Search |
| `<leader>g` | Goto/Git |
| `<leader>l` | LSP |
| `<leader>o` | Org |
| `<leader>t` | Terminal |
| `<leader>u` | Utilities |

## File/Search (`<leader>f`)

| Key | Description |
|:---:|:---|
| `<leader>e` | File Explorer (with hidden files) |
| `<leader>ff` | Find Files |
| `<leader>fg` | Live Grep |
| `<leader>fb` | Find Buffers (includes terminals) |
| `<leader>fr` | Recent Files |
| `<leader>fs` | Search Word Under Cursor |
| `<leader>fp` | Projects |
| `<leader>fpa` | Add Current Dir as Project |
| `<leader>fa` | Add to Harpoon |
| `<leader>fh` | Harpoon Picker |
| `<leader>fH` | Harpoon Menu |
| `<leader>fhr` | Remove from Harpoon |
| `<leader>1-4` | Jump to Harpoon File 1-4 |
| `-` | Oil (parent directory) |
| `<leader>pk` | Search Keymaps |
| `<leader>qf` | Quickfix List |
| `<leader>bd` | Delete Buffer |

## Terminal (`<leader>t`)

| Key | Description |
|:---:|:---|
| `<leader>tt` | Toggle Terminal (float) |
| `<leader>tv` | Terminal (vertical split) |
| `<leader>ts` | Terminal (horizontal split) |

### Terminal Tips

```vim
:terminal npm run dev          " Open terminal running dev server
:terminal npm run dev | hide   " Run in background, hide immediately
```

To run a background process:
1. `<leader>tv` - Open terminal in vsplit
2. Run your command (e.g., `npm run dev`)
3. `<C-w>q` or `:hide` - Hide the window (process keeps running)
4. `<leader>fb` - Find buffers to get back to it

## Git (`<leader>g`)

| Key | Description |
|:---:|:---|
| `<leader>gg` | Neogit Status |
| `<leader>gC` | Neogit Commit |
| `<leader>gP` | Neogit Push |
| `<leader>gF` | Neogit Pull |
| `<leader>gB` | Neogit Branch |
| `<leader>gd` | Diffview Open |
| `<leader>gh` | File History |
| `<leader>gH` | Branch History |
| `<leader>gq` | Diffview Close |
| `<leader>lg` | Open Lazygit |
| `<leader>gl` | Lazygit Logs |
| `<leader>gbr` | Git Branch Picker |

## LSP (`<leader>l`)

| Key | Description |
|:---:|:---|
| `<leader>li` | LSP Info |
| `<leader>la` | Code Action |
| `<leader>lc` | Run Codelens |
| `<leader>lC` | Refresh Codelens |
| `<leader>lr` | Rename Symbol |
| `<leader>k` | Hover Documentation |
| `<leader>gd` | Go to Definition |
| `<leader>gr` | Go to References |
| `<leader>gi` | Go to Implementation |
| `<leader>gy` | Go to Type Definition |
| `<leader>gD` | Go to Declaration |
| `<leader>gk` | Signature Help |
| `<C-k>` | Signature Help (Insert Mode) |
| `<leader>dl` | Show Line Diagnostics |
| `<leader>df` | Show All Diagnostics in Quickfix |

## Org (`<leader>o`)

| Key | Description |
|:---:|:---|
| `<leader>oa` | Org Agenda |
| `<leader>oc` | Org Capture |
| `<leader>of` | Open orgfiles Directory |
| `<leader>ot` | Open tasks.org |
| `<leader>on` | Open notes.org |
| `<leader>om` | Open meetings.org |
| `<leader>or` | Open refile.org |
| `<leader>ol` | Open learn Directory |
| `<leader>op` | Open projects Directory |

### Org Mode Keys (in .org files)

| Key | Description |
|:---:|:---|
| `<C-Space>` | Toggle Checkbox |
| `cit` | Cycle TODO State |
| `,s` | Schedule |
| `,d` | Deadline |
| `,t` | Timestamp |

## Debug (`<leader>d`)

| Key | Description |
|:---:|:---|
| `<leader>db` | Toggle Breakpoint |
| `<leader>dB` | Breakpoint Condition |
| `<leader>dc` | Run/Continue |
| `<leader>da` | Run with Args |
| `<leader>dC` | Run to Cursor |
| `<leader>dg` | Go to Line (No Execute) |
| `<leader>di` | Step Into |
| `<leader>dj` | Down |
| `<leader>dk` | Up |
| `<leader>dL` | Run Last |
| `<leader>do` | Step Out |
| `<leader>dO` | Step Over |
| `<leader>dP` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>ds` | Session |
| `<leader>dt` | Terminate |
| `<leader>dw` | Widgets |
| `<leader>du` | Dap UI |
| `<leader>de` | Eval |

## Utilities (`<leader>u`)

### REST Client (Kulala)

| Key | Description |
|:---:|:---|
| `<leader>urr` | Send HTTP Request |
| `<leader>ura` | Send All Requests |
| `<leader>url` | Replay Last Request |
| `<leader>uri` | Inspect Request |
| `<leader>urt` | Toggle Body/Headers View |
| `<leader>urh` | Open HTTP Files Directory |

### Database (Dadbod)

| Key | Description |
|:---:|:---|
| `<leader>udb` | Open Database UI |
| `<leader>udc` | Add Database Connection |
| `<leader>udq` | Find Database Buffer |

### Markdown Preview

| Key | Description |
|:---:|:---|
| `<leader>ump` | Markdown Preview |
| `<leader>umc` | Close Preview |

## AI (`<leader>ai`)

### CodeCompanion

| Key | Description |
|:---:|:---|
| `<leader>aic` | AI Chat |
| `<leader>aii` | AI Inline (select code first) |
| `<leader>aia` | AI Actions |

## Common Vim Commands

### Find & Replace

```vim
:%s/old/new/g           " Replace all occurrences in file
:%s/old/new/gc          " Replace with confirmation
:'<,'>s/old/new/g       " Replace in visual selection
:g/pattern/d            " Delete all lines containing pattern
:v/pattern/d            " Delete all lines NOT containing pattern
```

### Advanced Navigation

```vim
50%                     " Jump to 50% of file
:50                     " Jump to line 50
/{pattern}              " Search forward
?{pattern}              " Search backward
*                       " Search word under cursor forward
#                       " Search word under cursor backward
```

### Text Objects & Editing

```vim
di(                     " Delete inside parentheses
di{                     " Delete inside braces
di"                     " Delete inside quotes
ci(                     " Change inside parentheses
yi{                     " Yank inside braces
dap                     " Delete around paragraph
cit                     " Change inside tag (HTML)
```

### Window & File Operations

```vim
:vsp filename           " Open file in vertical split
:sp filename            " Open file in horizontal split
:e filename             " Edit file in current window
:tabnew filename        " Open file in new tab
<C-w>h/j/k/l            " Move between windows
<C-w>=                  " Equalize split sizes
<C-w>q                  " Close window (keeps buffer)
:hide                   " Hide current window
<C-Alt-h>               " Previous tab
<C-Alt-l>               " Next tab
```

### Folding

```vim
zc                      " Close fold
zo                      " Open fold
za                      " Toggle fold
zM                      " Close all folds
zR                      " Open all folds
```

### Jump Between Blocks

```vim
%                       " Jump between matching (), {}, []
]]                      " Jump to next function/class
[[                      " Jump to previous function/class
[{                      " Jump to beginning of block
]}                      " Jump to end of block
```

### Macros & Registers

```vim
qa                      " Record macro to register 'a'
q                       " Stop recording
@a                      " Execute macro 'a'
@@                      " Repeat last macro
"ayy                    " Yank line to register 'a'
"ap                     " Paste from register 'a'
```

### Visual Block Mode

```vim
<C-v>                   " Enter visual block mode
I                       " Insert at start of block
A                       " Append at end of block
c                       " Change block
r                       " Replace all characters in block
```

## Conform (Formatter)

| Command | Action |
|:---:|:---|
| `:ConformDisable` | Disable formatting (current buffer) |
| `:ConformDisable!` | Disable formatting (globally) |
| `:ConformEnable` | Re-enable formatting (current buffer) |
| `:ConformEnable!` | Re-enable formatting (globally) |
