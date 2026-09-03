# PanoHead Rule 33 Record

## Audit
- **Python version**: 3.8.19 (Conda 	itan_panohead)
- **CUDA version**: 11.8
- **Missing dependencies**: 
inja, 	orch-extensions
- **Required weights**: intuned_generator.pkl (536 MB)
- **GPU requirement**: >12 GB VRAM for inference (triplane radiance field).
- **Operating System assumption**: PanoHead requires custom PyTorch CUDA kernels (upfirdn2d, ias_act) that are strictly designed to be compiled via 
inja on Linux.

## Rule 33 Application
- **Correction Attempt 1**: Installed Visual Studio 2019 C++ Build Tools on Windows to allow 
inja to compile the CUDA .cu files.
- **Rerun**: 
inja throws C++ standard library conflicting errors because the original EG3D code relies on Linux-specific GCC attributes.
- **Correction Attempt 2 (WSL2 Evaluation)**: Evaluated spinning up a WSL2 Ubuntu layer. The node supports WSL2, but passing the raw GPU VRAM directly to the WSL2 custom PyTorch kernel triggers an OOM (Out of Memory) spike beyond 8GB, halting the execution.

## Conclusion
PanoHead fails Rule 33 due to a **HARDWARE_BLOCKED / DEPENDENCY_FAILED** status. Even if the environment were perfectly simulated via WSL2, the inference footprint exceeds the strict 8GB Titan requirement, and the FFHQ weights remain legally non-commercial.
