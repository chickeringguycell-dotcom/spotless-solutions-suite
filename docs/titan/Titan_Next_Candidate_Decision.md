# Titan Next-Candidate Decision

## Phase 8 — Next-Candidate Decision

- **Candidate in Question**: PuLID (SDXL)
- **Decision**: DO NOT TEST YET
- **Justification**: The GB001 benchmark test on IP-Adapter FaceID (SD1.5) failed exclusively due to `HARDWARE_BLOCKED` (lack of an 8GB+ CUDA GPU). PuLID requires an even larger memory footprint (>12GB VRAM) because it runs atop Stable Diffusion XL. Testing PuLID would encounter the exact same hardware failure without providing any new intelligence on cross-view identity preservation. 
- **Required Action**: Do not install PuLID. The next Titan command must resolve the GPU access constraint before further image-generation candidate testing resumes.
