# Vault Task Audit Results

**Date:** 2026-03-06
**Vault:** `/Users/sunginkim/GIT3/ArkNode-AI/vault`

---

## Summary

| Metric | Count |
|--------|-------|
| Total Incomplete Tasks (`- [ ]`) | **498** |
| Total Done Tasks (`- [x]`) | **131** |
| Files with Incomplete Tasks | **95** |
| Tasks in Today's Daily Note (2026-03-06) | **0** |

Today's daily note (`vault/2026-03-06.md`) exists but is empty -- it contains no tasks.

---

## Commands Used

```bash
# Python script to walk all .md files in the vault and extract tasks
cd /Users/sunginkim/GIT3/ArkNode-AI/vault
python3 << 'PYEOF'
import os, re
from collections import defaultdict

vault = "."
incomplete = defaultdict(list)
done_count = 0
daily_note_tasks = 0
daily_note_file = "./2026-03-06.md"

for root, dirs, files in os.walk(vault):
    dirs[:] = [d for d in dirs if not d.startswith('.')]
    for fname in files:
        if not fname.endswith('.md'):
            continue
        fpath = os.path.join(root, fname)
        try:
            with open(fpath, 'r', encoding='utf-8', errors='replace') as f:
                for i, line in enumerate(f, 1):
                    if re.search(r'- \[ \]', line):
                        incomplete[fpath].append((i, line.rstrip()))
                        if os.path.abspath(fpath) == os.path.abspath(daily_note_file):
                            daily_note_tasks += 1
                    if re.search(r'- \[x\]', line):
                        done_count += 1
        except Exception:
            pass

for fpath in sorted(incomplete.keys()):
    print(f"### {fpath}")
    for lineno, content in incomplete[fpath]:
        print(f"  Line {lineno}: {content}")
    print()

print(f"TOTAL INCOMPLETE TASKS: {sum(len(v) for v in incomplete.values())}")
print(f"TOTAL DONE TASKS: {done_count}")
print(f"FILES WITH INCOMPLETE TASKS: {len(incomplete)}")
PYEOF
```

---

## Incomplete Tasks Grouped by File (with line numbers)

### ./TaskNotes/Archive/ArkSignal-001-quanllm-research.md
  Line 28: - [ ] Review QuanLLM documentation and capabilities
  Line 29: - [ ] Assess relevance to current trading strategies
  Line 30: - [ ] Document findings

### ./TaskNotes/Archive/ArkSignal-002-optimize-capital-allocation.md
  Line 28: - [ ] Set up vectorBT environment
  Line 29: - [ ] Create backtesting framework
  Line 30: - [ ] Run optimization for capital allocation
  Line 31: - [ ] Run optimization for leverage
  Line 32: - [ ] Document optimal parameters

### ./TaskNotes/Archive/ArkSignal-003-fix-mlflow.md
  Line 28: - [ ] Identify MLflow issues
  Line 29: - [ ] Fix tracking problems
  Line 30: - [ ] Verify model logging works
  Line 31: - [ ] Test model registry

### ./TaskNotes/Archive/ArkSignal-004-implement-market-condition-filters.md
  Line 45: - [ ] Add `condition_filters` config section to `strategies.yaml`
  Line 46: - [ ] Fetch indicators (`btc_rsi_14`, `volatility_change`, `adx_14`) from OHLCV service at execution time
  Line 47: - [ ] Implement gate checks in `position_manager.process_predictions()` before opening positions
  Line 48: - [ ] Test each gate individually with historical data
  Line 49: - [ ] Deploy to paper trading and validate performance
  Line 50: - [ ] Document filter behavior and thresholds

### ./TaskNotes/Archive/ArkSignal-005-arksignal-backtest-framework.md
  Line 45: - [ ] All 6 sub-tasks completed
  Line 46: - [ ] Framework tested with ArkSignal-Strategy-v1
  Line 47: - [ ] Documentation complete
  Line 48: - [ ] 50+ existing scripts migrated

### ./TaskNotes/Archive/ArkSignal-007-design-backtest-engine-architecture.md
  Line 50: - [ ] Define BacktestEngine interface
  Line 51: - [ ] Design strategy plugin system
  Line 52: - [ ] Create configuration schema
  Line 53: - [ ] Plan exit strategy abstraction
  Line 54: - [ ] Document architecture decisions

### ./TaskNotes/Archive/ArkSignal-008-implement-data-pipeline.md
  Line 45: - [ ] Create unified data loader
  Line 46: - [ ] Implement feature computation pipeline
  Line 47: - [ ] Add signal preparation module
  Line 48: - [ ] Create data validation checks
  Line 49: - [ ] Optimize for large datasets

### ./TaskNotes/Archive/ArkSignal-009-implement-distributed-execution.md
  Line 45: - [ ] Create job scheduler
  Line 46: - [ ] Implement GPU worker pool
  Line 47: - [ ] Add result aggregation
  Line 48: - [ ] Create progress monitoring
  Line 49: - [ ] Handle failures and retries

### ./TaskNotes/Archive/ArkSignal-010-implement-unified-metrics.md
  Line 57: - [ ] Create unified metrics module
  Line 58: - [ ] Implement regime breakdown
  Line 59: - [ ] Add baseline comparison
  Line 60: - [ ] Generate standardized reports
  Line 61: - [ ] Export to MLflow

### ./TaskNotes/Archive/ArkSignal-011-implement-rolling-validation.md
  Line 45: - [ ] Create rolling window generator
  Line 46: - [ ] Implement overfitting detection metrics
  Line 47: - [ ] Add threshold sweep functionality
  Line 48: - [ ] Create validation reports
  Line 49: - [ ] Integrate with MLflow tracking

### ./TaskNotes/Archive/ArkSignal-012-migrate-existing-backtests.md
  Line 49: - [ ] Create migration guide
  Line 50: - [ ] Migrate ArkSignal v1 backtest
  Line 51: - [ ] Migrate ArkSignal v2 backtest
  Line 52: - [ ] Migrate XGBoost backtests
  Line 53: - [ ] Migrate Platt calibration backtests
  Line 54: - [ ] Migrate remaining backtests
  Line 55: - [ ] Archive old scripts

