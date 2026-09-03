# Titan Code Reuse Assessment

This document assesses the legal and technical viability of reusing code or weights from open-source candidates to build Titan's identity-preserving intelligence.

## 1. InsightFace (ArcFace)
- **Repository:** `deepinsight/insightface`
- **License:** MIT License (Code), Non-commercial (Some Models)
- **Commercial Use:** Permitted for code. Weight restrictions apply depending on the specific model (e.g. AntelopeV2 vs Buffalo_L).
- **Direct Reuse Allowed:** Yes, code is MIT.
- **Integration Risks:** Python library is well-maintained, but requires ONNXRuntime.

## 2. IP-Adapter FaceID
- **Repository:** `tencent-ailab/IP-Adapter`
- **License:** Apache 2.0 (Code)
- **Commercial Use:** Permitted (Code). Models may inherit restrictions from base models (SD1.5).
- **Direct Reuse Allowed:** Yes.
- **Integration Risks:** High VRAM usage if paired with SDXL. Very stable with SD1.5.

## 3. PRNet (Position Map Regression Network)
- **Repository:** `YadiraF/PRNet`
- **License:** MIT License
- **Commercial Use:** Permitted.
- **Direct Reuse Allowed:** Yes.
- **Integration Risks:** Built on older TensorFlow 1.x or early PyTorch. May require significant refactoring to modernize for current PyTorch environments. (Environment `titan_prnet` exists locally).

## 4. 3DDFA_V2
- **Repository:** `cleardusk/3DDFA_V2`
- **License:** MIT License
- **Commercial Use:** Permitted.
- **Direct Reuse Allowed:** Yes.
- **Integration Risks:** Relies heavily on Cython/C++ extensions for rasterization which can be brittle to compile on Windows. (Environment `titan_3ddfa` exists locally).

## 5. InstantID
- **Repository:** `InstantID/InstantID`
- **License:** Apache 2.0
- **Commercial Use:** Permitted.
- **Direct Reuse Allowed:** Yes.
- **Integration Risks:** Requires SDXL, ControlNet, and InsightFace. Extremely VRAM heavy (typically requires 12GB+ for SDXL). May hit the 8GB Windows VRAM ceiling.

## Capability Decision (Provisional)
Based on the license and hardware audit, a **COMPOSITE SOLUTION** is the most viable path forward for Titan:
1. **InsightFace + IP-Adapter** to provide stable cross-view identity injection (solves identity drift).
2. **PRNet or 3DDFA** to extract the dense 3D facial geometry and UV position map from the frontal source (solves UV unwrapping and topological references).
3. **ControlNet (Depth/Pose)** to enforce the side-profile output angle.

# Commercial Identity Stack Investigation

## RESEARCH-ONLY IDENTITY STACK
These pipelines depend on InsightFace (ArcFace / AntelopeV2 / Buffalo_L face models), which strictly forbid commercial use without explicit licensing from deepinsight.

1. **IP-Adapter FaceID**
   - Code License: Apache 2.0
   - Weight License: Research Only (inherits from InsightFace)
   - Dependency License: InsightFace (Non-Commercial)
   - Commercial Status: BLOCKED
   - Windows Support: Yes (8GB VRAM Feasible)

2. **InstantID**
   - Code License: Apache 2.0
   - Weight License: Research Only (inherits from InsightFace)
   - Base-model: SDXL (OpenRAIL++)
   - Commercial Status: BLOCKED
   - Windows Support: Yes (but highly VRAM intensive, >12GB usually required)

3. **PuLID**
   - Code License: Apache 2.0
   - Weight License: Research Only (inherits from InsightFace)
   - Commercial Status: BLOCKED

## COMMERCIAL-CANDIDATE IDENTITY STACK
Pipelines that can be used commercially without infringing on deepinsight's ArcFace licenses.

1. **IP-Adapter Plus (Standard CLIP Image Prompting)**
   - Face-recognition model: None (Uses OpenAI CLIP Vision encoder, MIT)
   - Commercial Status: USABLE
   - Attribution: Required by OpenAI CLIP
   - Drawback: Preserves style/composition but allows facial identity drift.

2. **Titan Custom Trainable Identity Encoder**
   - Face-recognition model: Dlib Face Recognition (Boost Software License - Commercial OK) or FaceNet (Apache)
   - Status: REQUIRES INDEPENDENT TRAINING. We would need to train a cross-attention adapter injecting 128D Dlib embeddings into the UNet, similar to FaceID, but legally clean.

