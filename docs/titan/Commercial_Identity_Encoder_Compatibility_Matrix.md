# Commercial Identity Encoder Compatibility Matrix

## Phase 4 — Embedding Compatibility Analysis

### Ecosystem Expected Embeddings
| Generator | Identity Encoder | Expected Dimension | Token Count | Projection Layer | Frozen Encoder? |
|:---|:---|:---|:---|:---|:---|
| **Arc2Face** | InsightFace | 512-D | Spatial projection | CLIP-aligned Transformer | Yes |
| **PhotoMaker V2**| InsightFace | 512-D | Merged ID Tokens | Cross-attention MLP | Yes |
| **PuLID** | InsightFace | 512-D | 5 tokens | Contrastive MLP | Yes |
| **IP-Adapter-FaceID**| InsightFace | 512-D | 4 to 16 tokens | LoRA / MLP | Yes |

### Embedding Properties Required for Titan Generation
For each evaluated encoder, the following metrics will be mapped:
- **Embedding dimension**: Usually 128-D or 512-D.
- **Vector normalization**: e.g., L2 norm before projection.
- **Distance metric**: Cosine Similarity.
- **Same-person distribution**: Mean and variance of distances between images of the same person.
- **Different-person distribution**: Mean and variance between different people.
- **Pose sensitivity**: Variance caused by 90-degree profile shifts.
- **Invariance limits**: Does the embedding discard too much lighting/expression data, rendering generative control difficult?
- **Dataset bias**: Known failure cases (e.g., specific age groups or ethnicities).

### Compatibility Pathways to Existing SD Architecture
Compare these properties against the embedding interfaces expected by Arc2Face, PhotoMaker V2, PuLID, and Titan’s IP-Adapter workflow. Determine which compatibility path is technically plausible:

A. **Direct substitution**: (Status: UNLIKELY to succeed without mathematical translation).
B. **Linear projection adapter**: (Status: Plausible for simple distribution shifts).
C. **Nonlinear MLP adapter**: (Status: Standard practice in PuLID/IP-Adapter).
D. **Token-expansion transformer**: (Status: Used in Arc2Face, highly complex).
E. **Cross-attention identity adapter**: (Status: Most flexible injection method).
F. **LoRA-conditioned identity injection**: (Status: Requires weight-baking per person).
G. **Distillation from a research-only teacher**: (Status: Do not approve distillation from restricted models for commercial production without legal review).
H. **Full retraining**: (Status: The guaranteed baseline, but highly expensive).
