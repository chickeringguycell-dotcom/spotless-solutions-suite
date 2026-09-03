# Phase 2: CUDA Compatibility Matrix

## Environmental Baselines
- **Target OS**: Windows
- **Target Python**: 3.10.20
- **Driver CUDA Max**: 13.3
- **Candidate Stack**: Diffusers, Accelerate, IP-Adapter, InsightFace

## PyTorch CUDA Matrix Selection
- **Selected Torch Version**: 2.3.1 (Latest stable equivalent via cu121 index)
- **Selected CUDA Runtime Wheel**: `cu121` (CUDA 12.1)
- **torchvision Version**: 0.18.1 (cu121)
- **Expected Disk Usage**: ~2.5 GB for the PyTorch core wheels.
- **Compatibility Rationale**: CUDA 12.1 wheels are the most proven stable configuration for Windows SD1.5 / Diffusers deployments. It sits well below the max driver compatibility (13.3) and contains its own bundled CUDA runtime library, meaning no global system modifications (like Visual Studio Build Tools or global PATH changes) are necessary.
- **Rollback Command**: `conda run -n titan_faceid_test pip uninstall -y torch torchvision && conda run -n titan_faceid_test pip install torch torchvision` (Restores to default PyPI behavior).
