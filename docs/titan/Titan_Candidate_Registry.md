# Titan Candidate Registry

## Phase 4 — Candidate Leads & Phase 6 — Classification

**MediaPipe Face Landmarker** (Google)
- Output: 2D Landmarks
- License: Apache 2.0
- VRAM Feasibility: CPU compatible
- Classification: `COMPLETE_SOLUTION_CANDIDATE` (For landmarking)

**InsightFace** (DeepInsight)
- Output: Identity Embedding
- License: MIT (Code) / Non-Commercial (Weights)
- VRAM Feasibility: <4GB
- Classification: `LICENSE_BLOCKED` (For production), `RESEARCH_REFERENCE` (For architecture)

**3DDFA_V2** (Jianzhu Guo)
- Output: 3D Mesh Vertices / Pose
- License: MIT (Code) / Non-Commercial (300W-LP Data)
- VRAM Feasibility: <8GB
- Classification: `LICENSE_BLOCKED` & `HARDWARE_BLOCKED` (Requires C++ compilation)

**EG3D** (NVIDIA)
- Output: 3D-aware novel view synthesis
- License: NV Source Code (Non-Commercial Weights)
- VRAM Feasibility: >12GB
- Classification: `LICENSE_BLOCKED` & `HARDWARE_BLOCKED`

## Phase 7 — Shortlist

**TIER A (Strongest Complete-Solution Candidates)**
- None currently exist that are both completely open-source for commercial use and pre-trained on legal datasets.

**TIER B (Strongest Complementary Components)**
- MediaPipe Face Landmarker (Apache 2.0)
- Titan Custom Identity Encoder (TBD based on V0 Dataset)

**TIER C (Research References)**
- 3DDFA_V2 / PRNet (For understanding single-image 3DMM regression)
- InsightFace (For understanding Angular Margin loss encoding)

**REJECT**
- Generic object reconstructors (TRELLIS, Stable Fast 3D, InstantMesh) as they lack human-specific structural priors required for exact identity reconstruction.
