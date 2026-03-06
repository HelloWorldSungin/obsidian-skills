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
| List files | `obsidian files folder="Folder/"` | `Glob` pattern matching |
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
obsidian create name="My Note" path="Projects/" content="# My Note\n\nContent here."

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
| `create` | Create a new note | `obsidian create name="Sprint 42" content="# Sprint 42"` |
| `append` | Add content to end of file | `obsidian append file="Log" content="\n- Entry"` |
| `prepend` | Add content to start of file | `obsidian prepend file="Log" content="# Updated\n"` |
| `delete` | Delete a file (trash by default) | `obsidian delete file="Old Draft"` |
| `move` | Move file to another folder | `obsidian move file="Note" to="Archive/"` |
| `rename` | Rename a file | `obsidian rename file="Draft" name="Final"` |
| `open` | Open a file in the UI | `obsidian open file="Dashboard" newtab` |
| `file` | File info (size, dates, path) | `obsidian file file="README"` |
| `files` | List files in vault/folder | `obsidian files folder="Projects/" ext=md` |
| `folder` | Folder info (files, size) | `obsidian folder path="Projects/" info=files` |
| `folders` | List all folders | `obsidian folders folder="Projects/" total` |

Key parameters for `create`: `name`, `content`, `path` (folder), `template`, `overwrite`, `open`, `newtab`.

Key parameters for `files`: `folder` (filter by folder), `ext` (filter by extension), `total`.

Key parameters for `delete`: `permanent` (skip trash, delete permanently — default moves to trash).

The `append` and `prepend` commands accept an `inline` flag to add content without a newline separator.

---

## Search & Discovery

| Command | Purpose | Example |
|---------|---------|---------|
| `search` | Full-text search | `obsidian search query="machine learning" limit=10` |
| `search:context` | Search with matching line context | `obsidian search:context query="TODO" limit=10` |
| `search:open` | Open search in Obsidian UI | `obsidian search:open query="refactor"` |
| `backlinks` | List notes linking to a file | `obsidian backlinks file="API Design" counts` |
| `links` | List outgoing links from a file | `obsidian links file="Index" total` |
| `tag` | Info for a single tag | `obsidian tag name="project" verbose` |
| `tags` | List all tags in vault | `obsidian tags sort=count counts` |
| `aliases` | List all aliases | `obsidian aliases verbose` |
| `outline` | Show heading structure | `obsidian outline file="Architecture" format=json` |
| `wordcount` | Word/char count for a file | `obsidian wordcount file="Draft" words` |
| `recents` | Recently opened files | `obsidian recents total` |
| `random` | Open a random note | `obsidian random folder="Projects/"` |
| `random:read` | Read a random note | `obsidian random:read folder="Projects/"` |

Key parameters for `search`: `query`, `limit`, `path` (scope to folder), `case` (case sensitive), `format=text|json`.

Key parameters for `backlinks`: `counts` (include link counts), `total`, `format=json|tsv|csv`.

Key parameters for `outline`: `format=tree|md|json` (default: tree), `total` (heading count only).

Key parameters for `tags`: `file` or `path` (scope to note/folder), `counts`, `sort=count`, `format=json|tsv|csv`, `active` (active file only).

Key parameters for `aliases`: `file` (scope to note), `total`, `verbose` (include file paths), `active`.

Key parameters for `wordcount`: `words` (word count only), `characters` (char count only).

---

## Vault Health

Find structural issues in your vault.

| Command | Purpose | Example |
|---------|---------|---------|
| `deadends` | Notes with no outgoing links | `obsidian deadends total` |
| `orphans` | Notes with no incoming links | `obsidian orphans total` |
| `unresolved` | Broken/unresolved wikilinks | `obsidian unresolved verbose` |

Key parameters for `deadends`/`orphans`: `total`, `all` (include non-markdown files).

Key parameters for `unresolved`: `total`, `counts` (include link counts), `verbose` (include source files), `format=json|tsv|csv`.

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

Daily commands accept `paneType=tab|split|window` to control where the note opens. `daily:append` and `daily:prepend` accept `inline` (no newline) and `open` flags.

---

## Properties

Operate on YAML frontmatter properties.

| Command | Purpose | Example |
|---------|---------|---------|
| `properties` | List properties (file or vault-wide) | `obsidian properties file="Project X"` |
| `property:read` | Read a single property | `obsidian property:read name="status" file="Project X"` |
| `property:set` | Set a property value | `obsidian property:set name="status" value="done" file="Project X"` |
| `property:remove` | Remove a property | `obsidian property:remove name="draft" file="Project X"` |

