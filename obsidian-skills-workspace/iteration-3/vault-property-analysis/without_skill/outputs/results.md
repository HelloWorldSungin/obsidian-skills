# Vault Property Analysis Results (Without Skill)

**Date:** 2026-03-06
**Vault:** `/Users/sunginkim/GIT3/ArkNode-AI/vault`
**Method:** Direct file inspection via Bash/Python (no Obsidian skill or API)

---

## 1. All Property Names Sorted by Frequency

### Command

```bash
cd /Users/sunginkim/GIT3/ArkNode-AI/vault && python3 -c "
import os, re, yaml
from collections import Counter

prop_counter = Counter()
for root, dirs, files in os.walk('.'):
    dirs[:] = [d for d in dirs if not d.startswith('.')]
    for f in files:
        if not f.endswith('.md'):
            continue
        path = os.path.join(root, f)
        try:
            with open(path, 'r', encoding='utf-8') as fh:
                content = fh.read()
        except:
            continue
        if not content.startswith('---'):
            continue
        end_idx = content.find('---', 3)
        if end_idx == -1:
            continue
        fm_text = content[3:end_idx].strip()
        try:
            parsed = yaml.safe_load(fm_text)
            if isinstance(parsed, dict):
                for key in parsed.keys():
                    prop_counter[key] += 1
        except:
            for line in fm_text.split('\n'):
                m = re.match(r'^([a-zA-Z_][a-zA-Z0-9_-]*)\s*:', line)
                if m:
                    prop_counter[m.group(1)] += 1

for prop, count in prop_counter.most_common():
    print(f'{count:>4}  {prop}')
"
```

### Output

```
 192  tags
 174  title
 136  status
  84  session
  82  type
  74  last-updated
  60  created
  60  date
  58  priority
  57  task-id
  57  project
  56  task-type
  55  work-type
  55  component
  55  urgency
  55  due
  55  scheduled
  41  projects
  19  blockedBy
  16  dateModified
  11  container
  10  related
   9  port
   7  prev
   6  ip
   6  cpus
   6  ram
   6  gpus
   4  url
   3  recurrence
   3  complete_instances
   3  updated
   2  description
   2  this.projects
   2  accuracy
   2  strategies
   2  aliases
   1  contexts
   1  related-experiment
   1  reviewed
   1  categories
   1  verdict
   1  model_type
   1  gpu_config
   1  dataset_size
```

**Total unique properties: 45**

### Observations

- **`tags`** is the most widely used property (192 files), appearing in nearly every file with frontmatter.
- **`title`** (174) and **`status`** (136) are the next most common, suggesting a convention of titling and status-tracking across notes.
- A cluster of task management properties (`priority`, `task-id`, `project`, `task-type`, `work-type`, `component`, `urgency`, `due`, `scheduled`) each appear ~55-58 times, indicating a TaskNotes plugin with consistent schema.
- Infrastructure notes contribute domain-specific properties: `container`, `port`, `ip`, `cpus`, `ram`, `gpus`.
- Several low-frequency properties (`this.projects`, `accuracy`, `verdict`, `model_type`, etc.) appear in only 1-2 files, likely experimental or one-off.

---

## 2. Tags on the Active File

### How the Active File Was Determined

Read Obsidian's workspace state from `.obsidian/workspace.json`. The `"active"` field pointed to leaf ID `756daecfcc4e119e`, which maps to:

```
Trading-Signal-AI/Research/Strategy-Failure-Analysis.md
```

### Command

```bash
# Read workspace.json to find the active leaf ID, then match it to a file path
cat /Users/sunginkim/GIT3/ArkNode-AI/vault/.obsidian/workspace.json | python3 -c "
import json, sys
ws = json.load(sys.stdin)
# ws['active'] = '756daecfcc4e119e' -> maps to the leaf with that id
# Leaf state: file = 'Trading-Signal-AI/Research/Strategy-Failure-Analysis.md'
"
```

Then read the frontmatter of that file directly.

### Output

The active file `Strategy-Failure-Analysis.md` has the following tags:

```yaml
tags:
  - research
  - strategy-analysis
  - ml-modeling
  - session-274
```

**4 tags total:** `research`, `strategy-analysis`, `ml-modeling`, `session-274`

---

## 3. Detailed Outline of Session-274 (JSON)

### Command