### ./TaskNotes/Archive/Infra-002-dev-deployment-ct110.md
  Line 29: - [ ] Set up CT110 with same services as CT100
  Line 30: - [ ] Verify all components work correctly
  Line 31: - [ ] Create deployment validation tests
  Line 32: - [ ] Document deployment process

### ./TaskNotes/TaskNotes-Configuration-Checklist.md
  Line 17: - [ ] Obsidian 1.10.1 or later installed
  Line 18: - [ ] TaskNotes plugin installed from Community Plugins
  Line 19: - [ ] Bases core plugin enabled
  Line 114: - [ ] **All-Tasks.base** - See all tasks in table format
  Line 115: - [ ] **Kanban-Status.base** - Visual kanban board
  Line 116: - [ ] **By-Project.base** - Tasks grouped by project
  Line 117: - [ ] **By-Component.base** - Tasks grouped by component
  Line 118: - [ ] **Critical-Blocking.base** - High priority tasks
  Line 119: - [ ] **This-Week.base** - Tasks scheduled for this week
  Line 135: - [ ] Is Bases plugin enabled?
  Line 136: - [ ] Do task files have `tags: [task]` in frontmatter?
  Line 137: - [ ] Is the task folder path correct in settings?
  Line 140: - [ ] Is TaskNotes plugin enabled?
  Line 141: - [ ] Check console for errors (Cmd/Ctrl + Shift + I)
  Line 144: - [ ] Open the `.base` file directly
  Line 145: - [ ] Check that query path matches your folder structure
  Line 146: - [ ] Try refreshing the view

### ./TaskNotes/Tasks/Epic/ArkClaw-001-tinyclaw-opencode-integration.md
  Line 43: - [ ] All 4 sub-tasks completed
  Line 44: - [ ] Test both Opencode and Claude CLI modes
  Line 45: - [ ] Verify agent routing works correctly

### ./TaskNotes/Tasks/Epic/ArkSignal-013-freqtrade-integration.md
  Line 263: - [ ] Freqtrade runs on CT100 with Hyperliquid exchange connection
  Line 264: - [ ] `ArkSignalStrategy` correctly reads predictions from inference API (`:8811`)
  Line 265: - [ ] Stoploss-on-exchange active for all open positions
  Line 266: - [ ] Telegram bot responds to `/status`, `/profit`, `/balance` commands
  Line 267: - [ ] Protection plugins halt trading after 3 consecutive stoplosses or 10% drawdown
  Line 268: - [ ] Parallel paper run shows <=5% deviation from existing executor over 7 days
  Line 269: - [ ] Live cutover completed with rollback plan documented
  Line 270: - [ ] Monitor dashboard updated to read Freqtrade trade data

### ./TaskNotes/Tasks/Epic/Infra-002-ct110-dev-deployment.md
  Line 48: - [ ] CT110 mirrors CT100 services
  Line 49: - [ ] E2E tests pass consistently
  Line 50: - [ ] Validation workflow documented
  Line 51: - [ ] Deploy to CT110 -> Monitor -> Deploy to CT100 process working

### ./TaskNotes/Tasks/Epic/Infra-003-monitor-dashboard-transformation.md
  Line 53: - [ ] All 7 sub-tasks completed
  Line 54: - [ ] Health page displays real-time status indicators
  Line 55: - [ ] Alerts configured for critical failures
  Line 56: - [ ] Documentation updated

### ./TaskNotes/Tasks/Epic/Infra-017-ct110-claude-code-dev-env.md
  Line 48: - [ ] `dev` user exists with SSH + GitHub access
  Line 49: - [ ] Git worktrees functional with `wt` helper
  Line 50: - [ ] Claude Code authenticated and configured
  Line 51: - [ ] Shell aliases and tmux configured for mobile
  Line 52: - [ ] E2E verification passes all checks

### ./TaskNotes/Tasks/Epic/Infra-023-workflow-visualization-grafana-prefect.md
  Line 116: - [ ] Grafana Service Health dashboard shows all CT100/CT110/CT120 services
  Line 117: - [ ] Grafana Pipeline Topology shows data flow with live health colors
  Line 118: - [ ] Prefect UI shows registered flows (monthly retrain, quarterly TFT, walk-forward)
  Line 119: - [ ] Monthly retraining and quarterly TFT scheduled in Prefect
  Line 120: - [ ] Grafana displays Prefect flow run status and alerts on failure
  Line 121: - [ ] Three dashboards complement each other (Monitor -> trades, Grafana -> services, Prefect -> pipelines)

### ./TaskNotes/Tasks/Story/ArkClaw-003-add-opencode-provider-support.md
  Line 46: - [ ] Implement local opencode execution
  Line 47: - [ ] Implement remote SSH opencode execution
  Line 48: - [ ] Add error handling for opencode failures
  Line 49: - [ ] Test opencode command execution

### ./TaskNotes/Tasks/Story/ArkClaw-004-implement-engine-selection-logic.md
  Line 46: - [ ] Implement task source detection
  Line 47: - [ ] Add engine selection logic
  Line 48: - [ ] Support per-agent engine preference
  Line 49: - [ ] Test routing for different task types

### ./TaskNotes/Tasks/Story/ArkClaw-005-update-agent-configurations.md
  Line 47: - [ ] Add llm_engine field to all agent configs
  Line 48: - [ ] Set appropriate engine per agent
  Line 49: - [ ] Test config loading
  Line 50: - [ ] Update agent template for new agents

### ./TaskNotes/Tasks/Story/ArkClaw-006-update-documentation-and-types.md
  Line 46: - [ ] Update AGENTS.md with Opencode info
  Line 47: - [ ] Update README.md architecture
  Line 48: - [ ] Add llm_engine to TypeScript types
  Line 49: - [ ] Create migration guide
  Line 50: - [ ] Update TinyClaw Obsidian docs

### ./TaskNotes/Tasks/Story/ArkSignal-034-tft-live-inference-pipeline.md
  Line 91: - [ ] Create `predictions.tft_forecasts` table on CT120 (PostgreSQL)
  Line 92: - [ ] Build TFT inference script for production (`scripts/inference/tft_hourly_forecast.py`)
  Line 96: - [ ] Set up hourly cron on CT110 (`/etc/cron.d/tft-forecast`)
  Line 97: - [ ] Update CT100 inference service to read `tft_forecast` from DB
  Line 100: - [ ] Add monitoring: forecast freshness alert if no new forecast in 2+ hours
  Line 101: - [ ] Add TFT forecast to Grafana dashboard (CT120)
  Line 102: - [ ] End-to-end test: paper trading with live TFT forecasts

