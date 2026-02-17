---
name: obsidian-project-management
description: Task and project management for ArkNode-AI using TaskNotes plugin. Create, manage, and track tasks with session integration. Supports task creation from CLI, session auto-prompting, and TODOS.md migration.
---

# Obsidian Project Management

Task and project management system for ArkNode-AI vault using the TaskNotes Obsidian plugin.

## Overview

This skill provides command-line tools to manage tasks using TaskNotes' "one note per task" principle. Tasks are stored as Markdown files in `TaskNotes/Tasks/` with structured YAML frontmatter.

**Vault Location:** `/Users/sunginkim/Documents/Obsidian Vault/`

## Prerequisites

- Obsidian 1.10.1+ with TaskNotes plugin installed
- Bases core plugin enabled in Obsidian
- TaskNotes configured with custom fields (see Configuration)

## Quick Start

```bash
# Create a new task
/task-create title="Implement feature X" project="trading-signal-ai" priority="high"

# List all tasks
/task-list

# List tasks by status
/task-list status=in-progress

# List tasks by project
/task-list project="tinyclaw"

# Create session with task prompts
/session-create number=227

# Migrate existing TODOS.md
/tasks-migrate
```

## Commands

### Task Commands

#### `/task-create`

Create a new task in TaskNotes/Tasks/.

**Parameters:**
- `title` (required): Task title
- `project`: Project name (trading-signal-ai, tinyclaw, ark-trade, ark-line, infrastructure)
- `work-type`: Type of work (research, model-training, deployment, infrastructure, documentation)
- `component`: Infrastructure component (ct100, ct110, ct120, ct200, none)
- `priority`: Task priority (critical, high, medium, low)
- `urgency`: Urgency level (blocking, high, normal, low)
- `due`: Due date (YYYY-MM-DD)
- `scheduled`: Scheduled date (YYYY-MM-DD)
- `session`: Related session ID (e.g., "226")
- `description`: Task description

**Example:**
```bash
/task-create \
  title="Implement fixed exit strategy" \
  project="trading-signal-ai" \
  work-type="model-training" \
  component="ct100" \
  priority="high" \
  description="Add fixed 5-bar exit to position manager"
```

#### `/task-list`

List tasks with optional filtering.

**Parameters:**
- `status`: Filter by status (backlog, todo, in-progress, blocked, review, done)
- `project`: Filter by project
- `component`: Filter by component
- `priority`: Filter by priority
- `limit`: Maximum number of tasks to show (default: 50)

**Examples:**
```bash
/task-list                           # All tasks
/task-list status=in-progress        # Only in-progress tasks
/task-list project="tinyclaw"        # All TinyClaw tasks
/task-list component="ct100"         # All CT100 tasks
/task-list priority=high             # All high priority tasks
```

#### `/task-update`

Update task properties.

**Parameters:**
- `id` (required): Task ID (e.g., "TASK-001")
- `field` (required): Property to update
- `value` (required): New value

**Example:**
```bash
/task-update id=TASK-001 field=status value="in-progress"
/task-update id=TASK-001 field=session value="227"
```

#### `/task-archive`

Manually archive a completed task to TaskNotes/Archive/.

**Parameters:**
- `id` (required): Task ID to archive

**Example:**
```bash
/task-archive id=TASK-001
```

**Note:** TaskNotes can also auto-archive completed tasks based on plugin settings.

### Session Commands

#### `/session-create`

Create a new build journal session with task integration.

**Parameters:**
- `number` (required): Session number
- `date`: Session date (default: today)
- `prompt-tasks`: Whether to prompt for related tasks (default: yes)

**Example:**
```bash
/session-create number=227
```

This command will:
1. Create `Build-Journal/Session-227.md`
2. Prompt: "Create related tasks for this session? (y/n)"
3. If yes, enter interactive task creation mode
4. Auto-populate `related-tasks` array in session frontmatter

#### `/session-tasks`

View or manage tasks linked to a session.

**Parameters:**
- `session` (required): Session number or ID
- `action`: Action to perform (view, add, list)

**Examples:**
```bash
/session-tasks session=227              # View tasks for session 227
/session-tasks session=227 action=add   # Add tasks to session
```

### Migration Commands

#### `/tasks-migrate`

Migrate existing TODOS.md to TaskNotes format.

**Parameters:**
- `source`: Path to TODOS.md (default: Trading-Signal-AI/TODOS.md)
- `dry-run`: Preview migration without creating files

**Example:**
```bash
/tasks-migrate                           # Migrate default TODOS.md
/tasks-migrate dry-run                   # Preview only
/tasks-migrate source="Other/TODO.md"    # Migrate custom file
```

