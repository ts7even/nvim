# Complete Vim & Neovim Guide

<!--toc:start-->
- [Complete Vim & Neovim Guide](#complete-vim--neovim-guide)
  - [Leader Key](#leader-key)
  - [Essential Vim Commands](#essential-vim-commands)
  - [Motions & Movement](#motions--movement)
  - [Text Objects](#text-objects)
  - [Visual Mode](#visual-mode)
  - [File Operations & Editing](#file-operations--editing)
  - [Find and Replace](#find-and-replace)
  - [Folding](#folding)
  - [Custom Leader Keymaps](#custom-leader-keymaps)
  - [File Picker Commands](#file-picker-commands)
  - [Org-Mode](#org-mode)
  - [Obsidian Commands](#obsidian-commands)
  - [Buffer, Window & Tab Management](#buffer-window--tab-management)
  - [Macros & Registers](#macros--registers)
  - [Advanced Tips](#advanced-tips)
<!--toc:end-->

## Leader Key

**Leader key is set to `Space`**

All custom keymaps use `<leader>` which means you press `Space` followed by the key combination.

## Essential Vim Commands

### Basic Operations

| Command | Description |
|---------|-------------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open/create file |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change |
| `dd` | Delete line |
| `yy` | Yank (copy) line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Insertion & Editing

| Command | Description |
|---------|-------------|
| `i` | Insert before cursor |
| `I` | Insert at beginning of line |
| `a` | Insert after cursor |
| `A` | Insert at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `s` | Substitute character |
| `S` | Substitute line |
| `c` | Change (delete and insert) |
| `r` | Replace single character |
| `R` | Replace mode |

## Motions & Movement

### Basic Movement

| Motion | Description |
|--------|-------------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `gj` | Move down by display line (wrapped) |
| `gk` | Move up by display line (wrapped) |

### Word Movement

| Motion | Description |
|--------|-------------|
| `w` | Jump to start of next word |
| `W` | Jump to start of next WORD (space-delimited) |
| `e` | Jump to end of current/next word |
| `E` | Jump to end of current/next WORD |
| `b` | Jump backward to start of word |
| `B` | Jump backward to start of WORD |
| `ge` | Jump backward to end of word |

**Note**: *word* = delimited by punctuation (`hello-world` = 3 words), *WORD* = space-delimited only (`hello-world` = 1 WORD)

### Line Movement
| Motion | Description |
|--------|-------------|
| `0` | Go to first character of line |
| `^` | Go to first non-blank character |
| `$` | Go to end of line |
| `g_` | Go to last non-blank character |
| `+` | Go to first non-blank of next line |
| `-` | Go to first non-blank of previous line |

### File Movement
| Motion | Description |
|--------|-------------|
| `gg` | Go to first line of file |
| `G` | Go to last line of file |
| `5G` or `:5` | Go to line 5 |
| `50%` | Go to 50% through file |
| `<C-o>` | Jump to older position (back) |
| `<C-i>` | Jump to newer position (forward) |

### Screen Movement
| Motion | Description |
|--------|-------------|
| `H` | Go to top of screen |
| `M` | Go to middle of screen |
| `L` | Go to bottom of screen |
| `zt` | Scroll line to top of screen |
| `zz` | Center line on screen |
| `zb` | Scroll line to bottom of screen |
| `<C-u>` | Scroll up half page |
| `<C-d>` | Scroll down half page |
| `<C-b>` | Scroll up full page |
| `<C-f>` | Scroll down full page |

### Search Movement
| Motion | Description |
|--------|-------------|
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward for pattern |
| `n` | Repeat search in same direction |
| `N` | Repeat search in opposite direction |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |
| `f{char}` | Find next character on line |
| `F{char}` | Find previous character on line |
| `t{char}` | Till next character (stop before) |
| `T{char}` | Till previous character (stop before) |
| `;` | Repeat last f/F/t/T |
| `,` | Repeat last f/F/t/T in opposite direction |

### Code Block Movement
| Motion | Description |
|--------|-------------|
| `%` | Jump to matching bracket/brace/parenthesis |
| `]]` | Jump to next function/class |
| `[[` | Jump to previous function/class |
| `]m` | Jump to next method |
| `[m` | Jump to previous method |
| `}{` | Jump to next/previous paragraph |

## Text Objects

### Inner vs Around

- **i** = inner (excluding delimiters)
- **a** = around (including delimiters)

### Word Objects

| Object | Description |
|--------|-------------|
| `iw` | Inner word |
| `aw` | A word (includes trailing space) |
| `iW` | Inner WORD |
| `aW` | A WORD |

### Quote Objects
| Object | Description |
|--------|-------------|
| `i"` | Inside double quotes |
| `a"` | Around double quotes |
| `i'` | Inside single quotes |
| `a'` | Around single quotes |
| `` i` `` | Inside backticks |
| `` a` `` | Around backticks |

### Bracket Objects
| Object | Description |
|--------|-------------|
| `i(` or `i)` | Inside parentheses |
| `a(` or `a)` | Around parentheses |
| `i{` or `i}` | Inside braces |
| `a{` or `a}` | Around braces |
| `i[` or `i]` | Inside brackets |
| `a[` or `a]` | Around brackets |
| `i<` or `i>` | Inside angle brackets |
| `a<` or `a>` | Around angle brackets |

### Block Objects
| Object | Description |
|--------|-------------|
| `ip` | Inner paragraph |
| `ap` | A paragraph |
| `is` | Inner sentence |
| `as` | A sentence |
| `it` | Inner tag (HTML/XML) |
| `at` | Around tag (HTML/XML) |

## Visual Mode

### Visual Selection Types
| Command | Description |
|---------|-------------|
| `v` | Character-wise visual mode |
| `V` | Line-wise visual mode |
| `<C-v>` | Block-wise visual mode |
| `gv` | Reselect last visual selection |

### Visual Mode Operations
| Command | Description |
|---------|-------------|
| `o` | Go to other end of selection |
| `O` | Go to other corner (block mode) |
| `d` | Delete selection |
| `y` | Yank selection |
| `c` | Change selection |
| `>` | Indent selection |
| `<` | Unindent selection |

### Block Selection & Mass Editing

```vim
<C-v>         " Enter visual block mode
j/k           " Select multiple lines
I             " Insert at beginning of all lines
<Esc>         " Apply to all selected lines

<C-v>         " Visual block mode
$             " Go to end of lines
A             " Append to end of all lines
<Esc>         " Apply changes
```

## File Operations & Editing

### File Management
| Command | Description |
|---------|-------------|
| `:e filename` | Edit file |
| `:e!` | Reload current file (discard changes) |
| `:w filename` | Save as filename |
| `:saveas filename` | Save as and switch to new file |
| `:pwd` | Show current directory |
| `:cd path` | Change directory |

### Window Operations
| Command | Description |
|---------|-------------|
| `:sp filename` | Split window horizontally and open file |
| `:vsp filename` | Split window vertically and open file |
| `:tabe filename` | Open file in new tab |
| `<C-w>h/j/k/l` | Navigate between windows |
| `<C-w>w` | Move to next window |
| `<C-w>=` | Make all windows equal size |
| `<C-w>_` | Maximize current window height |
| `<C-w>|` | Maximize current window width |

### Repeat Operations with Numbers
| Command | Description |
|---------|-------------|
| `10i text <Esc>` | Insert "text" 10 times |
| `10dd` | Delete 10 lines |
| `10yy` | Yank 10 lines |
| `10j` | Move down 10 lines |
| `10.` | Repeat last change 10 times |

## Find and Replace

### Basic Find/Replace
```vim
:s/old/new/           " Replace first occurrence in current line
:s/old/new/g          " Replace all in current line
:%s/old/new/g         " Replace all in file
:%s/old/new/gc        " Replace all with confirmation
:10,20s/old/new/g     " Replace in lines 10-20
:'<,'>s/old/new/g     " Replace in visual selection
```

### Advanced Find/Replace
```vim
:%s/\<word\>/new/g    " Replace whole word only
:%s/old/new/gi        " Case insensitive replace
:%s/^/text/           " Add text to beginning of all lines
:%s/$/text/           " Add text to end of all lines
:%s/.*pattern.*/new/  " Replace entire lines containing pattern
```

## Folding

Folding allows you to collapse sections of code or text for better navigation and focus.

### Manual Folding
| Command | Description |
|---------|-------------|
| `zf{motion}` | Create fold (e.g., `zfap` for paragraph) |
| `zf5j` | Create fold for next 5 lines |
| `zf/pattern` | Create fold from cursor to pattern |
| `zd` | Delete fold at cursor |
| `zD` | Delete all folds in current line |
| `zE` | Delete all folds in buffer |

### Fold Navigation & Control
| Command | Description |
|---------|-------------|
| `zo` | Open fold at cursor |
| `zO` | Open all folds at cursor recursively |
| `zc` | Close fold at cursor |
| `zC` | Close all folds at cursor recursively |
| `za` | Toggle fold at cursor |
| `zA` | Toggle all folds at cursor recursively |
| `zv` | Open folds to reveal cursor line |
| `zx` | Update folds (refresh) |

### Global Fold Operations
| Command | Description |
|---------|-------------|
| `zM` | Close all folds (fold more) |
| `zR` | Open all folds (reduce folds) |
| `zm` | Increase fold level (close some folds) |
| `zr` | Decrease fold level (open some folds) |

### Fold Movement
| Command | Description |
|---------|-------------|
| `[z` | Move to start of open fold |
| `]z` | Move to end of open fold |
| `zj` | Move down to start of next fold |
| `zk` | Move up to end of previous fold |

### Automatic Folding for Code
Add to your config for automatic folding based on indentation or syntax:
```vim
:set foldmethod=indent    " Fold based on indentation
:set foldmethod=syntax    " Fold based on syntax
:set foldmethod=marker    " Fold based on markers {{{ }}}
:set foldlevel=0          " Start with all folds closed
:set foldlevel=99         " Start with all folds open
```

### Markdown Header Folding
For markdown files, you can fold by headers:
- Use `zM` to fold all headers
- Use `zR` to unfold all headers  
- Use `za` to toggle current header section
- Use `zo`/`zc` to open/close specific header sections

## Custom Leader Keymaps

Your current Neovim configuration includes these custom leader key mappings:

### File & Navigation
| Keymap | Description |
|--------|-------------|
| `<leader>e` | Open file explorer (Snacks) |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep search |
| `<leader>fb` | Find buffers |
| `<leader>fr` | Recent files |
| `<leader>sw` | Search word under cursor |
| `<leader>pk` | Search keymaps |

### LSP & Code Actions
| Keymap | Description |
|--------|-------------|
| `<leader>ca` | Code actions |
| `<leader>fc` | Format code |
| `<leader>dl` | Show line diagnostics |
| `<leader>df` | Show all diagnostics in quickfix |

### Git Operations
| Keymap | Description |
|--------|-------------|
| `<leader>lg` | Lazygit |
| `<leader>gl` | Lazygit logs |
| `<leader>gbr` | Git branch picker |

### AI & Code Assistance
| Keymap | Description |
|--------|-------------|
| `<leader>cc` | CodeCompanion chat toggle |
| `<leader>ca` | CodeCompanion actions |
| `<leader>ci` | CodeCompanion inline |
| `<leader>cq` | Send selection to CodeCompanion |

### Markdown
| Keymap | Description |
|--------|-------------|
| `<leader>mp` | Markdown preview open |
| `<leader>mc` | Markdown preview close |

### Terminal & Utilities
| Keymap | Description |
|--------|-------------|
| `<leader>t` | Toggle terminal |
| `<leader>bd` | Delete buffer |

### Database
| Keymap | Description |
|--------|-------------|
| `<leader>ddb` | Open Database UI |
| `<leader>ddc` | Add Database Connection |

### Debug (DAP)
| Keymap | Description |
|--------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Breakpoint condition |
| `<leader>dc` | Debug continue |
| `<leader>di` | Debug step into |
| `<leader>do` | Debug step out |
| `<leader>dO` | Debug step over |
| `<leader>dt` | Debug terminate |
| `<leader>du` | Debug UI toggle |

### Org-Mode File Access
| Keymap | Description |
|--------|-------------|
| `<leader>of` | Open orgfiles directory |
| `<leader>ot` | Open tasks.org |
| `<leader>on` | Open notes.org |
| `<leader>ol` | Open learn directory |
| `<leader>om` | Open meetings.org |
| `<leader>or` | Open refile.org |
| `<leader>op` | Open projects directory |

## File Picker Commands

When using the file picker (`<leader>ff`, `<leader>fg`, etc.), these commands work:

### Navigation in Picker
| Command | Description |
|---------|-------------|
| `<Tab>` | Move up in list |
| `<S-Tab>` | Move down in list |
| `<C-j>` / `<C-k>` | Alternative up/down navigation |
| `<Esc>` | Close picker |
| `<C-q>` | Send results to quickfix |

### File Opening Commands
| Command | Description |
|---------|-------------|
| `<CR>` | Open file in current window |
| `<C-t>` | Open file in new tab |
| `<C-v>` | Open file in vertical split |
| `<C-x>` | Open file in horizontal split |
| `<C-s>` | Open file in horizontal split (alternative) |

### Additional Picker Features
- **Live grep**: Type your search term and see results update in real-time
- **File preview**: Many pickers show file preview in a separate pane
- **Fuzzy matching**: Type partial matches to find files quickly
- **Recent files**: Sorted by most recently accessed

## Org-Mode

### File Structure
Your org files are located in `~/orgfiles/` with this structure:
```
~/orgfiles/
├── tasks.org           # Main tasks and TODOs
├── notes.org           # General notes and reference  
├── meetings.org        # Meeting notes
├── refile.org          # Quick captures
├── learn/              # Learning materials
├── projects/           # Project-specific files
└── templates/          # Template files
```

### Essential Commands
| Command | Description |
|---------|-------------|
| `Tab` | Fold/unfold current heading |
| `S-Tab` | Cycle visibility of entire document |
| `]]` | Next heading |
| `[[` | Previous heading |
| `cit` | Change TODO state |
| `<C-c><C-t>` | Cycle TODO state |
| `<C-c>.` | Insert active timestamp |
| `<C-c>!` | Insert inactive timestamp |

### Org Agenda & Capture
| Command | Description |
|---------|-------------|
| `<leader>oa` | Open agenda view |
| `<leader>oc` | Quick capture menu |

### Capture Templates
Press `<leader>oc` then choose:
- **`t`** - Task: Creates TODO with scheduled date
- **`n`** - Note: Creates timestamped note
- **`m`** - Meeting: Uses meeting template  
- **`l`** - Learning: Uses learning template
- **`p`** - Project Task: Creates project task
- **`r`** - Refile: Quick capture for later organization

### Basic Org Syntax
```org
* First Level Heading
** Second Level  
*** Third Level

* TODO Important task
* NEXT Working on this  
* DONE Completed task

SCHEDULED: <2025-08-06 Tue 10:00>
DEADLINE: <2025-08-10 Sat>

[[https://example.com][Website Link]]
[[file:~/documents/report.pdf][Project Report]]
```

## Obsidian Commands

Your Obsidian setup supports two vaults:
- Personal: `~/vaults/personal`
- Work: `~/vaults/work`

### Navigation & Links
| Command | Description |
|---------|-------------|
| `gf` | Follow link under cursor |
| `<leader>ch` | Toggle checkbox |
| `<CR>` | Smart action (follow link or toggle checkbox) |

### Obsidian Telescope Picker Commands
When using Obsidian's telescope integration:

| Command | Description |
|---------|-------------|
| `<C-x>` | Create new note from query |
| `<C-l>` | Insert link to selected note |

### Obsidian Commands (via Command Palette)
- `:ObsidianOpen` - Open vault in Obsidian app
- `:ObsidianNew` - Create new note
- `:ObsidianQuickSwitch` - Quick switch between notes
- `:ObsidianFollowLink` - Follow link under cursor
- `:ObsidianBackLinks` - Show backlinks
- `:ObsidianTags` - Show all tags
- `:ObsidianToday` - Open/create daily note
- `:ObsidianYesterday` - Open yesterday's daily note
- `:ObsidianTomorrow` - Open tomorrow's daily note
- `:ObsidianDailies` - Open daily notes
- `:ObsidianSearch` - Search in vault
- `:ObsidianLink` - Link text to note
- `:ObsidianLinkNew` - Link text to new note
- `:ObsidianExtractNote` - Extract text to new note
- `:ObsidianWorkspace` - Switch workspace
- `:ObsidianPasteImg` - Paste image from clipboard
- `:ObsidianRename` - Rename note and update links

### Templates & Daily Notes
- Daily notes stored in: `notes/dailies/`
- Templates stored in: `templates/`
- Date format: `%Y-%m-%d`
- Images stored in: `assets/imgs/`

## Buffer, Window & Tab Management

### Buffer Navigation
| Command | Description |
|---------|-------------|
| `:ls` | List all buffers |
| `:b number` | Switch to buffer number |
| `:b filename` | Switch to buffer by name |
| `:bd` | Delete current buffer |
| `:bn` | Next buffer |
| `:bp` | Previous buffer |
| `<C-6>` | Switch between last two buffers |
| `gt` | Go to next tab |
| `gT` | Go to previous tab |

### Window Management
| Command | Description |
|---------|-------------|
| `<C-w>h/j/k/l` | Move between windows |
| `<C-w>w` | Move to next window |
| `<C-w>p` | Move to previous window |
| `<C-w>+/-` | Resize window height |
| `<C-w></>` | Resize window width |
| `<C-w>=` | Make all windows equal size |
| `<C-w>o` | Close all other windows |

### Tab Management
| Command | Description |
|---------|-------------|
| `:tabnew` | New tab |
| `:tabe filename` | Open file in new tab |
| `:tabc` | Close current tab |
| `:tabo` | Close all other tabs |
| `:tabs` | List all tabs |
| `1gt` | Go to tab 1 |
| `2gt` | Go to tab 2 |

## Macros & Registers

### Recording & Playing Macros
| Command | Description |
|---------|-------------|
| `qa` | Start recording macro in register 'a' |
| `q` | Stop recording |
| `@a` | Play macro from register 'a' |
| `@@` | Repeat last played macro |
| `10@a` | Play macro 'a' 10 times |

### Using Registers
| Command | Description |
|---------|-------------|
| `"ayiw` | Yank inner word into register 'a' |
| `"ap` | Paste contents of register 'a' |
| `"*y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
| `:reg` | Show all register contents |

### Special Registers
- `"0` - Last yank
- `"1`-`"9` - Delete history  
- `".` - Last inserted text
- `"%` - Current filename
- `":` - Last command
- `"*` - System clipboard (selection)
- `"+` - System clipboard

## Advanced Tips

### Command Line Completion
| Command | Description |
|---------|-------------|
| `<Tab>` | Complete command/filename |
| `<C-d>` | Show all completions |
| `<C-a>` | Move to beginning of line |
| `<C-e>` | Move to end of line |
| `<C-w>` | Delete word backward |
| `<C-u>` | Delete to beginning of line |

### Command History
| Command | Description |
|---------|-------------|
| `↑` / `↓` | Navigate command history |
| `:history` | Show command history |
| `q:` | Open command history window |
| `q/` | Open search history window |

### Marks & Jumps
| Command | Description |
|---------|-------------|
| `ma` | Set mark 'a' at current position |
| `'a` | Jump to mark 'a' |
| `` `a `` | Jump to exact position of mark 'a' |
| `''` | Jump to last position before jump |
| `'.` | Jump to last change |
| `'^` | Jump to last insert |
| `:marks` | Show all marks |
| `<C-o>` | Jump to older position |
| `<C-i>` | Jump to newer position |

### Surround Operations (Mini.surround)
| Command | Description |
|---------|-------------|
| `sa{motion}{char}` | Add surrounding |
| `sd{char}` | Delete surrounding |
| `sr{old}{new}` | Replace surrounding |
| `sf{char}` | Find surrounding (right) |
| `sF{char}` | Find surrounding (left) |

Examples:
- `saiw"` - Surround word with quotes
- `sd"` - Delete surrounding quotes  
- `sr"'` - Change double quotes to single quotes

### Comment Operations (Mini.comment)
| Command | Description |
|---------|-------------|
| `gcc` | Toggle line comment |
| `gc{motion}` | Toggle comment for motion |
| `gc` | Toggle comment (visual mode) |

### Auto-pairs
Automatically closes:
- `()` - Parentheses
- `[]` - Brackets  
- `{}` - Braces
- `""` - Double quotes
- `''` - Single quotes

### Session Management
```vim
:mksession ~/my-session.vim    " Save session
:source ~/my-session.vim       " Restore session
nvim -S ~/my-session.vim       " Open with session
```

### Creating Files & Directories
```vim
:e notes/newfile.txt           " Create new file
:!mkdir -p notes               " Create directory
```

This comprehensive guide covers all the essential Vim/Neovim commands, your custom configuration keymaps, and plugin-specific features. Keep this as your reference for efficient text editing and navigation!