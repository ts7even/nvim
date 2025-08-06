# Org-Mode Guide for Neovim

<!--toc:start-->

- [Org-Mode Guide for Neovim](#org-mode-guide-for-neovim)
  - [Introduction](#introduction)
  - [Setup and Configuration](#setup-and-configuration)
  - [File Structure](#file-structure)
  - [Basic Concepts](#basic-concepts)
  - [Getting Started](#getting-started)
  - [Headings and Structure](#headings-and-structure)
  - [TODO Management](#todo-management)
  - [Timestamps and Scheduling](#timestamps-and-scheduling)
  - [Capture Templates](#capture-templates)
  - [Agenda Views](#agenda-views)
  - [Links](#links)
  - [Tables](#tables)
  - [Tags and Properties](#tags-and-properties)
  - [Export](#export)
  - [Time Tracking (Clocking)](#time-tracking-clocking)
  - [Advanced Features](#advanced-features)
  - [Workflow Examples](#workflow-examples)
  - [Tips and Best Practices](#tips-and-best-practices)

<!--toc:end-->

## Introduction

Org-mode is a powerful document editing, formatting, and organizing mode for plain text files.
Originally from Emacs, this Neovim implementation brings most of org-mode's functionality to your
favorite editor.

## Setup and Configuration

Based on your configuration, here's what you have set up:

```lua
{
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        require('orgmode').setup({
            org_agenda_files = '~/orgfiles/**/*',
            org_default_notes_file = '~/orgfiles/refile.org',
            
            org_capture_templates = {
                t = {
                    description = 'Task',
                    template = '* TODO %?\n  %u',
                    target = '~/orgfiles/tasks.org'
                },
                n = {
                    description = 'Note',
                    template = '* %?\n  %u',
                    target = '~/orgfiles/notes.org'
                },
            },
            
            org_agenda_start_on_weekday = 1, -- Monday
            org_deadline_warning_days = 14,
            org_todo_keywords = { 'TODO', 'WAITING', '|', 'DONE', 'CANCELLED' },
            org_priority_highest = 'A',
            org_priority_default = 'B',
            org_priority_lowest = 'C',
        })
        
        vim.keymap.set('n', '<leader>oa', '<cmd>lua require("orgmode").action("agenda.prompt")<CR>', { desc = 'Org Agenda' })
        vim.keymap.set('n', '<leader>oc', '<cmd>lua require("orgmode").action("capture.prompt")<CR>', { desc = 'Org Capture' })
    end,
},
```

## File Structure

Create your org files directory:

```bash
mkdir -p ~/orgfiles
```

Recommended file structure:

```
~/orgfiles/
├── tasks.org       # Main task file
├── notes.org       # General notes
├── refile.org      # Temporary capture location
├── projects/       # Project-specific org files
├── archive/        # Archived items
└── agenda/         # Agenda-specific files
```

## Basic Concepts

### Outlines

Org files are structured as outlines using headings:

```org
* Top Level Heading
** Second Level
*** Third Level
**** Fourth Level
```

### TODO Items

Tasks are marked with TODO keywords:

```org
* TODO Complete project proposal
* WAITING Feedback from client
* DONE Meeting with team
* CANCELLED Old project idea
```

### Timestamps

Various timestamp formats:

```org
* Meeting with client
  SCHEDULED: <2025-08-05 Mon 10:00>
  DEADLINE: <2025-08-05 Mon 12:00>
  
* Project started [2025-08-01 Thu]
  - Note taken on [2025-08-01 Thu 14:30]
```

## Getting Started

1. **Create your first org file:**

   ```bash
   nvim ~/orgfiles/tasks.org
   ```

1. **Start with a simple structure:**

   ```org
   #+TITLE: My Tasks
   #+AUTHOR: Your Name

   * TODO Learn org-mode basics
   * TODO Set up my workflow
   ** TODO Create capture templates
   ** TODO Configure agenda
   * DONE Install org-mode plugin
   ```

1. **Use the custom keybinds:**

   - `<leader>oa` - Open agenda
   - `<leader>oc` - Quick capture

## Headings and Structure

### Creating Headings

- Type `*` followed by space for a first-level heading
- Use `**`, `***`, etc. for deeper levels
- Press `<CR>` to create a new heading at the same level
- Use `M-<CR>` (Alt+Enter) to insert a heading at the same level

### Navigation

- `Tab` - Cycle visibility (fold/unfold current heading)
- `S-Tab` - Global visibility cycling
- `]]` - Next heading
- `[[` - Previous heading
- `gj` - Next heading at same level
- `gk` - Previous heading at same level

### Restructuring

- `M-h` - Promote heading (decrease level)
- `M-l` - Demote heading (increase level)
- `M-k` - Move subtree up
- `M-j` - Move subtree down

## TODO Management

### TODO Keywords

Your configuration uses: `TODO`, `WAITING`, `|`, `DONE`, `CANCELLED`

The `|` separates active states from inactive states.

### Changing TODO States

- `cit` - Change TODO state
- `<leader>ot` - TODO state forward
- `<leader>oT` - TODO state backward

### Priority Levels

Add priorities to tasks:

```org
* TODO [#A] High priority task
* TODO [#B] Normal priority task  
* TODO [#C] Low priority task
```

### Example TODO Structure

```org
* Projects
** TODO [#A] Website Redesign
   DEADLINE: <2025-08-15 Fri>
*** TODO Create wireframes
*** WAITING Client feedback on mockups
*** TODO Implement responsive design
** DONE [#B] Database Migration
   CLOSED: [2025-08-01 Thu 16:30]
```

## Timestamps and Scheduling

### Types of Timestamps

1. **Plain timestamp:** `[2025-08-05 Mon]`
1. **Active timestamp:** `<2025-08-05 Mon>`
1. **Scheduled:** `SCHEDULED: <2025-08-05 Mon>`
1. **Deadline:** `DEADLINE: <2025-08-05 Mon>`

### Adding Timestamps

- `<leader>oid` - Insert deadline
- `<leader>ois` - Insert scheduled
- `<leader>oit` - Insert active timestamp
- `<leader>oiT` - Insert inactive timestamp

### Time Ranges

```org
* Meeting
  <2025-08-05 Mon 10:00-11:30>
  
* Conference
  <2025-08-10 Sat>--<2025-08-12 Mon>
```

## Capture Templates

Your configuration includes two capture templates:

### Task Template (`t`)

Creates: `* TODO %?\n  %u`

- `%?` - Cursor position after capture
- `%u` - Inactive timestamp

### Note Template (`n`)

Creates: `* %?\n  %u`

### Using Capture

1. Press `<leader>oc`
1. Select template (`t` for task, `n` for note)
1. Enter your content
1. Save with `:w` or finish capture

### Example Capture Workflow

```org
# After using task capture template:
* TODO Review quarterly reports
  [2025-08-05 Mon 14:30]
  
# After using note capture template:
* Meeting insights from client call
  [2025-08-05 Mon 15:45]
  - Client wants to add new feature
  - Budget increase approved
  - Timeline moved to September
```

## Agenda Views

### Opening Agenda

- `<leader>oa` - Open agenda prompt
- Choose from different view types

### Agenda Types

1. **Daily/Weekly agenda** - Shows scheduled items and deadlines
1. **TODO list** - All TODO items
1. **Tags match** - Items matching specific tags
1. **Search** - Text search across org files

### Navigation in Agenda

- `j/k` - Move up/down
- `<CR>` - Go to item
- `q` - Quit agenda
- `r` - Refresh agenda

## Links

### Creating Links

- `<leader>oil` - Insert link
- `<leader>ols` - Store link (for later insertion)

### Link Types

```org
# Web links
[[https://example.com][Example Website]]

# File links
[[file:~/documents/report.pdf][Project Report]]

# Internal links
[[*Heading Name][Link to heading]]

# Email links
[[mailto:user@example.com][Email John]]
```

### Following Links

- `gx` - Open link under cursor

## Tables

### Creating Tables

```org
| Name    | Age | City     |
|---------+-----+----------|
| Alice   |  30 | New York |
| Bob     |  25 | London   |
| Charlie |  35 | Tokyo    |
```

### Table Operations

- `<leader>oic` - Insert column
- `<leader>oir` - Insert row
- `<leader>oih` - Insert row above
- `M-h/M-l` - Move column left/right
- `M-k/M-j` - Move row up/down
- `Tab` - Move to next field
- `S-Tab` - Move to previous field

### Table Formulas

```org
| Item  | Quantity | Price | Total |
|-------+----------+-------+-------|
| Apples|        5 |  1.20 |  6.00 |
| Bananas|       3 |  0.80 |  2.40 |
|-------+----------+-------+-------|
| Total |          |       |  8.40 |
#+TBLFM: $4=$2*$3::@>$4=vsum(@2..@-1)
```

## Tags and Properties

### Adding Tags

```org
* TODO Meeting with client    :work:urgent:
* Personal project           :personal:hobby:
* Research task              :research:reading:
```

### Tag Inheritance

```org
* Work Projects              :work:
** TODO Client presentation  :urgent:    # inherits :work:
** DONE Database setup       :backend:   # inherits :work:
```

### Properties

```org
* Project Alpha
  :PROPERTIES:
  :BUDGET:   $50000
  :CONTACT:  john@example.com
  :DEADLINE: 2025-12-31
  :END:
```

## Export

### Export Commands

- `<leader>oee` - Export menu
- `<leader>oep` - Export to PDF
- `<leader>oeh` - Export to HTML

### Export Settings

Add to the top of your org file:

```org
#+TITLE: Document Title
#+AUTHOR: Your Name
#+DATE: 2025-08-05
#+OPTIONS: toc:2 num:t
#+LATEX_CLASS: article
```

## Time Tracking (Clocking)

### Clock Commands

- `<leader>oxi` - Clock in
- `<leader>oxo` - Clock out
- `<leader>oxr` - Clock report
- `<leader>oxj` - Clock goto

### Example with Clocking

```org
* TODO Write documentation
  :LOGBOOK:
  CLOCK: [2025-08-05 Mon 09:00]--[2025-08-05 Mon 11:30] =>  2:30
  CLOCK: [2025-08-05 Mon 14:00]--[2025-08-05 Mon 16:00] =>  2:00
  :END:
  Total time: 4:30
```

## Advanced Features

### Archive

- `<leader>oA` - Archive subtree
- `<leader>o$` - Archive sibling

### Refile

- `<leader>ocr` - Refile current heading

### Custom TODO Sequences

```org
#+TODO: TODO NEXT | DONE
#+TODO: REPORT BUG KNOWNCAUSE | FIXED
#+TODO: | CANCELLED
```

### Effort Estimation

```org
* TODO Complex project
  :PROPERTIES:
  :EFFORT:   8:00
  :END:
```

## Workflow Examples

### Daily Planning Workflow

1. **Morning Planning:**

   ```org
   * Daily Plan [2025-08-05 Mon]
   ** TODO Review emails               :@office:
   ** TODO Team standup at 10:00       :@office:meeting:
   ** TODO Work on project Alpha       :@office:coding:
   ** TODO Call with client            :@phone:
   ** TODO Grocery shopping            :@errands:
   ```

1. **Use agenda to see the day:**

   - `<leader>oa` → Daily agenda

1. **Clock time on tasks:**

   - `<leader>oxi` when starting
   - `<leader>oxo` when finishing

### Project Management Workflow

```org
* Project: Website Redesign          :project:web:
** TODO [#A] Project Planning Phase
   DEADLINE: <2025-08-10 Sun>
*** TODO Define requirements        :planning:
*** TODO Create wireframes          :design:
*** WAITING Client approval on mockups :waiting:client:
** TODO [#B] Development Phase
   SCHEDULED: <2025-08-15 Fri>
*** TODO Set up development environment :setup:
*** TODO Implement responsive design    :coding:frontend:
*** TODO Backend API integration        :coding:backend:
** TODO [#C] Testing Phase
*** TODO User acceptance testing    :testing:
*** TODO Performance optimization   :testing:optimization:
```

### Meeting Notes Workflow

```org
* Meeting: Weekly Team Sync
  [2025-08-05 Mon 10:00-11:00]
  
** Attendees
   - Alice (PM)
   - Bob (Developer)
   - Charlie (Designer)
   
** Agenda
*** Sprint review
*** Next sprint planning
*** Blockers discussion

** Action Items
*** TODO [#A] Bob: Fix login bug
    DEADLINE: <2025-08-07 Wed>
*** TODO [#B] Charlie: Update design mockups
    DEADLINE: <2025-08-09 Fri>
*** TODO [#C] Alice: Schedule client demo
    SCHEDULED: <2025-08-08 Thu>

** Notes
   - Sprint went well, completed 8/10 stories
   - Client feedback was positive
   - Need to address performance issues
```

## Tips and Best Practices

### File Organization

1. **Keep files focused:**

   - `tasks.org` - Active tasks and projects
   - `notes.org` - Reference material and meeting notes
   - `someday.org` - Future ideas and projects

1. **Use consistent tagging:**

   ```org
   :work:personal:urgent:waiting:project:meeting:
   ```

1. **Regular reviews:**

   - Weekly: Review all TODO items
   - Monthly: Archive completed projects
   - Quarterly: Clean up tags and restructure

### Capture Best Practices

1. **Quick capture everything:**

   - Use `<leader>oc` frequently
   - Process captures daily

1. **Template examples:**

   ```org
   # Meeting template
   * Meeting: %? 
     [%u]
     ** Attendees
     ** Agenda
     ** Action Items
     ** Notes

   # Project template
   * PROJECT %?
     DEADLINE: %t
     ** Objectives
     ** Tasks
     ** Resources
     ** Timeline
   ```

### Agenda Workflow

1. **Daily routine:**

   - Morning: Check agenda (`<leader>oa`)
   - Throughout day: Update TODO states
   - Evening: Plan next day

1. **Weekly routine:**

   - Review all TODO items
   - Reschedule overdue items
   - Archive completed projects

### Keyboard Shortcuts Summary

| Action | Keybind | Description | |--------|---------|-------------| | Agenda | `<leader>oa` | Open
agenda | | Capture | `<leader>oc` | Quick capture | | TODO cycle | `cit` | Change TODO state | |
Fold/unfold | `Tab` | Toggle visibility | | Next heading | `]]` | Navigate to next heading | |
Insert link | `<leader>oil` | Create link | | Clock in | `<leader>oxi` | Start time tracking | |
Archive | `<leader>oA` | Archive subtree |

### Common Patterns

1. **Project tracking:**

   ```org
   * PROJECT Website Redesign [0/3]
   ** TODO [#A] Planning [0/2]
   *** TODO Requirements gathering
   *** TODO Stakeholder interviews
   ** TODO [#B] Design [0/3]
   *** TODO Wireframes
   *** TODO Mockups
   *** TODO Prototypes
   ** TODO [#C] Development [0/4]
   *** TODO Frontend
   *** TODO Backend
   *** TODO Testing
   *** TODO Deployment
   ```

1. **Weekly planning:**

   ```org
   * Week of [2025-08-05 Mon]
   ** Monday
   *** TODO Team meeting 10:00
   *** TODO Code review
   ** Tuesday
   *** TODO Client call 14:00
   *** TODO Deploy to staging
   ** Wednesday
   *** TODO Documentation
   ** Thursday
   *** TODO Testing
   ** Friday
   *** TODO Sprint retrospective
   ```

### Integration with Other Tools

1. **Git integration:**

   ```org
   * TODO Fix bug #123
     [[https://github.com/user/repo/issues/123][GitHub Issue]]
   ```

1. **Calendar sync:**

   - Export agenda to ICS format
   - Import into Google Calendar or similar

1. **Email integration:**

   ```org
   * TODO Follow up with client
     [[mailto:client@example.com][Email Client]]
   ```

This guide should get you started with org-mode in Neovim. Start simple with basic TODO items and
gradually incorporate more advanced features as you become comfortable with the workflow.
