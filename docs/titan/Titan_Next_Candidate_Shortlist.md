# Titan Next Candidate Shortlist

## Phase 4 — Reassess the Shortlist

Reassessing candidates specifically against GB001 capabilities:

| Candidate | Functional Group | GB001 Capability Match | License |
|:---|:---|:---|:---|
| **PuLID** | A, G | Excellent identity preservation. Can be prompted for "profile view". | `RESEARCH_REFERENCE` (AntelopeV2 weights) |
| **IP-Adapter FaceID** | A, G | Good identity. Promptable views. | `RESEARCH_REFERENCE` (InsightFace weights) |
| **InstantID** | A, G | Excellent identity and facial structure. | `RESEARCH_REFERENCE` (AntelopeV2 weights) |
| **PanoHead** | B, D | True 3D cross-view consistency. | `RESEARCH_REFERENCE` |
| **MediaPipe** | C | Foundational landmarks. | `COMPLETE_SOLUTION_CANDIDATE` |

## Phase 5 — Minimum Viable Test Path

**Goal**: Produce GB001 PROFILE REFERENCE.
**Selected Minimum Viable Candidate**: **IP-Adapter FaceID (SD1.5)** or **PuLID**. 
**Reasoning**: Both operate in pure Python via HuggingFace `diffusers`, requiring no Windows C++ Build Tools (satisfying Priority 1 & 3: Runs in isolated Conda / prebuilt packages). They allow immediate visual evaluation of cross-view identity intelligence. Because of weight restrictions, this is an internal research baseline test to measure current state-of-the-art capability before building a commercial equivalent.
