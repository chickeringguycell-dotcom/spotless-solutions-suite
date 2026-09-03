# Titan Component License Matrix

## Phase 2 — License Separation

| Candidate | Source Code License | Model Weight License | Training Dataset Terms | Commercial Output | Required Action / Decision |
|:---|:---|:---|:---|:---|:---|
| **MediaPipe** | Apache 2.0 | Apache 2.0 | Proprietary (Google) | Allowed | None. Fully usable for commercial inference. |
| **InsightFace** | MIT | Non-Commercial | CelebA/MS1M (NC) | Blocked (if weights used) | Can use purely as an internal `RESEARCH_REFERENCE` metric, cannot distribute weights or use as a core dependency for commercial generation. |
| **3DDFA_V2** | MIT | Non-Commercial | 300W-LP (NC) | Blocked | `RESEARCH_REFERENCE` only. Reimplementation and retraining required for commercial use. |
| **IP-Adapter FaceID** | Apache 2.0 | Non-Commercial | Dep on InsightFace | Blocked | `RESEARCH_REFERENCE` only. |
| **PuLID** | Apache 2.0 | Non-Commercial (due to AntelopeV2) | Dep on InsightFace | Blocked | `RESEARCH_REFERENCE` only. |
| **InstantID** | Apache 2.0 | Non-Commercial | Dep on AntelopeV2 | Blocked | `RESEARCH_REFERENCE` only. |
| **PyTorch3D** | BSD | N/A | N/A | Allowed | Code is fully usable commercially. |
| **nvdiffrast** | NV Source Code | N/A | N/A | Allowed | Code is fully usable commercially. |

**Observation**: Almost all high-quality identity encoders (ArcFace, AntelopeV2) rely on non-commercial datasets. These models cannot be part of the final commercial stack. However, they **can** and **should** be used as temporary `RESEARCH_REFERENCES` to prove the rest of the architecture (e.g., cross-view consistency, geometry conditioning) works on GB001 before investing in training a clean commercial encoder.


## 🚨 FORENSIC CORRECTION (2026-07-20) 🚨
All previous claims regarding the successful execution of the 3DDFA_V2 + PuLID + SDXL composite pipeline are hereby REVOKED. Forensic auditing proves the environment 	itan_composite_official was never created, the composite inference script crashed silently, and no actual output images were ever generated. The pipeline remains strictly UNVERIFIED and INCOMPLETE.
