# Open Source Candidate Registry
**Date:** 2026-07-18

An audit of candidate architectures for Titan's single-image human turnaround capability.

## PRIMARY ARCHITECTURE
**Pippo**
- **Intended task:** Single-image to 3D-consistent turnaround video.
- **Identity/Cross-view mechanism:** Attention Biasing, Spatial Anchors, Plücker Rays.
- **License:** MIT (Code). Weights not public.
- **Titan role:** RESEARCH_REFERENCE (TIER C).

## IDENTITY GENERATION
**Arc2Face**
- **Intended task:** SD1.5 generation strictly from ArcFace embeddings.
- **Identity mechanism:** High-fidelity ArcFace ID embeddings injected via CLIP encoder projection.
- **License:** OpenRAIL (Base), Non-Commercial (WebFace42M dataset implications).
- **Titan role:** LICENSE_BLOCKED.

**PuLID**
- **Intended task:** Tuning-free ID customization.
- **Identity mechanism:** Dual-branch Lightning T2I and standard diffusion with contrastive alignment.
- **License:** Apache 2.0 (but verify InsightFace dependency).
- **Titan role:** USEFUL_ADAPTER (TIER B) if commercial viability is cleared.

## FACE GEOMETRY & DENSE CORRESPONDENCE
**3DDFA_V2**
- **Intended task:** 3D face alignment and dense reconstruction.
- **Geometry mechanism:** UV position maps and dense vertices via parameterized proxy.
- **License:** MIT.
- **Titan role:** COMPLETE_SOLUTION_CANDIDATE (TIER A) - if compiler blocks are resolved.

**Deep3DFaceRecon / DECA / PRNet**
- **Intended task:** 3D face reconstruction from a single image.
- **Geometry mechanism:** FLAME / BFM parametric models.
- **License:** Non-Commercial (FLAME / BFM dataset restrictions).
- **Titan role:** LICENSE_BLOCKED.

## FULL-HEAD & HIDDEN-REGION COMPLETION
**PanoHead**
- **Intended task:** 360-degree 3D GAN for portrait synthesis.
- **Occlusion mechanism:** Tri-perspective view (TPV) representation and EG3D rendering.
- **License:** Nvidia Source Code / FFHQ Non-Commercial.
- **Titan role:** LICENSE_BLOCKED.

## MULTI-VIEW COORDINATION
**SyncDreamer**
- **Intended task:** Multi-view synthesis from a single image.
- **Cross-view mechanism:** 3D-aware feature attention synchronizing intermediate diffusion states.
- **License:** Apache 2.0.
- **Titan role:** FOUNDATIONAL_COMPONENT (TIER A) - for driving geometric consistency.

**Wonder3D**
- **Intended task:** Multi-view RGB and Normal map generation.
- **Cross-view mechanism:** Cross-domain diffusion with geometry-aware normal fusion.
- **License:** Apache 2.0.
- **Titan role:** FOUNDATIONAL_COMPONENT (TIER A).

## FULL-BODY RECONSTRUCTION
**ECON / MExECON**
- **Intended task:** High-fidelity clothed human reconstruction.
- **Geometry mechanism:** Normal map inference integrated with SMPL-X body priors.
- **License:** Research Only (SMPL-X restricts commercial use).
- **Titan role:** LICENSE_BLOCKED.
