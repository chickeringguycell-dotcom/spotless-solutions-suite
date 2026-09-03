# Build-Tool Necessity Audit

## Phase 3 — Build-Tool Necessity Audit

| Component | Compilation Requirement | Safer Execution Path Available? | Classification |
|:---|:---|:---|:---|
| **PyTorch3D** | High (Requires C++ / CUDA Toolkit) | Prebuilt unofficial wheels exist (e.g., from cgohlke for specific Python versions), or Conda `pytorch3d -c pytorch3d` (sometimes CPU only on Windows). | `REQUIRES_ISOLATED_ENVIRONMENT` (Can attempt prebuilt wheels first) |
| **nvdiffrast** | High (Requires C++ / CUDA Toolkit) | Pure Python/OpenGL fallback mode exists, or prebuilt wheels via third parties, but CUDA mode requires local compiler. | `AVAILABLE_NOW` (Via OpenGL fallback or ComfyUI bundled binaries) |
| **InsightFace** | Low (Cython/C++ for some bbox ops) | Prebuilt Windows wheels (`insightface-0.7.3-cp310-cp310-win_amd64.whl`) widely available on PyPI. | `AVAILABLE_NOW` |
| **Sim3DR** (3DDFA) | High (C++ extension) | Prebuilt wheels are rare. Pure python fallbacks are slow but exist in some forks. | `REQUIRES_BUILD_TOOLS` |
| **Diffusers (IP-Adapter/PuLID)** | None (Pure Python) | `pip install diffusers transformers accelerate` works seamlessly. | `AVAILABLE_NOW` |

**Conclusion**: Build tools are not strictly necessary to test GB001 profile generation if we use diffusion-based methods (IP-Adapter/PuLID) via HuggingFace `diffusers` or `ComfyUI`. For geometry testing (PyTorch3D/nvdiffrast), we can attempt Conda prebuilts or OpenGL fallbacks before concluding C++ tools are unavoidable.
