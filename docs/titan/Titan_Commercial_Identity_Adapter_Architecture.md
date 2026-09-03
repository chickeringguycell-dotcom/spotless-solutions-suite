# Titan Commercial Identity Adapter Architecture

## Phase 4 — Clean Titan Identity Adapter Design

**Objective**: Design an original Titan Identity Adapter that does not depend at runtime on restricted InsightFace, AntelopeV2, or Buffalo weights.

### Separation of Concerns
- **IDENTITY CONDITIONING**: Handled strictly by the Commercial Face Encoder + Titan Adapter.
- **CAMERA CONDITIONING**: Handled by 3DDFA_V2 (geometry/pose evidence) or ControlNet. 3DDFA_V2 does NOT supply the identity generation function.

### Provisional Architecture
The pipeline translates a single source image into a fully conditioned diffusion UNet:

1. **Commercial Identity Encoder** (e.g., AuraFace, pending verification)
   *↓ Extracts 512-D vector*
2. **Embedding Normalization**
   *↓ L2 Normalization / Standardization*
3. **Trainable Projection Network (Adapter)**
   *↓ MLP or Transformer*
4. **Multiple Identity Tokens**
   *↓ Expands the 512-D vector into `N` text-like tokens*
5. **Cross-Attention Injection**
   *↓ Modifies UNet keys/values without destroying spatial structure*
6. **Diffusion Model** (Stable Diffusion 1.5 Base)
   *↓ Denoising steps*
7. **Identity-Preserving Image Output**

### Required Modules
To construct this pipeline, the following software modules must be implemented:
- **Encoder interface**: Standardized API wrapping the chosen commercial model.
- **Alignment preprocessor**: Native Python logic to crop/align the face exactly as the encoder expects without calling non-commercial detectors.
- **Embedding cache**: Storage layer for precomputed dataset vectors during training.
- **Projection adapter**: The PyTorch neural network to be trained.
- **Token generator**: Formats the projection output for the UNet cross-attention.
- **Diffusion injection layer**: Binds the tokens into the UNet (similar to IP-Adapter code).
- **Identity-strength control**: Multiplier for the attention scores.
- **View-conditioning interface**: Separate channel to accept 3DDFA_V2 depths.
- **Provenance record**: Logs exactly which encoder and weights generated the identity.
- **SentinelQC identity measurement**: Automated verification of the final output.
