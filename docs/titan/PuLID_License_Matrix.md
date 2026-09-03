# PuLID License Matrix

| Component | License | Commercial Status | Notes |
|:---|:---|:---|:---|
| **PuLID Source Code** | Apache 2.0 | `COMMERCIAL_USE_CONFIRMED` | Architecture is permissible. |
| **PuLID Projector Weights** | Apache 2.0 | `COMMERCIAL_USE_CONFIRMED` | Weights are open, but mathematically bound to InsightFace. |
| **InsightFace (Detector/Encoder)**| Non-Commercial | `LICENSE_BLOCKED` | The operational blocker. Cannot be used commercially without an enterprise license. |
| **Base SDXL/Flux Model** | Permissive | `COMMERCIAL_USE_CONFIRMED` | Open RAIL-M / Apache 2.0. |

### Verdict
`COMMERCIAL_USE_POSSIBLE_WITH_REPLACEMENT_DEPENDENCIES`. 
The architecture is legally usable, but the implementation pipeline is completely blocked by InsightFace. To deploy PuLID commercially for Titan, Viper Studios must strip out InsightFace, substitute a permissive encoder like AuraFace, and completely retrain the PuLID MLP adapters.
