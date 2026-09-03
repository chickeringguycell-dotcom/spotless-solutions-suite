# Open Source Forensic Inventory
**Date:** 2026-07-18

An audit of relevant systems downloaded, installed, or previously tested in the local Viper Studios environment.

| System | Installed Status | Weight Status | License | Commercial | 8GB Feasible | Exact Limitation |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **ComfyUI** | OPERATIONAL | Present | GPL | YES | YES | Orchestration only, lacks innate 3D geometry priors. |
| **Stable Diffusion 1.5** | OPERATIONAL | Present | OpenRAIL | YES | YES | Lacks multi-view consistency without adapters. |
| **SDXL** | OPERATIONAL | Present | OpenRAIL | YES | YES | Lacks multi-view consistency; 8GB VRAM requires aggressive optimization. |
| **IP-Adapter** | OPERATIONAL | Present | Apache 2.0 | NO* | YES | *Depends on InsightFace (AntelopeV2), poisoning commercial viability. |
| **ControlNet** | OPERATIONAL | Present | Apache 2.0 | YES | YES | Requires external pre-processors (e.g., OpenPose, Depth). |
| **CLIP Vision** | OPERATIONAL | Present | MIT | YES | YES | Embeddings are global, losing fine facial geometry details. |
| **TRELLIS** | PARTIALLY_OPERATIONAL | Present | Apache 2.0 | YES | NO (16GB req) | Hardware blocked for full precision; struggles with detailed facial identity without ControlNet. |
| **Stable Fast 3D** | INSTALLED_UNTESTED | Missing | MIT | YES | YES | Focuses on generic objects, not photorealistic identity-preserving human heads. |
| **TripoSR** | OPERATIONAL | Present | MIT | YES | YES | Low polygon count; terrible at preserving facial identity from a single image. |
| **SAM / SAM 3D** | OPERATIONAL | Present | Apache 2.0 | YES | YES | Segmentation only; does not generate novel views. |
| **3DDFA_V2** | INSTALLED_UNTESTED | Present | MIT | YES | YES | DEPENDENCY_FAILED (Cython/MSVC compilation blocked on native Windows). |
| **DECA** | INSTALLED_UNTESTED | Present | Non-Commercial | NO | YES | LICENSE_BLOCKED (FLAME dataset). PyTorch3D compilation fails natively. |
| **PRNet** | INSTALLED_UNTESTED | Present | MIT | NO | YES | LICENSE_BLOCKED (BFM dataset). Requires TF 1.15. |
| **PanoHead** | DOWNLOADED_NOT_INSTALLED | Present (500MB pkl) | Nvidia | NO | YES | LICENSE_BLOCKED (FFHQ). Requires custom CUDA Ninja ops that fail natively. |
| **MediaPipe** | OPERATIONAL | Present | Apache 2.0 | YES | YES | Only provides 2D front-facing landmarks. No depth profile extraction. |
