# Vim Motions & Commands

## Navigation

- `h` → move left
- `j` → move down
- `k` → move up
- `l` → move right
- `w` → jump to the next word
- `b` → jump backwords to the next word
- `gg` → jump to the top of the file
- `G` (`Shift + gg`) → jump to the bottom of the file
- `0` → go to beginning of the line
- `^` → go to the first non-blank character of the line
- `$` → go to end of line (Normal mode)
- `A` (`Shift + a`) → go to end of line and enter Insert mode
- `Ctrl + u` → jump up half a page
- `Ctrl + d` → jump down half a page
- `Ctrl + o` → go to older cursor position (jump back)
- `Ctrl + i` → go to newer cursor position (jump forward)
- `Ctrl + v` → Visual Block Mode (Add / Delete comments)
- `:bnext` or `:bn` → next buffer
- `:bprev` or `:bp` → previous buffer
- `%` → jump to matching bracket/brace/parenthesis
- `V` (`Shift + v`) → Select entire line

## Search Navigation

- `/pattern` → search forward for pattern
- `?pattern` → search backward for pattern
- `n` → repeat search in same direction
- `N` → repeat search in opposite direction

## Jumping Between Code (great for programming)

- `]]` → jump to the start of the next function (depends on filetype support)
- `[[` → jump to the start of the previous function
- `]m` → jump to the start of the next method/function
- `[m` → jump to the start of the previous method/function
- `%` → jump between matching brackets `()`, `{}`, `[]`, etc.

## Text Object Motions (Useful for Code Editing)

- `ciw` → change inner word (deletes and enters insert mode)
- `diw` → delete inner word
- `yiw` → yank inner word
- `yw` → yank word from cursor to the end
- `ci(` / `ci{` / `ci[` → change contents inside parentheses/braces/brackets
- `di(` / `di{` / `di[` → delete contents inside parentheses/braces/brackets
- `yi(` / `yi{` / `yi[` → yank contents inside parentheses/braces/brackets

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
