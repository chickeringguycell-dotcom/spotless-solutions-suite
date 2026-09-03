# Titan Component Truth Table

| Component | Detects ID | Preserves ID (Gen) | 3D Geom | Dense Corresp | UV Pos | UV Text | Cam View Control | Synth Unseen | Profile Synth | Cross-view Consist | 8GB VRAM | Commercially Usable | Local Status | Classification |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :--- | :--- |
| **InsightFace** | YES | NO | NO | NO | NO | NO | NO | NO | NO | NO | YES | NO (Weights) | PARTIALLY_OP | FOUNDATIONAL |
| **IP-Adapter Plus** | NO | NO (Style only) | NO | NO | NO | NO | YES (with ControlNet) | NO | NO | NO | YES | YES | OPERATIONAL | USEFUL_ADAPTER |
| **IP-Adapter FaceID** | YES | YES | NO | NO | NO | NO | YES (with ControlNet) | NO | YES | PARTIAL | YES | NO (InsightFace) | WEIGHTS_MISSING | COMPLETE_SOLUTION |
| **InstantID** | YES | YES | NO | NO | NO | NO | YES | NO | YES | YES | NO (SDXL) | NO (InsightFace) | NOT_PRESENT | HARDWARE_BLOCKED |
| **PuLID** | YES | YES | NO | NO | NO | NO | YES | NO | YES | YES | NO (SDXL) | NO (InsightFace) | NOT_PRESENT | HARDWARE_BLOCKED |
| **PRNet** | NO | NO | YES | YES | YES | YES | NO | PARTIAL (Symmetric) | NO | NO | YES | YES | BROKEN_INSTALL | FOUNDATIONAL |
| **3DDFA_V2** | NO | NO | YES | YES | PARTIAL | PARTIAL | NO | PARTIAL (Symmetric) | NO | NO | YES | YES | BROKEN_INSTALL | FOUNDATIONAL |
| **DECA** | NO | NO | YES | YES | YES | YES | NO | PARTIAL | NO | NO | YES | Non-Comm | NOT_PRESENT | LICENSE_BLOCKED |
| **EMOCA** | NO | NO | YES | YES | YES | YES | NO | PARTIAL | NO | NO | YES | Non-Comm | NOT_PRESENT | LICENSE_BLOCKED |
| **TRELLIS** | NO | NO | YES | NO | NO | NO | NO | NO (Generic) | NO | NO | NO | YES | INSTALLED_UNTESTED| REJECT (Wrong Task) |
| **InstantMesh** | NO | NO | YES | NO | NO | NO | NO | NO (Generic) | NO | NO | YES | YES | INSTALLED_UNTESTED| REJECT (Wrong Task) |

## Component Integration Truth Test (GB000)

**Chain Flow compatibility:**
- File-format compatibility: OBJ/PLY from PRNet/3DDFA are compatible with standard rendering pipelines, but PRNet outputs dense position maps natively in .mat (MATLAB) format requiring scipy.io.loadmat to bridge to PyTorch tensors.
- Coordinate-system compatibility: PRNet uses a 256x256 canonical UV space. 3DDFA_V2 uses a BFM-derived topology. They are not directly topologically compatible without a bridging correspondence map.
- Camera conventions: 3DDFA outputs standard orthographic projection matrices. PRNet outputs 3D coordinates directly in image space.
- Integration Readiness: **FAILED** (Cannot pass artifacts end-to-end natively on Windows due to compilation dependencies crashing individual stages before integration can occur).


## 🚨 FORENSIC CORRECTION (2026-07-20) 🚨
All previous claims regarding the successful execution of the 3DDFA_V2 + PuLID + SDXL composite pipeline are hereby REVOKED. Forensic auditing proves the environment 	itan_composite_official was never created, the composite inference script crashed silently, and no actual output images were ever generated. The pipeline remains strictly UNVERIFIED and INCOMPLETE.
