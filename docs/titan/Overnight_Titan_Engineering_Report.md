# Overnight Titan Engineering Report
**Date:** 2026-07-18
**Project:** Titan Photo-Generator Skill Acquisition

## Executive Summary
This overnight autonomous campaign executed a Rule 33 forensic audit of open-source 3D facial reconstruction systems to determine if they can solve Titan's missing ability to generate identity-consistent profile and three-quarter renders from a single photo.

**Result:** No single open-source candidate provides a commercially viable, out-of-the-box solution on Windows. Most are either strictly blocked by non-commercial dataset licenses (FLAME/BFM) or natively uncompilable due to legacy dependencies.

## Campaign Results
1. **3DDFA_V2:** DEPENDENCY_FAILED. Requires manual MSVC/Cython resolution. Commercially viable if fixed.
2. **DECA:** DEPENDENCY_FAILED & LICENSE_BLOCKED. Fails due to PyTorch3D Windows build issues. FLAME license prohibits commercial use.
3. **PRNet:** DEPENDENCY_FAILED & LICENSE_BLOCKED. Requires legacy TensorFlow 1.15. BFM license prohibits commercial use.
4. **PanoHead:** DEPENDENCY_FAILED & LICENSE_BLOCKED. Requires Ninja/CUDA custom ops that fail on Windows. FFHQ license restricts use.
5. **MediaPipe:** PARTIAL. Operates flawlessly. Provides 468 landmarks but lacks the volumetric depth required for true profile rendering. Commercially viable.
6. **Identity Engine Inventory:** InsightFace, InstantID, and IP-Adapter successfully inject identity in 2D space, but are blocked by the AntelopeV2 non-commercial license.
7. **Official License Evidence:** Confirmed that FLAME, BFM, and Buffalo datasets aggressively poison downstream commercial viability.
8. **Titan Missing Capability Map:** Documented the exact failure points of current tools to extract dense facial correspondence and rear-head geometry.
9. **GB001 Readiness:** FAILED. The physical GB001 files are missing from the local workspace.
10. **Titan Component Decision:** Reject DECA, PRNet, and PanoHead for commercial use. Re-evaluate Apache-licensed alternatives like TRELLIS coupled with MediaPipe.

## Evidence Artifacts
All raw execution logs, dependency states, and environment exports are physically preserved at:
`services/project-titan-3d/evidence/photo_skill_acquisition/`

## Recommended Next Command
```text
CMD FOR HAL

Proceed with Campaign 1 repair: Initialize a WSL2 or Docker abstraction environment to successfully compile 3DDFA_V2, as it remains the only commercially viable candidate capable of extracting dense landmarks.
```