### ./TaskNotes/Tasks/Story/ArkSignal-035-benchmark-obsidian-skills.md
  Line 21: - [ ] Define benchmark metrics
  Line 22: - [ ] Run benchmarks against vault operations
  Line 23: - [ ] Document results

### ./TaskNotes/Tasks/Story/Infra-004-remove-jt-indicator-monitoring.md
  Line 24: - [ ] Identify all JT indicator monitoring code in dashboard
  Line 25: - [ ] Remove JT signal data sources
  Line 26: - [ ] Remove JT indicator UI components
  Line 27: - [ ] Update dashboard configuration
  Line 28: - [ ] Clean up JT-related database tables/collections if any
  Line 29: - [ ] Test dashboard loads correctly without JT data

### ./TaskNotes/Tasks/Story/Infra-005-create-ohlcv-health-monitor.md
  Line 31: - [ ] Design health check queries
  Line 32: - [ ] Create status indicators (green: <5min delay, yellow: 5-15min, red: >15min)
  Line 33: - [ ] Add to Health page dashboard
  Line 34: - [ ] Configure alerts for critical issues
  Line 35: - [ ] Test with historical gap scenarios

### ./TaskNotes/Tasks/Story/Infra-006-create-futures-data-monitor.md
  Line 31: - [ ] Design futures data health checks
  Line 32: - [ ] Create status indicators for funding rate recency
  Line 33: - [ ] Add contract expiration warnings
  Line 34: - [ ] Integrate into Health page
  Line 35: - [ ] Set up alerts for funding rate anomalies

### ./TaskNotes/Tasks/Story/Infra-007-create-inference-api-health-monitor.md
  Line 31: - [ ] Add latency tracking middleware
  Line 32: - [ ] Create error rate dashboards
  Line 33: - [ ] Design status indicators (green: <100ms, yellow: 100-500ms, red: >500ms)
  Line 34: - [ ] Add to Health page with real-time metrics
  Line 35: - [ ] Configure alerts for high error rates

### ./TaskNotes/Tasks/Story/Infra-008-create-position-manager-monitor.md
  Line 31: - [ ] Query position database for current state
  Line 32: - [ ] Create position status summary
  Line 33: - [ ] Add execution success rate metrics
  Line 34: - [ ] Design status indicators for trading health
  Line 35: - [ ] Integrate into Health page

### ./TaskNotes/Tasks/Story/Infra-009-transform-ml-to-health-page.md
  Line 39: - [ ] Design Health page layout
  Line 40: - [ ] Create status indicator components
  Line 41: - [ ] Implement service grid
  Line 42: - [ ] Add auto-refresh functionality
  Line 43: - [ ] Create drill-down detail views
  Line 44: - [ ] Style with clear visual hierarchy

### ./TaskNotes/Tasks/Story/Infra-010-create-infrastructure-health-monitor.md
  Line 36: - [ ] Create container status checks
  Line 37: - [ ] Monitor resource metrics
  Line 38: - [ ] Design infrastructure status dashboard
  Line 39: - [ ] Add to Health page
  Line 40: - [ ] Configure resource threshold alerts

### ./TaskNotes/Tasks/Story/Infra-011-audit-ct110-state.md
  Line 31: - [ ] Inference API (GPU-accelerated)
  Line 32: - [ ] OHLCV Service
  Line 33: - [ ] Unified Executor (paper trading mode)
  Line 34: - [ ] Monitor Dashboard (dev version)
  Line 35: - [ ] TinyClaw agents (dev mode)
  Line 36: - [ ] PostgreSQL connectivity
  Line 37: - [ ] MLflow connectivity
  Line 40: - [ ] Container status
  Line 41: - [ ] GPU availability (nvidia-smi)
  Line 42: - [ ] Disk space
  Line 43: - [ ] Network connectivity to CT100/CT120
  Line 44: - [ ] Bun/Node.js versions
  Line 52: - [ ] SSH into CT110
  Line 53: - [ ] Run service discovery commands
  Line 54: - [ ] Check systemd services
  Line 55: - [ ] Verify GPU status
  Line 56: - [ ] Test database connections
  Line 57: - [ ] Document findings

### ./TaskNotes/Tasks/Story/Infra-012-create-service-parity-checklist.md
  Line 27: - [ ] Inference API (port 8811)
  Line 28: - [ ] OHLCV Service (port 8812)
  Line 29: - [ ] Unified Executor (paper trading)
  Line 30: - [ ] Position Manager
  Line 33: - [ ] Monitor Dashboard (dev version, port 8766)
  Line 34: - [ ] MLflow tracking (CT120:5000)
  Line 35: - [ ] Grafana (CT120:3001)
  Line 38: - [ ] TinyClaw Discord service
  Line 39: - [ ] TinyClaw Heartbeat service
  Line 40: - [ ] TinyClaw Trading service
  Line 43: - [ ] PostgreSQL test DB connection (CT120:5434)
  Line 44: - [ ] OHLCV read-only connection (CT120:5435)
  Line 45: - [ ] GPU drivers and CUDA
  Line 46: - [ ] Bun runtime environment
  Line 55: - [ ] Document all CT100 services
  Line 56: - [ ] Create deployment checklist
  Line 57: - [ ] Define configuration templates
  Line 58: - [ ] Specify environment variables

### ./TaskNotes/Tasks/Story/Infra-013-implement-ct110-deployment-automation.md
  Line 46: - [ ] Create deployment scripts
  Line 47: - [ ] Set up configuration templates
  Line 48: - [ ] Implement health check verification
  Line 49: - [ ] Create rollback procedures
  Line 50: - [ ] Document deployment process

### ./TaskNotes/Tasks/Story/Infra-014-design-e2e-testing-framework.md
  Line 56: - [ ] Design test architecture
  Line 57: - [ ] Define test scenarios
  Line 58: - [ ] Create test data fixtures
  Line 59: - [ ] Plan validation criteria
  Line 60: - [ ] Design reporting format

