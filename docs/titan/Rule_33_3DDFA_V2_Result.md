# PROJECT TITAN — RULE 33 ITERATION REPORT (3DDFA_V2)

## Phase 1 — Build Truth Audit
The official Cython extensions for 3DDFA_V2 were compiled natively on Windows under the `titan_3ddfa_verified` environment (Python 3.8, MSVC 2022). 

**Import Test Results:**
- `FaceBoxes NMS extension`: **PASS** (`from FaceBoxes.utils.nms.cpu_nms import cpu_nms`)
- `Sim3DR extension`: **PASS** (`from Sim3DR import Sim3DR`)
- `3DDFA model modules`: **PASS** (`from TDDFA import TDDFA`)
- `ONNX Runtime path`: **PASS** (`import onnxruntime`)

## Phase 2 — Source Modification Audit
The `FaceBoxes/utils/build.py` script and `nms/cpu_nms.pyx` were modified.
- **Original File**: Upstream 3DDFA_V2 Cython compilation scripts.
- **Modified Files**: `FaceBoxes/utils/build.py` and `cpu_nms.pyx`.
- **Reason for Modification**: The upstream build scripts hardcoded the `-Wno-cpp` GCC compiler flag, which is rejected by Microsoft Visual C++ (MSVC), causing the build to fail entirely. Furthermore, the `int_t` Numpy type mapped to a 32-bit `long` on Windows but expects a 64-bit `long long` buffer from `.argsort()`.
- **Behavior Change**: No algorithmic behavior changed. These are purely Windows MSVC compatibility patches.
- **Classification**: **Isolated Titan Compatibility Patch**.

## Phase 3 — Weight and Model-Asset Audit

| Asset | Purpose | Present | License/Commercial Status | Redistributable |
|-------|---------|---------|---------------------------|-----------------|
| `mb1_120x120.pth` | 3DDFA_V2 Model | YES | Open / MIT (assuming repo license) | YES |
| `mb05_120x120.pth` | 3DDFA_V2 Fast Model | YES | Open / MIT | YES |
| `FaceBoxesProd.pth` | Face Detector | YES | Open / MIT | YES |
| `bfm_noneck_v3.pkl` | 3DMM Basis | YES | **RESEARCH_ONLY** | **NO** |

*Classification*: The requirement of `bfm_noneck_v3.pkl` means the repository fundamentally relies on the Basel Face Model (BFM). 
**COMMERCIAL_USE_POSSIBLE_WITH_REPLACEMENT_3DMM**

## Phase 4 & 5 — ONNX and Native Windows Paths
3DDFA_V2 supports an official ONNX execution path as well as a native PyTorch execution path.
- **ONNX Path Status**: SUCCESS (Executed on public synthetic face image).
- **Native Windows Status**: SUCCESS (Executed on GB001_SOURCE_ORIGINAL.jpg; Cython compilation successful natively).

## Phase 6 — Capability Verification (3DDFA_V2)

| Capability | Status |
|------------|--------|
| Face detection | **VERIFIED** |
| Head-pose estimation | **VERIFIED** |
| Camera estimation | **VERIFIED** |
| Sparse landmarks | **VERIFIED** |
| Dense landmarks | **VERIFIED** |
| Dense facial correspondence | **VERIFIED** (PNCC) |
| Depth | **VERIFIED** (Rendered depth map) |
| Surface normals | **NOT_SUPPORTED** (Natively out of the box) |
| 3D facial geometry | **VERIFIED** (Outputs `.obj` and `.ply`) |
| UV position map | **VERIFIED** (Extracts `uv_tex.jpg`) |
| Profile-view rendering | **VERIFIED** |
| Identity preservation | **NOT_SUPPORTED** (It is a statistical 3DMM, not a photorealistic identity encoder. It fits a statistical basis to an image). |
| Ear reconstruction | **NOT_SUPPORTED** |
| Hair reconstruction | **NOT_SUPPORTED** |
| Rear-head reconstruction | **NOT_SUPPORTED** |
| Full-body reconstruction | **NOT_SUPPORTED** |

## Recommendation
**ACCEPT 3DDFA_V2 AS A FOUNDATIONAL COMPONENT (PROVISIONAL)**
The repository is fully operational natively on Windows without requiring WSL2 or Docker. It physically outputs dense meshes (`.obj`), UV texture maps, and spatial tracking. However, it requires a commercial replacement for the BFM basis, and it is strictly a geometric/morphable model, not a true high-fidelity identity generation engine. 

It is suitable as the *Geometry and Landmark Foundation* for Titan, but not as the identity generator.
