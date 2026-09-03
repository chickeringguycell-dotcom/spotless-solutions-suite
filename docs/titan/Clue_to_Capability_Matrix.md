# Clue-to-Capability Matrix
**Date:** 2026-07-18

Mapping isolated technical mechanisms to Titan's missing capabilities.

| Required GB001 Behavior | Missing Titan Capability | Candidate Project | Relevant Mechanism / Keyword | Expected Value for Titan | License | Hardware | Evidence Status |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| Unmistakable same person | Identity Encoding | Arc2Face | `identity_embedding` (ArcFace injection via CLIP) | Inject robust identity prior into SD1.5 latent space without text prompt pollution. | LICENSE_BLOCKED | 8GB YES | PROVISIONAL |
| Profiles & rear head | 3D-Aware Occlusion Completion | PanoHead | `tri-perspective view (TPV)` & `EG3D` | Reconstructs 360-degree head volume, inferring rear skull and ear depth. | LICENSE_BLOCKED | 8GB YES | PROVISIONAL |
| View interpolation | Cross-View Consistency | SyncDreamer | `cross_view_attention` / `3D-aware feature attention` | Synchronizes intermediate states across views to prevent "drifting" identity in novel angles. | Apache 2.0 | 12GB+ | UNCALIBRATED |
| UV-style semantic output | Face Geometry & Dense Correspondence | 3DDFA_V2 | `UV_position_map` / `dense_correspondence` | Unwraps 2D face pixels into canonical 3D topology map for texturing. | MIT | 8GB YES | PROVISIONAL |
| Geometry fidelity | Face Geometry | Wonder3D | `geometry-aware normal fusion` | Generates consistent normal maps for detailed surface extraction (wrinkles, nose bridge). | Apache 2.0 | 8GB YES | UNCALIBRATED |
| 3D volumetric consistency | Cross-View Consistency | Pippo | `Plücker rays` & `spatial_anchor` | Forces generated views to obey rigid multi-camera geometry, evaluated via `reprojection_loss`. | MIT Code (No Weights) | Cluster Req. | PROVISIONAL |
