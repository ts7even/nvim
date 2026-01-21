# Neovim configuration

Neovim configuration for multi-tasking and development.

## Leader Keys 

### Snacks 

|Key|Description|Type|
|:---:|:---|:---:|
|`<leader>e`|File Explorer (with hidden files)|Action|
|`<leader>ff`|Find Files|Picker|
|`<leader>fg`|Live Grep|Picker|
|`<leader>fb`|Find Buffers|Picker|
|`<leader>fr`|Recent Files|Picker|
|`<leader>sw`|Search Word Under Cursor|Picker|
|`<leader>pk`|Search Keymaps|Picker|
|`<leader>qf`|Quickfix List|Picker|
|`<leader>lg`|Open Lazygit|Action|
|`<leader>gl`|Lazygit Logs|Action|
|`<leader>gbr`|Git Branch Picker|Picker|
|`<leader>t`|Toggle Terminal|Action|
|`<leader>bd`|Delete Buffer|Action|

### Kalulu - HTTP Client 

|Key|Description|
|:---:|:---|
|`<leader>rr`|Send HTTP Request|
|`<leader>ra`|Send All Requests|
|`<leader>rl`|Replay Last Request|
|`<leader>ri`|Inspect Request|
|`<leader>rt`|Toggle Body/Headers View|
|`<leader>rh`|Open HTTP Files Directory in a new tab|

### Dadbod - Database Client

|Key|Description|
|:---:|:---|
|`<leader>ddb`|Open Database UI in Full Window|
|`<leader>ddc`|Add Database Connection|
|`<leader>ddq`|Find Database Buffer|

### Debug Adapter Protocol (DAP)

|Key|Description|
|:---:|:---|
|`<leader>db`|Toggle Breakpoint|
|`<leader>dB`|Breakpoint Condition|
|`<leader>dc`|Run/Continue|
|`<leader>da`|Run with Args|
|`<leader>dC`|Run to Cursor|
|`<leader>dg`|Go to Line (No Execute)|
|`<leader>di`|Step Into|
|`<leader>dj`|Down|
|`<leader>dk`|Up|
|`<leader>dL`|Run Last|
|`<leader>do`|Step Out|
|`<leader>dO`|Step Over|
|`<leader>dP`|Pause|
|`<leader>dr`|Toggle REPL|
|`<leader>ds`|Session|
|`<leader>dt`|Terminate|
|`<leader>dw`|Widgets|
|`<leader>du`|Dap UI|
|`<leader>de`|Eval|

### LSP (Language Server Protocol)

|Key|Description|
|:---:|:---|
|`<leader>cl`|LSP Info|
|`<leader>k`|Hover Documentation|
|`<leader>gd`|Go to Definition (Snacks Picker)|
|`<leader>gr`|Go to References (Snacks Picker)|
|`<leader>gi`|Go to Implementation|
|`<leader>gy`|Go to Type Definition|
|`<leader>gD`|Go to Declaration|
|`<leader>gk`|Signature Help|
|`<C-k>`|Signature Help (Insert Mode)|
|`<leader>ca`|Code Action|
|`<leader>cc`|Run Codelens|
|`<leader>cC`|Refresh & Display Codelens|
|`<leader>cr`|Rename Symbol|
|`<leader>dl`|Show Line Diagnostics|
|`<leader>df`|Show All Diagnostics in Quickfix|

### Orgmode

|Key|Description|
|:---:|:---|
|`<leader>of`|Open orgfiles Directory|
|`<leader>ot`|Open tasks.org|
|`<leader>on`|Open notes.org|
|`<leader>ol`|Open learn Directory|
|`<leader>om`|Open meetings.org|
|`<leader>or`|Open refile.org|
|`<leader>op`|Open projects Directory|

### Obsidian

|Key|Description|
|:---:|:---|
|`gf`|Follow Link (in markdown files)|
|`<leader>ch`|Toggle Checkbox|
|`<cr>`|Smart Action (follow link or toggle checkbox)|

### AI (CodeCompanion)

