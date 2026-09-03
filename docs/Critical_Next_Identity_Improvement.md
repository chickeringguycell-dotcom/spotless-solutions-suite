# Critical Next Identity Improvement

## Identified Improvement
**Repair the ComfyUI Installation (Locate/Replace `comfy_aimdo`)**

## Rationale
Experiment 005 execution is completely halted by a factual blocker. The local ComfyUI installation is missing a critical, presumably proprietary dependency (`comfy_aimdo`). This prevents the application from booting.

Since we are strictly forbidden from using mock inference, no further validation of the Dual-Conditioning pipeline can occur until the local generation server is fully operational. 

## Required Action
Before proceeding, the `comfy_aimdo` package must be installed, or the dependency must be decoupled from the `main.py` entrypoint.
