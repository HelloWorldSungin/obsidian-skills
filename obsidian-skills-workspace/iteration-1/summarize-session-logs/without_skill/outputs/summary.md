# Session Log Summary: Sessions 270-274

## Session 270 -- Per-Direction Condition Filters, Threshold Optimization & Portfolio Ranking
- **Date:** 2026-03-05
- **Status:** complete
- **Tags:** session-log, per-direction-models, condition-filter, threshold-optimization, portfolio-ranking, S270

**Summary:** Discovered that Long and Short trades respond oppositely to the same market conditions, meaning a single condition filter hurts one direction. The existing CHOPPY + BTC_FLAT filter helps Longs (Sharpe 0.34) but hurts Shorts (Sharpe -0.08). Ran per-direction walk-forward backtests across all 8 strategies and found the Short model has 23x better correlation with P&L than the old unified model. Optimal Short threshold is 0.52 (Sharpe 3.38); the Long model has no signal at any threshold. Designed a confidence-ranked portfolio allocation system using prof_prob. Produced per-strategy recommended thresholds (6 strategies benefit from the model, 4 are hurt by it, 6 show no signal).

---

## Session 271 -- Strategy-Type-Specific Feature Sets for Per-Direction Models
- **Date:** 2026-03-05
- **Status:** complete
- **Tags:** session-log, per-direction-models, feature-engineering, strategy-specific-features, S271

**Summary:** Tested whether grouping strategies into 4 types (crossover, breakout, mean reversion, momentum) with tailored feature sets would fix the inverted-correlation problem for breakout strategies. Implemented a strategy-type taxonomy with 37-44 features per type and a new `--feature-set auto` CLI flag. Results: the hypothesis was not confirmed. Donchian breakout Short improved only modestly (-0.124 to -0.098) and several crossover strategies regressed (e.g., nine_ema_crossover Short from +0.040 to -0.053). Concluded that rearranging existing features is insufficient -- new engineered features targeting breakout dynamics are needed.

---

## Session 272 -- New Engineered Features for Strategy-Specific Profitability Models
- **Date:** 2026-03-05
- **Status:** complete
- **Tags:** session-log, feature-engineering, per-direction-models, strategy-specific-features, S272

**Summary:** Engineered 29 new features across 8 experimental versions (v2-v8b). Key additions: 9 breakout features (donchian position, breakout magnitude, ATR expansion), 6 mean reversion features (bb_zscore, RSI distance, extreme duration), 4 momentum features, and 6 direction-normalized "extremity" features. Found and fixed two critical bugs: (1) strategy_builder.py was not extracting strategy-specific features into training data (affecting all S270/S271 results), and (2) df.dropna() in the feature engine was silently dropping different training rows per feature version, invalidating cross-version comparisons. Mean reversion flipped positive in both directions. Donchian breakout Short improved from -0.124 to -0.036 (v5 best). No single feature version wins across all strategies -- each strategy/direction combo has a different optimal feature set.

---

## Session 273 -- Systematic Ablation to Re-derive Per-Direction Feature Flags
- **Date:** 2026-03-05
- **Status:** complete
- **Tags:** session-log, feature-engineering, per-direction-models, ablation, S273

**Summary:** After the dropna bug fix invalidated the v2-v7 correlation matrix, performed a systematic 128-cell ablation study (8 feature combos x 8 strategies x 2 directions) to re-derive optimal per-direction feature flags. Key findings: volume/multi-TF features never win for any pair, breakout quality features are the most useful additive group (7/16 pairs), and 7/16 pairs do best with no additive features at all (base only). The new flags beat the baseline in 13/16 pairs (mean delta +0.012). After cherry-picking 3 pairs back to baseline and removing tsmom (horizon mismatch), final validation shows 10 wins and 6 losses. Donchian breakout Short reached +0.108 correlation -- the highest ever. Updated _DIRECTION_FEATURE_FLAGS in features.py.

---

## Session 274 -- Direction Model Target Engineering (Binary to Soft Regression)
- **Date:** 2026-03-06
- **Status:** complete
- **Tags:** session-log, target-engineering, regressor, per-direction-models, S274

**Summary:** Replaced binary XGBClassifier with XGBRegressor trained on winsorized pnl_pct, preserving return magnitude. Results: 5 of 7 strategies profitable at threshold=0. Mean reversion is the standout (Sharpe 3.10, 71% win rate, Calmar 1.70). Post-hoc threshold sweep shows optimal thresholds of 0.01-0.10, with mean reversion reaching Sharpe 6.76 at threshold 0.05. Only 2 strategies have statistically significant Spearman IC: mean_reversion (0.25, p<0.001) and donchian_breakout (0.06, p<0.003). A risk-adjusted target experiment (pnl/volatility) was tried and reverted -- it made MaxDD worse for 6/7 strategies. Identified that ema_crossover has negative IC and should likely be dropped.
