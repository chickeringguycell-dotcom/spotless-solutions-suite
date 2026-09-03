# PuLID Clue to Capability Map

## Phase 2 — PuLID Identity-Mechanism Audit

### 1. Face Detection and Alignment
- **Mechanism**: InsightFace detector locates the face and performs 2D affine alignment.
- **Titan capability**: Baseline geometry setup.
- **License impact**: `LICENSE_BLOCKED`.
- **Replacement feasibility**: High (can be swapped with RetinaFace/MediaPipe).

### 2. Identity Encoder
- **Mechanism**: InsightFace `antelopev2` extracts a 512-dimensional embedding representing the deep semantic identity.
- **Embedding dimensions**: 512-D.
- **Titan capability**: Core identity signal.
- **License impact**: `LICENSE_BLOCKED` (Non-commercial weights).
- **Replacement feasibility**: Hard. Requires replacing with AuraFace/AdaFace and retraining the downstream projection layers.

### 3. Identity Projection & Cross-Attention Injection
- **Mechanism**: The 512-D ID embedding is passed through an MLP (Multi-Layer Perceptron) projector to map it into the UNet's cross-attention space. PuLID uses "Contrastive Alignment" during training to separate the identity features from background/lighting features.
- **Identity-guidance strength**: Controlled via the attention weights (multiplying the projected keys/values).
- **Titan capability**: Injection of the identity without destroying the text prompt's composition.

### 4. Expression and Pose Behavior
- **Mechanism**: PuLID is remarkably resilient to pose changes and allows expression modification via text (e.g., "smiling"). Because the contrastive alignment separates ID from lighting/pose, PuLID does not rigidly bake in the source photo's expression (unlike early IP-Adapter implementations).
- **Profile behavior**: Degrades significantly if the training data lacked true 90-degree profiles. Requires ControlNet assistance.

### Required Retraining if Replaced
If `antelopev2` is swapped for AuraFace, the entire MLP projection pathway and the UNet cross-attention adapters must be retrained using the PuLID contrastive loss framework on a massive, commercially cleared facial dataset.
