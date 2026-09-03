# 3DDFA_V2 Visual Comparison Sheet

This sheet compares the baseline `GB001` source input against the natively generated physical artifacts from the 3DDFA_V2 geometry pipeline.

## Input Source
| Canonical GB001 Profile |
|:---:|
| ![GB001_SOURCE_ORIGINAL.jpg](../../local-compute-node/ComfyUI/input/GB001_SOURCE_ORIGINAL.jpg) |

## Pipeline Outputs (Native PyTorch)

| 3D Mesh Render (`_3d`) | Depth Render (`_depth`) |
|:---:|:---:|
| ![GB001_3D](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_3d.jpg) | ![GB001_Depth](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_depth.jpg) |

| Point Cloud / Dense Alignment (`_pncc`) | UV Position Map (`_uv_tex`) |
|:---:|:---:|
| ![GB001_PNCC](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_pncc.jpg) | ![GB001_UV](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_uv_tex.jpg) |

| Pose Tracking (`_pose`) | Sparse Landmarks (`_2d_sparse`) |
|:---:|:---:|
| ![GB001_Pose](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_pose.jpg) | ![GB001_Sparse](../../services/project-titan-3d/evidence/photo_skill_acquisition/3DDFA_V2_verified/outputs/GB001/GB001_SOURCE_ORIGINAL_2d_sparse.jpg) |

---
**Status**: The pipeline successfully generated physical outputs natively on Windows without errors. 
**Verification**: True
**Model**: 3DDFA_V2 (mb1_120x120.pth + FaceBoxesProd.pth)
