# PhotoMaker V2 Benchmark Results

## Phase 4, 5, 6 — Inference Ablation & Benchmark
**Status**: `BLOCKED`

### Reason for Block
Execution of the public smoke test, GB001 source test, and baseline ablation require the download and runtime initialization of the InsightFace face-analysis package.

Per the forensic audit constraints:
1. The InsightFace dependency is encumbered by a strictly Non-Commercial / Research-Only license.
2. Operational directives explicitly prohibit copying, downloading, or redistributing restricted assets or continuing execution once a genuine licensing blocker is confirmed.
3. Because PhotoMaker V2 cannot function without executing the InsightFace code to extract the conditioning embedding, the benchmark is legally and operationally blocked.

### Next Steps
The benchmark cannot be executed using the official PhotoMaker pipeline for Titan. We must identify an identity generator that natively utilizes a commercially permissible visual encoder, or pivot to retraining an open-source architecture using AuraFace.
