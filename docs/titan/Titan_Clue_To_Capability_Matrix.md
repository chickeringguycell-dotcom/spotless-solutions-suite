# Titan Clue-To-Capability Matrix

## Phase 5 — Clue-To-Capability Matrix

| Required Gemini Behavior | Missing Titan Capability | Candidate Project | Relevant Mechanism / Function | Input | Output | License | Expected Contribution | Evidence Status |
|:---|:---|:---|:---|:---|:---|:---|:---|:---|
| Standardized front identity | Face Landmark & Parsing | MediaPipe | `FaceLandmarker` | Image | 2D Points | Apache 2.0 | Normalized alignment | `UNVERIFIED` (Blocked by install) |
| Profile & 3/4 views | Camera & View Control | PyTorch3D / nvdiffrast | `Rasterizer` / `look_at_view_transform` | 3D Mesh + Extrinsics | Novel View Render | BSD / NV Source | View generation | `UNVERIFIED` (Blocked by C++ build tools) |
| Topology/wireframe reference | Geometry-Aware Face Understanding | 3DDFA_V2 / PRNet | `reconstruct_3d_face` | Image | 3D Vertices/Faces | MIT/NC | Dense 3D geometry | `UNVERIFIED` (Blocked by License & Hardware) |
| Cross-view identity consistency | Identity Representation | Titan Custom Encoder | `IdentityEmbedding` / `ArcFace Loss` | Image | 512-D Vector | Proprietary | Latent lock across views | `UNVERIFIED` (Blocked by Dataset rendering) |
| UV-style identity reference | UV-Style Semantic Canonicalization | PyTorch3D | `texture_atlas` / `uv_mapping` | 3D Mesh + UV Map | Flattened Texture | BSD | Semantic UV Map | `UNVERIFIED` (Blocked by C++ build tools) |
