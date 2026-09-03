# TRELLIS Integration Architecture & Setup Guide

This document serves as the architectural audit and setup guide for integrating TRELLIS (Structured 3D Latents for Scalable and Versatile 3D Generation) into Viper Studios.

## 1. Architectural Integration
Viper Studios uses **ComfyUI** as its unified AI execution engine. We do **not** install TRELLIS natively inside the local-compute-node Python environment to avoid Windows CUDA compilation issues and PyTorch version conflicts.

Instead, the local-compute-node routes image-to-3d jobs to ComfyUI via the comfyui_client.py adapter.

## 2. Setup Guide: Installing TRELLIS

### Step A: Install ComfyUI-TRELLIS
1. Open your ComfyUI installation directory.
2. Navigate to custom_nodes/.
3. Clone the TRELLIS node pack:
   git clone https://github.com/PozzettiAndrea/ComfyUI-TRELLIS
4. Run the install script provided by the node pack (or install requirements via your ComfyUI Python environment).

### Step B: Download Checkpoints
1. Download the official TRELLIS weights from HuggingFace (e.g., TRELLIS-image-large or GGUF quantized models).
2. Place the models in your ComfyUI models directory, specifically models/trellis/ (or wherever the custom node specifies).

### Step C: Export the Workflow
1. Open the ComfyUI web interface.
2. Build a workflow that:
   - Loads an image.
   - Generates a TRELLIS 3D mesh.
   - Saves the output as a .glb file using a Save3D node.
3. Enable "Enable Dev mode Options" in ComfyUI settings.
4. Click **Save (API Format)**.
5. Save the file as 	rellis_default.json.
6. Replace the placeholder workflow in Viper-Studios/local-compute-node/workflows/trellis_default.json with this newly exported file.

## 3. Fallback Behavior & Failure Modes
**The Golden Rule:** *Never let an AI failure crash the Forge.*

- **Workflow Missing:** If 	rellis_default.json is missing or invalid, the backend instantly falls back to providing a valid procedural test GLB (sideTable.glb).
- **OOM / Node Crash:** If ComfyUI runs out of VRAM or fails during the generation, the backend traps the timeout or error, releases the GPU semaphore, logs the failure, and returns the test GLB.
- **Compute Safety:** All 3D generations are protected by the gpu_semaphore. They will queue up and wait rather than crashing the system with concurrent VRAM spikes.
