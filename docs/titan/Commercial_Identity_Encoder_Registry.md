# Commercial Identity Encoder Registry

## Phase 1 — Commercial Encoder Truth Audit

| Encoder Candidate | Source License | Weight License | Dataset License | Input Resolution | ONNX | Verdict |
|:---|:---|:---|:---|:---|:---|:---|
| **AuraFace** | REQUIRES VERIFICATION | REQUIRES VERIFICATION | REQUIRES VERIFICATION | 112x112 | YES | `LICENSE_REVIEW_REQUIRED` (Provisionally selected as top commercial-intent candidate) |
| **AdaFace** | MIT | Unknown | Unknown | 112x112 | YES | `LICENSE_REVIEW_REQUIRED` |
| **MagFace** | MIT | Research Only | MS-Celeb-1M | 112x112 | YES | `RESEARCH_ONLY` |
| **GhostFaceNet** | MIT | Unknown | Varies | 112x112 | YES | `LICENSE_REVIEW_REQUIRED` |
| **OpenFace** | Apache 2.0 | Apache 2.0 | CASIA-WebFace | 96x96 | YES | `COMMERCIAL_USE_POSSIBLE_WITH_REPLACEMENT_WEIGHTS` |
| **MobileFaceNet**| Varies | Varies | Varies | 112x112 | YES | `LICENSE_REVIEW_REQUIRED` |

### Summary
No candidate can be selected purely on the repository's MIT/Apache status. The licensing of the underlying training data (e.g., MS-Celeb-1M) frequently restricts the released weights to `RESEARCH_ONLY`. AuraFace is currently the most promising candidate built explicitly for commercial use, but its exact dataset clearance and weight licenses require formal verification before moving beyond experimental `PROVISIONAL` status.
