# Titan Missing Pieces Investigation

**Date:** 2026-07-18

## Missing Capability Fingerprint
To successfully achieve the GB001 benchmark (turning one front-facing portrait into a complete identity package), Titan requires the following proven mechanisms:

1. **Identity Representation:** Pose-invariant identity encoding mapped into a latent space (e.g., Facenet-PyTorch).
2. **3D Face Reconstruction:** Metric 3D mesh geometry extraction to anchor coordinates (e.g., MICA, DECA).
3. **Camera and View Control:** 3D-aware camera azimuth and elevation embeddings (e.g., SyncDreamer).
4. **Cross-View Consistency:** Spatial attention or shared denoising mechanisms to synchronize views (e.g., SyncDreamer).
5. **Occlusion Completion:** Inferring missing data (ears, scalp, neck) accurately.
6. **UV-Style Reference:** Extraction of dense semantic correspondence into flattened texture maps (e.g., Deep3DFaceRecon, DECA).

## Clue-to-Capability Matrix

| Required Behavior | Missing Titan Capability | Candidate Project | Mechanism | Expected Contribution |
| :--- | :--- | :--- | :--- | :--- |
| Exact Identity Match | Identity Encoding | Facenet-PyTorch | VGGFace2 Embeddings | Replaces InsightFace with commercial license |
| Same nose in front/profile | 3D Face Reconstruction | MICA / DECA | FLAME Mesh / Metrical Geometry | Provides anchor for spatial features |
| Full 90-degree profile | Novel View Synthesis | SyncDreamer / SV3D | Synchronized Multi-View Diffusion | Generates missing ears, skull, and hair |
| Flat Face Texture | UV-Style Generation | Deep3DFaceRecon / DECA | Barycentric texture unwrapping | Outputs the flat UV identity reference |
