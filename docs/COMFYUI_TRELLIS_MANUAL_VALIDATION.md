# ComfyUI-TRELLIS Manual Validation Plan

This document outlines the strict, step-by-step manual validation process for installing, testing, and exporting the ComfyUI-TRELLIS integration. **Do not attempt to trigger a TRELLIS generation from Viper Studios until every step in this checklist is complete.**

## 1. Prerequisites
- **Hardware:** Minimum 8GB VRAM (with aggressive optimizations) or 16GB+ VRAM for standard generation.
- **Environment:** Windows OS, Python 3.10+, ComfyUI installed and operational.
- **Risks:** The ComfyUI-TRELLIS node requires CUDA compilation (like cumesh). Ensure you have Visual Studio C++ Build Tools installed. PyTorch version mismatches are common.

## 2. Installation Steps
1. Navigate to your ComfyUI installation directory.
2. Enter the custom_nodes folder.
3. Clone the node pack: git clone https://github.com/PozzettiAndrea/ComfyUI-TRELLIS
4. Install dependencies. Usually done by running pip install -r requirements.txt within the ComfyUI-TRELLIS folder using your ComfyUI Python environment. 
   *(Note: Some node packs provide an install.bat file to handle this).*
5. **Download Models:** Download the official TRELLIS weights or community-provided GGUF quantized models.
6. **Model Path:** Place the downloaded model folders/files exactly where the ComfyUI-TRELLIS README specifies (usually inside ComfyUI/models/trellis/).
7. Restart ComfyUI. Watch the console logs on startup to ensure the TRELLIS custom node is loaded successfully and no import errors are thrown.

## 3. The Smoke Test
Before touching Viper Studios, you must prove ComfyUI can generate 3D:
1. Open the ComfyUI web interface (http://127.0.0.1:8188).
2. Build (or load a provided example) a minimal TRELLIS workflow:
   - Load Image node -> TRELLIS 3D Generator node -> Save 3D Mesh (.glb) node.
3. Load a simple reference image (e.g., a prop with a solid background).
4. Click **Queue Prompt**.
5. Monitor VRAM usage. If it crashes, enable "Low VRAM Mode" on the TRELLIS node.
6. Verify a .glb file is produced in the ComfyUI output/ directory.
7. Open the .glb file in the default Windows 3D Viewer or Blender to confirm it contains valid mesh geometry.

## 4. Workflow Export
Once the smoke test succeeds, you must export the workflow so Viper Studios can use it.
1. In ComfyUI, go to Settings (gear icon).
2. Check **Enable Dev mode Options**.
3. Close settings. You will now see a **Save (API Format)** button.
4. Click **Save (API Format)** and save the file.
5. Rename the file to 	rellis_default.json.
6. Copy 	rellis_default.json into Viper Studios at: local-compute-node/workflows/trellis_default.json, replacing the placeholder.
7. **Crucial Mapping:** Ensure that the input image node uses the filename assigned by comfyui_client.py (which injects uploaded_filename into the LoadImage node). Our client currently assumes node "1" is the LoadImage node and node "2" is the TRELLIS generator. If your exported JSON has different node IDs, you must either edit the JSON IDs to match or update comfyui_client.py's injection logic.

## 5. Expected Failure Handling
- **Missing Node Pack:** The ComfyUI console will show import errors on startup.
- **Missing Checkpoint:** The TRELLIS node will turn red and throw a "Model not found" error when you Queue Prompt.
- **CUDA Compile Failure:** pip install will throw massive red C++ compilation errors. Ensure VS Build Tools are installed.
- **OOM Error:** ComfyUI will crash or halt mid-generation. Restart ComfyUI with --lowvram and enable gradient checkpointing.
- **No .glb Output:** Ensure your workflow terminates with a Save3D node, not just a preview node.

## 6. Viper Readiness Checklist
- [ ] ComfyUI reachable at http://127.0.0.1:8188
- [ ] TRELLIS custom node loads without terminal errors
- [ ] Models loaded successfully in ComfyUI
- [ ] Manual generation produced a valid .glb
- [ ] API format workflow exported to local-compute-node/workflows/trellis_default.json
- [ ] Viper local-compute-node health endpoint reports: "trellis_workflow_present": true and "trellis_status": "ready"
- [ ] Viper still falls back safely to test GLBs if ComfyUI is abruptly killed

## 7. Final Recommendation
**Do not proceed to live Viper integration testing until the manual ComfyUI test produces a real .glb.** 
Debugging 3D generation failures inside Viper Studios is nearly impossible if the underlying ComfyUI pipeline is broken. Isolate, validate, and verify in ComfyUI first.