|Key|Description|
|:---:|:---|
|`<leader>aic`|AI Chat|
|`<leader>aii`|AI Inline - select code first|
|`<leader>aia`|AI Actions|

### AI (Claude Code)

|Key|Description|
|:---:|:---|
|`<leader>ait`|Toggle Claude Code|
|`<leader>aif`|Focus Claude Code|
|`<leader>air`|Resume Claude|
|`<leader>aiR`|Continue Claude|
|`<leader>aim`|Select Model|
|`<leader>aib`|Add Buffer to Claude|
|`<leader>ais`|Send Selection to Claude (visual)|
|`<leader>aid`|Accept Diff|
|`<leader>aix`|Reject Diff|

### Vim

|Key|Description|
|:---:|:---|
|`<leader>vr`|Reload Config|

## Usage Guide

### Debug (DAP)

**Setting Breakpoints:**
1. Open file and place cursor on line
2. Press `<leader>db` to toggle breakpoint
3. Press `<leader>dB` for conditional breakpoint
4. Press `<leader>dc` to start debugging

**During Debug Session:**
- `<leader>di` - Step into function
- `<leader>dO` - Step over line
- `<leader>do` - Step out of function
- `<leader>du` - Open debug UI
- `<leader>de` - Evaluate expression under cursor
- `<leader>dt` - Stop debugging

### Claude Code

**Getting Started:**
1. Install Claude Code CLI: `npm install -g @anthropic-ai/claude-code`
2. Authenticate: `claude login`
3. Press `<leader>ait` to open Claude Code terminal

**Basic Workflow:**
- `<leader>ait` - Toggle Claude Code terminal
- `<leader>aif` - Focus/unfocus the terminal
- `<leader>aib` - Add current buffer to Claude's context

**Working with Code:**
1. Select code in visual mode
2. Press `<leader>ais` to send selection to Claude
3. Claude will analyze and suggest changes
4. Use `<leader>aid` to accept or `<leader>aix` to reject diffs

**Session Management:**
- `<leader>air` - Resume previous session
- `<leader>aiR` - Continue current session
- `<leader>aim` - Switch between Claude models

**Commands:**

|Command|Action|
|:---:|:---|
|`:ClaudeCode`|Toggle terminal window|
|`:ClaudeCodeFocus`|Smart focus/toggle|
|`:ClaudeCodeSend`|Send visual selection|
|`:ClaudeCodeAdd <file>`|Add file to context|
|`:ClaudeCodeSelectModel`|Choose model variant|
|`:ClaudeCodeDiffAccept`|Accept changes|
|`:ClaudeCodeDiffDeny`|Reject changes|

### REST Client (Kulala)

**Creating Requests:**
1. Create `.http` or `.rest` file in project root or `static/` directory
2. Write HTTP request:
   ```
   GET https://api.example.com/users
   ```
3. Place cursor on request and press `<leader>rr`

**Multiple Requests:**
- Separate requests with `###`
- Use `<leader>ra` to run all requests
- Use `<leader>rl` to replay last request

### Database (Dadbod)

**Adding Connection:**
1. Press `<leader>ddc` to add connection
2. Enter connection string: `postgresql://user:pass@host:5432/dbname`
3. Connections saved to `static/db_connections.json`

**Using Database:**
1. Press `<leader>ddb` to open database UI
2. Navigate with `j/k`, expand with `<Enter>`
3. Press `o` on table to query
4. Edit query and press `<leader>r` to execute

### Snippets

**Using Snippets:**
1. Type snippet prefix (e.g., `fn`, `class`, `struct`)
2. Snippet appears in autocomplete menu
3. Press `<Tab>` to expand and navigate placeholders
4. Press `<S-Tab>` to go back to previous placeholder

**Available Languages:**
- Rust, Python, Zig, C, C++, JavaScript, TypeScript, HTML
- View all snippets in `static/snippets.json`

### Orgmode

**File Structure:**
- Store files in `~/orgfiles/`
- Main files: `tasks.org`, `notes.org`, `meetings.org`

**Basic Usage:**
1. Open with `<leader>ot` (tasks) or `<leader>on` (notes)
2. Create heading with `* Heading`
3. Add TODO with `* TODO Task name`
4. Toggle TODO state with `Ctrl+Space`
5. Schedule with `,s` and set deadline with `,d`

