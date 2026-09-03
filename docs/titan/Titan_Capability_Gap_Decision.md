# Titan Capability Gap Decision

## 1. Verified Capability Gap
The primary limitation of Titan`s current `project_geometry_uv_fast.py` pipeline is that it operates purely in 2D space (mapping observed pixels to UV coordinates) but lacks **Single-Shot 3D Face Reconstruction**. It cannot infer the unobserved 3D geometry and texture of the sides and back of the head.

## 2. Capability Decision
**B. COMPOSITE OPEN-SOURCE PIPELINE**

To achieve full parity with the Gemini Golden Benchmark, Titan requires a composite architecture consisting of:
1. **Face Detection & Landmarking:** MediaPipe Face Mesh or InsightFace (to detect 468+ specific landmarks and anchor the mesh perfectly).
2. **3D Reconstruction & UV Extraction:** PRNet (Position Map Regression Network) or Deep3DFaceRecon_pytorch (to estimate 3D shape and albedo from a single photo and instantly generate a UV Position Map).
3. **Novel View Synthesis / Occlusion Completion:** PanoHead or EG3D (to synthesize the missing 360-degree head geometry and output consistent side profiles).

