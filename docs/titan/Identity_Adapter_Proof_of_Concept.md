# Identity Adapter Proof of Concept

## Phase 5 — Minimum Replacement Experiment

**Objective**: Prove or disprove the hypothesis: *"A commercially usable identity embedding (e.g., AuraFace) can be translated into a conditioning representation that affects identity-preserving generation using an existing diffusion pipeline."*

### Experiment Design
Because Titan cannot legally execute the InsightFace weights to test existing pipelines, and retraining an entire UNet cross-attention layer is prohibitively expensive for a first-pass test, the minimum legally permissible experiment is:

1. **Encoder**: Load a commercially permissible face encoder (e.g., AuraFace).
2. **Adapter**: Build a small trainable MLP projection adapter (translating the AuraFace 512-D vector into a format the IP-Adapter standard expects, or fine-tuning the IP-Adapter projection layer).
3. **Pipeline**: Connect the adapter to a legally usable SD 1.5 conditioning path.
4. **Execution**: Perform a controlled identity generation on a synthetic/public face.

### Control Variables (Frozen)
- Source Image
- Prompt ("A photograph of a person")
- Checkpoint (SD 1.5 Base)
- Seed
- Sampler / Steps
- Resolution
- Requested view

### Measurement Metrics
Compare `BASELINE` (No identity adapter) versus `CORRECTION` (AuraFace + Adapter):
- Source-to-output identity similarity
- Face-detection success
- Eye consistency, Nose consistency, Mouth consistency, Jaw consistency
- Skin tone
- Stability across three runs

### Current Status
**Status**: `UNCALIBRATED`. 
The execution of this experiment requires the setup of an isolated training script to perform the initial MLP projection training loop. This serves as the blueprint for the next major Titan engineering effort.
