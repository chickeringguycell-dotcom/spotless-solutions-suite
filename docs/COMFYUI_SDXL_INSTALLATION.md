# Local ComfyUI + SDXL Installation Guide

Viper Studios uses a locally installed, unencumbered instance of ComfyUI for its native Image Generation pipeline. The Local Compute Node (local-compute-node/main.py) acts as the bridge between the React frontend and the ComfyUI inference engine.

## 1. Prerequisites
- **OS**: Windows, Linux, or macOS.
- **GPU**: NVIDIA (CUDA), AMD (ROCm), or Apple Silicon (MPS).
- **RAM**: 16GB minimum (32GB recommended for SDXL).
- **VRAM**: 8GB minimum (12GB+ recommended).

## 2. Installing ComfyUI
1. Download the latest standalone release from the [ComfyUI GitHub Repository](https://github.com/comfyanonymous/ComfyUI).
2. Extract the archive to a directory of your choice (e.g., C:\ComfyUI or ~/ComfyUI).

## 3. Installing the Checkpoint
Viper Studios requires **SDXL Base 1.0**.
1. Download sd_xl_base_1.0.safetensors from HuggingFace.
2. Place the file inside your ComfyUI installation at:
   ComfyUI/models/checkpoints/sd_xl_base_1.0.safetensors

*(Note: The compute node's workflow sdxl_default.json expects this exact filename).*

## 4. Running the Engine
1. Launch ComfyUI:
   - **Windows**: Run un_nvidia_gpu.bat (or your equivalent startup script).
   - **Linux/Mac**: python main.py
2. ComfyUI must be running on its default port: http://127.0.0.1:8188.
3. Start the Viper Studios local-compute-node:
   `ash
   cd local-compute-node
   uvicorn main:app --port 8000
   `

## 5. Fallback Behavior
The Local Compute Node constantly polls http://127.0.0.1:8188/system_stats. 
- **If ComfyUI is OFF**: The studio will instantly silently fall back to the Mock Image Provider, returning placeholder images so you can continue testing the Forge without crashing.
- **If generation fails (e.g., missing checkpoint)**: The node intercepts the 500/timeout error and gracefully routes the output through the mock pipeline.

## 6. Modifying Workflows
The JSON workflow powering generation is located at local-compute-node/workflows/sdxl_default.json. You can export new ComfyUI workflows in "API Format" and replace this file to change the core generation behavior.