### ./TaskNotes/Tasks/Story/Infra-015-implement-e2e-test-suite.md
  Line 26: - [ ] Test OHLCV data fetching
  Line 27: - [ ] Test feature computation
  Line 28: - [ ] Test data freshness validation
  Line 29: - [ ] Test error handling
  Line 32: - [ ] Test model loading
  Line 33: - [ ] Test API responses
  Line 34: - [ ] Test signal generation
  Line 35: - [ ] Test prediction quality
  Line 38: - [ ] Test signal processing
  Line 39: - [ ] Test position calculations
  Line 40: - [ ] Test paper trade execution
  Line 41: - [ ] Test P&L computation
  Line 44: - [ ] Test complete pipeline end-to-end
  Line 45: - [ ] Test concurrent operations
  Line 46: - [ ] Test error recovery
  Line 47: - [ ] Test performance under load
  Line 50: - [ ] Create test runner
  Line 51: - [ ] Implement individual tests
  Line 52: - [ ] Add test fixtures
  Line 53: - [ ] Create validation logic
  Line 54: - [ ] Generate test reports

### ./TaskNotes/Tasks/Story/Infra-016-create-deployment-validation-workflow.md
  Line 54: - [ ] Create workflow orchestrator
  Line 55: - [ ] Implement approval gates
  Line 56: - [ ] Add rollback automation
  Line 57: - [ ] Create monitoring dashboards
  Line 58: - [ ] Set up alerts
  Line 61: - [ ] Document workflow steps
  Line 62: - [ ] Create runbook
  Line 63: - [ ] Define rollback criteria
  Line 64: - [ ] Set up monitoring checklists

### ./TaskNotes/Tasks/Story/Infra-018-create-dev-user.md
  Line 46: - [ ] `ssh dev@192.168.68.110` works from MacBook
  Line 47: - [ ] `ssh -T git@github.com` works as dev user
  Line 48: - [ ] dev user in sudo and video groups

### ./TaskNotes/Tasks/Story/Infra-019-setup-git-worktree-workspaces.md
  Line 32: - [ ] `/home/dev/repo` contains full clone on `master`
  Line 33: - [ ] Submodules initialized
  Line 34: - [ ] venv created and requirements installed
  Line 35: - [ ] `wt ls` shows main repo
  Line 36: - [ ] `wt add test feat/test && wt rm test` works

### ./TaskNotes/Tasks/Story/Infra-020-configure-claude-code.md
  Line 31: - [ ] `claude --version` shows installed version
  Line 32: - [ ] Settings.json exists with correct config
  Line 33: - [ ] Claude Code authenticated (OAuth complete)
  Line 34: - [ ] `claude --dangerously-skip-permissions` starts successfully

### ./TaskNotes/Tasks/Story/Infra-021-configure-shell-tmux-env.md
  Line 35: - [ ] SSH login shows custom prompt with git branch
  Line 36: - [ ] `tc` creates/attaches tmux session
  Line 37: - [ ] All aliases functional
  Line 38: - [ ] Environment variables loaded from `/etc/trading-signal-ai.env`

### ./TaskNotes/Tasks/Story/Infra-022-e2e-verification.md
  Line 36: - [ ] All verification checks pass
  Line 37: - [ ] `verify-env` script created at `/home/dev/bin/verify-env`
  Line 38: - [ ] Results documented

### ./TaskNotes/Tasks/Story/Infra-024-install-grafana-infinity-plugin.md
  Line 27: - [ ] Infinity plugin installed and visible in Grafana datasource list
  Line 28: - [ ] Test datasource configured that polls a known `/health` endpoint (e.g., CT100:8811/health)
  Line 29: - [ ] Verify JSON response parsing works correctly in a test panel

### ./TaskNotes/Tasks/Story/Infra-025-add-health-endpoints.md
  Line 54: - [ ] HL Account API responds to `/health` with JSON status
  Line 55: - [ ] Ops API responds to `/health` with JSON status
  Line 56: - [ ] Ops API exposes systemd timer/service status for Unified Executor and TinyClaw
  Line 57: - [ ] CT110 GPU metrics accessible via HTTP (utilization, VRAM, temp)
  Line 58: - [ ] All endpoints return structured JSON suitable for Grafana Infinity parsing

### ./TaskNotes/Tasks/Story/Infra-026-grafana-service-health-dashboard.md
  Line 63: - [ ] Dashboard shows all services across 3 containers
  Line 64: - [ ] Color-coded health: green (healthy), red (down), yellow (degraded)
  Line 65: - [ ] Auto-refresh every 30 seconds
  Line 66: - [ ] GPU metrics visible when CT110 has active workloads
  Line 67: - [ ] Dashboard accessible at CT120:3001

### ./TaskNotes/Tasks/Story/Infra-027-grafana-pipeline-topology-dashboard.md
  Line 71: - [ ] Canvas panel renders full pipeline topology
  Line 72: - [ ] Nodes color-coded by live health status (green/yellow/red)
  Line 73: - [ ] Data flow arrows show direction of data movement
  Line 74: - [ ] Container grouping visible (CT100, CT110, CT120)
  Line 75: - [ ] Clicking a node drills into relevant metrics/logs

### ./TaskNotes/Tasks/Story/Infra-028-install-prefect-server.md
  Line 74: - [ ] Prefect server running as systemd service on CT120
  Line 75: - [ ] Prefect UI accessible at http://192.168.68.120:4200
  Line 76: - [ ] PostgreSQL backend configured and connected
  Line 77: - [ ] `gpu-training` work pool created
  Line 78: - [ ] Server survives reboot (systemd enabled)

### ./TaskNotes/Tasks/Story/Infra-029-prefect-worker-ct110.md
  Line 61: - [ ] Prefect worker running as systemd service on CT110
  Line 62: - [ ] Worker appears in Prefect UI under `gpu-training` work pool
  Line 63: - [ ] Worker is idle (not executing any flows) until triggered
  Line 64: - [ ] No impact on existing GPU training workloads
  Line 65: - [ ] Worker survives reboot (systemd enabled)

