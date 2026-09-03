# Comfy Aimdo Import Origin Audit

## Phase 1 Execution
**Target**: `comfy_aimdo`

### Search Results
- **Exact importing file**: `local-compute-node/ComfyUI/main.py`
- **Line number**: `55`
- **Import statement**: `import comfy_aimdo.control`
- **Responsible package**: Upstream ComfyUI `main.py`
- **Dependency Classification**: **REQUIRED COMFYUI CORE DEPENDENCY**
- **Git Commit Introduction**: `main.py` line `55` was added as part of the dynamic VRAM performance features introduced around ComfyUI PR `#11845` ("Reduce RAM usage, fix VRAM OOMs... adaptive model loading") and incrementally upgraded through `comfy-aimdo==0.4.10` in PR `#14116` / `#14489`.
- **Standard Upstream?**: Yes. This is an official dependency in standard upstream ComfyUI.
- **Local Modification?**: No. This is not a Viper Studios modification. The dependency exists explicitly in `local-compute-node/ComfyUI/requirements.txt` on line 26 as `comfy-aimdo==0.4.10`.

## Conclusion
The module `comfy_aimdo` is not a rogue local script or an optional custom node. It is a strictly required memory-management core dependency of modern ComfyUI that was simply missing from the active virtual environment because `pip install -r requirements.txt` had not been executed following the latest upstream ComfyUI pull.
