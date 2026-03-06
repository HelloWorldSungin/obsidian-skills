---
generated: 2026-03-06
sessions: 270-274
source: Trading-Signal-AI/Session-Logs
---

# Session Log Summary: Sessions 270-274

## Session 270 — Per-Direction Condition Filters, Threshold Optimization & Portfolio Ranking

- **Status:** complete
- **Date:** 2026-03-05
- **Tags:** per-direction-models, condition-filter, threshold-optimization, portfolio-ranking
- **Summary:** Discovered that condition filters must differ per direction (long vs short) due to opposite dynamics. Ran threshold sweeps for both directions across 8,464 OOS trades. Introduced confidence-ranked portfolio allocation with min thresholds. Evaluated all strategies with per-direction walk-forward backtests (6 help, 4 hurt, 6 no signal). Produced recommended per-strategy configuration.

## Session 271 — Strategy-Type-Specific Feature Sets for Per-Direction Models

- **Status:** complete
- **Date:** 2026-03-05
- **Tags:** per-direction-models, feature-engineering, strategy-specific-features
- **Summary:** Attempted strategy-type-specific feature sets (4 taxonomy types) for per-direction models, motivated by S270 findings. Implemented custom feature sets and code changes. Results showed it did not outperform the unified feature approach in correlation comparisons, though some Val AUC highlights were noted. Concluded that strategy-specific features alone were insufficient.

## Session 272 — New Engineered Features for Strategy-Specific Profitability Models

- **Status:** complete
- **Date:** 2026-03-05
- **Tags:** feature-engineering, per-direction-models, strategy-specific-features
- **Summary:** Large feature engineering session adding breakout (9), mean reversion (6), and momentum/crossover (4) features. Fixed a critical bug in `strategy_builder.py`. Ran 8 sub-experiments (v1-v8) iterating through direction-normalized features, breakout quality features, volume profile, multi-TF Donchian, and per-direction feature optimization. Identified optimal feature mix per strategy. v5 (direction-normalized) emerged as the current best baseline.

## Session 273 — Systematic Ablation to Re-derive Per-Direction Feature Flags

- **Status:** complete
- **Date:** 2026-03-05
- **Tags:** feature-engineering, per-direction-models, ablation
- **Summary:** Built systematic ablation infrastructure (new CLI flag `--ablation-combo`, orchestration shell script, analysis Python script). Ran two ablation rounds: one with condition filters and one unbiased (no filter, threshold=0). Produced new `_DIRECTION_FEATURE_FLAGS` from the unbiased correlation matrix. Validated new flags against baseline and cherry-picked refinements. Identified potential AUC improvements for further exploration.

## Session 274 — Direction Model Target Engineering (Binary to Soft Regression)

- **Status:** complete
- **Date:** 2026-03-06
- **Tags:** target-engineering, regressor, per-direction-models
- **Summary:** Shifted direction models from binary classification to soft regression targets. Modified 5 files with key design decisions around parallel backtest execution. Walk-forward backtest and post-hoc threshold sweep showed mixed results. Model accuracy matrix and per-fold IC trends were analyzed. A risk-adjusted target experiment (`pnl_pct / volatility`) failed. Confirmed S273 feature flags and assessed per-strategy feature pruning potential.
