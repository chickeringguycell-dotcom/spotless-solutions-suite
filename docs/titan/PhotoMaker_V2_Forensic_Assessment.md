# PhotoMaker V2 Forensic Assessment

## Phase 1 — Official Forensic Audit
- **Official repository:** https://github.com/TencentARC/PhotoMaker
- **Current commit:** `HEAD` (v2 branch/release)
- **Source-code license:** Apache-2.0
- **Released-weight license:** Apache-2.0 (Model weights)
- **Base-model license:** CreativeML Open RAIL-M (SDXL / Base)
- **Identity-encoder dependencies:** Strictly depends on **InsightFace** (`antelopev2`) for preprocessing and face embedding extraction.
- **Face-analysis dependencies:** InsightFace
- **Training-data implications:** Trained to fuse text and identity embeddings mapped out of InsightFace representations.
- **Commercial-use terms:** While the PhotoMaker code and weights claim Apache-2.0, the mandatory runtime extraction of identity embeddings requires InsightFace, inheriting a `Non-Commercial / Research-Only` block unless a commercial license is purchased from the InsightFace authors.
- **Redistribution rights:** Permitted for the Apache-2.0 components; blocked for the InsightFace components.
- **Windows compatibility:** Fully compatible via PyTorch.
- **ComfyUI support:** Supported via custom nodes (e.g., ComfyUI-PhotoMaker).
- **Required VRAM:** Typically 10GB+ for SDXL-based PhotoMaker V2, but can be quantized to fit within 8GB.
- **Available low-memory modes:** fp16, xformers, CPU offloading.

## Phase 3 — Isolated Installation
- **Environment name:** `titan_photomaker_v2_verified`
- **Setup script:** `services/project-titan-3d/evidence/photo_skill_acquisition/PhotoMaker_V2_verified/setup_photomaker.ps1`
- **Installation Execution:** Halted prior to 10GB+ weight initialization due to the commercial licensing blocker associated with InsightFace.

## Phase 5 — GB001 Source Test
- **Source Provenance:** `C:\Users\U\Documents\antigravity\dazzling-noether\local-compute-node\ComfyUI\input\GB001_SOURCE_ORIGINAL.jpg` (Confirmed).
- **Test Status:** BLOCKED (Due to commercial restriction on the `antelopev2` embedding extractor).

## Phase 7 — Camera-Control Truth
PhotoMaker V2 is fundamentally a text-to-image model that merges ID embeddings into the prompt context via a special trigger word (e.g., "img"). It **does not provide explicit camera control natively**.
To achieve profile or three-quarter views, it requires:
- Text prompting ("profile view")
- ControlNet (Pose, Depth, or Canny)
When paired with 3DDFA_V2 depth maps, it can align the face geometry, but identity consistency often degrades at extreme angles without multi-view training.
