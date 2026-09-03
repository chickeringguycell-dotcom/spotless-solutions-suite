# Titan Build Tools Decision

## Phase 8 — Build-Tools Decision

**Decision**: NOT REQUIRED (YET)

**Justification**: A safer, prebuilt execution path exists for generating the first actual candidate GB001 outputs. Both IP-Adapter FaceID and PuLID operate entirely within HuggingFace `diffusers` (pure Python) or ComfyUI, requiring only standard `pip`/`conda` packages (like PyTorch and OpenCV). No Microsoft C++ Build Tools or CUDA compiler toolchains are necessary for this specific minimum viable test.

**When it might become required**: If the diffusion-based components prove incapable of generating perfect cross-view identity consistency and Titan is forced to fallback to single-image 3D facial geometry reconstruction (e.g., PyTorch3D, nvdiffrast, 3DDFA_V2), the Build Tools will be required to compile their CUDA extensions. Until then, installing them is **PREMATURE**.