Key parameters for `properties` (vault-wide when no file given): `name` (specific property count), `sort=count`, `counts` (include occurrence counts), `format=yaml|json|tsv`, `active` (active file only).

Key parameters for `property:set`: `type=text|list|number|checkbox|date|datetime` to specify the property type explicitly.

For list-type properties, `property:set` replaces the entire value. Use JSON for arrays: `value="[\"tag1\",\"tag2\"]"`.

---

## Tasks

Operates on `- [ ]` / `- [x]` checkbox items in note content (NOT frontmatter properties).

| Command | Purpose | Example |
|---------|---------|---------|
| `task` | Show or update a task | `obsidian task line=5 done file="Sprint"` |
| `tasks` | List/filter tasks | `obsidian tasks todo verbose` |

Key parameters for `task`: `line` (line number), `file`/`path`, `toggle`, `done`, `todo`, `status="<char>"` (custom status like `/`, `?`, `!`), `daily` (target daily note), `ref=<path:line>` (task reference).

Key parameters for `tasks`: `todo` (incomplete only), `done` (completed only), `status="<char>"` (filter by status character), `file`/`path` (scope), `verbose` (group by file with line numbers), `format=json|tsv|csv`, `total`, `active` (active file), `daily` (daily note tasks).

```bash
# List all incomplete tasks in a folder, grouped by file
obsidian tasks todo path="Projects/" verbose

# Mark a specific task as done
obsidian task line=12 done file="Sprint 42"

# Set custom status character (e.g., in-progress)
obsidian task line=8 status="/" file="Sprint 42"

# Count tasks in today's daily note
obsidian tasks daily total

# Get tasks as JSON for processing
obsidian tasks todo format=json
```

---

## Bases

Interact with Obsidian Bases (database views). Bases accept both `file=` and `path=`.

| Command | Purpose | Example |
|---------|---------|---------|
| `bases` | List all bases in vault | `obsidian bases` |
| `base:views` | List views in a base | `obsidian base:views path="Bases/Projects.base"` |
| `base:create` | Create a new item in a base | `obsidian base:create path="Bases/Tasks.base" name="New Task" content="# New Task"` |
| `base:query` | Query base data | `obsidian base:query path="Bases/Projects.base" format=md` |

Key parameters for `base:create`: `name` (new file name), `content` (initial content), `view` (target view), `open`, `newtab`.

Supported `format` values for `base:query`: `json`, `csv`, `tsv`, `md`, `paths`. Use `view=` to query a specific view.

---

## Bookmarks

| Command | Purpose | Example |
|---------|---------|---------|
| `bookmark` | Add a bookmark | `obsidian bookmark file="Important Note"` |
| `bookmarks` | List all bookmarks | `obsidian bookmarks verbose` |

Key parameters for `bookmark`: `file` (file path), `subpath` (heading or block within file), `folder` (folder path), `search` (search query), `url` (URL), `title` (bookmark title).

Key parameters for `bookmarks`: `total`, `verbose` (include bookmark types), `format=json|tsv|csv`.

---

## History & Versioning

Access Obsidian's built-in file recovery snapshots.

| Command | Purpose | Example |
|---------|---------|---------|
| `history` | List file history versions | `obsidian history file="Config"` |
| `history:list` | List files with history | `obsidian history:list` |
| `history:read` | Read a specific snapshot | `obsidian history:read file="Config" version=2` |
| `history:restore` | Restore a snapshot | `obsidian history:restore file="Config" version=2` |
| `history:open` | Open file recovery UI | `obsidian history:open file="Config"` |
| `diff` | Diff between versions | `obsidian diff file="Config" from=1 to=3` |

Key parameters for `diff`: `from` (version to diff from), `to` (version to diff to), `filter=local|sync` (filter by version source).

---

## Sync

Manage Obsidian Sync (requires active Sync subscription).

| Command | Purpose | Example |
|---------|---------|---------|
| `sync` | Pause or resume sync | `obsidian sync on` |
| `sync:status` | Check sync status | `obsidian sync:status` |
| `sync:history` | List sync version history for a file | `obsidian sync:history file="Note"` |
| `sync:read` | Read a synced version | `obsidian sync:read file="Note" version=3` |
| `sync:restore` | Restore a synced version | `obsidian sync:restore file="Note" version=3` |
| `sync:deleted` | List remotely deleted files | `obsidian sync:deleted total` |
| `sync:open` | Open sync history UI | `obsidian sync:open file="Note"` |

Key parameters for `sync`: `on` (resume), `off` (pause).

---

## Templates