### ./TaskNotes/Tasks/Story/Infra-030-prefect-monthly-retraining-flow.md
  Line 62: - [ ] Prefect flow registered and visible in UI
  Line 63: - [ ] Each pipeline step is a separate Prefect task with logging
  Line 64: - [ ] AUC gap validation fails the flow if thresholds exceeded
  Line 65: - [ ] Deployment step copies models to CT100 and restarts inference
  Line 66: - [ ] Monthly schedule configured in Prefect
  Line 67: - [ ] Flow tested end-to-end (after current TFT training completes)

### ./TaskNotes/Tasks/Story/Infra-031-prefect-quarterly-tft-flow.md
  Line 64: - [ ] Prefect flow registered with per-fold task tracking
  Line 65: - [ ] Each TFT fold shows progress in Prefect UI
  Line 66: - [ ] Flow handles fold failures gracefully (retry or skip + alert)
  Line 67: - [ ] Rolling forecast merge and timestamp fix automated
  Line 68: - [ ] A/B validation step compares TFT vs NoTFT Sharpe
  Line 69: - [ ] Quarterly schedule configured (with manual trigger option)
  Line 70: - [ ] Deployment to TFT Forecast Service (CT110:8813) on success

### ./TaskNotes/Tasks/Story/Infra-032-prefect-walkforward-flow.md
  Line 63: - [ ] Walk-forward flow registered in Prefect
  Line 64: - [ ] Per-strategy results visible as separate tasks
  Line 65: - [ ] Comparison report generated automatically
  Line 66: - [ ] Monthly retraining schedule active
  Line 67: - [ ] Quarterly TFT schedule active
  Line 68: - [ ] Walk-forward can be triggered manually or as post-retraining step

### ./TaskNotes/Tasks/Story/Infra-033-grafana-prefect-integration.md
  Line 62: - [ ] Grafana shows recent Prefect flow runs in a table
  Line 63: - [ ] Flow status color-coded (green=completed, red=failed, blue=running)
  Line 64: - [ ] Stat panels show days since last successful monthly/quarterly run
  Line 65: - [ ] Alerts configured for failed or overdue flows
  Line 66: - [ ] Pipeline topology dashboard integrates Prefect status into training nodes

### ./TaskNotes/Tasks/Story/Infra-034-e2e-verification-cross-linking.md
  Line 28: - [ ] All CT100 services show correct UP/DOWN status
  Line 29: - [ ] All CT110 services show correct status + GPU metrics
  Line 30: - [ ] All CT120 services show correct status
  Line 31: - [ ] Intentionally stop a service -> verify dashboard goes red within 60s
  Line 32: - [ ] Auto-refresh working (30s interval)
  Line 35: - [ ] Canvas panel renders full pipeline diagram
  Line 36: - [ ] Nodes colored by live health status
  Line 37: - [ ] Data flow arrows correctly show direction
  Line 38: - [ ] Clicking nodes navigates to relevant detail panels
  Line 41: - [ ] All 3 flows registered (monthly retrain, quarterly TFT, walk-forward)
  Line 42: - [ ] Work pool `gpu-training` shows CT110 worker connected
  Line 43: - [ ] Monthly and quarterly schedules visible
  Line 44: - [ ] Trigger a test walk-forward flow -> verify execution tracked end-to-end
  Line 45: - [ ] Flow results visible in both Prefect UI and Grafana
  Line 48: - [ ] Grafana "Pipeline Runs" panel links to Prefect UI flow run detail
  Line 49: - [ ] Grafana topology training nodes link to Prefect flow history
  Line 50: - [ ] Monitor Dashboard (CT100:8766) has link to Grafana infrastructure view
  Line 51: - [ ] Grafana has link to Monitor Dashboard for trading detail
  Line 62: - [ ] All verification checks pass
  Line 63: - [ ] Cross-links working bidirectionally
  Line 64: - [ ] Three dashboards serve distinct, complementary purposes
  Line 65: - [ ] Documentation updated with dashboard URLs and access instructions

### ./TaskNotes/Tasks/Task/ArkSignal-035-benchmark-obsidian-skills.md
  Line 26: - [ ] Benchmarking complete

### ./TaskNotes/Templates/Task-Template.md
  Line 26: - [ ]

### ./Trading-Signal-AI/Models/Per-Strategy-Paper-Trading.md
  Line 214: - [ ] All 5 strategies producing paper trades within 2 hours of deployment
  Line 215: - [ ] V1 paper trading unaffected (no regression)
  Line 216: - [ ] Per-strategy paper Sharpe within 50% of backtest Sharpe
  Line 217: - [ ] No strategy exceeding -30% paper drawdown
  Line 218: - [ ] TFT forecasts refreshing every 30 minutes on CT110
  Line 280: - [ ] All 5 strategies producing paper trades within 2 hours of restart
  Line 281: - [ ] V1 paper trading unaffected (no regression)
  Line 282: - [ ] Per-strategy paper Sharpe within 50% of backtest Sharpe
  Line 283: - [ ] No strategy exceeding -30% paper drawdown

### ./Trading-Signal-AI/Research/Benchmark-Analysis-Baseline.md
  Line 55: - [ ] Run initial benchmark suite
  Line 56: - [ ] Compare against Session-274 baselines
  Line 57: - [ ] Document findings in follow-up session

### ./Trading-Signal-AI/Session-Logs/Session-204.md
  Line 55: - [ ] Investigate if model retraining with asymmetric labels could improve further

### ./Trading-Signal-AI/Session-Logs/Session-205.md
  Line 47: - [ ] Consider futures data for longer-horizon strategies in future research

### ./Trading-Signal-AI/Session-Logs/Session-225.md
  Line 39: - [ ] Merge `feature/futures-feature-integration` to master
  Line 40: - [ ] Deploy to CT100/CT110
  Line 41: - [ ] Monitor D_fixed_exit live performance

### ./Trading-Signal-AI/Session-Logs/Session-226.md
  Line 41: - [ ] Monitor 24-48h of inline prediction execution on CT100
  Line 42: - [ ] Verify consistent 5-bar holds in paper trading logs
  Line 43: - [ ] Merge `improve/trading-pipeline` to master after validation
  Line 44: - [ ] Remove standalone `hl-prediction-generator` timer unit from CT100

