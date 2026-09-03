# Titan Open-Source Forensic Inventory

This document tracks the installation, environment, and operational state of every open-source AI project audited for Titan's identity-preserving multi-view intelligence.

## Local AI Environments Found
- `comfy_env`: Operational
- `instantmesh`: Installed
- `sam3d`: Installed
- `sf3d` (Stable Fast 3D): Installed
- `titan_3ddfa`: Installed
- `titan_env`: Operational (Diffusers base)
- `titan_mp` (MediaPipe): Installed
- `titan_prnet`: Installed
- `titan_tf115` (TensorFlow 1.15): Installed
- `trellis`: Installed
- `triposr`: Installed

## Repository Status

### 1. ComfyUI
- **Official Name:** ComfyUI
- **Local Path:** `C:\Users\U\Documents\antigravity\dazzling-noether\local-compute-node\ComfyUI`
- **Environment:** `comfy_env`
- **Installed State:** OPERATIONAL
- **Intended Task:** Node-based workflow execution for SD1.5/SDXL.
- **Actual Capabilities:** Workflow runner.
- **License:** GPL-3.0

### 2. ControlNet (ComfyUI Aux)
- **Local Path:** `local-compute-node\ComfyUI\custom_nodes\comfyui_controlnet_aux`
- **Installed State:** OPERATIONAL
- **Intended Task:** Spatial conditioning.

### 3. IP-Adapter FaceID (ComfyUI)
- **Local Path:** `local-compute-node\ComfyUI\custom_nodes\ComfyUI_IPAdapter_plus`
- **Installed State:** OPERATIONAL
- **Intended Task:** Injecting facial embeddings as image prompts.

### 4. TRELLIS
- **Official Name:** TRELLIS
- **Local Path:** `services\project-titan-3d\TRELLIS`
- **Environment:** `trellis`
- **Installed State:** INSTALLED_UNTESTED
- **Intended Task:** Text/Image to 3D Generation.

### 5. 3DDFA / 3DDFA_V2
- **Official Name:** 3DDFA_V2
- **Local Path:** `services\project-titan-3d\local-compute-node\3DDFA_V2`
- **Environment:** `titan_3ddfa`
- **Installed State:** INSTALLED_UNTESTED
- **Intended Task:** Single-image 3D face alignment and reconstruction.

### 6. PRNet
- **Official Name:** PRNet
- **Local Path:** `services\project-titan-3d\local-compute-node\PRNet_Official`
- **Environment:** `titan_prnet`
- **Installed State:** INSTALLED_UNTESTED
- **Intended Task:** Joint 3D face reconstruction and dense alignment via position maps.

### 7. InsightFace
- **Local Path:** `C:\Users\U\.insightface` (Weights only)
- **Installed State:** PARTIALLY_OPERATIONAL (Weights present, library accessible in `titan_env`)
- **Intended Task:** 2D Face Recognition, ArcFace embeddings.

### 8. TripoSR
- **Environment:** `triposr`
- **Installed State:** DOWNLOADED_NOT_INSTALLED (Weights in HF Cache)

### 9. InstantMesh
- **Environment:** `instantmesh`
- **Installed State:** INSTALLED_UNTESTED

### 10. Missing Systems (NOT_PRESENT)
- Deep3DFaceRecon_pytorch
- DECA
- EMOCA
- PanoHead
- EG3D
- Zero123-family
- InstantID
- PuLID