**Quick Navigation:**
- `<leader>of` - Browse all org files
- `<leader>ol` - Learning notes
- `<leader>op` - Project files

### Obsidian

**Vault Setup:**
1. Set `OBSIDIAN_PATH` environment variable to vault location
2. Vaults: `finance` and `compsci` (configure in `obsidian.lua`)

**Navigation:**
1. Open markdown file in vault
2. Use `gf` on `[[wiki-link]]` to follow
3. Press `<Enter>` on link or checkbox for smart action
4. Use `<leader>ch` to toggle checkbox

**Commands:**
- `:ObsidianQuickSwitch` - Find notes
- `:ObsidianSearch <term>` - Search in vault
- `:ObsidianNew <name>` - Create new note
- `:ObsidianToday` - Open daily note

## Common Vim Commands

### Find & Replace

```vim
:%s/old/new/g           # Replace all occurrences in file
:%s/old/new/gc          # Replace with confirmation
:'<,'>s/old/new/g       # Replace in visual selection
:g/pattern/d            # Delete all lines containing pattern
:v/pattern/d            # Delete all lines NOT containing pattern
```

### Advanced Navigation

```vim
50%                     # Jump to 50% of file
75%                     # Jump to 75% of file
:50                     # Jump to line 50
/{pattern}              # Search forward
?{pattern}              # Search backward
*                       # Search word under cursor forward
#                       # Search word under cursor backward
```

### Text Objects & Editing

```vim
di(                     # Delete inside parentheses
di{                     # Delete inside braces
di"                     # Delete inside quotes
ci(                     # Change inside parentheses
yi{                     # Yank inside braces
dap                     # Delete around paragraph
cit                     # Change inside tag (HTML)
```

### Window & File Operations

```vim
:vsp filename           # Open file in vertical split
:sp filename            # Open file in horizontal split
:e filename             # Edit file in current window
:tabnew filename        # Open file in new tab
<C-w>h                  # Move to left window
<C-w>j                  # Move to bottom window
<C-w>k                  # Move to top window
<C-w>l                  # Move to right window
<C-w>=                  # Equalize split sizes
<C-Alt-h>                 # Previous tab
<C-Alt-l>                 # Next tab
gt                      # Next tab
gT                      # Previous tab
```

### Folding

```vim
zc                      # Close fold
zo                      # Open fold
za                      # Toggle fold
zM                      # Close all folds
zR                      # Open all folds
zf{motion}              # Create fold (e.g., zfap for paragraph)
```

### Jump Between Blocks

```vim
%                       # Jump between matching (), {}, []
]]                      # Jump to next function/class
[[                      # Jump to previous function/class
[{                      # Jump to beginning of block
]}                      # Jump to end of block
```

### Documentation & Help

```vim
:h {command}            # Open help for command
:h :substitute          # Help for substitute command
:h motion.txt           # Help for motions
:h pattern              # Help for search patterns
K                       # Look up word under cursor (LSP hover)
<C-]>                   # Jump to tag/definition in help
<C-o>                   # Jump back
```

### Macros & Registers

```vim
qa                      # Record macro to register 'a'
q                       # Stop recording
@a                      # Execute macro 'a'
@@                      # Repeat last macro
100@a                   # Execute macro 'a' 100 times
"ayy                    # Yank line to register 'a'
"ap                     # Paste from register 'a'
```

### Visual Block Mode

```vim
<C-v>                   # Enter visual block mode
I                       # Insert at start of block
A                       # Append at end of block
c                       # Change block
r                       # Replace all characters in block
```

### Conform (Formatter)

|Command|Action|
|:---:|:---|
|`:ConformDisable`|Disable formatting (current buffer)|
|`:ConformDisable!`|Disable formatting (globally)|
|`:ConformEnable`|Re-enable formatting (current buffer)|
|`:ConformEnable!`|Re-enable formatting (globally)|

When opening MkDocs files, run `:ConformDisable` to turn off formatting for that buffer.