### ./Trading-Signal-AI/Session-Logs/Session-227.md
  Line 51: - [ ] Monitor full 30-epoch training on CT110 (currently at Epoch 1).
  Line 52: - [ ] Evaluate final model performance (Win Rate, Sharpe) via backtest.
  Line 53: - [ ] Deploy to CT100 for paper trading if Sharpe > 1.5.

### ./Trading-Signal-AI/Session-Logs/Session-243.md
  Line 146: - [ ] Deploy retrained models to CT100 for production inference
  Line 147: - [ ] Monitor live paper trading with new models
  Line 148: - [ ] Add 2026 fold to TFT rolling forecasts for next XGBoost retrain cycle
  Line 149: - [ ] Consider VectorBT integration for portfolio-level backtesting

### ./Trading-Signal-AI/Session-Logs/Session-244.md
  Line 137: - [ ] Drop losing strategies from paper trading (keep blended_momentum_mr, maybe donchian_breakout)
  Line 138: - [ ] Investigate whether simpler fixed-exit approaches outperform the ML-filtered pipeline
  Line 139: - [ ] Consider alternative ML targets (e.g., regime classification instead of per-trade prediction)
  Line 140: - [ ] Run walk-forward on ALL tickers to see if the edge changes with broader universe

### ./Trading-Signal-AI/Session-Logs/Session-245.md
  Line 351: - [ ] Build composite regime+condition filter (e.g., RALLY + NEAR_HIGHS + BTC_UP) for top strategies
  Line 352: - [ ] Fix `volatility_change > 0` bug in `strategy_router.py` and `strategy_v2_adapter.py` (should be `> 1.0`)
  Line 353: - [ ] Drop ema_crossover and triple_indicator from the strategy roster -- negative across all OOS conditions
  Line 354: - [ ] Test multi-condition stacking: does RALLY + BTC_UP compound the edge or just reduce trade count?
  Line 355: - [ ] Compare regime filter vs XGBoost filter: both flip strategies positive, but regime is simpler and more interpretable

### ./Trading-Signal-AI/Session-Logs/Session-246.md
  Line 213: - [ ] Monitor paper trading performance for 2-4 weeks under current 2x/5% config
  Line 214: - [ ] Compare live Sharpe/DD to OOS sweep predictions
  Line 215: - [ ] If paper confirms, deploy half-Kelly (1.5x/10%) to paper first
  Line 216: - [ ] Consider extending grid to 5x/15% to find true Kelly maximum
  Line 217: - [ ] Add `exit_time` column to OOS trade CSVs to enable concurrent position tracking in the sweep

### ./Trading-Signal-AI/Session-Logs/Session-247.md
  Line 207: - [ ] Review per-fold breakdown for the 4 TFT winners (is improvement consistent across 2023/2024/2025?)
  Line 208: - [ ] Check TFT ticker coverage gap -- SHIB, TRX, TON, MATIC missing from TFT forecasts
  Line 209: - [ ] Decide which strategies to deploy with TFT
  Line 210: - [ ] Deploy validated strategies + update TFT service to fold_2026 checkpoint
  Line 211: - [ ] Re-run backfill script with TFT-integrated models
  Line 212: - [ ] Restart production services + verify health endpoints

### ./Trading-Signal-AI/Session-Logs/Session-248.md
  Line 477: - [ ] Deploy all 5 strategies to paper trading (4 existing + triple_indicator short)

### ./Trading-Signal-AI/Session-Logs/Session-249.md
  Line 174: - [ ] Deploy all 5 strategies to paper trading (carried from Session-248)
  Line 175: - [ ] Monitor LINK-USD in paper trading as weakest candidate
  Line 176: - [ ] Re-evaluate per-ticker performance after 30 days of paper trading with real trade counts

### ./Trading-Signal-AI/Session-Logs/Session-250.md
  Line 223: - [ ] Investigate macd_rsi Dec-Feb deterioration -- is the condition filter (RALLY + NEAR_HIGHS) still appropriate?
  Line 224: - [ ] Consider threshold increase for macd_rsi: 0.55 -> 0.60
  Line 225: - [ ] Loosen donchian_breakout condition filter or remove from deployed set
  Line 226: - [ ] Implement automated monthly retraining cron on CT110
  Line 227: - [ ] Re-run backfill dry-run with decay-retrained models to compare against previous backfill
  Line 228: - [ ] Paper trading deployment for mean_reversion (Tier A) with decay-retrained models

### ./Trading-Signal-AI/Session-Logs/Session-251.md
  Line 394: - [ ] Apply final config to `strategies.yaml`:
  Line 395:   - [ ] Flip Donchian to `short_only`, remove condition filter
  Line 396:   - [ ] Flip MACD+RSI to `short_only`, remove condition filter
  Line 397:   - [ ] Add TSMOM as `long_only`, no condition filter, paper enabled
  Line 398:   - [ ] Enable EMA Cross paper trading
  Line 399:   - [ ] Disable Triple Indicator paper trading
  Line 400: - [ ] **Keep** Mean Rev current config (deep-dive reversed S251 recommendation)
  Line 401: - [ ] **Keep** EMA Cross as `both` (deep-dive reversed S251 recommendation)
  Line 402: - [ ] Implement BTC_OS kill switch as portfolio-level safeguard
  Line 403: - [ ] Monitor equal-weight top-4 portfolio (Donchian, MACD+RSI, Mean Rev, TSMOM) in paper trading

### ./Trading-Signal-AI/Session-Logs/Session-252.md
  Line 300: - [ ] Wait for Run 2 TFT training to complete (~Mar 1-2)
  Line 301: - [ ] Run S252c: Monthly walk-forward with 50-ticker quarterly TFT on all deployed tickers
  Line 302: - [ ] If S252c confirms S252b: Deploy TFT to production inference pipeline on CT100
  Line 303: - [ ] Re-evaluate REVISED_CONFIGS with TFT included (optimal direction/condition filters may change)
  Line 304: - [ ] Fix `tft_forecasts_rolling.parquet` timestamp issue (integer time_idx instead of datetime)

