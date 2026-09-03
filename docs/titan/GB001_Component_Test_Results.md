# GB001 Component Test Results

## Phase 4 — Isolated Installation Results
- **MediaPipe Face Landmarker**: `BLOCKED` (Requires Python environment changes and pip installs; aborted to prevent unauthorized system modification per Rule 31).
- **3DDFA_V2 / PRNet**: `LICENSE_BLOCKED` & `HARDWARE_BLOCKED` (Relies on 300W-LP restricted dataset; requires C++ build tools for PyTorch extension compilation on Windows, which constitutes a destructive/unauthorized environment change).
- **Titan Custom Identity Encoder**: `BLOCKED` (Requires Viper Dataset V0, which failed rendering due to missing Blender executable).

## Phase 7 — Component Tests
- **Landmark Test**: `BLOCKED` (MediaPipe installation aborted).
- **3D Reconstruction Test**: `BLOCKED` (3DDFA_V2 installation aborted).
- **Novel-View Test**: `BLOCKED`
- **Identity Test**: `BLOCKED`
- **UV-Style Test**: `BLOCKED`
