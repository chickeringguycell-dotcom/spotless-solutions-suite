# Titan Engineering Ideas Backlog

This document serves as the permanent research loop and engineering idea repository for Project Titan. It extracts engineering principles from approved open-source generators and translates them into actionable concepts for Titan.

---

### ITEM-001: Identity-Anchored Step Throttling
- **ID**: ITEM-001
- **Source**: Qwen-Image Engineering Study
- **Problem Solved**: "Step Count Drift" / "Beautification" where generative models destroy exact identity markers (asymmetries, proportions) when over-processed.
- **Engineering Principle**: Mathematical identity preservation is inversely proportional to diffusion step count.
- **Titan Benefit**: Forcing lower step counts (e.g., 8-10) anchors the generation strictly to the Identity Specification Package rather than internal beauty priors.
- **Difficulty**: Low
- **Dependencies**: Station 7C, Station 7D (Provider Execution overrides)
- **Evidence**: Qwen-Image-Edit community research showing drift past 15 steps.
- **Implementation Status**: Pending
- **Classification**: Adopt

### ITEM-002: Multi-Reference Fusion Matrix
- **ID**: ITEM-002
- **Source**: Qwen-Image & FLUX.2 Klein Engineering Studies
- **Problem Solved**: Single-source conditioning creates structural blind spots (e.g., ears, side profile).
- **Engineering Principle**: Multi-angle conditioning resolves `INFERRED` data into `MEASURED` data.
- **Titan Benefit**: Upgrading the Survey Engine to ingest a Source Image Manifest (front, left, right) dramatically improves volumetric accuracy.
- **Difficulty**: Medium
- **Dependencies**: Identity Survey Engine V2, Station 7A
- **Evidence**: Qwen-Image natively supports 9 references; FLUX.2 Klein natively supports 10.
- **Implementation Status**: Pending
- **Classification**: Adopt

### ITEM-003: Latent State Manager
- **ID**: ITEM-003
- **Source**: Qwen-Image Engineering Study
- **Problem Solved**: Sequential masking/inpainting degrades global image coherence if the latent space resets between passes.
- **Engineering Principle**: Unified latent editing preserves structural context during regional correction.
- **Titan Benefit**: Allows SentinelQC to execute targeted corrections (e.g., fixing an eye) without destroying the perfectly measured cheekbones.
- **Difficulty**: High
- **Dependencies**: Station 7J (SentinelQC), Master Orchestrator, Phase 2 Correction Loops
- **Evidence**: Qwen-Image unifies generation and editing in the same latent space successfully.
- **Implementation Status**: Pending
- **Classification**: Prototype

### ITEM-004: Triple-Encoding Spatial Syntax Processing
- **ID**: ITEM-004
- **Source**: SD 3.5 Medium Engineering Study
- **Problem Solved**: CLIP alone struggles with exact spatial relationships and complex anatomical text.
- **Engineering Principle**: Merging semantic aesthetic encoders (CLIP) with high-capacity linguistic encoders (T5-XXL) provides superior spatial control.
- **Titan Benefit**: Using multiple smaller LMs to translate geometric measurements into explicit prompt structures before sending to the generator.
- **Difficulty**: Medium
- **Dependencies**: Station 7A (Identity Conditioning)
- **Evidence**: SD 3.5 MMDiT-X relies heavily on T5-XXL for complex syntax parsing.
- **Implementation Status**: Pending
- **Classification**: Prototype

### ITEM-005: LoRA over Zero-Shot IP-Adapters for 3D Identity
- **ID**: ITEM-005
- **Source**: SD 3.5 Medium Engineering Study
- **Problem Solved**: Zero-shot IP-adapters provide style/2D likeness but hallucinate actual physical 3D structure.
- **Engineering Principle**: Identity requires physical structural logic, not just 2D style transfer.
- **Titan Benefit**: Avoid investing engineering time into building complex IP-Adapter integrations; focus instead on rapid in-memory LoRA fine-tuning for specific subjects.
- **Difficulty**: High
- **Dependencies**: Provider Architecture
- **Evidence**: SD 3.5 research indicates zero-shot methods fail on extreme angles without structural LoRA.
- **Implementation Status**: Resolved
- **Classification**: Adopt (Reject IP-Adapters, Adopt LoRA)

### ITEM-006: VLM Semantic Anchoring
- **ID**: ITEM-006
- **Source**: FLUX.2 Klein Engineering Study
- **Problem Solved**: Lack of deep semantic understanding of image conditioning.
- **Engineering Principle**: A Vision-Language Model (VLM) can analyze reference images and explicitly define identity traits to bridge the text/image gap.
- **Titan Benefit**: Station 7A can utilize a VLM to generate the exact textual representation of the Identity Knowledge Graph.
- **Difficulty**: Medium
- **Dependencies**: Station 7A, Identity Knowledge Engine
- **Evidence**: FLUX.2 uses Mistral-3 VLM to anchor structural traits natively.
- **Implementation Status**: Pending
- **Classification**: Adopt
