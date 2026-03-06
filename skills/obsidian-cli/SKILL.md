---
name: obsidian-cli
description: Interact with Obsidian vaults using the `obsidian` CLI to read, create, search, and manage notes, tasks, properties, and more. ALWAYS prefer CLI commands over Read/Edit/Write/Grep tools for vault operations — the CLI uses Obsidian's live index, saving significant context window tokens. Use when the user asks to interact with their Obsidian vault, manage notes, search vault content, query bases, create or edit notes, perform vault health checks, or develop and debug Obsidian plugins and themes.
---

# Obsidian CLI Reference

Use the `obsidian` CLI to interact with a running Obsidian instance. Requires **Obsidian 1.10+** to be open. Run `obsidian help` or `obsidian help <command>` for the latest parameter details.

---

## CLI-First Principles

The `obsidian` CLI talks directly to Obsidian's live index — it knows about links, tags, properties, and base views without scanning files. This makes it dramatically faster and lighter than using Read/Grep/Glob on vault files.

**Prefer CLI over Claude Code tools for vault operations:**

| Task | Use CLI | NOT this |
|------|---------|----------|
| Read note content | `obsidian read file="Note"` | `Read` tool on `.md` file |
| Create a note | `obsidian create name="Note" content="..." silent` | `Write` tool |
| Edit properties | `obsidian property:set name="status" value="done" file="Note"` | `Edit` tool on frontmatter |
| Search vault | `obsidian search query="keyword"` | `Grep` across vault files |
| List files | `obsidian files path="Folder/"` | `Glob` pattern matching |
| Query structured data | `obsidian base:query path="Views/Tasks.base"` | Reading `.base` + scanning all matching files |
| Vault health metrics | `obsidian unresolved total` / `orphans total` / `deadends total` | Manual link analysis with Grep |

### Minimal-Context Pattern

When you need to understand a note's content, gather metadata first before reading full content. This can save thousands of tokens:

```bash
# Step 1: Check structure (headings only — very small output)
obsidian outline file="Session-274"

# Step 2: Read properties (frontmatter only — no body content)
obsidian properties file="Session-274"

# Step 3: Only if needed, read the full note (or a specific section)
obsidian read file="Session-274"
```

For multi-file tasks (summarizing, auditing, comparing), use `outline` and `properties` across files first, then selectively `read` only the files that need deeper inspection. This avoids loading entire note bodies into the context window.

### CLI for Note Creation

When creating notes in a vault, use `obsidian create` + `property:set` + `append` instead of the `Write` tool. This ensures Obsidian's index updates immediately (no need to wait for file-watcher).

```bash
# Create with initial content
obsidian create name="My Note" path="Projects/" content="# My Note\n\nContent here." silent

# Set frontmatter properties
obsidian property:set name="tags" value="[\"project\",\"active\"]" file="My Note"
obsidian property:set name="status" value="draft" file="My Note"

# Append additional content
obsidian append file="My Note" content="\n## Section Two\nMore content."
```

---

## Syntax Reference

### Parameters and Flags

| Concept | Syntax | Example |
|---------|--------|---------|
| Parameter (key=value) | `name=value` | `file="My Note"` |
| Flag (boolean switch) | bare word | `silent`, `overwrite`, `total` |
| Multiline content | `\n` newline, `\t` tab | `content="Line 1\nLine 2"` |

Quote values containing spaces: `name="Weekly Review"`.

### File Targeting

Many commands accept `file` or `path`. If neither is given, the **active file** is used.

- `file=<name>` -- resolves like a wikilink (name only, no path or extension)
- `path=<path>` -- exact vault-relative path, e.g. `Projects/note.md`

### Vault Targeting

Commands target the most recently focused vault. Override with `vault=` as the **first** parameter:

```bash
obsidian vault="Work" search query="deadline"
```

### Global Modifiers

| Modifier | Effect |
|----------|--------|
| `--copy` | Copy command output to clipboard |
| `silent` | Prevent files from opening in the UI |
| `total` | On list commands, return only the count |

---

## File Operations

