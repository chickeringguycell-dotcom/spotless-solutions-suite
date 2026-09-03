# Arc2Face: Clue to Capability Map (Identity Mechanism)

## Phase 2 — Identity-Mechanism Audit

Arc2Face completely removes text embeddings as the driving force for human generation and replaces them entirely with ArcFace identity features.

### 1. Identity Embedding Extraction
- **Input**: Source image (e.g., GB001)
- **Mechanism**: The image is passed through InsightFace's `antelopev2` face detection and alignment pipeline. It extracts a highly dense, 512-dimensional vector.
- **Output**: Pure biometric feature tensor (No text/clip contamination).
- **Titan capability supplied**: Absolute identity grounding.

### 2. Identity-Token Conversion
- **Mechanism**: A fine-tuned CLIP encoder (which normally converts text to embeddings) is surgically replaced by an encoder trained specifically to project the 512-D ArcFace embedding into the SD1.5 latent space.
- **Output**: Identity tokens that plug directly into the UNet's cross-attention layers.
- **Titan capability supplied**: Cross-view and cross-pose identity preservation.

### 3. Diffusion Conditioning & Generation
- **Mechanism**: The customized SD1.5 UNet uses the projected ID embeddings as its primary condition. Because the model was fine-tuned heavily on WebFace42M strictly using ID embeddings, the UNet "knows" how to decode that ID into a photorealistic face at any angle.
- **Titan capability supplied**: Stable, repeatable, highly detailed photorealistic head generation.

### 4. Pose and Expression Control (Adapters)
- **Mechanism**: Arc2Face doesn't natively control expression or exact camera pose. Instead, it relies on standard SD1.5 `ControlNet` integration (e.g., feeding a depth map or a pose skeleton). 
- **Titan capability supplied**: When paired with a 3DDFA_V2 rendered depth map, Arc2Face acts as an identity-preserving renderer wrapping the 3D geometry provided by 3DDFA_V2.

**Replacement Feasibility**: HIGHLY DIFFICULT. Swapping the `antelopev2` encoder for a commercially viable alternative (like AuraFace) would shift the mathematical embedding space, meaning the Arc2Face CLIP-projector and UNet would fail to understand the new embedding. It would require retraining the projector entirely.