| Command | Purpose | Example |
|---------|---------|---------|
| `templates` | List available templates | `obsidian templates total` |
| `template:read` | Read a template's content | `obsidian template:read name="Meeting Notes"` |
| `template:insert` | Insert template into active file | `obsidian template:insert name="Meeting Notes"` |

Key parameters for `template:read`: `resolve` (resolve template variables like `{{date}}`, `{{title}}`), `title` (title value for variable resolution).

Note: `template:insert` inserts into the **active file** — it does not accept a `file=` parameter. Open the target file first with `obsidian open`.

---

## Plugins

| Command | Purpose | Example |
|---------|---------|---------|
| `plugins` | List installed plugins | `obsidian plugins filter=community versions` |
| `plugin` | Plugin info | `obsidian plugin id=dataview` |
| `plugin:enable` | Enable a plugin | `obsidian plugin:enable id=dataview` |
| `plugin:disable` | Disable a plugin | `obsidian plugin:disable id=dataview` |
| `plugin:install` | Install from community | `obsidian plugin:install id=obsidian-tasks enable` |
| `plugin:reload` | Reload a plugin (dev cycle) | `obsidian plugin:reload id=my-plugin` |
| `plugin:uninstall` | Uninstall a plugin | `obsidian plugin:uninstall id=old-plugin` |
| `plugins:enabled` | List enabled plugins only | `obsidian plugins:enabled filter=community` |
| `plugins:restrict` | Toggle restricted mode | `obsidian plugins:restrict on` |

Key parameters for `plugins`/`plugins:enabled`: `filter=core|community`, `versions` (include version numbers), `format=json|tsv|csv`.

Key parameters for `plugin:install`: `enable` (enable immediately after install).

---

## Themes & Snippets

| Command | Purpose | Example |
|---------|---------|---------|
| `theme` | Show active theme or theme info | `obsidian theme name="Minimal"` |
| `themes` | List installed themes | `obsidian themes` |
| `theme:install` | Install a theme | `obsidian theme:install name="Minimal" enable` |
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
| `tabs` | List open tabs | `obsidian tabs ids` |
| `tab:open` | Open a file in a new tab | `obsidian tab:open file="Dashboard"` |
| `workspace` | Show workspace tree | `obsidian workspace ids` |

Key parameters for `tabs`: `ids` (include tab IDs).

Key parameters for `tab:open`: `group` (tab group ID), `file` (file to open), `view` (view type).

Key parameters for `workspace`: `ids` (include workspace item IDs).

---

## Vault Management

| Command | Purpose | Example |
|---------|---------|---------|
| `vault` | Current vault info | `obsidian vault info=size` |
| `vaults` | List all known vaults | `obsidian vaults verbose` |
| `reload` | Reload the vault (re-index) | `obsidian reload` |
| `restart` | Restart Obsidian | `obsidian restart` |
| `version` | Show Obsidian version | `obsidian version` |

Key parameters for `vault`: `info=name|path|files|folders|size` (return specific info only).

Key parameters for `vaults`: `total`, `verbose` (include vault paths).

---

## Commands & Hotkeys

Execute any Obsidian command by ID.

| Command | Purpose | Example |
|---------|---------|---------|
| `command` | Execute a command | `obsidian command id="editor:toggle-bold"` |
| `commands` | List all commands | `obsidian commands filter="editor:toggle"` |
| `hotkey` | Get hotkey for a command | `obsidian hotkey id="editor:toggle-bold" verbose` |
| `hotkeys` | List all hotkeys | `obsidian hotkeys format=json` |

Key parameters for `commands`: `filter=<prefix>` (filter by command ID prefix).

Key parameters for `hotkeys`: `total`, `verbose` (show if custom), `format=json|tsv|csv`, `all` (include commands without hotkeys).

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
| `dev:css` | Inspect CSS with source locations | `obsidian dev:css selector=".workspace-leaf" prop=background-color` |
| `dev:mobile` | Toggle mobile emulation | `obsidian dev:mobile on` |
| `dev:cdp` | Chrome DevTools Protocol | `obsidian dev:cdp method="Runtime.evaluate" params='{"expression":"1+1"}'` |
| `dev:debug` | Attach/detach debugger | `obsidian dev:debug on` |

Key parameters for `dev:console`: `level=log|warn|error|info|debug`, `limit` (default 50), `clear` (clear the buffer).

Key parameters for `dev:errors`: `clear` (clear the error buffer).

Key parameters for `dev:dom`: `selector` (CSS selector), `text` (text content), `inner` (innerHTML), `all` (all matches), `attr=<name>`, `css=<prop>`, `total`.

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
obsidian create name="Missing Page" content="# Missing Page\nTODO: fill in"
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
obsidian create name="2026-02-23 Standup" template="Standup"
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
