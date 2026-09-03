# Operational Rerun Results

## Phase 3: Physical Candidate Re-Run Truth

### 1. MediaPipe
- **Environment**: 	itan_mp
- **Python/Lib Version**: MediaPipe 0.10.35
- **CUDA Availability**: CPU-bound
- **Run Command**: conda run -n titan_mp python -c "import mediapipe as mp; print(mp.__version__)"
- **Exit Code**: 0
- **Status**: **OPERATIONAL**

### 2. PRNet
- **Environment**: 	itan_prnet
- **Python/Lib Version**: TensorFlow 2.13.0
- **CUDA Availability**: None reported (TF2 API mismatch with PRNet's TF1 codebase)
- **Run Command**: conda run -n titan_prnet python -c "import tensorflow as tf; print(tf.__version__)"
- **Exit Code**: 0 (But structurally incapable of running PRNet code).
- **Status**: **DEPENDENCY_FAILED** (Requires TF 1.15, environment drifted to 2.13.0).

### 3. 3DDFA_V2
- **Environment**: 	itan_3ddfa
- **Python/Lib Version**: PyTorch 2.13.0+cpu
- **CUDA Availability**: False (+cpu)
- **Run Command**: conda run -n titan_3ddfa python -c "import torch; print(torch.__version__)"
- **Exit Code**: 0 (But lacks CUDA rendering, structural failure for 3D generation).
- **Status**: **DEPENDENCY_FAILED / HARDWARE_BLOCKED**

### 4. DECA
- **Environment**: 	itan_deca
- **Python/Lib Version**: PyTorch 1.11.0+cu113
- **CUDA Availability**: True
- **Run Command**: conda run -n titan_deca python -c "import torch; print(torch.__version__)"
- **Exit Code**: 1
- **Raw Execution Log**: Failed to initialize NumPy: _ARRAY_API not found... A module that was compiled using NumPy 1.x cannot be run in NumPy 2.0.2 as it may crash.
- **Status**: **DEPENDENCY_FAILED**

### 5. PanoHead
- **Environment**: 	itan_panohead
- **Status**: **DEPENDENCY_FAILED** (Missing ninja/torch-extensions and intuned_generator.pkl).

## Conclusion
The physical rerun definitively proves that **0 out of 4** local legacy human-geometry candidates are currently operational on the GPU. MediaPipe is the only functioning module, and it only extracts 2D landmarks.
