# PhotoMaker V2 Commercial License Matrix

## Phase 8 — Commercial Replacement Path

| Component | License | Commercial Status | Notes |
|:---|:---|:---|:---|
| **PhotoMaker V2 Code** | Apache 2.0 | `COMMERCIAL_USE_CONFIRMED` | The implementation logic is open source. |
| **PhotoMaker V2 Weights** | Apache 2.0 | `COMMERCIAL_USE_CONFIRMED` | The projection layers are open source. |
| **InsightFace Extraction** | Non-Commercial | `LICENSE_BLOCKED` | **Critical Blocker**. Mandatory for identity extraction. |
| **Base SDXL Model** | Open RAIL-M | `COMMERCIAL_USE_CONFIRMED` | SDXL foundation is permissive. |

### Commercial Replacement Path
PhotoMaker V2 strictly relies on the non-commercial InsightFace encoder.

**Replacement Candidates**:
- **AuraFace** (Commercially Permissive).
- **Interface compatibility**: Mismatched. AuraFace and InsightFace produce fundamentally different embedding topologies.
- **Required Retraining**: `CRITICAL`. Because PhotoMaker V2 merges visual embeddings into text tokens, its entire projection layer and UNet cross-attention adapters have been mathematically tuned to the *specific* shape and distribution of InsightFace embeddings. Swapping the encoder requires a complete retraining of the PhotoMaker architecture on a massive dataset (similar to the original WebFace42M).
- **Commercial Status**: `LICENSE_BLOCKED`. While the official PhotoMaker code is Apache 2.0, the pipeline cannot be executed without violating the InsightFace non-commercial clause, rendering the tool un-deployable for Titan's commercial goals out-of-the-box.