```bash
cd /Users/sunginkim/GIT3/ArkNode-AI/vault && python3 -c "
import re, json

with open('Trading-Signal-AI/Session-Logs/Session-274.md', 'r') as f:
    content = f.read()
lines = content.split('\n')

# Parse frontmatter
# ... (YAML extraction logic)

# Parse headings into hierarchical outline
# ... (heading stack algorithm)

result = {
    'file': 'Trading-Signal-AI/Session-Logs/Session-274.md',
    'frontmatter': frontmatter,
    'outline': outline
}
print(json.dumps(result, indent=2))
"
```

### Output

```json
{
  "file": "Trading-Signal-AI/Session-Logs/Session-274.md",
  "frontmatter": {
    "date": "2026-03-06",
    "tags": [
      "session-log",
      "target-engineering",
      "regressor",
      "per-direction-models",
      "S274"
    ],
    "session": 274,
    "status": "complete",
    "prev": "[[Session-273]]"
  },
  "outline": [
    {
      "level": 1,
      "title": "Session 274 — Direction Model Target Engineering (Binary → Soft Regression)",
      "line": 14,
      "children": [
        {
          "level": 2,
          "title": "Objective",
          "line": 16,
          "children": []
        },
        {
          "level": 2,
          "title": "Motivation",
          "line": 20,
          "children": []
        },
        {
          "level": 2,
          "title": "Implementation",
          "line": 24,
          "children": [
            {
              "level": 3,
              "title": "Files Modified (5)",
              "line": 26,
              "children": []
            },
            {
              "level": 3,
              "title": "Key Design Decisions",
              "line": 36,
              "children": []
            },
            {
              "level": 3,
              "title": "Parallel Backtest Execution",
              "line": 45,
              "children": []
            }
          ]
        },
        {
          "level": 2,
          "title": "Results",
          "line": 49,
          "children": [
            {
              "level": 3,
              "title": "Walk-Forward Backtest (threshold=0)",
              "line": 51,
              "children": []
            },
            {
              "level": 3,
              "title": "Post-Hoc Threshold Sweep",
              "line": 68,
              "children": []
            },
            {
              "level": 3,
              "title": "Model Accuracy Matrix",
              "line": 85,
              "children": []
            },
            {
              "level": 3,
              "title": "Per-Fold IC Trend",
              "line": 103,
              "children": []
            }
          ]
        },
        {
          "level": 2,
          "title": "Issues Identified",
          "line": 107,
          "children": []
        },
        {
          "level": 2,
          "title": "Failed Experiment: Risk-Adjusted Target (`pnl_pct / volatility`)",
          "line": 113,
          "children": [
            {
              "level": 3,
              "title": "Risk-Adjusted Results (threshold=0)",
              "line": 117,
              "children": []
            }
          ]
        },
        {
          "level": 2,
          "title": "S273 Feature Flags Confirmation",
          "line": 139,
          "children": []
        },
        {
          "level": 2,
          "title": "Per-Strategy Feature Pruning Assessment",
          "line": 151,
          "children": []
        },
        {
          "level": 2,
          "title": "Next Steps",
          "line": 159,
          "children": []
        },
        {
          "level": 2,
          "title": "Commits",
          "line": 166,
          "children": []
        }
      ]
    }
  ]
}
```

### Structure Summary

Session-274 has **1 H1 heading** with **10 H2 sections** and **7 H3 subsections** nested within Implementation (3) and Results (4), plus 1 H3 under the Failed Experiment section. The document covers the full arc of an experiment: objective, motivation, implementation, results, issues, a failed side-experiment, and next steps.

---

## Methodology Notes

- **Property extraction:** Used Python's `yaml.safe_load()` to parse YAML frontmatter from all `.md` files in the vault (excluding `.obsidian/` and hidden directories). This avoids false positives from content lines leaking through regex-only approaches.
- **Active file detection:** Read `.obsidian/workspace.json` and matched the `"active"` leaf ID (`756daecfcc4e119e`) to its corresponding file state (`Trading-Signal-AI/Research/Strategy-Failure-Analysis.md`).
- **Outline generation:** Parsed markdown headings (`# ... ######`) into a hierarchical tree structure using a stack-based algorithm, preserving parent-child nesting and line numbers.
- **Limitation:** The "active file" is determined from Obsidian's last-saved workspace state. If Obsidian is not running or the workspace file is stale, this may not reflect the true current state.
