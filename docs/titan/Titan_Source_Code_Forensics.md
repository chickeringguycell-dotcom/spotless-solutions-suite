# Titan Source-Code Forensics

**Phase 5: Source-Code Forensics**

The following forensic audit traces the specific classes and functions in Tier A (PanoHead) and Tier B (DECA) responsible for the missing capabilities.

---

## Tier A: PanoHead (Full-Head 3D GAN)
**Repository:** `https://github.com/SizheAn/PanoHead`
**Expected GB001 Improvement:** Generates missing ears, rear skull, and hair volume.

| Component | File | Class/Function | Purpose | Dependencies | Direct Integration? | Retraining Req? | Titan Interface |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Tri-Grid Representation** | `training/triplane.py` | `TriPlaneGenerator` | Extends EG3D's tri-plane to a 3D tri-grid to capture the back of the head. | StyleGAN2, PyTorch | Yes (MIT) | Yes (Weights restricted) | `FaceGeometryProvider` |
| **Novel-View Renderer** | `training/volumetric_rendering/` | `ray_sampler`, `renderer.py` | Casts rays through the tri-grid density field to synthesize novel profiles. | PyTorch3D, CUDA | Yes (MIT) | Yes | `CameraConditioning` |
| **Model Inversion (PTI)** | `projector.py` | `project` | Maps the single 2D GB001 image into the GAN latent space (`w+`). | LPPIPS, MTCNN | Yes (MIT) | Yes | `IdentityEncoder` |
| **Identity Loss** | `training/loss.py` | `StyleGAN2Loss` | Ensures the synthesized views match the ArcFace/FaceNet embeddings. | ArcFace | Yes (MIT) | No (Architectural) | `IdentityValidator` |

---

## Tier B: DECA (Detailed Expression Capture)
**Repository:** `https://github.com/YadiraF/DECA`
**Expected GB001 Improvement:** Generates missing ears and detailed facial wrinkles.

| Component | File | Class/Function | Purpose | Dependencies | Direct Integration? | Retraining Req? | Titan Interface |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Shape Encoder** | `decalib/models/encoders.py` | `ResnetEncoder` | Regresses 50 shape, 50 expression, 50 albedo, and 3 pose parameters. | Torchvision | Yes (MIT) | Yes (Uses FLAME) | `IdentityEncoder` |
| **FLAME Decoder** | `decalib/models/FLAME.py` | `FLAME` | Converts shape/pose parameters into the full 3D skull mesh (including ears/neck). | PyTorch, FLAME | No (FLAME is blocked)| Yes (Clean-Room) | `FaceGeometryProvider` |
| **Detailed Normal Map** | `decalib/models/generators.py`| `DetailGenerator` | Infers displacement maps for wrinkles based on expression. | PyTorch | Yes (MIT) | Yes | `NormalProvider` |
| **Novel-View Renderer** | `decalib/utils/renderer.py` | `SelaRender` | Renders the FLAME mesh using rasterization. | PyTorch3D | Yes (MIT) | No | `NovelViewRenderer` |

**Conclusion:** PanoHead provides the exact Tri-Grid density field necessary for Titan to generate hair and rear-skull volume (which DECA's FLAME decoder fundamentally lacks). We will directly integrate PanoHead's `TriPlaneGenerator` and volumetric renderer under the `DIRECT_INTEGRATION_CODE_RETRAIN_WEIGHTS` protocol.
