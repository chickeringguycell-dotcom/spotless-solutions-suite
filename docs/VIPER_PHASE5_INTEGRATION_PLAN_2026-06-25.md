# Viper Studios - Phase 5 Integration Plan
**Date:** 2026-06-25

## 1. Executive Summary & Recommendations

### Recommended First Tool: **TripoSR**
TripoSR (by Tripo AI and Stability AI) is the recommended first integration target.
- **Open Source Status:** MIT License.
- **Installation Complexity:** Low. Simple Python dependencies (`torch`, `transformers`, `trimesh`).
- **Hardware Requirements:** Low VRAM footprint (~6-8GB for default chunk sizes), heavily optimized for feed-forward inference.
- **Windows Compatibility:** High. Runs natively on Windows via standard PyTorch + CUDA installations.
- **Model Size:** ~1.5 - 2GB.
- **Output Formats:** `.obj`, `.glb`.

### Recommended First Test Case: **Simple Furniture Object** (e.g., a chair or table)
The Furniture Forge will handle this request.
- **Why?** Furniture objects have clear structural references, ground planes, and scale, making them ideal for testing the full pipeline (image -> 3D -> validation).

---

## 2. Why Not the Alternatives First?

### Alternative Tools Rejected for Initial Integration:
- **Trellis:** While producing superior quality, it requires significantly higher VRAM (12-16GB for standard inference) and involves more complex Windows installations (Flash Attention). It is better suited for Phase 6 (high-fidelity upgrades).
- **InstantMesh:** A strong contender, but TripoSR provides slightly easier dependency management and a slightly faster feed-forward loop for an initial infrastructure test.
- **Meta SAM 3D:** Focuses primarily on 3D segmentation of existing scenes/point clouds rather than pure 2D-to-3D generative asset creation.
- **Blender Pipeline:** Blender is an assembly and rendering tool, not a pure neural mesh generator. We will use Blender to *assemble* assets, but we need a generator like TripoSR first.

### Alternative Test Cases Rejected for Initial Integration:
- **Colonial Viper Part Generation:** Fails the "simple" criteria. Per Viper Studios rules, spacecraft must be built modularly (Space Forge). Orchestrating a multi-part generation pipeline is too risky for a first test.
- **Hair/Fur Test:** Generating 3D hair (Hair Studio) is notoriously difficult (requiring particle systems or hair cards) and poorly supported by basic image-to-3D models.
- **Creature Test:** Requires rigging, skin weights, and skeletal validation, which introduces too many variables.
- **Simple Prop/Tool:** Acceptable, but furniture offers better generic geometric bounds (e.g., resting flat on a floor) for validating coordinate system alignment (Y-up vs Z-up).

---

## 3. Required System Dependencies
- **Python:** 3.10 or 3.11
- **CUDA Toolkit:** 11.8 or 12.1+ (Windows)
- **Python Packages:** `torch`, `torchvision`, `transformers`, `trimesh`, `einops`, `rembg` (for background removal prior to TripoSR).
- **Storage Impact:** ~2GB for model weights, ~1GB for Python environment. Extremely manageable compared to diffusion models.

---

## 4. Integration with Helios Architecture

### 4.1 Plugging into Helios
1. **Capability Registry:** Register `image_to_3d_triposr`.
2. **Tool Registry:** Add a `generate_3d_from_image` tool that triggers a Helios Job.
3. **Execution:** The Node.js API server will spawn a `child_process` (or communicate via a local Python microservice) running the TripoSR inference script.
4. **Photo-to-Forge Router:** Helios will identify the image as "furniture", route it to **Furniture Forge**, which will dispatch the TripoSR job.

### 4.2 Mission Control Flow
1. User uploads a photo of a chair.
2. Helios logs a job in the **Helios Job Queue** (`capability: furniture_forge`).
3. Mission Control displays the active job in the **HELIOS JOBS** panel.
4. Progress updates (0% -> 50% -> 100%) are streamed back to the SQLite job table and reflected in the UI.

### 4.3 Universal Review Queue
1. Upon job completion, TripoSR outputs a `.glb` file to a secure temporary staging directory.
2. A new Review Item is created in the **Universal Review Queue** with the status `waiting_review`.
3. The Review Execution Planner generates a safe plan (e.g., "Copy staging/chair.glb to public/assets/furniture/chair.glb").
4. The user inspects the asset. If approved, the **Execution Validator** ensures the file is safe (no path traversal, valid binary header) and executes the move.

---

## 5. What Success Looks Like
- A user provides a 2D image of a chair.
- Helios successfully queues the task without blocking the API server.
- The Python script executes TripoSR, generating a 3D mesh within 10-20 seconds.
- Mission Control tracks the job to 100% completion.
- A Review Queue item is generated.
- The user approves the item, and the `.glb` file safely lands in the Viper Studios workspace without directly mutating protected assets.

---

## 6. Exact First Implementation Command

When we are ready to begin Phase 5 implementation, run this command to set up the Python environment and download the TripoSR wrapper script:

```bash
cd artifacts/api-server && python -m venv venv && .\venv\Scripts\activate && pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121 && pip install transformers trimesh rembg einops
```
