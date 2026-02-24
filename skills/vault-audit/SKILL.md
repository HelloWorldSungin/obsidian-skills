---
name: vault-audit
description: Audit Obsidian vault health by checking for broken links, orphan notes, dead ends, and tag/property consistency. Use when the user wants to check vault quality, find broken links, identify orphan notes, run a vault health check, or do a pre-publish review.
---

# Vault Audit

Audit and maintain Obsidian vault health using the CLI. Requires Obsidian 1.10+ running.

## Quick Health Check

Run these five commands for a quick vault overview:

```bash
obsidian unresolved total    # Broken wikilinks (link targets that don't exist)
obsidian orphans total       # Notes with no incoming links
obsidian deadends total      # Notes with no outgoing links
obsidian files total         # Total files in vault
obsidian vault               # Vault info and path
```

## Broken Links

Find wikilinks pointing to non-existent notes:

```bash
obsidian unresolved              # List all broken links with source files
obsidian unresolved total        # Count only
obsidian unresolved limit=20     # First 20
```

**Fix:** Create the missing note, or update the link in the source file.

## Orphan Notes

Notes that exist but no other note links to them:

```bash
obsidian orphans                 # List all orphans
obsidian orphans total           # Count only
```

**Fix:** Add links from related notes, or delete if no longer needed.

## Dead Ends

Notes that don't link to anything else:

```bash
obsidian deadends                # List all dead ends
obsidian deadends total          # Count only
```

**Fix:** Add outgoing links to connect these notes to the knowledge graph.

## Vault Statistics

```bash
obsidian tags sort=count counts  # Tags ranked by usage
obsidian properties sort=count   # Properties ranked by usage
obsidian files total             # Total file count
obsidian folders                 # Folder structure
```

## Common Workflows

### Weekly Vault Cleanup

```bash
# 1. Check overall health
obsidian unresolved total
obsidian orphans total
obsidian deadends total

# 2. Fix broken links first (highest priority)
obsidian unresolved

# 3. Review orphans — link or archive
obsidian orphans

# 4. Check for unused tags
obsidian tags sort=count counts
```

### Pre-Publish Link Check

Before sharing or publishing notes from a folder:

```bash
# Check for broken links in the target folder
obsidian search query="[[" path="Folder/To/Publish"
obsidian unresolved

# Verify all linked notes exist
obsidian links file="Index Note"
```

### Tag Audit

```bash
# Find all tags and their counts
obsidian tags sort=count counts

# Search for notes with a specific tag
obsidian search query="tag:#obsolete"

# Find notes with inconsistent tagging
obsidian properties name=tags
```
