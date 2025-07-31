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
<!--toc:end-->

## Basic Commands

| Command | Description |
|---------|-------------|
| `:w` | Save file |
| `:q` | Quit |
| `:wq` or `:x` | Save and quit |
| `:q!` | Quit without saving |
| `:e filename` | Open/create file |
| `:pwd` | Show current directory |
| `:cd path` | Change directory |

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

The -p flag is usefull because it prevents errors if the directory already
exisits and create parent directories as needed.
