# Open Source Face System Audit

## Phase 2 — Candidate Audit

### LANDMARK AND FACE PARSING
| Candidate | Official Source | License (Code) | License (Weights) | Classification |
|:---|:---|:---|:---|:---|
| **MediaPipe Face Landmarker** | Google | Apache 2.0 | Apache 2.0 | `COMPLETE_SOLUTION_CANDIDATE` |
| **dlib** | Davis King | BSL-1.0 | BSL-1.0 | `FOUNDATIONAL_COMPONENT` |

### IDENTITY ENCODING
| Candidate | Official Source | License (Code) | License (Weights) | Classification |
|:---|:---|:---|:---|:---|
| **InsightFace (ArcFace/Buffalo)** | DeepInsight | MIT | Non-Commercial | `LICENSE_BLOCKED` (for production), `RESEARCH_REFERENCE` |
| **IP-Adapter FaceID** | Tencent | Apache 2.0 | Non-Commercial (InsightFace dep) | `LICENSE_BLOCKED` |
| **Titan Custom Encoder** | Viper Studios | Proprietary | Proprietary | `COMPLETE_SOLUTION_CANDIDATE` |

### 3D FACE RECONSTRUCTION
| Candidate | Official Source | License (Code) | License (Weights/Data) | Classification |
|:---|:---|:---|:---|:---|
| **PRNet** | Y. Feng | MIT | Non-Commercial (300W-LP) | `RESEARCH_REFERENCE` |
| **Deep3DFaceRecon_pytorch** | Sicong Deng | MIT | Non-Commercial (BFM) | `RESEARCH_REFERENCE` |
| **3DDFA_V2** | Jianzhu Guo | MIT | Non-Commercial (300W-LP) | `RESEARCH_REFERENCE` |
| **FLAME** | MPI-IS | Custom | Non-Commercial | `LICENSE_BLOCKED` |

### NOVEL VIEW AND FULL-HEAD SYNTHESIS
| Candidate | Official Source | License (Code) | License (Weights) | Classification |
|:---|:---|:---|:---|:---|
| **PanoHead** | S. An | Custom (NC) | Non-Commercial (FFHQ) | `LICENSE_BLOCKED` |
| **EG3D** | NVIDIA | NV Source Code | Non-Commercial | `LICENSE_BLOCKED` |

### DENSE CORRESPONDENCE AND UV SUPPORT
| Candidate | Official Source | License (Code) | License (Weights) | Classification |
|:---|:---|:---|:---|:---|
| **PyTorch3D** | Meta | BSD | N/A | `FOUNDATIONAL_COMPONENT` |
| **nvdiffrast** | NVIDIA | NV Source Code | N/A | `FOUNDATIONAL_COMPONENT` |

## Phase 3 — Shortlist

Based on the audit and the requirement to establish a composite pipeline, we will use the following minimal stack:
1. **Face Detection & Landmarks**: MediaPipe Face Landmarker (`COMPLETE_SOLUTION_CANDIDATE`, Apache 2.0).
2. **Identity Representation**: Titan Custom Encoder (to avoid InsightFace NC taint).
3. **3D Reconstruction**: 3DDFA_V2 (Adapter wrapped as `RESEARCH_REFERENCE` to prove the geometry pipeline until a commercial alternative is trained).
4. **Dense Correspondence & Rasterization**: PyTorch3D / nvdiffrast (`FOUNDATIONAL_COMPONENT`).