| Command | Purpose | Example |
|---------|---------|---------|
| `read` | Read file content | `obsidian read file="Meeting Notes"` |
| `create` | Create a new note | `obsidian create name="Sprint 42" content="# Sprint 42" silent` |
| `append` | Add content to end of file | `obsidian append file="Log" content="\n- Entry"` |
| `prepend` | Add content to start of file | `obsidian prepend file="Log" content="# Updated\n"` |
| `delete` | Delete a file | `obsidian delete file="Old Draft" trash` |
| `move` | Move file to another folder | `obsidian move file="Note" to="Archive/"` |
| `rename` | Rename a file | `obsidian rename file="Draft" name="Final"` |
| `open` | Open a file in the UI | `obsidian open file="Dashboard" newtab` |
| `file` | File info (size, dates, path) | `obsidian file file="README"` |
| `files` | List files in vault/folder | `obsidian files path="Projects/" ext=md` |
| `folder` | Create a folder | `obsidian folder path="Projects/2026-Q1"` |
| `folders` | List all folders | `obsidian folders` |

Key parameters for `create`: `name`, `content`, `path` (folder), `template`, `overwrite`, `silent`.

Key parameters for `files`: `path` (folder), `ext` (filter by extension), `sort` (name/modified/created), `total`.

---

## Search & Discovery

| Command | Purpose | Example |
|---------|---------|---------|
| `search` | Full-text search | `obsidian search query="machine learning" limit=10` |
| `search:context` | Search with surrounding context | `obsidian search:context query="TODO" lines=3` |
| `search:open` | Open search in Obsidian UI | `obsidian search:open query="refactor"` |
| `backlinks` | List notes linking to a file | `obsidian backlinks file="API Design"` |
| `links` | List outgoing links from a file | `obsidian links file="Index"` |
| `tag` | Info for a single tag | `obsidian tag name="project" verbose` |
| `tags` | List all tags in vault | `obsidian tags sort=count counts` |
| `aliases` | List all aliases | `obsidian aliases` |
| `outline` | Show heading structure | `obsidian outline file="Architecture"` |
| `wordcount` | Word/char count for a file | `obsidian wordcount file="Draft"` |
| `recents` | Recently opened files | `obsidian recents limit=5` |
| `random` | Open a random note | `obsidian random folder="Projects/"` |
| `random:read` | Read a random note | `obsidian random:read` |

Key parameters for `search`: `query`, `limit`, `path` (scope to folder), `ext`, `sort`.

---

## Vault Health

Find structural issues in your vault.

| Command | Purpose | Example |
|---------|---------|---------|
| `deadends` | Notes with no outgoing links | `obsidian deadends limit=20` |
| `orphans` | Notes with no incoming links | `obsidian orphans` |
| `unresolved` | Broken/unresolved wikilinks | `obsidian unresolved` |

---

## Daily Notes

| Command | Purpose | Example |
|---------|---------|---------|
| `daily` | Open today's daily note (create if needed) | `obsidian daily` |
| `daily:read` | Read today's daily note | `obsidian daily:read` |
| `daily:append` | Append to daily note | `obsidian daily:append content="- [ ] Review PRs"` |
| `daily:prepend` | Prepend to daily note | `obsidian daily:prepend content="## Morning\n"` |
| `daily:path` | Get path of daily note | `obsidian daily:path` |

Use `date=YYYY-MM-DD` to target a specific day: `obsidian daily:read date=2026-02-20`.

---

## Properties

Operate on YAML frontmatter properties.

| Command | Purpose | Example |
|---------|---------|---------|
| `properties` | List all properties on a file | `obsidian properties file="Project X"` |
| `property:read` | Read a single property | `obsidian property:read name="status" file="Project X"` |
| `property:set` | Set a property value | `obsidian property:set name="status" value="done" file="Project X"` |
| `property:remove` | Remove a property | `obsidian property:remove name="draft" file="Project X"` |

For list-type properties, `property:set` replaces the entire value. Use JSON for arrays: `value="[\"tag1\",\"tag2\"]"`.

---

## Tasks

Operates on `- [ ]` / `- [x]` checkbox items in note content (NOT frontmatter properties).

| Command | Purpose | Example |
|---------|---------|---------|
| `task` | Toggle/set task status | `obsidian task line=5 done file="Sprint"` |
| `tasks` | List/filter tasks | `obsidian tasks todo` |

Key parameters for `tasks`: `todo` (incomplete only), `done` (completed only), `file` (scope to note), `path` (scope to folder), `tag` (filter by tag), `limit`, `total`.

```bash
# List all incomplete tasks in a folder
obsidian tasks todo path="Projects/" limit=20

# Mark a specific task as done
obsidian task line=12 done file="Sprint 42"

# Count all tasks in daily note
obsidian tasks file="2026-02-23" total
```

