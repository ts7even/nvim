# Org-Mode Quick Reference for Neovim

This guide covers the essential org-mode features configured in your Neovim setup.

## Setup and File Structure

Your org files are located in `~/orgfiles/` with this structure:

```
~/orgfiles/
├── tasks.org           # Main tasks and TODOs
├── notes.org           # General notes and reference
├── meetings.org        # Meeting notes with templates
├── refile.org          # Quick captures for later organization
├── learn/              # Learning materials organized by topic
│   ├── python-async.org
│   ├── languages/
│   └── frameworks/
├── projects/           # Project-specific files
│   ├── project-alpha.org
│   └── poc-new-feature.org
├── templates/          # Template files
│   ├── meeting.org
│   ├── project.org
│   ├── learning.org
│   └── poc.org
└── attachments/        # File attachments
```

## Essential Keybinds

### Quick File Access
- `<leader>of` - Open orgfiles directory
- `<leader>ot` - Open tasks.org
- `<leader>on` - Open notes.org
- `<leader>ol` - Open learn directory
- `<leader>om` - Open meetings.org
- `<leader>or` - Open refile.org
- `<leader>op` - Open projects directory

### Create New Files (with Templates)
- `<leader>onp` - Create new project from template
- `<leader>onc` - Create new POC from template
- `<leader>onl` - Create new learning file from template

### Org-Mode Actions
- `<leader>oa` - Open agenda view
- `<leader>oc` - Quick capture menu

## Capture Templates

Press `<leader>oc` then choose:

- **`t`** - Task: Creates TODO with scheduled date in tasks.org
- **`n`** - Note: Creates timestamped note in notes.org  
- **`m`** - Meeting: Uses meeting template in meetings.org
- **`l`** - Learning: Uses learning template in learn/[topic].org
- **`p`** - Project Task: Creates project task in projects/[name].org
- **`r`** - Refile: Quick capture for later organization in refile.org

## Basic Org Syntax

### Headings
```org
* First Level Heading
** Second Level
*** Third Level
```

### TODO Items
```org
* TODO Important task
* NEXT Working on this
* WAITING For client response
* DONE Completed task
* CANCELLED Not doing this
```

### Timestamps
```org
* Meeting with client
  SCHEDULED: <2025-08-06 Tue 10:00>
  DEADLINE: <2025-08-10 Sat>
  
* Note taken [2025-08-06 Tue 14:30]
```

### Links
```org
[[https://example.com][Website Link]]
[[file:~/documents/report.pdf][Project Report]]
[[*Heading Name][Internal Link]]
```

## Essential Commands

### Navigation
- `Tab` - Fold/unfold current heading
- `S-Tab` - Cycle visibility of entire document
- `]]` - Next heading
- `[[` - Previous heading

### TODO Management
- `cit` - Change TODO state
- `<C-c><C-t>` - Cycle TODO state

### Timestamps
- `<C-c>.` - Insert active timestamp
- `<C-c>!` - Insert inactive timestamp

## Agenda Views

The agenda shows your scheduled items and deadlines across all org files.

### Agenda Navigation
- `j/k` - Move up/down
- `<CR>` - Jump to item
- `t` - Change TODO state
- `r` - Refresh
- `q` - Quit agenda

## Quick Workflow Examples

### Daily Task Management
1. `<leader>oa` - Check today's agenda
2. `<leader>oc` → `t` - Capture new tasks
3. Work on tasks, update states with `cit`
4. `<leader>or` - Process refile.org items

### Meeting Notes
1. `<leader>oc` → `m` - Create meeting note
2. Fill in template with agenda, attendees, notes
3. Create action items as TODO tasks

### Learning Documentation
1. `<leader>oc` → `l` - Create learning note
2. Enter topic like "python/async" for organized filing
3. Use template sections for concepts, code, practice

### Project Management
1. `<leader>onp` - Create project file from template
2. Break down into phases and tasks
3. Use `<leader>oc` → `p` for project-specific tasks

## Tips for Success

1. **Use capture frequently** - `<leader>oc` should become muscle memory
2. **Process refile.org daily** - Move items to proper files
3. **Check agenda each morning** - `<leader>oa` for daily planning
4. **Keep templates consistent** - Modify in `~/orgfiles/templates/`
5. **Organize learn folder** - Use subdirectories like `languages/`, `frameworks/`

## Template Customization

Your templates are in `~/orgfiles/templates/`. Modify them to fit your workflow:

- `meeting.org` - Meeting structure
- `project.org` - Project phases and planning
- `learning.org` - Learning documentation format
- `poc.org` - Proof of concept template

This covers the essential org-mode features you need for effective task and knowledge management!
