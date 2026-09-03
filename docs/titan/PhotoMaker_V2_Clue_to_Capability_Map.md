# PhotoMaker V2 Clue to Capability Map

## Phase 2 — Identity Mechanism Audit

PhotoMaker V2 utilizes a unique "stacked identity embedding" approach, merging visual ID tokens with text tokens.

### 1. Face Detection and Alignment
- **Source file**: `insightface/app/face_analysis.py`
- **Input**: Raw reference image (GB001).
- **Output**: Aligned, cropped face tensor.
- **Titan capability**: Baseline geometry extraction.
- **License impact**: Non-Commercial (InsightFace).

### 2. Identity Embedding
- **Mechanism**: The aligned face is processed through a visual encoder (CLIP/InsightFace) to extract semantic identity vectors.
- **Titan capability**: Photorealistic identity preservation.

### 3. Stacked Identity Embeddings
- **Mechanism**: PhotoMaker allows multiple reference images of the same person. It stacks these embeddings together to form a highly robust, multi-dimensional representation of the identity, reducing hallucination.
- **Titan capability**: High-fidelity single/multi-reference identity generation.

### 4. Identity-Token Fusion
- **Mechanism**: The visual embeddings are projected into the text-encoder space. A trigger word (like "img") in the prompt is mathematically replaced by these visual tokens, tricking the diffusion model into "reading" the face as a word.
- **Titan capability**: Deep identity conditioning without relying exclusively on spatial IP-Adapters.

**Replacement Feasibility**: HIGHLY DIFFICULT. The entire SDXL UNet was fine-tuned to accept these specific projected visual tokens. Replacing the InsightFace detector/encoder with a commercial alternative (like AuraFace) would break the mathematical projection layer, necessitating a complete retraining of the PhotoMaker projection layers on a massive GPU cluster.
