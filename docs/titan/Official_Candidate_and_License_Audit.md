# Official Candidate and License Audit

## 3D Face Reconstruction Candidates

### 1. Deep3DFaceRecon_pytorch
* **Code License:** MIT License
* **Weight/Data License:** Requires BFM (Basel Face Model) which is strictly RESEARCH_ONLY / COMMERCIAL_USE_BLOCKED.
* **Status:** PROVISIONAL CANDIDATE (REDISTRIBUTION_RESTRICTED).

### 2. PRNet
* **Code License:** MIT License
* **Status:** PROVISIONAL CANDIDATE (COMMERCIAL_USE_CONFIRMED for code).
* **VRAM Feasibility:** Excellent.

### 3. DECA / EMOCA / MICA / 3DDFA_V2
* **Code License:** Various.
* **Weight/Data License:** FLAME License (Research & Evaluation only for models).
* **Status:** PROVISIONAL CANDIDATE (RESEARCH_ONLY / COMMERCIAL_USE_BLOCKED).

## Face Landmarking and Identity

### 1. MediaPipe Face Landmarker
* **License:** Apache 2.0.
* **Status:** COMMERCIAL_USE_CONFIRMED.

### 2. InsightFace / ArcFace
* **Code License:** MIT License.
* **Weight/Data License:** InsightFace model weights are strictly Non-Commercial.
* **Status:** RESEARCH_ONLY.

## 3D-Aware Novel View Candidates

### 1. PanoHead / EG3D
* **License:** Research/Non-Commercial (Nvidia Source Code License / CC-BY-NC).
* **Status:** PROVISIONAL RESEARCH CANDIDATES (RESEARCH_ONLY).

## Identity-Preserving Image Generation Candidates

### 1. InstantID / PuLID / PhotoMaker / Arc2Face / IP-Adapter FaceID
* **Code License:** Apache 2.0 / MIT.
* **Weight/Data License:** Rely on InsightFace embeddings and stable diffusion base models.
* **Status:** REDISTRIBUTION_RESTRICTED / RESEARCH_ONLY (due to InsightFace dependency).
