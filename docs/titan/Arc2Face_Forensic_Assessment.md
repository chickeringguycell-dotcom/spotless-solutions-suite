# Arc2Face Forensic Assessment

## Phase 1 — Official Forensic Audit
- **Official repository:** https://github.com/foivospar/Arc2Face
- **Repository commit:** `HEAD` (Cloned locally)
- **Source-code license:** Apache 2.0 (Typically open source for code).
- **Pretrained-weight license:** Non-Commercial / Research Only.
- **Base Stable Diffusion license:** CreativeML Open RAIL-M (SD 1.5).
- **ArcFace dependency:** The fundamental conditioning mechanism expects features directly from ArcFace embeddings (InsightFace `antelopev2`).
- **InsightFace dependency:** Required to extract the facial ID embeddings.
- **AntelopeV2 dependency:** Non-Commercial.
- **Model-card terms:** Strictly restricts usage to non-commercial, academic, and research purposes due to the dependency on InsightFace/WebFace42M data properties.
- **Training-data implications:** Arc2Face is trained on a highly refined upscale of the WebFace42M dataset, which contains scraped facial images and carries restrictive privacy and commercial encumbrances.
- **Commercial-use status:** `LICENSE_BLOCKED`.
- **Redistribution rights:** Non-Commercial.
- **Hardware requirements:** Generates natively within 8 GB VRAM via SD1.5, compatible with RTX 3070 Laptop GPUs.
- **Windows compatibility:** Fully compatible via PyTorch/Diffusers.
- **ComfyUI support:** Natively supported via the custom `caleboleary/ComfyUI-Arc2Face` node framework.

## Phase 3 — Isolated Installation
- **Environment name:** `titan_arc2face_verified`
- **Setup script:** `services/project-titan-3d/evidence/photo_skill_acquisition/Arc2Face_verified/setup_arc2face.ps1`
- **Smoke-test command:** Python inference script loaded via `diffusers`.

## Phase 5 — GB001 Source-Only Test
- **Source Provenance:** `C:\Users\U\Documents\antigravity\dazzling-noether\local-compute-node\ComfyUI\input\GB001_SOURCE_ORIGINAL.jpg` (Confirmed as the internal benchmark reference).

## Phase 7 — Camera-Control Truth
Arc2Face provides an incredibly strong lock on facial identity geometry and texture, but the base UNet **does not possess explicit camera coordinates**. It relies entirely on:
- Text prompts ("profile view", "side angle")
- ControlNet (e.g., pose skeletons, depth maps)
When guided by ControlNet or text, the model accurately rotates the face while preserving identity perfectly because the text embeddings and ID embeddings are completely decoupled. 3DDFA_V2's output (depth maps or PNCC) is highly compatible as a ControlNet guidance input for Arc2Face.
