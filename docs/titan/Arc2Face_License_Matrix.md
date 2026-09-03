# Arc2Face Commercial License Matrix

## Phase 8 — Commercial Replacement Path

| Component | License | Commercial Status | Notes |
|:---|:---|:---|:---|
| **Arc2Face Code/Inference** | Apache 2.0 | `COMMERCIAL_USE_CONFIRMED` | Code itself is open source. |
| **Arc2Face Pretrained Weights** | Non-Commercial | `LICENSE_BLOCKED` | Bound by WebFace42M dataset terms. |
| **InsightFace / AntelopeV2** | Non-Commercial | `LICENSE_BLOCKED` | Essential for embedding generation. |
| **Base SD 1.5** | CreativeML Open RAIL-M | `COMMERCIAL_USE_CONFIRMED` | The foundation model is commercially permissive. |

### Commercial Replacement Path
If Arc2Face depends on non-commercial InsightFace weights, can the dependency be replaced?

**Research**:
- **AuraFace**: A commercially permissible open-source alternative to ArcFace. It extracts identity embeddings that perform similarly to InsightFace.
- **Integration Effort**: `HIGH`. The `Arc2Face` UNet and CLIP-projector were fine-tuned specifically to decode the mathematical vector space of `antelopev2`. If we inject an `AuraFace` embedding into the Arc2Face network, the latent space will mismatch, resulting in corrupted images.
- **Required Retraining**: To use AuraFace commercially, Titan would have to train a brand new CLIP-projector network (and potentially fine-tune the UNet) to map AuraFace embeddings to SD1.5 latents using a commercially clean dataset. 

**Classification**: `USABLE_WITH_REPLACEMENT_IDENTITY_ENCODER` (Technically) but effectively `LICENSE_BLOCKED` for direct out-of-the-box integration. We cannot legally redistribute or commercially operate the official Arc2Face weights or the InsightFace extractor.