### View Commands

#### `/tasks-kanban`

Open Kanban view in Obsidian (requires Obsidian running).

**Example:**
```bash
/tasks-kanban
```

#### `/tasks-today`

Show tasks scheduled for today.

**Example:**
```bash
/tasks-today
```

## Task Properties

Tasks support the following custom properties:

| Property | Type | Description | Values |
|----------|------|-------------|--------|
| `task-id` | text | Unique identifier | TASK-001, TASK-002, etc. |
| `status` | text | Current status | backlog, todo, in-progress, blocked, review, done |
| `priority` | text | Importance | critical, high, medium, low |
| `project` | text | Project | trading-signal-ai, tinyclaw, ark-trade, ark-line, infrastructure |
| `work-type` | text | Work category | research, model-training, deployment, infrastructure, documentation |
| `component` | text | Infra component | ct100, ct110, ct120, ct200, none |
| `urgency` | text | Time sensitivity | blocking, high, normal, low |
| `due` | date | Deadline | YYYY-MM-DD |
| `scheduled` | date | Planned date | YYYY-MM-DD |
| `session` | text | Related session | Session number (e.g., "227") |
| `related` | list | Related tasks | ["TASK-001", "TASK-002"] |
| `created` | date | Creation date | YYYY-MM-DD |

## Task ID System

Tasks use sequential IDs starting at TASK-001:
- Counter stored in `TaskNotes/meta/task-counter`
- Format: `TASK-NNN-description.md`
- Auto-incremented on each task creation

## Session Integration Workflow

1. Create session: `/session-create number=227`
2. Get prompted: "Create related tasks for this session?"
3. If yes, create tasks interactively:
   - Enter task title
   - Select project, work-type, component
   - Set priority
   - Repeat until done
4. Tasks automatically linked via `session` field
5. Session updated with `related-tasks` array

## File Structure

```
Vault/
├── TaskNotes/
│   ├── Tasks/
│   │   ├── TASK-001-quanllm-research.md
│   │   ├── TASK-002-migrate-notes.md
│   │   └── ...
│   ├── Archive/
│   │   └── (completed tasks auto-moved here)
│   ├── Views/
│   │   ├── All-Tasks.base
│   │   ├── Kanban-Status.base
│   │   ├── By-Project.base
│   │   └── This-Week.base
│   └── meta/
│       └── task-counter
├── Build-Journal/
│   ├── Session-227.md
│   └── ...
└── ...
```

## Configuration

### TaskNotes Plugin Settings

Configure these in Obsidian Settings → TaskNotes:

**General:**
- Task folder: `TaskNotes/Tasks`
- Archive folder: `TaskNotes/Archive`
- Enable auto-archive: Yes
- Property-based task detection: Yes

**Task Properties (Custom Fields):**
Add these custom properties:
- `task-id` (text)
- `project` (text)
- `work-type` (text)
- `component` (text)
- `urgency` (text)

**Status Values:**
Configure status field with these values:
- backlog
- todo
- in-progress
- blocked
- review
- done

## Troubleshooting

### Task not appearing in views
- Ensure Bases plugin is enabled
- Check that task file has `tags: [task]` in frontmatter
- Verify TaskNotes plugin settings

### Counter out of sync
- Check `TaskNotes/meta/task-counter` file
- Manually set to correct next number if needed

### Session tasks not linking
- Verify task `session` field matches session number
- Check session `related-tasks` array format

## Integration with Build Journal

Tasks integrate with the existing Build Journal system:
- Each session can have related tasks
- Tasks track which session they were created in
- Build journal references task IDs for traceability
- Session template includes task prompt section

## Tips

1. **Use consistent project names** - Always use kebab-case (e.g., `trading-signal-ai`)
2. **Set due dates for urgent items** - Use the `due` field for deadline tracking
3. **Link related tasks** - Use the `related` field to connect dependent tasks
4. **Archive regularly** - Completed tasks auto-archive, keeping views clean
5. **Use Kanban view** - Visual workflow tracking via TaskNotes Kanban view

## Examples

### Creating a research task
```bash
/task-create \
  title="Research adaptive threshold methods" \
  project="trading-signal-ai" \
  work-type="research" \
  priority="high" \
  due="2026-02-20"
```

### Creating an infrastructure task
```bash
/task-create \
  title="Configure CT110 GPU drivers" \
  project="infrastructure" \
  work-type="infrastructure" \
  component="ct110" \
  priority="critical" \
  urgency="blocking"
```

### Migrating TODOs
```bash
# First preview
/tasks-migrate dry-run

# Then actually migrate
/tasks-migrate
```
