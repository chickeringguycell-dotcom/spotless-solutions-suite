# Pippo Forensic Assessment

## Phase 3 — Official Source Acquisition
- **Official repository:** https://github.com/facebookresearch/pippo
- **Current commit:** `HEAD` (Cloned locally)
- **Source-code license:** CC BY-NC 4.0 (Attribution-NonCommercial 4.0 International)
- **Public files:** `README.md`, `LICENSE`, `train.py`, `common.py`, `latent_diffusion/*`, `config/*`, `scripts/*`
- **Missing files:** No pretrained weights are provided.
- **Configuration files:** `config/full/128_4v.yml`, `config/tiny/128_4v_tiny.yml`
- **Training scripts:** `train.py`
- **Inference scripts:** No official inference script for pretrained models yet.
- **Evaluation scripts:** `scripts/pippo/reprojection_error.py`
- **Example data:** Available via `scripts/pippo/download_samples.py` (Ava-256 subset).
- **Pretrained weights:** NONE.
- **Base-model dependencies:** None (trained from scratch as a Diffusion Transformer).

## Phase 4 — Weight Availability Truth
**Classification**: 
- **Public release**: CODE_ONLY
- **Full learned capability**: UNAVAILABLE_WITHOUT_COMPATIBLE_WEIGHTS
- **Direct commercial use of released code**: RESEARCH_ONLY_IF_CC_BY_NC_CONFIRMED
- **Architectural value**: VERIFIED_RESEARCH_BLUEPRINT
- **Titan integration**: NOT APPROVED
- **Independent implementation of similar mechanisms**: REQUIRES_ORIGINAL_CODE_AND_LICENSE_REVIEW
- **Production training feasibility**: HARDWARE_AND_DATASET_BLOCKED (Not impossible, but extremely prohibitive)

Model architecture and source code define the network and computation.
Model weights are the learned numerical parameters created during training that contain the acquired multi-view and identity behavior.
Without compatible trained weights, the code may be inspectable and smoke-testable but cannot reproduce the full trained capability.

* Pippo explicitly states in its README: "This is a code-only release without pre-trained weights."
* Therefore, it is impossible to evaluate its zero-shot performance out-of-the-box.

## Phase 7 — Reduced Smoke Test
A reduced smoke test was conducted by initializing the purely deterministic and structural module: `ControlMLP` from `latent_diffusion.models.control_mlp`.
- **Result:** SUCCESS. The code is structurally sound and compiles the computation graph when properly initialized with PyTorch and Einops. 
- **Inference Demonstration:** Not fabricated, as no weights exist to populate the network.
