# Obsidian Vault Health Check Report

**Vault:** `/Users/sunginkim/GIT3/ArkNode-AI/vault`
**Date:** 2026-03-06
**Method:** Manual analysis using Read, Grep, Glob, Bash (no obsidian CLI)

---

## Summary

| Metric | Count |
|--------|------:|
| Total markdown files | 195 |
| Total files (all types) | 256 |
| Broken wikilinks | 92 |
| -- Missing notes | 90 |
| -- Missing images | 2 |
| Orphan notes (no incoming links) | 46 |
| Dead-end notes (no outgoing links) | 17 |
| Unique tags | 270 |
| Total tag occurrences | 709 |

---

## Top 10 Most-Used Tags

| Rank | Tag | Count |
|------|-----|------:|
| 1 | #task | 56 |
| 2 | #session-log | 48 |
| 3 | #trading-signal-ai | 27 |
| 4 | #infrastructure | 19 |
| 5 | #xgboost | 19 |
| 6 | #tft | 15 |
| 7 | #deployment | 14 |
| 8 | #archived | 14 |
| 9 | #research | 14 |
| 10 | #walk-forward | 14 |

---

## Broken Wikilinks (92)

Links that point to notes, images, or other files that do not exist in the vault.

### Infrastructure & Top-Level (7 broken links)

| Source | Broken Target |
|--------|---------------|
| `00-Home.md` | `[[00-Ark-Trade-Overview]]` |
| `Ark-Line/00-Ark-Line-Overview.md` | `[[OHLCV-Service]]` |
| `Infrastructure/00-Infrastructure-Overview.md` | `[[OHLCV-Service]]` |
| `Infrastructure/Containers/CT100-Trading.md` | `[[HL-Account-API]]` |
| `Infrastructure/Containers/CT100-Trading.md` | `[[OHLCV-Service]]` |
| `Infrastructure/Database-Architecture.md` | `[[OHLCV-Service]]` |
| `Infrastructure/Services/Unified-Executor.md` | `[[OHLCV-Service]]` |

> **Note:** `[[OHLCV-Service]]` is broken in 5 places. The actual file is `OHLCV-Service-Overview.md` inside `Infrastructure/Services/OHLCV-Service/`.

### TaskNotes -- Archive (14 broken links)

| Source | Broken Target |
|--------|---------------|
| `TaskNotes/Archive/ArkSignal-005-arksignal-backtest-framework.md` | `[[ArkSignal-007]]`, `[[ArkSignal-008]]`, `[[ArkSignal-009]]`, `[[ArkSignal-010]]`, `[[ArkSignal-011]]`, `[[ArkSignal-012]]` |
| `TaskNotes/Archive/ArkSignal-007-design-backtest-engine-architecture.md` | `[[ArkSignal-005]]` |
| `TaskNotes/Archive/ArkSignal-008-implement-data-pipeline.md` | `[[ArkSignal-005]]` |
| `TaskNotes/Archive/ArkSignal-009-implement-distributed-execution.md` | `[[ArkSignal-005]]` |
| `TaskNotes/Archive/ArkSignal-010-implement-unified-metrics.md` | `[[ArkSignal-005]]`, `[[TASK-009-arksignal-backtest-framework]]`, `[[TASK-009.4-implement-unified-metrics]]` |
| `TaskNotes/Archive/ArkSignal-011-implement-rolling-validation.md` | `[[ArkSignal-005]]` |
| `TaskNotes/Archive/ArkSignal-012-migrate-existing-backtests.md` | `[[ArkSignal-005]]` |

> **Note:** Archived tasks use short IDs (e.g., `ArkSignal-005`) but actual filenames are longer (e.g., `ArkSignal-005-arksignal-backtest-framework.md`). These are systematic naming mismatches.

### TaskNotes -- Epics (33 broken links)

| Source | Broken Target |
|--------|---------------|
| `TaskNotes/Tasks/Epic/ArkClaw-001-tinyclaw-opencode-integration.md` | `[[ArkClaw-003]]`, `[[ArkClaw-004]]`, `[[ArkClaw-005]]`, `[[ArkClaw-006]]` |
| `TaskNotes/Tasks/Epic/ArkSignal-013-freqtrade-integration.md` | `[[ArkSignal-014-freqtrade-env-setup]]` through `[[ArkSignal-025-cross-exchange-arbitrage]]` (12 links) |
| `TaskNotes/Tasks/Epic/Infra-002-ct110-dev-deployment.md` | `[[Infra-011]]` through `[[Infra-016]]` (6 links) |
| `TaskNotes/Tasks/Epic/Infra-003-monitor-dashboard-transformation.md` | `[[Infra-004]]` through `[[Infra-010]]` (7 links), `[[TASK-007-monitor-dashboard-transformation]]` |

> **Note:** Epic-to-Story links use short IDs but filenames contain full slugs. The ArkSignal-013 epic references 12 story notes that have not been created yet.

### TaskNotes -- Stories (17 broken links)

