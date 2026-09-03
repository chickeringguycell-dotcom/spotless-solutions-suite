# Viper Studios Provider Roadmap

This document outlines the strategic integration path for external AI providers in Viper Studios. As per our core philosophy, we prefer self-hosted open-source models over commercial APIs to ensure sovereignty over the Viper pipeline.

## Active Providers
- **Local ComfyUI**: Primary local image generator (SDXL/Flux).
- **TRELLIS**: Primary Image-to-3D mesh generator for props and ships.
- **OpenAvatar**: Primary placeholder for open-source avatar generators.

## Provider Research: SAM 3D (Meta)

**SAM 3D** (Segment Anything Model 3D) is a suite of generative models released by Meta designed to reconstruct 3D objects and human bodies from 2D images. 

### Strengths
- **Dual Capability:** Contains "SAM 3D Objects" (general meshes) and "SAM 3D Body" (human pose/mesh reconstruction), making it highly versatile for Viper Studios.
- **Spatial Understanding:** Predicts depth, volume, and obscured sides of objects specifically engineered for "in-the-wild" clutter.
- **Unified Ecosystem:** Pairs seamlessly with SAM 2/3 for segmentation tasks.

### Weaknesses & Limitations
- **Heavy Compute Requirements:** Likely requires significant VRAM (24GB+) for local inference, mirroring heavy Diffusion Transformers (DiTs).
- **Early Stage:** Open-source weights and precise capabilities for game-ready topology are still emerging compared to established tools like TripoSR.
- **Licensing:** Meta's research licenses often restrict commercial use (e.g. CC-BY-NC). We must audit the exact license of the model weights before deployment.

### Positioning within Viper Studios
SAM 3D does not immediately replace TRELLIS or TripoSR. Instead, it is perfectly suited as a **specialized, optional provider selected by Helios**.
- For **general prop generation**, TRELLIS remains the default due to its speed and structured output.
- For **avatar/body reconstruction**, SAM 3D Body is uniquely positioned to handle complex pose regression and human mesh generation, potentially replacing `OpenAvatarProvider`.
- It can also serve as an advanced **segmentation/preprocessing stage** before feeding isolated objects into TRELLIS.

### Recommended Prototype Path
1. **Phase 1: Safe Scaffold (Current)**: Build the `SAM3DProvider` interface routing to the Local Compute Node without installing the model.
2. **Phase 2: Local Python Worker**: Once the weights are audited for commercial safety, wrap the official Meta SAM 3D Python API in a fast FastAPI worker.
3. **Phase 3: Integration**: Connect the Compute Node to the Python worker and allow Helios to route requests to it based on user prompts (e.g., "reconstruct this avatar from a photo").

## Helios Provider Selection Rules

Helios now acts as a dynamic router using a capability-based scoring system rather than relying purely on hardcoded fallbacks. The `ProviderSelector` analyzes intent:

- **Image Generation**: Uses `local_comfyui` as the primary generator.
- **Image-to-3D**: Defaults to `trellis_3d` for general objects. If the user prompt specifically requests "SAM", "segmentation", or "scene parsing", Helios routes the job to `sam_3d`.
- **Avatar Generation**: Defaults to `open_avatar`. If the user prompt requests "body reconstruction", "raw mesh", or explicitly mentions "SAM", Helios selects `sam_3d` Body for its advanced pose regression capabilities.
- **Diagnostics**: All routing decisions (Target Provider, Fallback Provider, and Reason) are logged and projected into the **Bay 05 Tech/Utility** holographic dashboard in real-time.
