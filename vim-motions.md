# Vim Motions & Movement Commands

<!--toc:start-->
- [Vim Motions & Movement Commands](#vim-motions--movement-commands)
  - [Basic Movement](#basic-movement)
  - [Word Movement](#word-movement)
  - [Line Movement](#line-movement)
  - [Screen Movement](#screen-movement)
  - [File Movement](#file-movement)
  - [Search Movement](#search-movement)
  - [Character Movement](#character-movement)
  - [Paragraph and Sentence Movement](#paragraph-and-sentence-movement)
  - [Code Block Movement](#code-block-movement)
  - [Window and Tab Movement](#window-and-tab-movement)
  - [Advanced Movement Combinations](#advanced-movement-combinations)
  - [Movement with Operations](#movement-with-operations)
  - [Text Objects](#text-objects)
  - [Visual Mode Movements](#visual-mode-movements)
<!--toc:end-->

## Basic Movement

| Motion | Description |
|--------|-------------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `gj` | Move down by display line (wrapped) |
| `gk` | Move up by display line (wrapped) |

## Word Movement

| Motion | Description |
|--------|-------------|
| `w` | Jump to start of next word |
| `W` | Jump to start of next WORD (space-delimited) |
| `e` | Jump to end of current/next word |
| `E` | Jump to end of current/next WORD |
| `b` | Jump backward to start of word |
| `B` | Jump backward to start of WORD |
| `ge` | Jump backward to end of word |
| `gE` | Jump backward to end of WORD |

### Word vs WORD
- **word**: delimited by punctuation and whitespace (`hello-world` = 3 words)
- **WORD**: delimited only by whitespace (`hello-world` = 1 WORD)

## Line Movement

| Motion | Description |
|--------|-------------|
| `0` | Go to first character of line |
| `^` | Go to first non-blank character |
| `$` | Go to end of line |
| `g_` | Go to last non-blank character |
| `+` | Go to first non-blank of next line |
| `-` | Go to first non-blank of previous line |

## Screen Movement

| Motion | Description |
|--------|-------------|
| `H` | Go to top of screen (High) |
| `M` | Go to middle of screen (Middle) |
| `L` | Go to bottom of screen (Low) |
| `zt` | Scroll line to top of screen |
| `zz` | Center line on screen |
| `zb` | Scroll line to bottom of screen |
| `Ctrl+u` | Scroll up half page |
| `Ctrl+d` | Scroll down half page |
| `Ctrl+b` | Scroll up full page (back) |
| `Ctrl+f` | Scroll down full page (forward) |
| `Ctrl+e` | Scroll down one line |
| `Ctrl+y` | Scroll up one line |

## File Movement

| Motion | Description |
|--------|-------------|
| `gg` | Go to first line of file |
| `G` | Go to last line of file |
| `5G` or `:5` | Go to line 5 |
| `50%` | Go to 50% through file |
| `Ctrl+o` | Jump to older position (back) |
| `Ctrl+i` | Jump to newer position (forward) |

## Search Movement

| Motion | Description |
|--------|-------------|
| `/pattern` | Search forward for pattern |
| `?pattern` | Search backward for pattern |
| `n` | Repeat search in same direction |
| `N` | Repeat search in opposite direction |
| `*` | Search forward for word under cursor |
| `#` | Search backward for word under cursor |
| `g*` | Search forward for partial word under cursor |
| `g#` | Search backward for partial word under cursor |

### Advanced Search
| Motion | Description |
|--------|-------------|
| `f{char}` | Find next character on line |
| `F{char}` | Find previous character on line |
| `t{char}` | Till next character (stop before) |
| `T{char}` | Till previous character (stop before) |
| `;` | Repeat last f/F/t/T |
| `,` | Repeat last f/F/t/T in opposite direction |

## Character Movement

| Motion | Description |
|--------|-------------|
| `Space` | Move right (same as `l`) |
| `Backspace` | Move left (same as `h`) |
| `Enter` | Move to start of next line |
| `|` | Move to column 1 |
| `5|` | Move to column 5 |

## Paragraph and Sentence Movement

| Motion | Description |
|--------|-------------|
| `}` | Move to next paragraph |
| `{` | Move to previous paragraph |
| `)` | Move to next sentence |
| `(` | Move to previous sentence |

## Code Block Movement

| Motion | Description |
|--------|-------------|
| `%` | Jump to matching bracket/brace/parenthesis |
| `]]` | Jump to next function/class |
| `[[` | Jump to previous function/class |
| `][` | Jump to end of current function |
| `[]` | Jump to end of previous function |
| `]m` | Jump to next method |
| `[m` | Jump to previous method |
| `]{` | Jump to next unmatched `{` |
| `[{` | Jump to previous unmatched `{` |
| `])` | Jump to next unmatched `)` |
| `[(` | Jump to previous unmatched `(` |

## Window and Tab Movement

### Window Movement
| Motion | Description |
|--------|-------------|
| `Ctrl+w h` | Move to left window |
| `Ctrl+w j` | Move to bottom window |
| `Ctrl+w k` | Move to top window |
| `Ctrl+w l` | Move to right window |
| `Ctrl+w w` | Move to next window |
| `Ctrl+w p` | Move to previous window |

### Tab Movement
| Motion | Description |
|--------|-------------|
| `gt` | Go to next tab |
| `gT` | Go to previous tab |
| `{n}gt` | Go to tab number n |

## Advanced Movement Combinations

### Line Numbers with Motions
| Motion | Description |
|--------|-------------|
| `5j` | Move down 5 lines |
| `3w` | Move forward 3 words |
| `2f.` | Find second occurrence of `.` on line |
| `4}` | Move forward 4 paragraphs |

### Relative Line Numbers
With `relativenumber` set:
| Motion | Description |
|--------|-------------|
| `5j` | Move to line 5 below current |
| `3k` | Move to line 3 above current |
| `7G` | Still goes to absolute line 7 |

## Movement with Operations

### Delete with Movement
| Command | Description |
|---------|-------------|
| `dw` | Delete word |
| `d$` | Delete to end of line |
| `d0` | Delete to beginning of line |
| `dd` | Delete entire line |
| `d}` | Delete to end of paragraph |
| `df.` | Delete until (and including) `.` |
| `dt.` | Delete until (not including) `.` |

### Yank with Movement
| Command | Description |
|---------|-------------|
| `yw` | Yank word |
| `y$` | Yank to end of line |
| `yy` | Yank entire line |
| `y}` | Yank to end of paragraph |

### Change with Movement
| Command | Description |
|---------|-------------|
| `cw` | Change word |
| `c$` | Change to end of line |
| `cc` | Change entire line |
| `c}` | Change to end of paragraph |

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
| `i` ` | Inside backticks |
| `a` ` | Around backticks |

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

## Visual Mode Movements

### Visual Selection
| Command | Description |
|---------|-------------|
| `v` | Character-wise visual mode |
| `V` | Line-wise visual mode |
| `Ctrl+v` | Block-wise visual mode |
| `gv` | Reselect last visual selection |

### Visual Mode Motions
All normal mode motions work in visual mode:
- `vw` - Select word
- `v$` - Select to end of line
- `V}` - Select to end of paragraph
- `Ctrl+v3j` - Select block 3 lines down

### Visual Mode Text Objects
| Command | Description |
|---------|-------------|
| `viw` | Select inner word |
| `vaw` | Select a word |
| `vi"` | Select inside quotes |
| `va"` | Select around quotes |
| `vip` | Select inner paragraph |
| `vap` | Select a paragraph |

### Advanced Visual Selections
| Command | Description |
|---------|-------------|
| `o` | Go to other end of selection |
| `O` | Go to other corner (block mode) |
| `gv` | Reselect previous selection |

## Examples and Common Patterns

### Quick Line Operations
```vim
dd             " Delete line
yy             " Copy line
cc             " Change line
>>             " Indent line
<<             " Unindent line
```

### Quick Word Operations
```vim
dw             " Delete word
yw             " Copy word
cw             " Change word
diw            " Delete inner word (more precise)
ciw            " Change inner word
```

### Navigate and Edit
```vim
/function      " Search for 'function'
n              " Go to next occurrence
ciw            " Change the word
```

### Block Editing Example
```vim
Ctrl+v         " Start block selection
3j             " Select 4 lines
I              " Insert at beginning
// <Esc>       " Add comment, then Esc to apply to all lines
```

## Registers

- `"ayiw` → yank inner word into register `a`
- `"by$` → yank to the end of the line into register `b`
- `"ap` → paste contents of register `a` after cursor
- `"aP` → paste contents of register `a` before cursor

_You can use any lowercase letter (a-z) as a register name._

## Simple Commands

- `:w` → save (write)
- `:q` → quit
- `:wq` or `ZZ` → save and quit
- `:q!` → force quit without saving
- `u` → undo
- `Ctrl + r` → redo
- `dd` → delete (cut) a line
- `yy` → yank (copy) a line
- `p` → paste after cursor
- `P` → paste before cursor

## Record Macros

- `q<register>` → start recording macro into register (e.g., `qa` for register `a`)
- `q` → stop recording
- `@<register>` → run macro from register (e.g., `@a`)
- `@@` → repeat last macro

## Bonus: Visual Mode Tips

- `v` → enter visual mode (character-wise selection)
- `V` → enter line-wise visual mode
- `Ctrl + v` → enter visual block mode (great for column edits)
- `:normal` → apply commands to visual selection
