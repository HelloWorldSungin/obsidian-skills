# Obsidian Vault Task Summary

**Vault:** /Users/sunginkim/GIT3/ArkNode-AI/vault
**Date:** 2026-03-06

---

## Commands Run

### 1. Incomplete tasks grouped by file (with line numbers)

**Command:**
```bash
obsidian vault="vault" tasks todo verbose
```

**Output (498 incomplete tasks across 68 files):**

```
_Templates/Session-Template.md
31	- [ ] Follow-up task 1
32	- [ ] Follow-up task 2

TaskNotes/Archive/ArkSignal-001-quanllm-research.md
28	- [ ] Review QuanLLM documentation and capabilities
29	- [ ] Assess relevance to current trading strategies
30	- [ ] Document findings

TaskNotes/Archive/ArkSignal-002-optimize-capital-allocation.md
28	- [ ] Set up vectorBT environment
29	- [ ] Create backtesting framework
30	- [ ] Run optimization for capital allocation
31	- [ ] Run optimization for leverage
32	- [ ] Document optimal parameters

TaskNotes/Archive/ArkSignal-003-fix-mlflow.md
28	- [ ] Identify MLflow issues
29	- [ ] Fix tracking problems
30	- [ ] Verify model logging works
31	- [ ] Test model registry

TaskNotes/Archive/ArkSignal-004-implement-market-condition-filters.md
45	- [ ] Add `condition_filters` config section to `strategies.yaml`
46	- [ ] Fetch indicators (`btc_rsi_14`, `volatility_change`, `adx_14`) from OHLCV service at execution time
47	- [ ] Implement gate checks in `position_manager.process_predictions()` before opening positions
48	- [ ] Test each gate individually with historical data
49	- [ ] Deploy to paper trading and validate performance
50	- [ ] Document filter behavior and thresholds

TaskNotes/Archive/ArkSignal-005-arksignal-backtest-framework.md
45	- [ ] All 6 sub-tasks completed
46	- [ ] Framework tested with ArkSignal-Strategy-v1
47	- [ ] Documentation complete
48	- [ ] 50+ existing scripts migrated

TaskNotes/Archive/ArkSignal-007-design-backtest-engine-architecture.md
50	- [ ] Define BacktestEngine interface
51	- [ ] Design strategy plugin system
52	- [ ] Create configuration schema
53	- [ ] Plan exit strategy abstraction
54	- [ ] Document architecture decisions

TaskNotes/Archive/ArkSignal-008-implement-data-pipeline.md
45	- [ ] Create unified data loader
46	- [ ] Implement feature computation pipeline
47	- [ ] Add signal preparation module
48	- [ ] Create data validation checks
49	- [ ] Optimize for large datasets

TaskNotes/Archive/ArkSignal-009-implement-distributed-execution.md
45	- [ ] Create job scheduler
46	- [ ] Implement GPU worker pool
47	- [ ] Add result aggregation
48	- [ ] Create progress monitoring
49	- [ ] Handle failures and retries

TaskNotes/Archive/ArkSignal-010-implement-unified-metrics.md
57	- [ ] Create unified metrics module
58	- [ ] Implement regime breakdown
59	- [ ] Add baseline comparison
60	- [ ] Generate standardized reports
61	- [ ] Export to MLflow

TaskNotes/Archive/ArkSignal-011-implement-rolling-validation.md
45	- [ ] Create rolling window generator
46	- [ ] Implement overfitting detection metrics
47	- [ ] Add threshold sweep functionality
48	- [ ] Create validation reports
49	- [ ] Integrate with MLflow tracking

TaskNotes/Archive/ArkSignal-012-migrate-existing-backtests.md
49	- [ ] Create migration guide
50	- [ ] Migrate ArkSignal v1 backtest
51	- [ ] Migrate ArkSignal v2 backtest
52	- [ ] Migrate XGBoost backtests
53	- [ ] Migrate Platt calibration backtests
54	- [ ] Migrate remaining backtests
55	- [ ] Archive old scripts

TaskNotes/Archive/Infra-002-dev-deployment-ct110.md
29	- [ ] Set up CT110 with same services as CT100
30	- [ ] Verify all components work correctly
31	- [ ] Create deployment validation tests
32	- [ ] Document deployment process

TaskNotes/TaskNotes-Configuration-Checklist.md
17	- [ ] Obsidian 1.10.1 or later installed
18	- [ ] TaskNotes plugin installed from Community Plugins
19	- [ ] Bases core plugin enabled
114	- [ ] **All-Tasks.base** - See all tasks in table format
115	- [ ] **Kanban-Status.base** - Visual kanban board
116	- [ ] **By-Project.base** - Tasks grouped by project
117	- [ ] **By-Component.base** - Tasks grouped by component
118	- [ ] **Critical-Blocking.base** - High priority tasks
119	- [ ] **This-Week.base** - Tasks scheduled for this week
135	- [ ] Is Bases plugin enabled?
136	- [ ] Do task files have `tags: [task]` in frontmatter?
137	- [ ] Is the task folder path correct in settings?
140	- [ ] Is TaskNotes plugin enabled?
141	- [ ] Check console for errors (Cmd/Ctrl + Shift + I)
144	- [ ] Open the `.base` file directly
145	- [ ] Check that query path matches your folder structure
146	- [ ] Try refreshing the view

TaskNotes/Tasks/Epic/ArkClaw-001-tinyclaw-opencode-integration.md
43	- [ ] All 4 sub-tasks completed
44	- [ ] Test both Opencode and Claude CLI modes
45	- [ ] Verify agent routing works correctly

TaskNotes/Tasks/Epic/ArkSignal-013-freqtrade-integration.md
263	- [ ] Freqtrade runs on CT100 with Hyperliquid exchange connection
264	- [ ] `ArkSignalStrategy` correctly reads predictions from inference API (`:8811`)
265	- [ ] Stoploss-on-exchange active for all open positions
266	- [ ] Telegram bot responds to `/status`, `/profit`, `/balance` commands
267	- [ ] Protection plugins halt trading after 3 consecutive stoplosses or 10% drawdown
268	- [ ] Parallel paper run shows ≤5% deviation from existing executor over 7 days
269	- [ ] Live cutover completed with rollback plan documented
270	- [ ] Monitor dashboard updated to read Freqtrade trade data

TaskNotes/Tasks/Epic/Infra-002-ct110-dev-deployment.md
48	- [ ] CT110 mirrors CT100 services
49	- [ ] E2E tests pass consistently
50	- [ ] Validation workflow documented
51	- [ ] Deploy to CT110 → Monitor → Deploy to CT100 process working

TaskNotes/Tasks/Epic/Infra-003-monitor-dashboard-transformation.md
53	- [ ] All 7 sub-tasks completed
54	- [ ] Health page displays real-time status indicators
55	- [ ] Alerts configured for critical failures
56	- [ ] Documentation updated

TaskNotes/Tasks/Epic/Infra-017-ct110-claude-code-dev-env.md
48	- [ ] `dev` user exists with SSH + GitHub access
49	- [ ] Git worktrees functional with `wt` helper
50	- [ ] Claude Code authenticated and configured
51	- [ ] Shell aliases and tmux configured for mobile
52	- [ ] E2E verification passes all checks

TaskNotes/Tasks/Epic/Infra-023-workflow-visualization-grafana-prefect.md
116	- [ ] Grafana Service Health dashboard shows all CT100/CT110/CT120 services
117	- [ ] Grafana Pipeline Topology shows data flow with live health colors
118	- [ ] Prefect UI shows registered flows (monthly retrain, quarterly TFT, walk-forward)
119	- [ ] Monthly retraining and quarterly TFT scheduled in Prefect
120	- [ ] Grafana displays Prefect flow run status and alerts on failure
121	- [ ] Three dashboards complement each other (Monitor → trades, Grafana → services, Prefect → pipelines)

TaskNotes/Tasks/Story/ArkClaw-003-add-opencode-provider-support.md
46	- [ ] Implement local opencode execution
47	- [ ] Implement remote SSH opencode execution
48	- [ ] Add error handling for opencode failures
49	- [ ] Test opencode command execution

TaskNotes/Tasks/Story/ArkClaw-004-implement-engine-selection-logic.md
46	- [ ] Implement task source detection
47	- [ ] Add engine selection logic
48	- [ ] Support per-agent engine preference
49	- [ ] Test routing for different task types

TaskNotes/Tasks/Story/ArkClaw-005-update-agent-configurations.md
47	- [ ] Add llm_engine field to all agent configs
48	- [ ] Set appropriate engine per agent
49	- [ ] Test config loading
50	- [ ] Update agent template for new agents

TaskNotes/Tasks/Story/ArkClaw-006-update-documentation-and-types.md
46	- [ ] Update AGENTS.md with Opencode info
47	- [ ] Update README.md architecture
48	- [ ] Add llm_engine to TypeScript types
49	- [ ] Create migration guide
50	- [ ] Update TinyClaw Obsidian docs

TaskNotes/Tasks/Story/ArkSignal-034-tft-live-inference-pipeline.md
91	- [ ] Create `predictions.tft_forecasts` table on CT120 (PostgreSQL)
92	- [ ] Build TFT inference script for production (`scripts/inference/tft_hourly_forecast.py`)
96	- [ ] Set up hourly cron on CT110 (`/etc/cron.d/tft-forecast`)
97	- [ ] Update CT100 inference service to read `tft_forecast` from DB
100	- [ ] Add monitoring: forecast freshness alert if no new forecast in 2+ hours
101	- [ ] Add TFT forecast to Grafana dashboard (CT120)
102	- [ ] End-to-end test: paper trading with live TFT forecasts

TaskNotes/Tasks/Story/ArkSignal-035-benchmark-obsidian-skills.md
21	- [ ] Define benchmark metrics
22	- [ ] Run benchmarks against vault operations
23	- [ ] Document results

TaskNotes/Tasks/Story/Infra-004-remove-jt-indicator-monitoring.md
24	- [ ] Identify all JT indicator monitoring code in dashboard
25	- [ ] Remove JT signal data sources
26	- [ ] Remove JT indicator UI components
27	- [ ] Update dashboard configuration
28	- [ ] Clean up JT-related database tables/collections if any
29	- [ ] Test dashboard loads correctly without JT data

TaskNotes/Tasks/Story/Infra-005-create-ohlcv-health-monitor.md
31	- [ ] Design health check queries
32	- [ ] Create status indicators (green: <5min delay, yellow: 5-15min, red: >15min)
33	- [ ] Add to Health page dashboard
34	- [ ] Configure alerts for critical issues
35	- [ ] Test with historical gap scenarios

TaskNotes/Tasks/Story/Infra-006-create-futures-data-monitor.md
31	- [ ] Design futures data health checks
32	- [ ] Create status indicators for funding rate recency
33	- [ ] Add contract expiration warnings
34	- [ ] Integrate into Health page
35	- [ ] Set up alerts for funding rate anomalies

TaskNotes/Tasks/Story/Infra-007-create-inference-api-health-monitor.md
31	- [ ] Add latency tracking middleware
32	- [ ] Create error rate dashboards
33	- [ ] Design status indicators (green: <100ms, yellow: 100-500ms, red: >500ms)
34	- [ ] Add to Health page with real-time metrics
35	- [ ] Configure alerts for high error rates

TaskNotes/Tasks/Story/Infra-008-create-position-manager-monitor.md
31	- [ ] Query position database for current state
32	- [ ] Create position status summary
33	- [ ] Add execution success rate metrics
34	- [ ] Design status indicators for trading health
35	- [ ] Integrate into Health page

TaskNotes/Tasks/Story/Infra-009-transform-ml-to-health-page.md
39	- [ ] Design Health page layout
40	- [ ] Create status indicator components
41	- [ ] Implement service grid
42	- [ ] Add auto-refresh functionality
43	- [ ] Create drill-down detail views
44	- [ ] Style with clear visual hierarchy

TaskNotes/Tasks/Story/Infra-010-create-infrastructure-health-monitor.md
36	- [ ] Create container status checks
37	- [ ] Monitor resource metrics
38	- [ ] Design infrastructure status dashboard
39	- [ ] Add to Health page
40	- [ ] Configure resource threshold alerts

TaskNotes/Tasks/Story/Infra-011-audit-ct110-state.md
31	- [ ] Inference API (GPU-accelerated)
32	- [ ] OHLCV Service
33	- [ ] Unified Executor (paper trading mode)
34	- [ ] Monitor Dashboard (dev version)
35	- [ ] TinyClaw agents (dev mode)
36	- [ ] PostgreSQL connectivity
37	- [ ] MLflow connectivity
40	- [ ] Container status
41	- [ ] GPU availability (nvidia-smi)
42	- [ ] Disk space
43	- [ ] Network connectivity to CT100/CT120
44	- [ ] Bun/Node.js versions
52	- [ ] SSH into CT110
53	- [ ] Run service discovery commands
54	- [ ] Check systemd services
55	- [ ] Verify GPU status
56	- [ ] Test database connections
57	- [ ] Document findings

TaskNotes/Tasks/Story/Infra-012-create-service-parity-checklist.md
27	- [ ] Inference API (port 8811)
28	- [ ] OHLCV Service (port 8812)
29	- [ ] Unified Executor (paper trading)
30	- [ ] Position Manager
33	- [ ] Monitor Dashboard (dev version, port 8766)
34	- [ ] MLflow tracking (CT120:5000)
35	- [ ] Grafana (CT120:3001)
38	- [ ] TinyClaw Discord service
39	- [ ] TinyClaw Heartbeat service
40	- [ ] TinyClaw Trading service
43	- [ ] PostgreSQL test DB connection (CT120:5434)
44	- [ ] OHLCV read-only connection (CT120:5435)
45	- [ ] GPU drivers and CUDA
46	- [ ] Bun runtime environment
55	- [ ] Document all CT100 services
56	- [ ] Create deployment checklist
57	- [ ] Define configuration templates
58	- [ ] Specify environment variables

TaskNotes/Tasks/Story/Infra-013-implement-ct110-deployment-automation.md
46	- [ ] Create deployment scripts
47	- [ ] Set up configuration templates
48	- [ ] Implement health check verification
49	- [ ] Create rollback procedures
50	- [ ] Document deployment process

TaskNotes/Tasks/Story/Infra-014-design-e2e-testing-framework.md
56	- [ ] Design test architecture
57	- [ ] Define test scenarios
58	- [ ] Create test data fixtures
59	- [ ] Plan validation criteria
60	- [ ] Design reporting format

TaskNotes/Tasks/Story/Infra-015-implement-e2e-test-suite.md
26	- [ ] Test OHLCV data fetching
27	- [ ] Test feature computation
28	- [ ] Test data freshness validation
29	- [ ] Test error handling
32	- [ ] Test model loading
33	- [ ] Test API responses
34	- [ ] Test signal generation
35	- [ ] Test prediction quality
38	- [ ] Test signal processing
39	- [ ] Test position calculations
40	- [ ] Test paper trade execution
41	- [ ] Test P&L computation
44	- [ ] Test complete pipeline end-to-end
45	- [ ] Test concurrent operations
46	- [ ] Test error recovery
47	- [ ] Test performance under load
50	- [ ] Create test runner
51	- [ ] Implement individual tests
52	- [ ] Add test fixtures
53	- [ ] Create validation logic
54	- [ ] Generate test reports

TaskNotes/Tasks/Story/Infra-016-create-deployment-validation-workflow.md
54	- [ ] Create workflow orchestrator
55	- [ ] Implement approval gates
56	- [ ] Add rollback automation
57	- [ ] Create monitoring dashboards
58	- [ ] Set up alerts
61	- [ ] Document workflow steps
62	- [ ] Create runbook
63	- [ ] Define rollback criteria
64	- [ ] Set up monitoring checklists

TaskNotes/Tasks/Story/Infra-018-create-dev-user.md
46	- [ ] `ssh dev@192.168.68.110` works from MacBook
47	- [ ] `ssh -T git@github.com` works as dev user
48	- [ ] dev user in sudo and video groups

TaskNotes/Tasks/Story/Infra-019-setup-git-worktree-workspaces.md
32	- [ ] `/home/dev/repo` contains full clone on `master`
33	- [ ] Submodules initialized
34	- [ ] venv created and requirements installed
35	- [ ] `wt ls` shows main repo
36	- [ ] `wt add test feat/test && wt rm test` works

TaskNotes/Tasks/Story/Infra-020-configure-claude-code.md
31	- [ ] `claude --version` shows installed version
32	- [ ] Settings.json exists with correct config
33	- [ ] Claude Code authenticated (OAuth complete)
34	- [ ] `claude --dangerously-skip-permissions` starts successfully

TaskNotes/Tasks/Story/Infra-021-configure-shell-tmux-env.md
35	- [ ] SSH login shows custom prompt with git branch
36	- [ ] `tc` creates/attaches tmux session
37	- [ ] All aliases functional
38	- [ ] Environment variables loaded from `/etc/trading-signal-ai.env`

TaskNotes/Tasks/Story/Infra-022-e2e-verification.md
36	- [ ] All verification checks pass
37	- [ ] `verify-env` script created at `/home/dev/bin/verify-env`
38	- [ ] Results documented

TaskNotes/Tasks/Story/Infra-024-install-grafana-infinity-plugin.md
27	- [ ] Infinity plugin installed and visible in Grafana datasource list
28	- [ ] Test datasource configured that polls a known `/health` endpoint (e.g., CT100:8811/health)
29	- [ ] Verify JSON response parsing works correctly in a test panel

TaskNotes/Tasks/Story/Infra-025-add-health-endpoints.md
54	- [ ] HL Account API responds to `/health` with JSON status
55	- [ ] Ops API responds to `/health` with JSON status
56	- [ ] Ops API exposes systemd timer/service status for Unified Executor and TinyClaw
57	- [ ] CT110 GPU metrics accessible via HTTP (utilization, VRAM, temp)
58	- [ ] All endpoints return structured JSON suitable for Grafana Infinity parsing

TaskNotes/Tasks/Story/Infra-026-grafana-service-health-dashboard.md
63	- [ ] Dashboard shows all services across 3 containers
64	- [ ] Color-coded health: green (healthy), red (down), yellow (degraded)
65	- [ ] Auto-refresh every 30 seconds
66	- [ ] GPU metrics visible when CT110 has active workloads
67	- [ ] Dashboard accessible at CT120:3001

TaskNotes/Tasks/Story/Infra-027-grafana-pipeline-topology-dashboard.md
71	- [ ] Canvas panel renders full pipeline topology
72	- [ ] Nodes color-coded by live health status (green/yellow/red)
73	- [ ] Data flow arrows show direction of data movement
74	- [ ] Container grouping visible (CT100, CT110, CT120)
75	- [ ] Clicking a node drills into relevant metrics/logs

TaskNotes/Tasks/Story/Infra-028-install-prefect-server.md
74	- [ ] Prefect server running as systemd service on CT120
75	- [ ] Prefect UI accessible at http://192.168.68.120:4200
76	- [ ] PostgreSQL backend configured and connected
77	- [ ] `gpu-training` work pool created
78	- [ ] Server survives reboot (systemd enabled)

TaskNotes/Tasks/Story/Infra-029-prefect-worker-ct110.md
61	- [ ] Prefect worker running as systemd service on CT110
62	- [ ] Worker appears in Prefect UI under `gpu-training` work pool
63	- [ ] Worker is idle (not executing any flows) until triggered
64	- [ ] No impact on existing GPU training workloads
65	- [ ] Worker survives reboot (systemd enabled)

TaskNotes/Tasks/Story/Infra-030-prefect-monthly-retraining-flow.md
62	- [ ] Prefect flow registered and visible in UI
63	- [ ] Each pipeline step is a separate Prefect task with logging
64	- [ ] AUC gap validation fails the flow if thresholds exceeded
65	- [ ] Deployment step copies models to CT100 and restarts inference
66	- [ ] Monthly schedule configured in Prefect
67	- [ ] Flow tested end-to-end (after current TFT training completes)

TaskNotes/Tasks/Story/Infra-031-prefect-quarterly-tft-flow.md
64	- [ ] Prefect flow registered with per-fold task tracking
65	- [ ] Each TFT fold shows progress in Prefect UI
66	- [ ] Flow handles fold failures gracefully (retry or skip + alert)
67	- [ ] Rolling forecast merge and timestamp fix automated
68	- [ ] A/B validation step compares TFT vs NoTFT Sharpe
69	- [ ] Quarterly schedule configured (with manual trigger option)
70	- [ ] Deployment to TFT Forecast Service (CT110:8813) on success

TaskNotes/Tasks/Story/Infra-032-prefect-walkforward-flow.md
63	- [ ] Walk-forward flow registered in Prefect
64	- [ ] Per-strategy results visible as separate tasks
65	- [ ] Comparison report generated automatically
66	- [ ] Monthly retraining schedule active
67	- [ ] Quarterly TFT schedule active
68	- [ ] Walk-forward can be triggered manually or as post-retraining step

TaskNotes/Tasks/Story/Infra-033-grafana-prefect-integration.md
62	- [ ] Grafana shows recent Prefect flow runs in a table
63	- [ ] Flow status color-coded (green=completed, red=failed, blue=running)
64	- [ ] Stat panels show days since last successful monthly/quarterly run
65	- [ ] Alerts configured for failed or overdue flows
66	- [ ] Pipeline topology dashboard integrates Prefect status into training nodes

TaskNotes/Tasks/Story/Infra-034-e2e-verification-cross-linking.md
28	- [ ] All CT100 services show correct UP/DOWN status
29	- [ ] All CT110 services show correct status + GPU metrics
30	- [ ] All CT120 services show correct status
31	- [ ] Intentionally stop a service → verify dashboard goes red within 60s
32	- [ ] Auto-refresh working (30s interval)
35	- [ ] Canvas panel renders full pipeline diagram
36	- [ ] Nodes colored by live health status
37	- [ ] Data flow arrows correctly show direction
38	- [ ] Clicking nodes navigates to relevant detail panels
41	- [ ] All 3 flows registered (monthly retrain, quarterly TFT, walk-forward)
42	- [ ] Work pool `gpu-training` shows CT110 worker connected
43	- [ ] Monthly and quarterly schedules visible
44	- [ ] Trigger a test walk-forward flow → verify execution tracked end-to-end
45	- [ ] Flow results visible in both Prefect UI and Grafana
48	- [ ] Grafana "Pipeline Runs" panel links to Prefect UI flow run detail
49	- [ ] Grafana topology training nodes link to Prefect flow history
50	- [ ] Monitor Dashboard (CT100:8766) has link to Grafana infrastructure view
51	- [ ] Grafana has link to Monitor Dashboard for trading detail
62	- [ ] All verification checks pass
63	- [ ] Cross-links working bidirectionally
64	- [ ] Three dashboards serve distinct, complementary purposes
65	- [ ] Documentation updated with dashboard URLs and access instructions

TaskNotes/Tasks/Task/ArkSignal-035-benchmark-obsidian-skills.md
26	- [ ] Benchmarking complete

TaskNotes/Templates/Task-Template.md
26	- [ ]

Trading-Signal-AI/Models/Per-Strategy-Paper-Trading.md
214	- [ ] All 5 strategies producing paper trades within 2 hours of deployment
215	- [ ] V1 paper trading unaffected (no regression)
216	- [ ] Per-strategy paper Sharpe within 50% of backtest Sharpe
217	- [ ] No strategy exceeding -30% paper drawdown
218	- [ ] TFT forecasts refreshing every 30 minutes on CT110
280	- [ ] All 5 strategies producing paper trades within 2 hours of restart
281	- [ ] V1 paper trading unaffected (no regression)
282	- [ ] Per-strategy paper Sharpe within 50% of backtest Sharpe
283	- [ ] No strategy exceeding -30% paper drawdown

Trading-Signal-AI/Research/Benchmark-Analysis-Baseline.md
55	- [ ] Run initial benchmark suite
56	- [ ] Compare against [[Session-274]] baselines
57	- [ ] Document findings in follow-up session

Trading-Signal-AI/Session-Logs/Session-204.md
55	- [ ] Investigate if model retraining with asymmetric labels could improve further

Trading-Signal-AI/Session-Logs/Session-205.md
47	- [ ] Consider futures data for longer-horizon strategies in future research

Trading-Signal-AI/Session-Logs/Session-225.md
39	- [ ] Merge `feature/futures-feature-integration` to master
40	- [ ] Deploy to CT100/CT110
41	- [ ] Monitor D_fixed_exit live performance

Trading-Signal-AI/Session-Logs/Session-226.md
41	- [ ] Monitor 24-48h of inline prediction execution on CT100
42	- [ ] Verify consistent 5-bar holds in paper trading logs
43	- [ ] Merge `improve/trading-pipeline` to master after validation
44	- [ ] Remove standalone `hl-prediction-generator` timer unit from CT100

Trading-Signal-AI/Session-Logs/Session-227.md
51	- [ ] Monitor full 30-epoch training on CT110 (currently at Epoch 1).
52	- [ ] Evaluate final model performance (Win Rate, Sharpe) via backtest.
53	- [ ] Deploy to CT100 for paper trading if Sharpe > 1.5.

Trading-Signal-AI/Session-Logs/Session-243.md
146	- [ ] Deploy retrained models to CT100 for production inference
147	- [ ] Monitor live paper trading with new models
148	- [ ] Add 2026 fold to TFT rolling forecasts for next XGBoost retrain cycle
149	- [ ] Consider VectorBT integration for portfolio-level backtesting

Trading-Signal-AI/Session-Logs/Session-244.md
137	- [ ] Drop losing strategies from paper trading (keep blended_momentum_mr, maybe donchian_breakout)
138	- [ ] Investigate whether simpler fixed-exit approaches outperform the ML-filtered pipeline
139	- [ ] Consider alternative ML targets (e.g., regime classification instead of per-trade prediction)
140	- [ ] Run walk-forward on ALL tickers to see if the edge changes with broader universe

Trading-Signal-AI/Session-Logs/Session-245.md
351	- [ ] Build composite regime+condition filter (e.g., RALLY + NEAR_HIGHS + BTC_UP) for top strategies
352	- [ ] Fix `volatility_change > 0` bug in `strategy_router.py` and `strategy_v2_adapter.py` (should be `> 1.0`)
353	- [ ] Drop ema_crossover and triple_indicator from the strategy roster — negative across all OOS conditions
354	- [ ] Test multi-condition stacking: does RALLY + BTC_UP compound the edge or just reduce trade count?
355	- [ ] Compare regime filter vs XGBoost filter: both flip strategies positive, but regime is simpler and more interpretable

Trading-Signal-AI/Session-Logs/Session-246.md
213	- [ ] Monitor paper trading performance for 2-4 weeks under current 2x/5% config
214	- [ ] Compare live Sharpe/DD to OOS sweep predictions
215	- [ ] If paper confirms, deploy half-Kelly (1.5x/10%) to paper first
216	- [ ] Consider extending grid to 5x/15% to find true Kelly maximum
217	- [ ] Add `exit_time` column to OOS trade CSVs to enable concurrent position tracking in the sweep

Trading-Signal-AI/Session-Logs/Session-247.md
207	- [ ] Review per-fold breakdown for the 4 TFT winners (is improvement consistent across 2023/2024/2025?)
208	- [ ] Check TFT ticker coverage gap — SHIB, TRX, TON, MATIC missing from TFT forecasts
209	- [ ] Decide which strategies to deploy with TFT
210	- [ ] Deploy validated strategies + update TFT service to fold_2026 checkpoint
211	- [ ] Re-run backfill script with TFT-integrated models
212	- [ ] Restart production services + verify health endpoints

Trading-Signal-AI/Session-Logs/Session-248.md
477	- [ ] Deploy all 5 strategies to paper trading (4 existing + triple_indicator short)

Trading-Signal-AI/Session-Logs/Session-249.md
174	- [ ] Deploy all 5 strategies to paper trading (carried from [[Session-248]])
175	- [ ] Monitor LINK-USD in paper trading as weakest candidate
176	- [ ] Re-evaluate per-ticker performance after 30 days of paper trading with real trade counts

Trading-Signal-AI/Session-Logs/Session-250.md
223	- [ ] Investigate macd_rsi Dec-Feb deterioration — is the condition filter (RALLY + NEAR_HIGHS) still appropriate?
224	- [ ] Consider threshold increase for macd_rsi: 0.55 → 0.60
225	- [ ] Loosen donchian_breakout condition filter or remove from deployed set
226	- [ ] Implement automated monthly retraining cron on CT110
227	- [ ] Re-run backfill dry-run with decay-retrained models to compare against previous backfill
228	- [ ] Paper trading deployment for mean_reversion (Tier A) with decay-retrained models

Trading-Signal-AI/Session-Logs/Session-251.md
394	- [ ] Apply final config to `strategies.yaml`:
395	- [ ] Flip Donchian to `short_only`, remove condition filter
396	- [ ] Flip MACD+RSI to `short_only`, remove condition filter
397	- [ ] Add TSMOM as `long_only`, no condition filter, paper enabled
398	- [ ] Enable EMA Cross paper trading
399	- [ ] Disable Triple Indicator paper trading
400	- [ ] **Keep** Mean Rev current config (deep-dive reversed S251 recommendation)
401	- [ ] **Keep** EMA Cross as `both` (deep-dive reversed S251 recommendation)
402	- [ ] Implement BTC_OS kill switch as portfolio-level safeguard
403	- [ ] Monitor equal-weight top-4 portfolio (Donchian, MACD+RSI, Mean Rev, TSMOM) in paper trading

Trading-Signal-AI/Session-Logs/Session-252.md
300	- [ ] Wait for Run 2 TFT training to complete (~Mar 1-2)
301	- [ ] Run S252c: Monthly walk-forward with 50-ticker quarterly TFT on all deployed tickers
302	- [ ] If S252c confirms S252b: Deploy TFT to production inference pipeline on CT100
303	- [ ] Re-evaluate REVISED_CONFIGS with TFT included (optimal direction/condition filters may change)
304	- [ ] Fix `tft_forecasts_rolling.parquet` timestamp issue (integer time_idx instead of datetime)

Trading-Signal-AI/Session-Logs/Session-253.md
162	- [ ] Monitor `nimble-dragon` TFT training to completion (~2.5-5 days, estimated Mar 1-2)
163	- [ ] Check TFT fold results as each fold completes
164	- [ ] After training: verify A/B test runs automatically (deploy=True, run_ab_test=True)
165	- [ ] Validate stitched `tft_forecasts_rolling.parquet` has proper datetime timestamps
166	- [ ] Merge `feat/workflow-visualization` branch to master after training validates
167	- [ ] Document Prefect + Grafana infrastructure in vault (this session's documentation task)

Trading-Signal-AI/Session-Logs/Session-254.md
278	- [ ] Implement per-strategy TFT opt-in in Prefect pipeline (TFT for mean_rev/macd_rsi/donchian/9ema/ema_cross, skip for tsmom/triple_ind/blended)
279	- [ ] Ensure Prefect A/B test always uses `--condition-filter` to match production behavior
280	- [ ] Test hypothesis: original 13-ticker TFT model produces better forecasts than 54-ticker quarterly model (run S252b setup with quarterly forecasts on 13 tickers)

Trading-Signal-AI/Session-Logs/Session-255.md
154	- [ ] Deploy to CT100 and verify inference service picks up new tickers
155	- [ ] Monitor first 24h of ema_crossover paper signals
156	- [ ] Verify CT110 TFT service is accessible for ema_crossover tickers
160	- [ ] Deploy updated `strategies.yaml` to CT100 via Prefect or manual sync
161	- [ ] Confirm TFT service on CT110 is running and responding for all 20 ema_crossover tickers
162	- [ ] Implement per-strategy TFT opt-out in inference API (to protect blended/tsmom from TFT noise)
163	- [ ] Monitor ema_crossover paper performance for 2 weeks — disable if Sharpe < 0
164	- [ ] Re-evaluate Donchian after 1 month — consider disabling if Sharpe stays near zero
165	- [ ] Ensure Prefect A/B test always applies `--condition-filter` to match production behavior

Trading-Signal-AI/Session-Logs/Session-256.md
186	- [ ] Re-run Feb backfill **with TFT forecasts** (`--tft-forecasts`) for fair comparison against S254 baseline
187	- [ ] Investigate why metalabel models have no discriminative power (constant output ~44%)
188	- [ ] Consider removing metalabel gate entirely from the prediction pipeline if it can't be fixed
189	- [ ] Run longer backfill (Jan+Feb 2026) to get more data points for evaluation
190	- [ ] Evaluate whether condition filters need loosening for bearish markets (donchian had 0 trades)
191	- [ ] Monitor production trades on CT100 with updated configuration

Trading-Signal-AI/Session-Logs/Session-259.md
301	- [ ] No regression in direction model AUC — DirAUC 0.506–0.537 (lower than expected ~0.93, but these are per-strategy models, not the global model)
302	- [ ] Paper trading generates trades within 24-48h of deployment — ==monitoring==

Trading-Signal-AI/Session-Logs/Session-260.md
218	- [ ] Consider donchian_breakout too illiquid for reliable evaluation (25 trades across 7 months)
219	- [ ] Run portfolio-level simulation (`--portfolio`) to assess diversification across strategies

Trading-Signal-AI/Session-Logs/Session-261.md
107	- [ ] Monitor tsmom + triple_indicator paper trades over next 24-48h
108	- [ ] Run portfolio-level simulation across the 5 active strategies
109	- [ ] Consider nine_ema_crossover re-evaluation if tsmom performs well

Trading-Signal-AI/Session-Logs/Session-263.md
129	- [ ] Re-run Feb backfill with aligned model, compare vs S262 results (93 trades, Sharpe 1.12)
130	- [ ] Consider retraining other strategies with aligned pipeline (`--strategies mean_reversion` as sanity check)
131	- [ ] Monitor live paper trades for signal quality changes

Trading-Signal-AI/Session-Logs/Session-265.md
192	- [ ] Re-optimize thresholds using backfill trades (single deployed model)
193	- [ ] Monitor live paper trades for signal quality with re-optimized thresholds

Trading-Signal-AI/Session-Logs/Session-266.md
158	- [ ] Investigate the 39 BF-only trades — are they from rolling features generating signals that `build_dataset()` misses, or from position constraint effects?
159	- [ ] Consider adding TFT forecasts to the backfill run for parity (currently WF has TFT, backfill doesn't)
160	- [ ] Profile the entry timing offset — is it always exactly 1 bar, or variable? Could inform whether a simple shift correction is viable

Trading-Signal-AI/Session-Logs/Session-267.md
264	- [ ] Consider horizon sensitivity test (horizon=12 vs 24) to understand the long/short flip
265	- [ ] Deploy Tier 1 strategies (macd_rsi, donchian_breakout, nine_ema_crossover) to CT100 production
266	- [ ] Enable paper trading for Tier 2 strategies (blended_momentum_mr, mean_reversion)
267	- [ ] Disable Tier 3 strategies (ema_crossover, tsmom, triple_indicator) in paper trading
268	- [ ] Monitor live performance vs WF expectations over 2-4 weeks

Trading-Signal-AI/Session-Logs/Session-268.md
456	- [ ] Deploy monthly WF Feb 2026 decay model to CT100 production (backup existing first)
457	- [ ] Re-run backfill with new model to validate trade count increases
460	- [ ] Test dual-horizon on other strategies (e.g., `donchian_breakout`, `mean_reversion`) — `macd_rsi` may be unique in having no long edge
461	- [ ] Consider training dedicated long models with h=5 labels (current models were all trained with h=24 labels, then tested long-only — the models never learned short-horizon long patterns)
462	- [ ] Update e2e pipeline to align with S267/S268 changes (entry price mode, sub-bar barriers, condition filters)

Trading-Signal-AI/Session-Logs/Session-269.md
359	- [ ] Run full WF with `--save-fold-models` to generate deployment-ready per-direction models
360	- [ ] Deploy per-direction models to CT100
361	- [ ] Paper trade backfill comparison: per-direction vs unified for Feb-Mar 2026
362	- [ ] Update deployed code on CT100 to match local Fallback 4
363	- [ ] Align `metalabel_threshold` between strategies.yaml and systemd env var
364	- [ ] Investigate Long model weakness — consider `short_only` with per-direction as validation

Trading-Signal-AI/Session-Logs/Session-270.md
266	- [ ] Implement per-strategy per-direction thresholds in `strategies.yaml`
267	- [ ] Implement confidence-ranked portfolio allocation in position manager
268	- [ ] Investigate strategy-specific feature sets for breakout strategies (donchian, ema)
269	- [ ] Deploy optimal configuration to CT100
270	- [ ] Run paper trade backfill comparison with new thresholds

Trading-Signal-AI/Session-Logs/Session-271.md
178	- [ ] Engineer breakout-specific features in `ArkFeatureEngine` (channel_percentile, breakout_magnitude, vol_regime_change)
179	- [ ] Re-run S271 comparison with new breakout features
180	- [ ] Consider per-strategy feature importance analysis to find which features actively hurt each strategy
181	- [ ] Deploy S270 optimal thresholds to production (independent of S271 — S270 findings still valid)

Trading-Signal-AI/Session-Logs/Session-272.md
558	- [ ] Re-derive per-direction feature flags from v5-fixed baseline (current flags based on buggy v2–v7 data)
559	- [ ] Per-strategy feature importance analysis to prune features that hurt
560	- [ ] Re-run S270 threshold optimization with best model variant on fixed-dropna baseline

Trading-Signal-AI/Session-Logs/Session-273.md
250	- [ ] **S274: Target engineering** — soft targets for profitability models
251	- [ ] **S274: Per-strategy feature pruning** — reduce noise features

Trading-Signal-AI/Session-Logs/Session-274.md
161	- [ ] Deploy mean_reversion and donchian_breakout with optimal thresholds (0.05) to production
162	- [ ] Consider dropping ema_crossover (negative IC — actively harmful)
163	- [ ] Evaluate `reg:pseudohubererror` as alternative loss function
164	- [ ] Focus on the 2 statistically significant strategies rather than optimizing the other 5

Trading-Signal-AI/Session-Logs/Session-275.md
113	- [ ] Check MR no-condition-filter result (threshold=0.05 only) — running on CT110 at `outputs/walkforward_regressor_optimized/`
114	- [ ] If MR threshold-only > MR with filter, disable condition_filter for mean_reversion in strategies.yaml
115	- [ ] Deploy donchian_breakout + mean_reversion regressor models to CT100 production
116	- [ ] Consider per-direction condition filter support in walkforward script (Long and Short get different conditions)
117	- [ ] Update strategies.yaml comments with S275 references

Trading-Signal-AI/Training/ArkTrain-Framework.md
157	- [ ] **LSTM**: Pending.

Trading-Signal-AI/Training/TFT-Ensemble-Global.md
62	- [ ] Monitor MLflow for convergence.
63	- [ ] Evaluate final `val_loss`.
64	- [ ] Run backtest on test set (future data).
65	- [ ] If Sharpe > 1.5, deploy to [[Review-CT100-Execution]].
```

---

### 2. Tasks in today's daily note (2026-03-06)

**Command:**
```bash
obsidian vault="vault" tasks daily total
```

**Output:**
```
0
```

There are **0 tasks** in today's daily note (2026-03-06.md).

---

### 3. Total count of all done tasks in the vault

**Command:**
```bash
obsidian vault="vault" tasks done total
```

**Output:**
```
131
```

There are **131 completed tasks** across the entire vault.

---

## Summary

| Metric | Count |
|--------|-------|
| Incomplete tasks (vault-wide) | 498 |
| Files containing incomplete tasks | 68 |
| Tasks in today's daily note (2026-03-06) | 0 |
| Completed tasks (vault-wide) | 131 |
