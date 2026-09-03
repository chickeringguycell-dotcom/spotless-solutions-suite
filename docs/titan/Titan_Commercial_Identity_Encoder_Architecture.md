# Titan Commercial Identity Encoder Architecture

## Phase 4 — Original Titan Encoder Architecture

**Objective**: Implement an original, compact face-identity encoder feasibility model suitable for training and inference on an RTX 3070 Laptop GPU.

### Architecture
- **Input**: 112x112 RGB facial crop.
- **Image Normalization**: standard (x - 0.5) / 0.5.
- **Backbone**: ResNet-50 or MobileNetV2 (Lightweight CNN).
- **Pooling**: Global Average Pooling.
- **Embedding**: Fixed 512-D L2-Normalized Vector.

### Selected Training Objective
**Loss**: Additive Angular Margin Loss (ArcFace Loss derivative) + Triplet Loss.
**Justification**: ArcFace loss (additive angular margin) is mathematically established as the standard for separating facial identities in deep embedding spaces. A Triplet loss component further enforces different-identity separation and same-identity closeness across pose variations (Pose-consistency loss). *Note: The mathematical formulation of angular margin is public knowledge; Titan claims no legal ownership over the general method.*

### Required Modules
- **Face crop and alignment**: Pre-processing module.
- **Image normalization**: Transforms module.
- **Backbone**: Standard PyTorch TorchVision backbone without pretrained weights (to avoid dataset taint).
- **Fixed-dimensional normalized embedding**: Final Linear layer + L2 norm.
- **Checkpoints**: Saving `state_dict`.
- **ONNX export**: ONNX runtime hooks.
- **Evaluation hooks**: Cosine similarity calculators.
