# Open Source Code Reuse Assessment

This document tracks mechanisms found in open-source candidates that are relevant to Titan's GB001 requirement, irrespective of whether the full project can be used.

## Source-Code Forensics

### IP-Adapter
- **Repository**: `tencent-ailab/IP-Adapter`
- **Mechanism**: Cross-attention layers injecting image embeddings into UNet.
- **Source File**: `ip_adapter.py`
- **License**: Apache 2.0 (Code)
- **Expected Titan Value**: High. We can reuse the architecture, but we MUST replace the InsightFace embedding with a commercially safe identity embedding.

### PRNet
- **Repository**: `YadiraF/PRNet`
- **Mechanism**: ResNet-based regression of a 256x256 UV position map.
- **Source File**: `predictor.py`, `api.py`
- **License**: MIT
- **Expected Titan Value**: High. Serves as the geometric backbone.

### Sim3DR (Used by 3DDFA_V2)
- **Repository**: `cleardusk/3DDFA_V2/Sim3DR`
- **Mechanism**: Cython-based fast rasterizer for 3D meshes.
- **Source File**: `Sim3DR_Cython.pyx`
- **License**: MIT
- **Expected Titan Value**: Low. We should prefer PyTorch3D or Nvdiffrast for differentiable rendering, as they are fully GPU accelerated and native PyTorch, avoiding Cython build failures on Windows.

### EG3D
- **Repository**: `NVlabs/eg3d`
- **Mechanism**: Tri-plane representation and volume rendering.
- **Source File**: `training/volumetric_rendering/`
- **License**: Nvidia Source Code License (Non-commercial)
- **Expected Titan Value**: Research reference only. 

## Commercial Identity Stack Investigation

### RESEARCH-ONLY IDENTITY STACK
These pipelines depend on InsightFace (ArcFace / AntelopeV2 / Buffalo_L face models), which strictly forbid commercial use without explicit licensing from deepinsight.
1. **IP-Adapter FaceID** (Blocked)
2. **InstantID** (Blocked)
3. **PuLID** (Blocked)

### COMMERCIAL-CANDIDATE IDENTITY STACK
Pipelines that can be used commercially without infringing on deepinsight's ArcFace licenses.
1. **IP-Adapter Plus (Standard CLIP Image Prompting)**: Preserves style, loses exact biometrics.
2. **Titan Custom Trainable Identity Encoder**: Dlib or FaceNet embeddings injected into an IP-Adapter style architecture. Needs dataset and training.
