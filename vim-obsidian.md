# Vim Obsidian

[Obsidian Git Hub](https://github.com/epwalsh/obsidian.nvim)

## Bash Command to Open Obsidian in neovim

- `ob [folder]`

```Bash
alias ob='function _ob() { cd ~/path/to/your/vault/"$1" && nvim .; }; _ob'
```

## Obsidian Vim Plugin Commands

### General Note Management

- **`:ObsidianOpen [QUERY]`**
  Open a note in the Obsidian app.

  - _QUERY_ (optional): Resolve the note by ID, path, or alias.
  - If not provided, the note corresponding to the current buffer is opened.

- **`:ObsidianNew [TITLE]`**
  Create a new note.

  - _TITLE_ (optional): Title of the new note.

- **`:ObsidianRename [NEWNAME] [--dry-run]`**
  Rename the current note or the reference under the cursor, updating all backlinks.

  - Append `--dry-run` to preview changes without committing.
  - Recommended to commit your vault before using.

- **`:ObsidianWorkspace [NAME]`**
  Switch to another workspace.

### Navigation & Search

- **`:ObsidianQuickSwitch`**
  Quickly switch to (or open) another note using your preferred picker.

- **`:ObsidianFollowLink [vsplit|hsplit]`**
  Follow a note reference under the cursor.

  - Optional split: `vsplit` or `hsplit`.

- **`:ObsidianBacklinks`**
  List references to the current buffer using a picker.

- **`:ObsidianTags [TAG ...]`**
  Show occurrences of the given tags using a picker.

- **`:ObsidianSearch [QUERY]`**
  Search for (or create) notes using `ripgrep` and your preferred picker.

- **`:ObsidianLinks`**
  Collect all links in the current buffer into a picker list.

- **`:ObsidianTOC`**
  Load the table of contents of the current note into a picker list.

### Daily Notes

- **`:ObsidianToday [OFFSET]`**
  Open/create a daily note.

  - _OFFSET_ (optional): e.g., `-1` for yesterday.

- **`:ObsidianYesterday`**
  Open/create the previous working day's note.

- **`:ObsidianTomorrow`**
  Open/create the next working day's note.

- **`:ObsidianDailies [OFFSET ...]`**
  List a range of daily notes.
  - Example: `:ObsidianDailies -2 1` lists from 2 days ago to tomorrow.

### Linking & Templates

- **`:ObsidianLink [QUERY]`**
  Link the selected text to a note.

  - _QUERY_ (optional): Resolved by ID, path, or alias.

- **`:ObsidianLinkNew [TITLE]`**
  Create a new note and link it to the selected text.

  - _TITLE_ (optional): Title for the new note.

- **`:ObsidianExtractNote [TITLE]`**
  Extract selected text into a new note and link to it.

- **`:ObsidianTemplate [NAME]`**
  Insert a template from the templates folder using a picker.

- **`:ObsidianNewFromTemplate [TITLE]`**
  Create a new note from a template.
  - _TITLE_ (optional): Title for the new note.

### Miscellaneous

- **`:ObsidianPasteImg [IMGNAME]`**
  Paste an image from the clipboard into the note.

  - Saves to the configured `attachments.img_folder`.
  - _IMGNAME_ (optional): Custom name for the image.

- **`:ObsidianToggleCheckbox`**
  Cycle through checkbox states.

```

```