---

## Bases

Interact with Obsidian Bases (database views). **Important:** Bases use `path=` not `file=`.

| Command | Purpose | Example |
|---------|---------|---------|
| `bases` | List all bases in vault | `obsidian bases` |
| `base:views` | List views in a base | `obsidian base:views path="Bases/Projects.base"` |
| `base:create` | Create a new base | `obsidian base:create path="Bases/Tasks.base"` |
| `base:query` | Query base data | `obsidian base:query path="Bases/Projects.base" format=md` |

Supported `format` values: `json`, `csv`, `tsv`, `md`, `paths`. Use `view=` to query a specific view.

---

## Bookmarks

| Command | Purpose | Example |
|---------|---------|---------|
| `bookmark` | Add/remove a bookmark | `obsidian bookmark file="Important Note"` |
| `bookmarks` | List all bookmarks | `obsidian bookmarks` |

---

## History & Versioning

Access Obsidian's built-in file recovery snapshots.

| Command | Purpose | Example |
|---------|---------|---------|
| `history` | Show version history summary | `obsidian history file="Config"` |
| `history:list` | List available snapshots | `obsidian history:list file="Config"` |
| `history:read` | Read a specific snapshot | `obsidian history:read file="Config" version=2` |
| `history:restore` | Restore a snapshot | `obsidian history:restore file="Config" version=2` |
| `history:open` | Open file recovery UI | `obsidian history:open file="Config"` |
| `diff` | Diff current vs. a snapshot | `obsidian diff file="Config" version=2` |

---

## Sync

Manage Obsidian Sync (requires active Sync subscription).

| Command | Purpose | Example |
|---------|---------|---------|
| `sync` | Trigger a sync | `obsidian sync` |
| `sync:status` | Check sync status | `obsidian sync:status` |
| `sync:history` | List sync history | `obsidian sync:history limit=10` |
| `sync:read` | Read a synced version | `obsidian sync:read file="Note" version=3` |
| `sync:restore` | Restore a synced version | `obsidian sync:restore file="Note" version=3` |
| `sync:deleted` | List remotely deleted files | `obsidian sync:deleted` |
| `sync:open` | Open sync history UI | `obsidian sync:open file="Note"` |

---

## Templates

| Command | Purpose | Example |
|---------|---------|---------|
| `templates` | List available templates | `obsidian templates` |
| `template:read` | Read a template's content | `obsidian template:read name="Meeting Notes"` |
| `template:insert` | Insert template into a file | `obsidian template:insert name="Meeting Notes" file="Today's Meeting"` |

---

## Plugins

| Command | Purpose | Example |
|---------|---------|---------|
| `plugins` | List installed plugins | `obsidian plugins` |
| `plugin` | Plugin info | `obsidian plugin id=dataview` |
| `plugin:enable` | Enable a plugin | `obsidian plugin:enable id=dataview` |
| `plugin:disable` | Disable a plugin | `obsidian plugin:disable id=dataview` |
| `plugin:install` | Install from community | `obsidian plugin:install id=obsidian-tasks` |
| `plugin:reload` | Reload a plugin (dev cycle) | `obsidian plugin:reload id=my-plugin` |
| `plugin:uninstall` | Uninstall a plugin | `obsidian plugin:uninstall id=old-plugin` |
| `plugins:enabled` | List enabled plugins only | `obsidian plugins:enabled filter=community` |
| `plugins:restrict` | Toggle restricted mode | `obsidian plugins:restrict on` |

---

## Themes & Snippets

| Command | Purpose | Example |
|---------|---------|---------|
| `theme` | Show active theme or theme info | `obsidian theme name="Minimal"` |
| `themes` | List installed themes | `obsidian themes` |
| `theme:install` | Install a theme | `obsidian theme:install name="Minimal"` |
| `theme:set` | Activate a theme | `obsidian theme:set name="Minimal"` |
| `theme:uninstall` | Remove a theme | `obsidian theme:uninstall name="Old Theme"` |
| `snippets` | List CSS snippets | `obsidian snippets` |
| `snippet:enable` | Enable a snippet | `obsidian snippet:enable name="custom-headers"` |
| `snippet:disable` | Disable a snippet | `obsidian snippet:disable name="custom-headers"` |
| `snippets:enabled` | List enabled snippets only | `obsidian snippets:enabled` |

