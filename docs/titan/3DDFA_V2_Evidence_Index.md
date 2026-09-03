# 3DDFA_V2 Final Evidence Index

This document serves as the canonical map for all verified physical artifacts, builds, patches, and logs pertaining to the `3DDFA_V2` Titan integration candidate. All paths are permanent and exist under `services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/`.

## 1. Native Windows PyTorch Artifacts (GB001)
- **Source Input**: `../../local-compute-node/ComfyUI/input/GB001_SOURCE_ORIGINAL.jpg`
- **Dense Geometry (OBJ)**: `outputs/GB001/GB001_SOURCE_ORIGINAL_obj.obj`
- **Sparse Landmarks**: `outputs/GB001/GB001_SOURCE_ORIGINAL_2d_sparse.jpg`
- **Dense Landmarks**: `outputs/GB001/GB001_SOURCE_ORIGINAL_2d_dense.jpg`
- **Depth Map**: `outputs/GB001/GB001_SOURCE_ORIGINAL_depth.jpg`
- **Point Cloud (PNCC)**: `outputs/GB001/GB001_SOURCE_ORIGINAL_pncc.jpg`
- **Pose**: `outputs/GB001/GB001_SOURCE_ORIGINAL_pose.jpg`
- **UV Texture Map**: `outputs/GB001/GB001_SOURCE_ORIGINAL_uv_tex.jpg`

## 2. Official ONNX Artifacts (Synthetic Subject)
- **3D Render**: `outputs/trump_hillary_3d.jpg`
- **Dense Geometry (OBJ)**: `outputs/trump_hillary_obj.obj`
- **Sparse Landmarks**: `outputs/trump_hillary_2d_sparse.jpg`
- **Dense Landmarks**: `outputs/trump_hillary_2d_dense.jpg`
- **Depth Map**: `outputs/trump_hillary_depth.jpg`
- **Point Cloud (PNCC)**: `outputs/trump_hillary_pncc.jpg`
- **Pose**: `outputs/trump_hillary_pose.jpg`
- **UV Texture Map**: `outputs/trump_hillary_uv_tex.jpg`

## 3. Visual Comparison Sheet
- **Path**: `../../../../docs/titan/Comparison_Sheet_3DDFA_V2.md`

## 4. Patches & Build Logs
- **FaceBoxes Patch**: `logs/build_py.diff` (Removes `-Wno-cpp` and fixes Cython `np.intp_t` for MSVC).
- **Import Tests**: `logs/import_results.txt` (Verifies NMS and Sim3DR load successfully).
- **Native Logs**: `logs/native_gb001_*.log`
- **ONNX Logs**: `logs/onnx_smoke_*.log`

## 5. Licensing & Matrix
- **License**: The code is MIT. The required weights (`bfm_noneck_v3.pkl`) are strictly `RESEARCH_ONLY`.
- **Classification**: `COMMERCIAL_USE_POSSIBLE_WITH_REPLACEMENT_3DMM`.
- **Capability Matrix**: Documented in `Rule_33_3DDFA_V2_Result.md`.
