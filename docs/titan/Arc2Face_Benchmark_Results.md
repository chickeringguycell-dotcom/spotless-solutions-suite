# Arc2Face Benchmark Results

## Phase 4, 5, 6 — Inference Ablation & Benchmark
**Status**: `BLOCKED`

### Reason for Block
The execution of the public smoke test, GB001 source test, and baseline ablation require the download and initialization of the `antelopev2` InsightFace model and the `Arc2Face` pretrained UNet. 

Per the forensic audit constraints:
1. Both `antelopev2` and `Arc2Face` pretrained weights are encumbered by strictly Non-Commercial / Research-Only licenses.
2. The operational directives prohibit copying, downloading, or redistributing restricted weights once their licensing and commercial viability are proven blocked.
3. Therefore, downloading the 5GB+ restricted models to execute the test would violate the commercial licensing block.

### Next Steps
The benchmark cannot be executed using Arc2Face's official weights for Titan. We must either:
- Evaluate a purely open-source commercially permissive identity encoder.
- Secure commercial licensing for InsightFace and retrain Arc2Face.
