# Commercial Identity Engine Registry

## Expanded Identity Search Candidates

### 1. DINOv2 (Vision Transformer)
- **Architecture**: ViT-L/14.
- **Embedding Dimension**: 1024-dim.
- **Preprocessing**: 224x224 center crop.
- **Weight Provenance**: Self-supervised on curated web data LVD-142M.
- **Code License**: Apache 2.0.
- **Weight License**: Apache 2.0.
- **Commercial Status**: COMMERCIAL_USE_CONFIRMED
- **Cross-View Evidence**: Does not inherently group identities. It groups semantic visual similarities. Requires fine-tuning to force identity separation.
- **Retraining Requirement**: FULL_RETRAINING_REQUIRED (No existing SDXL cross-attention layer understands DINOv2 face identity representations natively).

### 2. CLIP (OpenCLIP ViT-H/14)
- **Architecture**: ViT-H/14.
- **Embedding Dimension**: 1024-dim.
- **Weight Provenance**: LAION-2B (Commercial safety currently under legal scrutiny, but weights are released OpenRAIL-M).
- **Commercial Status**: LEGAL_REVIEW_REQUIRED (Copyright/IP lawsuits active on LAION).
- **Retraining Requirement**: FULL_RETRAINING_REQUIRED.

### 3. FaceNet (facenet-pytorch)
- **Code License**: MIT.
- **Weight License / Dataset Provenance**: Trained on VGGFace2 or CASIA-WebFace. Both explicitly prohibit commercial use.
- *Official VGGFace2 Clause*: "The VGGFace2 dataset is available for non-commercial research purposes only."
- **Commercial Status**: DATASET_PROVENANCE_RISK -> RESEARCH_ONLY_CONFIRMED.
- **Retraining Requirement**: N/A (Blocked).

### 4. InsightFace (buffalo_l / antelopev2)
- **Code License**: MIT.
- **Weight License**: "Available for non-commercial research purposes only."
- **Dataset Provenance**: MS-Celeb-1M, Glint360K (NC).
- **Commercial Status**: RESEARCH_ONLY_CONFIRMED.

## Conclusion
A commercially usable, zero-shot identity engine that matches uffalo_l accuracy **does not exist** natively. DINOv2 is legally safe but technically lacks cross-view identity separation.
