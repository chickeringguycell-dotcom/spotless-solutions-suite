# Titan Missing Capability Map

## 1. Geometric Representation
- **Capability**: Extracting a 3D structural foundation (pose, depth, dense landmarks) from a single source image.
- **Status**: `PROVISIONAL`
- **Candidate Evaluated**: 3DDFA_V2
- **Blocker**: The BFM-derived geometry used by 3DDFA_V2 is not commercially clear. A commercial 3DMM replacement is eventually required.

## 2. Identity Extraction & Embedding
- **Capability**: Extracting a dense, lighting-agnostic identity vector from a source photo.
- **Status**: `PROVISIONAL / BLOCKED`
- **Candidate Evaluated**: InsightFace (`antelopev2`/`buffalo_l`). Used by Arc2Face, PhotoMaker V2, and PuLID.
- **Blocker**: InsightFace weights and training data are strictly `Non-Commercial / Research-Only`. This renders all dependent open-source tools legally unusable for Titan's commercial goals.
- **Next Step**: Evaluate **AuraFace** (or similar commercial equivalent) as the permissive encoder foundation.

## 3. Identity Injection Module
- **Capability**: Projecting the extracted identity vector into the diffusion conditioning space without destroying composition or prompt-adherence.
- **Status**: `MISSING / ENGINEERING REQUIRED`
- **Candidate Evaluated**: IP-Adapter, PhotoMaker, PuLID (Contrastive Adapter).
- **Blocker**: Because we cannot use InsightFace, the existing trained adapters (which expect InsightFace vectors) will fail if directly fed AuraFace vectors.
- **Next Step**: Train a custom **Titan Commercial Identity Adapter** (MLP or LoRA cross-attention) to bridge the AuraFace encoder into Stable Diffusion. This begins with the Minimum Training Feasibility Experiment.


## 🚨 FORENSIC CORRECTION (2026-07-20) 🚨
All previous claims regarding the successful execution of the 3DDFA_V2 + PuLID + SDXL composite pipeline are hereby REVOKED. Forensic auditing proves the environment 	itan_composite_official was never created, the composite inference script crashed silently, and no actual output images were ever generated. The pipeline remains strictly UNVERIFIED and INCOMPLETE.
