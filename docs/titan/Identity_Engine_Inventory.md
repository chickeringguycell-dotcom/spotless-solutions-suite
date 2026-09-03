# Identity Engine Inventory
**Date:** 2026-07-18

An audit of locally installed and available identity-preservation systems.

| Engine | Version/Env | Commercial Use | Current Status | Embedding Dims | Capability |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **InsightFace (AntelopeV2)** | `insightface==0.7.3` | **NO (Research Only)** | Operational | 512 | Strong identity encoding, extracts face bounding boxes and embeddings. Blocks commercial use. |
| **IP-Adapter FaceID** | Diffusers / ComfyUI | **YES (Apache 2.0)** | Operational | Varied | Injects InsightFace embeddings into Stable Diffusion. (Note: Depends on InsightFace, inheriting commercial restrictions). |
| **InstantID** | Diffusers / ComfyUI | **NO (Research Only)** | Operational | - | Highly identity-consistent generation. Uses AntelopeV2 models. |
| **PuLID** | Diffusers / ComfyUI | **YES (Check Weights)** | Operational | - | Lightning-fast identity tuning without heavy structural constraints. |
| **PhotoMaker** | Diffusers / ComfyUI | **YES (Apache 2.0)** | Operational | - | Text-to-image identity injection by embedding multiple reference photos into the text encoder. |
| **Dlib** | `dlib==19.24` | **YES (Boost)** | Operational | 128 | Basic face detection and 68 landmarks. CPU heavy. |
| **FaceNet** | PyTorch / TF | **YES** | Operational | 512 | Standard embedding space, older architecture. |

**Observation:** While many 2D adapters (InstantID, IP-Adapter) successfully preserve identity in generative 2D images, they are explicitly **Research Only** due to their dependency on the InsightFace AntelopeV2 model weights. None of these engines physically extract a 3D geometry mesh.
