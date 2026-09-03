# PuLID Forensic Assessment

## Phase 1 — PuLID License-First Forensic Audit
- **Official repository:** https://github.com/ToTheBeginning/PuLID
- **Repository commit:** `HEAD` (Main)
- **Source-code license:** Apache 2.0
- **PuLID checkpoint license:** Apache 2.0
- **Base-model license:** Open RAIL-M (SDXL base) / Flux
- **Identity-encoder dependency:** InsightFace (`antelopev2`)
- **Face-detector dependency:** InsightFace (`buffalo_l` or `antelopev2`)
- **Training-data implications:** The PuLID attention layers were trained to map InsightFace face embeddings into the diffusion conditioning space.
- **Commercial-use status:** The code and projection weights are Apache 2.0. However, execution requires InsightFace, which strictly enforces a Non-Commercial/Research-Only license for its weights and dataset lineage.
- **Redistribution rights:** Yes for PuLID models, No for InsightFace weights.
- **Windows support:** Yes (via PyTorch)
- **ComfyUI support:** Yes (e.g., `PuLID_ComfyUI`)
- **VRAM requirements:** 12GB - 16GB (SDXL), 24GB+ (Flux base)
- **Low-memory modes:** fp8 support for Flux/SDXL.
- **Current maintenance status:** Active (NeurIPS 2024 accepted paper, recently released PuLID-Flux).

## Phase 6 — PuLID Execution Gate
Because PuLID depends on restricted `antelopev2` weights for its operational identity extraction, the pipeline hits the same execution gate as Arc2Face and PhotoMaker V2. 
- **Execution Status:** HALTED. Do not execute restricted assets as a prospective production component.
- **Classification:** `RESEARCH_BLUEPRINT`
- **Retraining Required:** PuLID's cross-attention layers and contrastive alignment models must be retrained against a new, commercially permissible identity encoder (e.g., AuraFace) before it can be used in Titan.