---

## Tabs & Workspace

| Command | Purpose | Example |
|---------|---------|---------|
| `tabs` | List open tabs | `obsidian tabs` |
| `tab:open` | Open a file in a new tab | `obsidian tab:open file="Dashboard"` |
| `workspace` | Save/load workspace layouts | `obsidian workspace name="Research"` |

---

## Vault Management

| Command | Purpose | Example |
|---------|---------|---------|
| `vault` | Current vault info | `obsidian vault` |
| `vaults` | List all known vaults | `obsidian vaults` |
| `reload` | Reload the vault (re-index) | `obsidian reload` |
| `restart` | Restart Obsidian | `obsidian restart` |
| `version` | Show Obsidian version | `obsidian version` |

---

## Commands & Hotkeys

Execute any Obsidian command by ID.

| Command | Purpose | Example |
|---------|---------|---------|
| `command` | Execute a command | `obsidian command id="editor:toggle-bold"` |
| `commands` | List all commands | `obsidian commands query="toggle"` |
| `hotkey` | Get hotkey for a command | `obsidian hotkey id="editor:toggle-bold"` |
| `hotkeys` | List all hotkeys | `obsidian hotkeys` |

---

## Developer Tools

| Command | Purpose | Example |
|---------|---------|---------|
| `eval` | Run JS in app context | `obsidian eval code="app.vault.getFiles().length"` |
| `devtools` | Open DevTools | `obsidian devtools` |
| `dev:console` | Read console output | `obsidian dev:console level=error limit=20` |
| `dev:errors` | List uncaught errors | `obsidian dev:errors` |
| `dev:screenshot` | Capture screenshot | `obsidian dev:screenshot path=screenshot.png` |
| `dev:dom` | Inspect DOM elements | `obsidian dev:dom selector=".workspace-leaf" text` |
| `dev:css` | Read computed CSS | `obsidian dev:css selector=".workspace-leaf" prop=background-color` |
| `dev:mobile` | Toggle mobile emulation | `obsidian dev:mobile on` |
| `dev:cdp` | Chrome DevTools Protocol | `obsidian dev:cdp method="Runtime.evaluate" params='{"expression":"1+1"}'` |
| `dev:debug` | Attach/detach debugger | `obsidian dev:debug on` |

---

## Common Recipes

### Summarize multiple notes efficiently

```bash
# Get structure + properties for each note (minimal tokens)
for n in 270 271 272 273 274; do
  echo "=== Session-$n ==="
  obsidian properties file="Session-$n"
  obsidian outline file="Session-$n"
done
# Only read full content for notes that need deeper inspection
obsidian read file="Session-274"
```

### Query structured data from Bases

```bash
# Query a base view — returns structured data without reading individual files
obsidian base:query path="TaskNotes/Views/tasks-default.base" format=md

# List available bases and views
obsidian bases
obsidian base:views path="TaskNotes/Views/tasks-default.base"
```

### Find and fix broken links

```bash
# List all unresolved links
obsidian unresolved --copy
# Create a missing note
obsidian create name="Missing Page" content="# Missing Page\nTODO: fill in" silent
```

### Vault health check (5 CLI calls)

```bash
obsidian unresolved total    # Broken link count
obsidian orphans total       # Orphan note count
obsidian deadends total      # Dead-end note count
obsidian files total         # Total file count
obsidian tags sort=count     # Tag frequency
```

### Bulk update a property across files

```bash
# Find files with a specific tag
obsidian search query="tag:#v1" path="Projects/"
# Update property on each result
obsidian property:set name="version" value="2.0" file="Project A"
obsidian property:set name="version" value="2.0" file="Project B"
```

### Create a note from template and tag it

```bash
obsidian create name="2026-02-23 Standup" template="Standup" silent
obsidian property:set name="type" value="standup" file="2026-02-23 Standup"
obsidian property:set name="status" value="draft" file="2026-02-23 Standup"
```

### Plugin development cycle

```bash
obsidian plugin:reload id=my-plugin
obsidian dev:errors
obsidian dev:console level=error limit=10
obsidian dev:screenshot path=after-change.png
```

### Daily note quick capture

```bash
obsidian daily:append content="- [ ] Fix login bug #urgent"
obsidian daily:append content="\n> Idea: cache invalidation strategy for the API layer"
```
