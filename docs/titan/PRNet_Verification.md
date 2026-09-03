# PRNet Verification Report
**Date:** 2026-07-18
**Candidate:** PRNet

## Rule 33 Execution Log
- **Audit:** PRNet's official implementation relies on legacy TensorFlow 1.15.
- **Root Cause:** TF 1.15 is unsupported on modern Windows Python environments (Python 3.8+). Running it requires a legacy container, WSL, or an unofficial PyTorch translation which breaks the "Official Sources Only" rule.
- **Physical Evidence:** See `evidence/photo_skill_acquisition/PRNet_verified/logs/status.json`.
- **Status:** **DEPENDENCY_FAILED**

## Evaluation
PRNet theoretically provides UV position maps and dense correspondence, which are incredibly valuable for Titan. However, its framework age prevents autonomous physical verification on the current Windows host.

**Classification:** DEPENDENCY_FAILED
