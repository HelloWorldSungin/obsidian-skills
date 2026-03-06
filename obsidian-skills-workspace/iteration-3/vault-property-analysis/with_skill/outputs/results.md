# Vault Property Analysis Results

Vault: `/Users/sunginkim/GIT3/ArkNode-AI/vault`
Date: 2026-03-06

---

## 1. All Property Names Sorted by Usage Count

**Command:**
```bash
obsidian vault="vault" properties sort=count counts
```

**Output:**
```
tags             191
title            173
status           135
session           84
type              82
last-updated      74
created           60
date              59
priority          58
task-id           57
project           57
task-type         56
work-type         55
component         55
urgency           55
due               55
scheduled         55
projects          41
blockedBy         19
dateModified      16
container         11
related           10
port               9
prev               7
ip                 6
cpus               6
ram                6
gpus               6
url                4
updated            3
recurrence         3
complete_instances 3
aliases            2
description        2
this.projects      2
accuracy           2
strategies         2
reviewed           1
categories         1
contexts           1
related-experiment 1
verdict            1
model_type         1
gpu_config         1
dataset_size       1
cssclasses         0
```

Total unique properties: 45

---

## 2. Tags on the Active File

**Command:**
```bash
obsidian vault="vault" tags active
```

**Output:**
```
#ml-modeling
#research
#session-274
#strategy-analysis
```

The active file has 4 tags.

---

## 3. Detailed Outline of Session-274 (JSON)

**Command:**
```bash
obsidian vault="vault" outline file="Session-274" format=json
```

**Output:**
```json
[
  {
    "level": 1,
    "heading": "Session 274 — Direction Model Target Engineering (Binary → Soft Regression)",
    "line": 14
  },
  {
    "level": 2,
    "heading": "Objective",
    "line": 16
  },
  {
    "level": 2,
    "heading": "Motivation",
    "line": 20
  },
  {
    "level": 2,
    "heading": "Implementation",
    "line": 24
  },
  {
    "level": 3,
    "heading": "Files Modified (5)",
    "line": 26
  },
  {
    "level": 3,
    "heading": "Key Design Decisions",
    "line": 36
  },
  {
    "level": 3,
    "heading": "Parallel Backtest Execution",
    "line": 45
  },
  {
    "level": 2,
    "heading": "Results",
    "line": 49
  },
  {
    "level": 3,
    "heading": "Walk-Forward Backtest (threshold=0)",
    "line": 51
  },
  {
    "level": 3,
    "heading": "Post-Hoc Threshold Sweep",
    "line": 68
  },
  {
    "level": 3,
    "heading": "Model Accuracy Matrix",
    "line": 85
  },
  {
    "level": 3,
    "heading": "Per-Fold IC Trend",
    "line": 103
  },
  {
    "level": 2,
    "heading": "Issues Identified",
    "line": 107
  },
  {
    "level": 2,
    "heading": "Failed Experiment: Risk-Adjusted Target (`pnl_pct / volatility`)",
    "line": 113
  },
  {
    "level": 3,
    "heading": "Risk-Adjusted Results (threshold=0)",
    "line": 117
  },
  {
    "level": 2,
    "heading": "S273 Feature Flags Confirmation",
    "line": 139
  },
  {
    "level": 2,
    "heading": "Per-Strategy Feature Pruning Assessment",
    "line": 151
  },
  {
    "level": 2,
    "heading": "Next Steps",
    "line": 159
  },
  {
    "level": 2,
    "heading": "Commits",
    "line": 166
  }
]
```

Session-274 has 19 headings: 1 H1, 9 H2, and 9 H3 sections. The note covers Direction Model Target Engineering, including implementation details, results with multiple analysis subsections, a failed experiment, and next steps.
