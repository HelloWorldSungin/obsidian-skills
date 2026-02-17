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

#### `/task-create-subtask`

Create sub-tasks with automatic ID generation and parent linking.

**Single sub-task:**
```bash
/task-create-subtask \
  parent=TASK-007 \
  title="Create OHLCV monitor" \
  description="Monitor data freshness" \
  work-type="deployment"
```

**Multiple sub-tasks:**
```bash
/task-create-subtask \
  parent=TASK-007 \
  titles="Subtask 1, Subtask 2, Subtask 3" \
  descriptions="Desc 1, Desc 2, Desc 3"
```

**Features:**
- Auto-generates next sub-task ID (TASK-007.1, TASK-007.2...)
- Links child to parent in `related` field
- Updates parent's `related` field
- Returns file paths of created tasks

#### `/task-link`

Link existing tasks without creating new ones.

**Usage:**
```bash
/task-link \
  task=TASK-001 \
  related=["TASK-002", "TASK-003"] \
  blockedBy=["TASK-004"]
```

**Parameters:**
- `task` (required): Task ID to update
- `related`: List of related task IDs
- `blockedBy`: List of blocking dependencies
- `projects`: List of project note links

### Session Commands

#### `/session-create`

Create a new build journal session with task integration.

**Parameters:**
- `number` (required): Session number
- `date`: Session date (default: today)
- `prompt-tasks`: Whether to prompt for related tasks (default: yes)
- `epic`: Link session to an epic/parent task (optional)

**Examples:**
```bash
/session-create number=227
/session-create number=227 epic=TASK-007
```

**With epic parameter:**
When you specify an epic, the command will:
1. Create `Build-Journal/Session-227.md`
2. Check epic for pending sub-tasks
3. Prompt: "This epic has 3 pending sub-tasks. Link to session?"
4. If yes, populate `related-tasks` with sub-task IDs

**Without epic parameter:**
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
| `task-id` | text | Unique identifier | TASK-001, EPIC-001, etc. |
| `status` | text | Current status | backlog, todo, in-progress, blocked, review, done |
| `priority` | text | Importance | critical, high, medium, low |
| `project` | text | Project | trading-signal-ai, tinyclaw, ark-trade, ark-line, infrastructure |
| `work-type` | text | Work category | epic, story, research, model-training, deployment, infrastructure, documentation |
| `component` | text | Infra component | ct100, ct110, ct120, ct200, none |
| `urgency` | text | Time sensitivity | blocking, high, normal, low |
| `due` | date | Deadline | YYYY-MM-DD |
| `scheduled` | date | Planned work date | YYYY-MM-DD |
| `session` | text | Related session | Session number (e.g., "227") |
| `related` | list | Related task IDs | ["TASK-001", "TASK-002"] |
| `blockedBy` | list | Blocking dependencies | ["TASK-001"] |
| `projects` | list | Project note links | ["[[Epic-001]]"] |
| `epic` | text | Parent epic ID | EPIC-001 |
| `created` | date | Creation date | YYYY-MM-DD |

## Task Relationships & Sub-Tasks

TaskNotes doesn't have native parent-child hierarchy, but supports relationships through multiple approaches:

### 1. Related Field (Recommended for Sub-Tasks)

Link parent and child tasks using the `related` field:

**Parent Task:**
```yaml
---
task-id: "TASK-007"
title: "Monitor Dashboard Transformation"
related: ["TASK-007.1", "TASK-007.2", "TASK-007.3"]
---

## Sub-Tasks
- [[TASK-007.1]] Remove JT Indicator Signal Monitoring
- [[TASK-007.2]] Create OHLCV Service Health Monitor  
- [[TASK-007.3]] Create Futures Data Monitor
```

**Child Task:**
```yaml
---
task-id: "TASK-007.1"
title: "Remove JT Indicator Signal Monitoring"
related: ["TASK-007"]
---

## Parent Task
Part of: [[TASK-007]]
```

**Naming Convention:**
- Parent: `TASK-007` or `EPIC-001`
- Children: `TASK-007.1`, `TASK-007.2`, `TASK-007.3`

### 2. BlockedBy Dependencies

Use TaskNotes' native `blockedBy` field for sequential dependencies:

```yaml
---
task-id: "TASK-008.2"
title: "Implement Engine Selection Logic"
blockedBy: ["TASK-008.1"]  # Must complete 008.1 first
---
```

### 3. Epic/Story Hierarchy

For large features broken into deliverables:

**Epic:**
```yaml
---
task-id: "EPIC-001"
title: "Dashboard Redesign"
work-type: "epic"
related: ["STORY-001", "STORY-002", "STORY-003"]
---
```

**Story:**
```yaml
---
task-id: "STORY-001"
title: "Add real-time P&L chart"
work-type: "story"
epic: "EPIC-001"
related: ["EPIC-001"]
---
```

### 4. Project-Based Grouping

Link tasks to project notes for grouping:

```yaml
---
title: "Create OHLCV Monitor"
projects: ["[[Monitor-Dashboard-Redesign]]"]
---
```

### 5. Follow-up Chain

Track post-completion follow-ups:

```yaml
---
task-id: "TASK-101"
title: "Monitor V2 model performance (1 week)"
related: ["TASK-100"]
scheduled: "2026-03-01"
---
```

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
