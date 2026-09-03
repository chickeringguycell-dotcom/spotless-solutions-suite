# Titan Code Reuse Decision

## Phase 11 — Code Reuse Decision
- **Component**: MediaPipe Face Landmarker
  - **License**: Apache 2.0
  - **Decision**: `PROVIDER WRAPPER` (Once Python dependencies are approved for install)
- **Component**: 3DDFA_V2
  - **License**: MIT (Code) / Non-Commercial (Weights)
  - **Decision**: `REJECT` for production; `RESEARCH_REFERENCE` (if installed)
- **Component**: InsightFace / ArcFace
  - **License**: MIT (Code) / Non-Commercial (Weights)
  - **Decision**: `REIMPLEMENT` (Original Titan Encoder trained on Viper Synthetic Dataset V0)
- **Component**: PyTorch3D / nvdiffrast
  - **License**: BSD / NV Source Code
  - **Decision**: `PROVIDER WRAPPER` (When C++ environment is available)
