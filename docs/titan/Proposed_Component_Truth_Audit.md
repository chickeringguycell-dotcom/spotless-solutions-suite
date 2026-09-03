# Proposed Component Truth Audit

This document audits the reality of open-source facial reconstruction, multi-view generation, and identity encoding systems against the Titan GB001 requirement (exact identity parity from a single image).

## Correcting Common Misunderstandings

1. **“PRNet is the industry-standard solution for Titan.”**
   - **PARTIALLY TRUE**: PRNet is highly effective for dense UV position maps, but it outputs geometry, not texture. It cannot hallucinate unseen profile textures with identity fidelity.
   - **Evidence**: PRNet official repository; local execution shows symmetric texture filling.

2. **“MICA plus DECA directly produces the Gemini-style side profile.”**
   - **FALSE**: MICA and DECA produce 3D geometry and albedo (FLAME parameters). They do not produce photorealistic, identity-perfect side-profile images natively. They require a rendering pipeline and conditional diffusion to look like a photograph.
   - **Evidence**: DECA/MICA papers focus on robust 3D reconstruction, not photorealistic novel view synthesis.

3. **“PanoHead accepts any single portrait and produces an exact 360-degree identity.”**
   - **FALSE**: PanoHead requires GAN inversion (e.g., PTI) to project a real photograph into its latent space. Inversion often loses high-frequency identity details or introduces artifacts.
   - **Evidence**: PanoHead paper details the inversion process; out-of-domain images suffer identity loss.

4. **“EG3D can be used directly without inversion or training.”**
   - **FALSE**: Like PanoHead, EG3D is an unconditional GAN. To use it on a specific person, you must perform computationally expensive latent inversion (PTI).
   - **Evidence**: EG3D official paper.

5. **“SV3D or SyncDreamer preserves exact human identity from one portrait.”**
   - **FALSE**: These are general-object novel view synthesis models. When applied to human faces, they fail to preserve exact micro-identity (eye spacing, nose shape), resulting in "uncanny valley" or smoothed identities.
   - **Evidence**: SV3D paper focuses on rigid objects (shoes, cars, fire hydrants), not exact human biometrics.

6. **“MediaPipe or InsightFace supplies enough geometry to solve the problem.”**
   - **FALSE**: MediaPipe outputs a sparse 468-point mesh (or 478 with irises). InsightFace provides a 106-point landmark set or a 3D parameter set (in some models), which is insufficient for full skull/head/neck geometry reconstruction needed for extreme profile views.
   - **Evidence**: MediaPipe Face Mesh documentation.

7. **“FaceNet-PyTorch or OpenFace pretrained weights are automatically safe for commercial use.”**
   - **PARTIALLY TRUE**: OpenFace is commercially viable but very old and inaccurate compared to modern systems. FaceNet-PyTorch code is MIT, but VGGFace2 weights are restricted.
   - **Evidence**: VGGFace2 dataset license prohibits commercial use.

8. **“A custom identity adapter can be trained easily from a commercial face encoder.”**
   - **REQUIRES EXPERIMENT**: Training a cross-attention adapter (like IP-Adapter) using Dlib or FaceNet embeddings is theoretically possible, but achieving the identity fidelity of ArcFace/InsightFace requires massive, clean, commercially-licensed datasets and significant compute.
   - **Evidence**: IP-Adapter FaceID required the MS-Celeb-1M derived ArcFace model to achieve its results.

9. **“A 3D mesh plus ControlNet automatically guarantees cross-view identity.”**
   - **FALSE**: A 3D mesh (via ControlNet Depth/Normal) guarantees cross-view *geometric* consistency, but standard Stable Diffusion will still hallucinate different facial features (identity drift) from view to view unless an identity embedding is also strictly enforced.
   - **Evidence**: Extensive ComfyUI testing shows style/composition is preserved, but exact biometric identity changes.

10. **“ArcFace similarity alone is sufficient SentinelQC validation.”**
    - **FALSE**: ArcFace similarity scores can be high even if the geometry (e.g., jawline, skull shape) or skin tone is wrong. SentinelQC requires multi-modal validation (landmarks, geometry, embeddings).
    - **Evidence**: Deepfake detection literature showing embedding-only validation is flawed.

---

## Component Audits

### PRNet
- **Problem solved**: Joint 3D face reconstruction and dense alignment.
- **Inputs**: Cropped RGB Image.
- **Outputs**: 256x256x3 UV Position Map.
- **Arbitrary real portraits?**: Yes (front to moderate profile).
- **Preserves exact identity?**: Preserves facial geometry, but does not generate identity-preserving missing textures.
- **Novel views?**: No (only geometry).
- **Generates a mesh?**: Yes.
- **Generates UV coordinates?**: Yes.
- **Usable texture?**: Only for visible regions.
- **Hair/ears/neck?**: No.
- **Inversion/training?**: No.
- **Standard topology?**: Custom 43k vertex topology.
- **8 GB RTX 3070?**: Yes.
- **Windows?**: Requires workarounds for `dlib`.
- **Source/Weights Commercial?**: MIT Code, Model trained on 300W-LP (Non-commercial dataset).
- **Status**: FOUNDATIONAL_COMPONENT (Geometry), but legally borderline for commercial use.

### 3DDFA_V2
- **Problem solved**: Fast 3D face reconstruction.
- **Inputs**: RGB Image.
- **Outputs**: BFM 3DMM parameters (Pose, Shape, Expression).
- **Arbitrary real portraits?**: Yes.
- **Preserves exact identity?**: Coarse geometry only.
- **Generates a mesh?**: Yes (BFM topology).
- **Windows?**: FAILED (Requires C++ Cython compilation for FaceBoxes and Sim3DR).
- **Status**: HARDWARE_BLOCKED / PLATFORM_BLOCKED.

### InsightFace / ArcFace
- **Problem solved**: Facial recognition and identity embedding.
- **Inputs**: Aligned face crop.
- **Outputs**: 512D identity vector.
- **Source/Weights Commercial?**: STRICTLY NON-COMMERCIAL (Deepinsight license).
- **Status**: LICENSE_BLOCKED.

### MICA
- **Problem solved**: High-fidelity 3D face shape reconstruction from a single image.
- **Inputs**: ArcFace embeddings and RGB image.
- **Outputs**: FLAME shape parameters.
- **Source/Weights Commercial?**: Research only (Depends on ArcFace and FLAME datasets).
- **Status**: LICENSE_BLOCKED.

### DECA / EMOCA
- **Problem solved**: Detailed 3D face reconstruction (wrinkles, expressions).
- **Source/Weights Commercial?**: Research only (FLAME topology is non-commercial).
- **Status**: LICENSE_BLOCKED.

### FaceNet-PyTorch
- **Problem solved**: Face recognition.
- **Source/Weights Commercial?**: Code is MIT, but VGGFace2 weights are non-commercial. Casia-WebFace weights are non-commercial.
- **Status**: LICENSE_BLOCKED.

### PanoHead / EG3D
- **Problem solved**: 3D-aware GAN for human heads.
- **Source/Weights Commercial?**: Trained on FFHQ (Non-commercial for weights). Requires PTI inversion.
- **Status**: RESEARCH_REFERENCE.

### SV3D / SyncDreamer
- **Problem solved**: General object novel-view synthesis.
- **Outputs**: Multi-view images / 3D models.
- **Arbitrary real portraits?**: Fails at exact biometric preservation.
- **Status**: REJECT (Wrong task / Insufficient identity fidelity).