### ./Trading-Signal-AI/Session-Logs/Session-253.md
  Line 162: - [ ] Monitor `nimble-dragon` TFT training to completion (~2.5-5 days, estimated Mar 1-2)
  Line 163: - [ ] Check TFT fold results as each fold completes
  Line 164: - [ ] After training: verify A/B test runs automatically (deploy=True, run_ab_test=True)
  Line 165: - [ ] Validate stitched `tft_forecasts_rolling.parquet` has proper datetime timestamps
  Line 166: - [ ] Merge `feat/workflow-visualization` branch to master after training validates
  Line 167: - [ ] Document Prefect + Grafana infrastructure in vault (this session's documentation task)

### ./Trading-Signal-AI/Session-Logs/Session-254.md
  Line 278: - [ ] Implement per-strategy TFT opt-in in Prefect pipeline (TFT for mean_rev/macd_rsi/donchian/9ema/ema_cross, skip for tsmom/triple_ind/blended)
  Line 279: - [ ] Ensure Prefect A/B test always uses `--condition-filter` to match production behavior
  Line 280: - [ ] Test hypothesis: original 13-ticker TFT model produces better forecasts than 54-ticker quarterly model (run S252b setup with quarterly forecasts on 13 tickers)

### ./Trading-Signal-AI/Session-Logs/Session-255.md
  Line 154: - [ ] Deploy to CT100 and verify inference service picks up new tickers
  Line 155: - [ ] Monitor first 24h of ema_crossover paper signals
  Line 156: - [ ] Verify CT110 TFT service is accessible for ema_crossover tickers
  Line 160: - [ ] Deploy updated `strategies.yaml` to CT100 via Prefect or manual sync
  Line 161: - [ ] Confirm TFT service on CT110 is running and responding for all 20 ema_crossover tickers
  Line 162: - [ ] Implement per-strategy TFT opt-out in inference API (to protect blended/tsmom from TFT noise)
  Line 163: - [ ] Monitor ema_crossover paper performance for 2 weeks -- disable if Sharpe < 0
  Line 164: - [ ] Re-evaluate Donchian after 1 month -- consider disabling if Sharpe stays near zero
  Line 165: - [ ] Ensure Prefect A/B test always applies `--condition-filter` to match production behavior

### ./Trading-Signal-AI/Session-Logs/Session-256.md
  Line 186: - [ ] Re-run Feb backfill **with TFT forecasts** (`--tft-forecasts`) for fair comparison against S254 baseline
  Line 187: - [ ] Investigate why metalabel models have no discriminative power (constant output ~44%)
  Line 188: - [ ] Consider removing metalabel gate entirely from the prediction pipeline if it can't be fixed
  Line 189: - [ ] Run longer backfill (Jan+Feb 2026) to get more data points for evaluation
  Line 190: - [ ] Evaluate whether condition filters need loosening for bearish markets (donchian had 0 trades)
  Line 191: - [ ] Monitor production trades on CT100 with updated configuration

### ./Trading-Signal-AI/Session-Logs/Session-259.md
  Line 301: - [ ] No regression in direction model AUC -- DirAUC 0.506-0.537 (lower than expected ~0.93, but these are per-strategy models, not the global model)
  Line 302: - [ ] Paper trading generates trades within 24-48h of deployment -- ==monitoring==

### ./Trading-Signal-AI/Session-Logs/Session-260.md
  Line 218: - [ ] Consider donchian_breakout too illiquid for reliable evaluation (25 trades across 7 months)
  Line 219: - [ ] Run portfolio-level simulation (`--portfolio`) to assess diversification across strategies

### ./Trading-Signal-AI/Session-Logs/Session-261.md
  Line 107: - [ ] Monitor tsmom + triple_indicator paper trades over next 24-48h
  Line 108: - [ ] Run portfolio-level simulation across the 5 active strategies
  Line 109: - [ ] Consider nine_ema_crossover re-evaluation if tsmom performs well

### ./Trading-Signal-AI/Session-Logs/Session-263.md
  Line 129: - [ ] Re-run Feb backfill with aligned model, compare vs S262 results (93 trades, Sharpe 1.12)
  Line 130: - [ ] Consider retraining other strategies with aligned pipeline (`--strategies mean_reversion` as sanity check)
  Line 131: - [ ] Monitor live paper trades for signal quality changes

### ./Trading-Signal-AI/Session-Logs/Session-265.md
  Line 192: - [ ] Re-optimize thresholds using backfill trades (single deployed model)
  Line 193: - [ ] Monitor live paper trades for signal quality with re-optimized thresholds

### ./Trading-Signal-AI/Session-Logs/Session-266.md
  Line 158: - [ ] Investigate the 39 BF-only trades -- are they from rolling features generating signals that `build_dataset()` misses, or from position constraint effects?
  Line 159: - [ ] Consider adding TFT forecasts to the backfill run for parity (currently WF has TFT, backfill doesn't)
  Line 160: - [ ] Profile the entry timing offset -- is it always exactly 1 bar, or variable? Could inform whether a simple shift correction is viable

### ./Trading-Signal-AI/Session-Logs/Session-267.md
  Line 264: - [ ] Consider horizon sensitivity test (horizon=12 vs 24) to understand the long/short flip
  Line 265: - [ ] Deploy Tier 1 strategies (macd_rsi, donchian_breakout, nine_ema_crossover) to CT100 production
  Line 266: - [ ] Enable paper trading for Tier 2 strategies (blended_momentum_mr, mean_reversion)
  Line 267: - [ ] Disable Tier 3 strategies (ema_crossover, tsmom, triple_indicator) in paper trading
  Line 268: - [ ] Monitor live performance vs WF expectations over 2-4 weeks

### ./Trading-Signal-AI/Session-Logs/Session-268.md
  Line 456: - [ ] Deploy monthly WF Feb 2026 decay model to CT100 production (backup existing first)
  Line 457: - [ ] Re-run backfill with new model to validate trade count increases
  Line 460: - [ ] Test dual-horizon on other strategies (e.g., `donchian_breakout`, `mean_reversion`) -- `macd_rsi` may be unique in having no long edge
  Line 461: - [ ] Consider training dedicated long models with h=5 labels (current models were all trained with h=24 labels, then tested long-only -- the models never learned short-horizon long patterns)
  Line 462: - [ ] Update e2e pipeline to align with S267/S268 changes (entry price mode, sub-bar barriers, condition filters)

### ./Trading-Signal-AI/Session-Logs/Session-269.md
  Line 359: - [ ] Run full WF with `--save-fold-models` to generate deployment-ready per-direction models
  Line 360: - [ ] Deploy per-direction models to CT100
  Line 361: - [ ] Paper trade backfill comparison: per-direction vs unified for Feb-Mar 2026
  Line 362: - [ ] Update deployed code on CT100 to match local Fallback 4
  Line 363: - [ ] Align `metalabel_threshold` between strategies.yaml and systemd env var
  Line 364: - [ ] Investigate Long model weakness -- consider `short_only` with per-direction as validation

### ./Trading-Signal-AI/Session-Logs/Session-270.md
  Line 266: - [ ] Implement per-strategy per-direction thresholds in `strategies.yaml`
  Line 267: - [ ] Implement confidence-ranked portfolio allocation in position manager
  Line 268: - [ ] Investigate strategy-specific feature sets for breakout strategies (donchian, ema)
  Line 269: - [ ] Deploy optimal configuration to CT100
  Line 270: - [ ] Run paper trade backfill comparison with new thresholds

### ./Trading-Signal-AI/Session-Logs/Session-271.md
  Line 178: - [ ] Engineer breakout-specific features in `ArkFeatureEngine` (channel_percentile, breakout_magnitude, vol_regime_change)
  Line 179: - [ ] Re-run S271 comparison with new breakout features
  Line 180: - [ ] Consider per-strategy feature importance analysis to find which features actively hurt each strategy
  Line 181: - [ ] Deploy S270 optimal thresholds to production (independent of S271 -- S270 findings still valid)

### ./Trading-Signal-AI/Session-Logs/Session-272.md
  Line 558: - [ ] Re-derive per-direction feature flags from v5-fixed baseline (current flags based on buggy v2-v7 data)
  Line 559: - [ ] Per-strategy feature importance analysis to prune features that hurt
  Line 560: - [ ] Re-run S270 threshold optimization with best model variant on fixed-dropna baseline

### ./Trading-Signal-AI/Session-Logs/Session-273.md
  Line 250: - [ ] **S274: Target engineering** -- soft targets for profitability models
  Line 251: - [ ] **S274: Per-strategy feature pruning** -- reduce noise features

### ./Trading-Signal-AI/Session-Logs/Session-274.md
  Line 161: - [ ] Deploy mean_reversion and donchian_breakout with optimal thresholds (0.05) to production
  Line 162: - [ ] Consider dropping ema_crossover (negative IC -- actively harmful)
  Line 163: - [ ] Evaluate `reg:pseudohubererror` as alternative loss function
  Line 164: - [ ] Focus on the 2 statistically significant strategies rather than optimizing the other 5

### ./Trading-Signal-AI/Session-Logs/Session-275.md
  Line 113: - [ ] Check MR no-condition-filter result (threshold=0.05 only) -- running on CT110
  Line 114: - [ ] If MR threshold-only > MR with filter, disable condition_filter for mean_reversion in strategies.yaml
  Line 115: - [ ] Deploy donchian_breakout + mean_reversion regressor models to CT100 production
  Line 116: - [ ] Consider per-direction condition filter support in walkforward script (Long and Short get different conditions)
  Line 117: - [ ] Update strategies.yaml comments with S275 references

### ./Trading-Signal-AI/Training/ArkTrain-Framework.md
  Line 157: - [ ] **LSTM**: Pending.

### ./Trading-Signal-AI/Training/TFT-Ensemble-Global.md
  Line 62: - [ ] Monitor MLflow for convergence.
  Line 63: - [ ] Evaluate final `val_loss`.
  Line 64: - [ ] Run backtest on test set (future data).
  Line 65: - [ ] If Sharpe > 1.5, deploy to Review-CT100-Execution.

### ./_Templates/Session-Template.md
  Line 31: - [ ] Follow-up task 1
  Line 32: - [ ] Follow-up task 2

---

## Done Tasks by File (count per file)

| File | Done Count |
|------|-----------|
| ./TaskNotes/Archive/Infra-001-migrate-notes.md | 3 |
| ./Trading-Signal-AI/Training/ArkTrain-Framework.md | 4 |
| ./Trading-Signal-AI/Training/E2E-Pipeline-Validation.md | 15 |
| ./Trading-Signal-AI/Session-Logs/Session-204.md | 2 |
| ./Trading-Signal-AI/Session-Logs/Session-205.md | 1 |
| ./Trading-Signal-AI/Session-Logs/Session-228.md | 4 |
| ./Trading-Signal-AI/Session-Logs/Session-230.md | 4 |
| ./Trading-Signal-AI/Session-Logs/Session-231.md | 4 |
| ./Trading-Signal-AI/Session-Logs/Session-248.md | 7 |
| ./Trading-Signal-AI/Session-Logs/Session-249.md | 2 |
| ./Trading-Signal-AI/Session-Logs/Session-251.md | 3 |
| ./Trading-Signal-AI/Session-Logs/Session-252.md | 1 |
| ./Trading-Signal-AI/Session-Logs/Session-254.md | 2 |
| ./Trading-Signal-AI/Session-Logs/Session-255.md | 3 |
| ./Trading-Signal-AI/Session-Logs/Session-257.md | 9 |
| ./Trading-Signal-AI/Session-Logs/Session-259.md | 4 |
| ./Trading-Signal-AI/Session-Logs/Session-260.md | 8 |
| ./Trading-Signal-AI/Session-Logs/Session-261.md | 6 |
| ./Trading-Signal-AI/Session-Logs/Session-262.md | 6 |
| ./Trading-Signal-AI/Session-Logs/Session-263.md | 7 |
| ./Trading-Signal-AI/Session-Logs/Session-265.md | 9 |
| ./Trading-Signal-AI/Session-Logs/Session-268.md | 5 |
| ./Trading-Signal-AI/Session-Logs/Session-269.md | 3 |
| ./Trading-Signal-AI/Session-Logs/Session-270.md | 3 |
| ./Trading-Signal-AI/Session-Logs/Session-271.md | 1 |
| ./Trading-Signal-AI/Session-Logs/Session-272.md | 11 |
| ./Trading-Signal-AI/Session-Logs/Session-273.md | 5 |