| Source | Broken Target |
|--------|---------------|
| `TaskNotes/Tasks/Story/ArkClaw-003` through `ArkClaw-006` | `[[ArkClaw-001]]` (4 links -- short ID mismatch) |
| `TaskNotes/Tasks/Story/Infra-004` through `Infra-010` | `[[Infra-003]]` (7 links -- short ID mismatch) |
| `TaskNotes/Tasks/Story/Infra-011` through `Infra-016` | `[[Infra-002]]` (5 links -- short ID mismatch) |
| `TaskNotes/Tasks/Story/Infra-011-audit-ct110-state.md` | `[[TASK-010-ct110-dev-deployment]]` (1 link -- old naming) |

### Trading-Signal-AI (21 broken links)

| Source | Broken Target |
|--------|---------------|
| `Trading-Signal-AI/Development-Workflow.md` | `[[COMMANDS.md]]` |
| `Trading-Signal-AI/Operations/Binance-Futures-Data.md` | `[[../../../CLAUDE]]` |
| `Trading-Signal-AI/Paper-Trading/Paper-Trading-Architecture.md` | `[[OHLCV-Service]]` |
| `Trading-Signal-AI/Research/Futures-Data-Hypothesis-Test.md` | `[[Binance-Global-API-Reference]]` |
| `Trading-Signal-AI/Session-Logs/00-Session-Logs-Index.md` | `[[Session-224]]`, `[[Session-237]]`, `[[Session-238]]` |
| `Trading-Signal-AI/Session-Logs/Session-225.md` | `[[Session-224]]` |
| `Trading-Signal-AI/Session-Logs/Session-228.md` | `[[Project-Overview]]` |
| `Trading-Signal-AI/Session-Logs/Session-231.md` | `[[Training/XGBoost-Strategies]]` |
| `Trading-Signal-AI/Session-Logs/Session-239.md` | `[[Session-238]]` |
| `Trading-Signal-AI/Session-Logs/Session-248.md` | `[[deployment_matrix.png]]`, `[[filter_tft_impact.png]]` |
| `Trading-Signal-AI/Strategies/Backtesting-Guide.md` | `[[ArkBacktest-Framework]]`, `[[Session-209]]` |
| `Trading-Signal-AI/Strategies/Exit-Strategy-Comparison.md` | `[[ArkBacktest-Framework]]` |
| `Trading-Signal-AI/Training/TFT-Ensemble-Global.md` | `[[Review-CT100-Execution]]` |
| `Trading-Signal-AI/Training/TFT-XGBoost-Pipeline.md` | `[[Rolling Window Backtest]]`, `[[Rolling Window Validation]]`, `[[Temporal Fusion Transformer (TFT)]]`, `[[Walk-Forward Validation]]`, `[[XGBoost]]`, `[[XGBoost Meta-Labeling]]` |

---

## Orphan Notes (46)

Notes with zero incoming links from other vault notes. These are disconnected from the knowledge graph.

### Templates & Config (5 notes -- expected orphans)

- `_Attachments/README.md`
- `_Templates/Container-Template.md`
- `_Templates/Model-Template.md`
- `_Templates/Service-Template.md`
- `TaskNotes/Templates/Task-Template.md`

### TaskNotes (30 notes)

- `TaskNotes/00-Project-Management-Guide.md`
- `TaskNotes/TaskNotes-Configuration-Checklist.md`
- `TaskNotes/Archive/ArkSignal-001-quanllm-research.md`
- `TaskNotes/Archive/ArkSignal-002-optimize-capital-allocation.md`
- `TaskNotes/Archive/ArkSignal-003-fix-mlflow.md`
- `TaskNotes/Archive/ArkSignal-004-implement-market-condition-filters.md`
- `TaskNotes/Archive/ArkSignal-007-design-backtest-engine-architecture.md`
- `TaskNotes/Archive/ArkSignal-008-implement-data-pipeline.md`
- `TaskNotes/Archive/ArkSignal-009-implement-distributed-execution.md`
- `TaskNotes/Archive/ArkSignal-010-implement-unified-metrics.md`
- `TaskNotes/Archive/ArkSignal-011-implement-rolling-validation.md`
- `TaskNotes/Archive/ArkSignal-012-migrate-existing-backtests.md`
- `TaskNotes/Archive/Infra-001-migrate-notes.md`
- `TaskNotes/Archive/Infra-002-dev-deployment-ct110.md`
- `TaskNotes/Tasks/Epic/ArkSignal-013-freqtrade-integration.md`
- `TaskNotes/Tasks/Story/ArkClaw-003-add-opencode-provider-support.md`
- `TaskNotes/Tasks/Story/ArkClaw-004-implement-engine-selection-logic.md`
- `TaskNotes/Tasks/Story/ArkClaw-005-update-agent-configurations.md`
- `TaskNotes/Tasks/Story/ArkClaw-006-update-documentation-and-types.md`
- `TaskNotes/Tasks/Story/ArkSignal-035-benchmark-obsidian-skills.md`
- `TaskNotes/Tasks/Story/Infra-004-remove-jt-indicator-monitoring.md`
- `TaskNotes/Tasks/Story/Infra-005-create-ohlcv-health-monitor.md`
- `TaskNotes/Tasks/Story/Infra-006-create-futures-data-monitor.md`
- `TaskNotes/Tasks/Story/Infra-007-create-inference-api-health-monitor.md`
- `TaskNotes/Tasks/Story/Infra-008-create-position-manager-monitor.md`
- `TaskNotes/Tasks/Story/Infra-009-transform-ml-to-health-page.md`
- `TaskNotes/Tasks/Story/Infra-010-create-infrastructure-health-monitor.md`
- `TaskNotes/Tasks/Story/Infra-011-audit-ct110-state.md`
- `TaskNotes/Tasks/Story/Infra-012-create-service-parity-checklist.md`
- `TaskNotes/Tasks/Story/Infra-013-implement-ct110-deployment-automation.md`
- `TaskNotes/Tasks/Story/Infra-014-design-e2e-testing-framework.md`
- `TaskNotes/Tasks/Story/Infra-015-implement-e2e-test-suite.md`
- `TaskNotes/Tasks/Story/Infra-016-create-deployment-validation-workflow.md`
- `TaskNotes/Tasks/Task/ArkSignal-035-benchmark-obsidian-skills.md`

