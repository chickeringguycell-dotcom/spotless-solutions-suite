# Pippo: Clue to Capability Map (Code Audit)

This matrix maps Pippo's deterministic code modules to Titan's functional requirements. Since Pippo is `CODE_ONLY`, these mechanisms describe the *computational capacity* of the architecture, not verified weight performance.

## 1. Spatial Anchoring (Multi-View Control)
- **Source file**: `latent_diffusion/models/control_mlp.py`
- **Class/Function**: `ControlMLP`
- **Inputs**: Plücker rays, target camera intrinsics, and extrinsics.
- **Outputs**: Spatial conditioning tensors injected into the DiT.
- **Learned or deterministic**: Deterministic projection, followed by a learned MLP (requires weights).
- **Titan capability supplied**: Camera-conditioned multi-view generation.
- **License**: CC BY-NC 4.0
- **Integration difficulty**: High (Requires full re-training of a DiT).
- **Reuse Permitted**: Research/Non-Commercial only.
- **Independent Reimplementation**: Preferable for a commercial Titan engine.

## 2. Multi-View Batching & Attention Biasing
- **Source file**: `latent_diffusion/models/dit.py`
- **Class/Function**: Attention bias masks for cross-view synthesis.
- **Inputs**: Sequence of views.
- **Outputs**: Bias masks enforcing spatial consistency across generated views.
- **Learned or deterministic**: Deterministic masking strategy.
- **Titan capability supplied**: Cross-view identity consistency.
- **License**: CC BY-NC 4.0
- **Reuse Permitted**: Research/Non-Commercial only.
- **Independent Reimplementation**: Strongly recommended as a blueprint for Titan's multi-view generation.

## 3. Reprojection-Error Evaluation
- **Source file**: `scripts/pippo/reprojection_error.py`
- **Class/Function**: `ReprojectionError`
- **Inputs**: Generated multi-view images, predicted depth.
- **Outputs**: Pixel-wise 3D consistency score.
- **Learned or deterministic**: Deterministic geometric evaluation.
- **Titan capability supplied**: Automated verification of multi-view 3D consistency.
- **License**: CC BY-NC 4.0
- **Reuse Permitted**: Research/Non-Commercial only.
- **Independent Reimplementation**: Preferable.
