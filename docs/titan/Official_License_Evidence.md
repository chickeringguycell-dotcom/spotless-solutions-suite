# Official License Evidence
**Date:** 2026-07-18

A physical verification of licensing restrictions impacting Project Titan.

| Candidate | Code License | Weight/Model Terms | Verdict |
| :--- | :--- | :--- | :--- |
| **3DDFA_V2** | MIT License | Unspecified | COMMERCIAL_USE_CONFIRMED |
| **DECA** | Non-Commercial | FLAME Database License (Research Only) | **LICENSE_BLOCKED** |
| **PRNet** | MIT License | BFM Dataset (Research Only) | **LICENSE_BLOCKED** |
| **PanoHead** | Nvidia Source Code License | FFHQ Dataset (CC-BY-NC-SA 4.0) | **LICENSE_BLOCKED** |
| **MediaPipe** | Apache 2.0 | Apache 2.0 | COMMERCIAL_USE_CONFIRMED |
| **InsightFace** | MIT License | AntelopeV2 / Buffalo (Non-Commercial) | **LICENSE_BLOCKED** |
| **InstantID** | Apache 2.0 | Dependent on InsightFace | **LICENSE_BLOCKED** |
| **TRELLIS** | Apache 2.0 | Apache 2.0 | COMMERCIAL_USE_CONFIRMED |

## Conclusion
Project Titan's commercial viability is severely threatened by the academic reliance on FLAME, BFM, and FFHQ datasets. Any tool deriving its geometry or weights from these datasets (DECA, PRNet, PanoHead, InsightFace) cannot be used in a commercial product. MediaPipe and 3DDFA_V2 remain the only commercially viable open-source options audited so far.
