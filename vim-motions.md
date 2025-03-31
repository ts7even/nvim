# Vim Motions

<!--toc:start-->
- [Vim Motions](#vim-motions)
  - [Buffer's](#buffers)
  - [Find replace text](#find-replace-text)
    - [Find and replace current line](#find-and-replace-current-line)
    - [Find and replace all in current line](#find-and-replace-all-in-current-line)
    - [Find and replace in the whole file](#find-and-replace-in-the-whole-file)
    - [Find and replace & confrim each replacement](#find-and-replace-confrim-each-replacement)
    - [Find and replace in specific range](#find-and-replace-in-specific-range)
  - [Jump between functions](#jump-between-functions)
<!--toc:end-->

## Buffer's

<Ctrl - 6> -> Move between two opened buffers.


## Find replace text

### Find and replace current line

:s/old/new/

### Find and replace all in current line

:s/old/new/g

### Find and replace in the whole file

:%s/old/new/g

### Find and replace & confrim each replacement

:%s/old/new/gc

### Find and replace in specific range

:10,20s/old/new/g

## Jump between functions
