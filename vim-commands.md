# Vim Commands Reference

<!--toc:start-->

- [Vim Commands Reference](#vim-commands-reference)
  - [Basic Commands](#basic-commands)
  - [Command Line Operations](#command-line-operations)
  - [Multiple Cursors & Mass Editing](#multiple-cursors--mass-editing)
  - [Repeat Operations](#repeat-operations)
  - [Find and Replace](#find-and-replace)
  - [Buffer Management](#buffer-management)
  - [File Operations](#file-operations)
  - [Navigation Between Functions](#navigation-between-functions)
  - [Visual Mode Commands](#visual-mode-commands)
  - [Command Line Completion](#command-line-completion)
  - [Settings (:set commands)](#settings-set-commands)
  - [Advanced Text Objects](#advanced-text-objects)
  - [Macros](#macros)
  - [Marks and Jumps](#marks-and-jumps)
  - [Windows, Tabs, and Buffers Navigation](#windows-tabs-and-buffers-navigation)

<!--toc:end-->

## Basic Commands

| Command | Description | |---------|-------------| | `:w` | Save file | | `:q` | Quit | | `:wq` or
`:x` | Save and quit | | `:q!` | Quit without saving | | `:e filename` | Open/create file | | `:pwd`
| Show current directory | | `:cd path` | Change directory |

## Command Line Operations

### Tab Completion

- `Tab` - Complete command/filename
- `Ctrl+d` - Show all completions
- `Ctrl+a` - Move to beginning of line
- `Ctrl+e` - Move to end of line
- `Ctrl+w` - Delete word backward
- `Ctrl+u` - Delete to beginning of line

### Command History

- `↑` / `↓` - Navigate command history
- `:history` - Show command history
- `q:` - Open command history window
- `q/` - Open search history window

## Multiple Cursors & Mass Editing

### Column/Block Selection

```vim
Ctrl+v         " Enter visual block mode
j/k            " Select multiple lines
Shift+i        " Insert at beginning of all lines
Esc            " Apply to all selected lines

Ctrl+v         " Visual block mode
$              " Go to end of lines
Shift+a        " Append to end of all lines
Esc            " Apply changes
```

### Mass Operations

```vim
" Delete at end of multiple lines
Ctrl+v         " Visual block mode
G              " Select to end of file
$              " Go to end of lines
x              " Delete character at end of each line

" Add text to multiple lines
:1,10s/$/text  " Add 'text' to end of lines 1-10
:%s/$/text     " Add 'text' to end of all lines

" Insert at beginning of multiple lines
:1,10s/^/text  " Add 'text' to beginning of lines 1-10
```

### Move to Middle of Lines

```vim
Ctrl+v         " Visual block mode
j/k            " Select lines
^              " Move to first non-blank character
I              " Insert at that position
```

## Repeat Operations

### Numeric Multipliers

```vim
10i            " Enter insert mode, type text, press Esc
               " Repeats the insertion 10 times

10a            " Append text 10 times
10o            " Create 10 new lines below
10O            " Create 10 new lines above

10dd           " Delete 10 lines
10yy           " Yank 10 lines
10x            " Delete 10 characters

10j            " Move down 10 lines
10w            " Move forward 10 words
10dw           " Delete 10 words
```

### Dot Command (.)

```vim
.              " Repeat last change
10.            " Repeat last change 10 times
```

### Example: Insert Text 10 Times

```vim
10i Hello World! Esc
" Results in: Hello World! Hello World! Hello World! ... (10 times)
```

## Find and Replace

### Basic Find/Replace

```vim
:s/old/new/           " Replace first occurrence in current line
:s/old/new/g          " Replace all in current line
:%s/old/new/g         " Replace all in file
:%s/old/new/gc        " Replace all with confirmation
:10,20s/old/new/g     " Replace in lines 10-20
```

### Advanced Find/Replace

```vim
:%s/\<word\>/new/g    " Replace whole word only
:%s/old/new/gi        " Case insensitive replace
:%s/^/text/           " Add text to beginning of all lines
:%s/$/text/           " Add text to end of all lines
:%s/.*pattern.*/new/  " Replace entire lines containing pattern
```

### Visual Selection Replace

```vim
gv             " Reselect last visual selection
:'<,'>s/old/new/g  " Replace in visual selection
```

## Buffer Management

```vim
:ls            " List all buffers
:b number      " Switch to buffer number
:b filename    " Switch to buffer by name (Tab completion)
:bd            " Delete current buffer
:bd number     " Delete specific buffer
:bn            " Next buffer
:bp            " Previous buffer
Ctrl+6         " Switch between last two buffers
```

## File Operations

```vim
:e filename    " Edit file
:e!            " Reload current file (discard changes)
:sp filename   " Split window horizontally and open file
:vsp filename  " Split window vertically and open file
:tabe filename " Open file in new tab
:w filename    " Save as filename
:saveas filename " Save as and switch to new file
```

## Navigation Between Functions

### Programming Navigation

```vim
]]             " Jump to next function/class
[[             " Jump to previous function/class
]m             " Jump to next method
[m             " Jump to previous method
%              " Jump to matching bracket/brace
gd             " Go to definition (LSP)
gD             " Go to declaration
K              " Show documentation (LSP)
```

### Tag Navigation (with ctags)

```vim
Ctrl+]         " Jump to tag definition
Ctrl+t         " Jump back from tag
:tag name      " Jump to tag
:tags          " Show tag stack
```

## Visual Mode Commands

```vim
gv             " Reselect last visual selection
v              " Character-wise visual mode
V              " Line-wise visual mode
Ctrl+v         " Block-wise visual mode
o              " Go to other end of selection
aw             " Select a word (including whitespace)
iw             " Select inner word
ap             " Select a paragraph
ip             " Select inner paragraph
```

## Command Line Completion

### File/Directory Completion

```vim
:e <Tab>       " Complete filenames
:cd <Tab>      " Complete directory names
:sp <Tab>      " Complete filenames for split
```

### Command Completion

```vim
:se<Tab>       " Completes to :set
:setl<Tab>     " Completes to :setlocal
:h <Tab>       " Complete help topics
```

### Buffer/Window Completion

```vim
:b <Tab>       " Complete buffer names
:sb <Tab>      " Complete buffer names for split
```

## Settings (:set commands)

### Display Settings

```vim
:set number            " Show line numbers
:set nonumber          " Hide line numbers
:set relativenumber    " Show relative line numbers
:set norelativenumber  " Hide relative line numbers
:set cursorline        " Highlight current line
:set nocursorline      " Remove current line highlight
:set wrap              " Enable line wrapping
:set nowrap            " Disable line wrapping
```

### Search Settings

```vim
:set ignorecase        " Case insensitive search
:set noignorecase      " Case sensitive search
:set smartcase         " Smart case search
:set hlsearch          " Highlight search results
:set nohlsearch        " Don't highlight search
:set incsearch         " Incremental search
```

### Indentation Settings

```vim
:set expandtab         " Use spaces instead of tabs
:set noexpandtab       " Use tabs instead of spaces
:set tabstop=4         " Tab width
:set shiftwidth=4      " Indent width
:set softtabstop=4     " Soft tab width
:set autoindent        " Auto indent new lines
:set smartindent       " Smart indenting
```

### File Settings

```vim
:set fileformat=unix   " Unix line endings
:set encoding=utf-8    " UTF-8 encoding
:set backup            " Create backup files
:set nobackup          " Don't create backup files
:set hidden            " Allow hidden buffers
```

### Show Current Settings

```vim
:set                   " Show all non-default settings
:set all               " Show all settings
:set number?           " Show current value of 'number'
:verbose set number?   " Show where 'number' was last set
```

## Advanced Text Objects

### Inside/Around Objects

```vim
ciw            " Change inner word
caw            " Change a word (including space)
ci"            " Change inside quotes
ca"            " Change around quotes (including quotes)
ci(            " Change inside parentheses
ca(            " Change around parentheses
ci{            " Change inside braces
ci[            " Change inside brackets
cit            " Change inside HTML/XML tag
cat            " Change around HTML/XML tag
```

### Paragraph and Sentence Objects

```vim
cip            " Change inner paragraph
cap            " Change a paragraph
cis            " Change inner sentence
cas            " Change a sentence
```

## Macros

### Recording and Playing Macros

```vim
qa             " Start recording macro in register 'a'
q              " Stop recording
@a             " Play macro from register 'a'
@@             " Repeat last played macro
10@a           " Play macro 'a' 10 times
```

### Macro Example

```vim
qa             " Start recording
I"<Esc>        " Insert quote at beginning
A"<Esc>        " Insert quote at end
j              " Move to next line
q              " Stop recording
@a             " Play macro (adds quotes to line)
10@a           " Apply to next 10 lines
```

## Marks and Jumps

### Local Marks (per buffer)

```vim
ma             " Set mark 'a' at current position
'a             " Jump to mark 'a'
`a             " Jump to exact position of mark 'a'
:marks         " Show all marks
```

### Global Marks (across files)

```vim
mA             " Set global mark 'A'
'A             " Jump to global mark 'A'
```

### Automatic Marks

```vim
''             " Jump to last position before jump
'.             " Jump to last change
'^             " Jump to last insert
'[             " Jump to beginning of last change
']             " Jump to end of last change
```

### Jump List

```vim
Ctrl+o         " Jump to older position
Ctrl+i         " Jump to newer position
:jumps         " Show jump list
```

### Create new file within a directory

:e notes/newfile.txt

### Create new directory

:e !mkdir -p notes

The -p flag is usefull because it prevents errors if the directory already exisits and create parent
directories as needed.

## Windows, Tabs, and Buffers Navigation

### Understanding the Hierarchy

```
Vim Instance
├── Tab 1
│   ├── Window 1 (Buffer A)
│   ├── Window 2 (Buffer B)
│   └── Window 3 (Buffer C)
├── Tab 2
│   ├── Window 1 (Buffer D)
│   └── Window 2 (Buffer A)  # Same buffer in different tab
└── Tab 3
    └── Window 1 (Buffer E)

Buffer List: [A, B, C, D, E]  # Independent of windows/tabs
```

### Window Management

#### Creating Windows

```vim
:split filename        " Horizontal split with file
:sp filename          " Short form
:split                " Horizontal split with same buffer
:vsplit filename      " Vertical split with file
:vsp filename         " Short form
:vsplit               " Vertical split with same buffer
:new                  " New horizontal window with empty buffer
:vnew                 " New vertical window with empty buffer
```

#### Navigating Between Windows

```vim
Ctrl+w h              " Move to left window
Ctrl+w j              " Move to bottom window
Ctrl+w k              " Move to top window
Ctrl+w l              " Move to right window
Ctrl+w w              " Move to next window (clockwise)
Ctrl+w W              " Move to previous window (counter-clockwise)
Ctrl+w p              " Move to previously accessed window
Ctrl+w t              " Move to top-left window
Ctrl+w b              " Move to bottom-right window
```

#### Window Resizing

```vim
Ctrl+w +              " Increase height
Ctrl+w -              " Decrease height
Ctrl+w >              " Increase width
Ctrl+w <              " Decrease width
Ctrl+w =              " Make all windows equal size
Ctrl+w |              " Maximize current window width
Ctrl+w _              " Maximize current window height
:resize 20            " Set window height to 20 lines
:vertical resize 80   " Set window width to 80 columns
```

#### Moving and Rearranging Windows

```vim
Ctrl+w H              " Move window to far left
Ctrl+w J              " Move window to bottom
Ctrl+w K              " Move window to top
Ctrl+w L              " Move window to far right
Ctrl+w x              " Exchange current window with next
Ctrl+w r              " Rotate windows downward
Ctrl+w R              " Rotate windows upward
```

#### Closing Windows

```vim
:q                    " Close current window
:close                " Close current window (same as :q)
Ctrl+w c              " Close current window
Ctrl+w o              " Close all other windows (only current remains)
:only                 " Close all other windows
```

### Tab Management

#### Creating Tabs

```vim
:tabnew               " New tab with empty buffer
:tabnew filename      " New tab with file
:tabe filename        " Edit file in new tab (short form)
:tabf filename        " Find and open file in new tab
Ctrl+w T              " Move current window to new tab
```

#### Navigating Between Tabs

```vim
gt                    " Go to next tab
gT                    " Go to previous tab
:tabn                 " Next tab (command form)
:tabp                 " Previous tab (command form)
:tabfirst             " Go to first tab
:tablast              " Go to last tab
1gt                   " Go to tab 1
2gt                   " Go to tab 2
{n}gt                 " Go to tab n
```

#### Tab Information and Management

```vim
:tabs                 " List all tabs with their windows
:tabm 0               " Move current tab to position 0 (first)
:tabm                 " Move current tab to last position
:tabm 3               " Move current tab to position 3
```

#### Closing Tabs

```vim
:tabc                 " Close current tab
:tabclose             " Close current tab (full form)
:tabo                 " Close all other tabs
:tabonly              " Close all other tabs (full form)
:qa                   " Quit all tabs
```

### Buffer Management

#### Buffer Navigation

```vim
:ls                   " List all buffers
:buffers              " List all buffers (full form)
:files                " List all buffers (alternative)
:b1                   " Switch to buffer 1
:b filename           " Switch to buffer by name (Tab completion works)
:buffer 2             " Switch to buffer 2 (full form)
:bn                   " Next buffer
:bnext                " Next buffer (full form)
:bp                   " Previous buffer
:bprev                " Previous buffer (full form)
:bf                   " First buffer
:bfirst               " First buffer (full form)
:bl                   " Last buffer
:blast                " Last buffer (full form)
Ctrl+6                " Switch to alternate buffer (last accessed)
Ctrl+^                " Switch to alternate buffer (alternative)
```

#### Buffer Status Indicators

When you run `:ls`, you'll see indicators:

```vim
:ls
  1 %a   "file1.txt"           line 1
  2 #h   "file2.txt"           line 5
  3      "file3.txt"           line 1

% = current buffer
# = alternate buffer
a = active (displayed in window)
h = hidden (loaded but not displayed)
u = unlisted
+ = modified
- = unmodifiable
= = readonly
x = read errors
```

#### Buffer Operations

```vim
:bd                   " Delete current buffer
:bdelete              " Delete current buffer (full form)
:bd 2                 " Delete buffer 2
:bd file.txt          " Delete buffer by name
:bw                   " Wipe buffer (more thorough deletion)
:bwipeout             " Wipe buffer (full form)
:%bd                  " Delete all buffers
:%bd|e#               " Delete all buffers except current
```

### Advanced Navigation Patterns

#### Working with Multiple Files

```vim
" Open multiple files in tabs
vim -p file1.txt file2.txt file3.txt

" Open multiple files in splits
vim -o file1.txt file2.txt    " Horizontal splits
vim -O file1.txt file2.txt    " Vertical splits

" Add files to current session
:tabe file1.txt
:sp file2.txt
:vsp file3.txt
```

#### Buffer vs Window vs Tab Usage Patterns

**Buffers**: Best for managing many files
```vim
" Open many files as buffers
:e file1.txt
:e file2.txt
:e file3.txt
" Navigate with :bn, :bp, :b filename
```

**Windows**: Best for comparing/working with multiple files simultaneously
```vim
:sp file1.txt         " Compare files side by side
:vsp file2.txt
Ctrl+w w              " Jump between comparisons
```

**Tabs**: Best for different contexts/projects
```vim
" Tab 1: Main project files
:tabe main.py
:sp tests.py

" Tab 2: Documentation
:tabe README.md
:sp CHANGELOG.md

" Tab 3: Configuration
:tabe config.json
```

### Useful Combinations and Workflows

#### Quick File Switching

```vim
" Method 1: Buffer switching (fastest for many files)
:b part<Tab>          " Quick switch using partial filename

" Method 2: Recent files (your telescope config)
<leader>fr            " Recent files in project

" Method 3: File finder (your telescope config)
<leader>ff            " Find files
```

#### Workspace Setup Examples

```vim
" Split workspace for development
:e main.py            " Open main file
:vsp tests.py         " Vertical split for tests
:sp config.yaml       " Horizontal split for config
Ctrl+w h              " Focus on main file

" Tab-based workflow
:tabe src/main.py     " Tab 1: Source code
:tabe tests/          " Tab 2: Tests
:tabe docs/           " Tab 3: Documentation
gt                    " Switch between contexts
```

#### Session Management

```vim
" Save session with all tabs/windows/buffers
:mksession ~/my-project.vim

" Restore session
:source ~/my-project.vim
" or from command line:
nvim -S ~/my-project.vim
```

### Integration with Your Custom Keymaps

Your current setup already includes some of these:

```vim
" Your existing telescope keymaps work great with buffers:
<leader>ff            " Find files (opens in current window)
<leader>fb            " Find buffers (quick buffer switching)
<leader>fr            " Recent files

" Your yazi integration:
<leader>e             " File manager (can open files in tabs/splits)

" Combine with window/tab commands:
<leader>ff            " Find file
Ctrl+w v              " Open in vertical split
<leader>ff            " Find another file
Ctrl+w s              " Open in horizontal split
```