### Infrastructure (2 notes)

- `Infrastructure/Services/OHLCV-Service/Futures-Longer-Horizon-Analysis.md`
- `Infrastructure/Services/Webhook-Server.md`

### Trading-Signal-AI (4 notes)

- `Trading-Signal-AI/Command.md`
- `Trading-Signal-AI/Research/Benchmark-Analysis-Baseline.md`
- `Trading-Signal-AI/Research/Benchmark-Analysis.md`
- `Trading-Signal-AI/Session-Logs/Session-246.md`
- `Trading-Signal-AI/Training/ArkSignal-Model-Architecture.md`

---

## Dead-End Notes (17)

Notes that contain zero outgoing wikilinks to other notes.

- `Infrastructure/Services/OHLCV-Service/Futures-Longer-Horizon-Analysis.md`
- `TaskNotes/00-Project-Management-Guide.md`
- `TaskNotes/Archive/ArkSignal-001-quanllm-research.md`
- `TaskNotes/Archive/ArkSignal-002-optimize-capital-allocation.md`
- `TaskNotes/Archive/ArkSignal-003-fix-mlflow.md`
- `TaskNotes/Archive/Infra-001-migrate-notes.md`
- `TaskNotes/Archive/Infra-002-dev-deployment-ct110.md`
- `TaskNotes/TaskNotes-Configuration-Checklist.md`
- `TaskNotes/Tasks/Story/ArkSignal-035-benchmark-obsidian-skills.md`
- `TaskNotes/Tasks/Task/ArkSignal-035-benchmark-obsidian-skills.md`
- `TaskNotes/Templates/Task-Template.md`
- `Trading-Signal-AI/Command.md`
- `Trading-Signal-AI/Session-Logs/Session-203.md`
- `Trading-Signal-AI/Session-Logs/Session-229.md`
- `Trading-Signal-AI/Session-Logs/Session-232.md`
- `_Attachments/README.md`
- `_Templates/Service-Template.md`

---

## Key Findings & Recommendations

### 1. TaskNotes short-ID linking is the #1 source of broken links (64 of 92)

Epic and Story notes link to each other using short IDs like `[[Infra-003]]` or `[[ArkClaw-001]]`, but the actual filenames are longer (e.g., `Infra-003-monitor-dashboard-transformation.md`). Obsidian cannot resolve these. **Fix:** Use Obsidian aliases in frontmatter (`aliases: [Infra-003]`) on each task note, or switch links to use the full filename.

### 2. `[[OHLCV-Service]]` is broken in 5 places

The file exists as `OHLCV-Service-Overview.md`. Either rename the file to `OHLCV-Service.md` or add an alias.

### 3. 12 planned ArkSignal Freqtrade stories do not exist yet

`ArkSignal-013-freqtrade-integration.md` links to 12 story notes (ArkSignal-014 through ArkSignal-025) that have not been created.

### 4. Missing session logs create broken chains

Sessions 209, 224, 237, and 238 are referenced but do not exist, breaking the session log chain.

### 5. `TFT-XGBoost-Pipeline.md` uses concept-style links

6 links like `[[XGBoost]]`, `[[Temporal Fusion Transformer (TFT)]]` point to concept notes that were never created. Consider creating glossary/concept notes or removing these links.

### 6. 2 missing images

`deployment_matrix.png` and `filter_tft_impact.png` referenced in Session-248 are not in `_Attachments/` or `assets/`.

### 7. Most orphans are TaskNotes story/archive notes

30 of 46 orphans are task notes. The Epic-to-Story linking is broken due to the short-ID issue (finding #1). Fixing aliases would resolve most orphans automatically.

### 8. Tags are well-structured

270 unique tags with consistent naming conventions. Tags are predominantly in YAML frontmatter (267 frontmatter vs 3 inline), indicating disciplined usage.
