# Provider Improvement Backlog

## Identified Issues & Required Fixes

### 1. Station 7C: Control Format Mismatch
- **Status**: FIXED
- **Description**: `station_7c_camera_geometry.py` currently outputs a scatterplot of disconnected white dots (pure `255,255,255`) on a black background.
- **Why It Failed**: OpenPose ControlNet (`control_v11p_sd15_openpose.pth`) relies on standard OpenPose RGB skeleton encodings and facial contours. It cannot read raw scatterplots.
- **Action Required**: 
  - Rewrite the rendering logic in `station_7c_camera_geometry.py` to output 18-point body and 68-point facial OpenPose standard heatmap colors and line connections.
  - Or, generate a custom `control_v11p_sd15_station7c.pth` ControlNet trained specifically on our scatterplot format (high effort, not recommended).

### 2. SentinelQC: MediaPipe Failures
- **Status**: FIXED
- **Description**: When a generated image is completely corrupted, MediaPipe FaceMesh fails to detect landmarks.
- **Fix Applied**: SentinelQC no longer returns fabricated `-1` deviations. It correctly outputs `NOT_MEASURED` with `FACE_NOT_DETECTED`.

### 3. Dual-Conditioning Orchestration
- **Status**: FAILED (Requires Architecture Redesign)
- **Description**: IP-Adapter and ControlNet weighting mechanics cause latent space collision in FLUX2. IPAdapter entirely washes out the Canny spatial control, forcing the generation into a frontal view, or warps profile proportions beyond usability.
- **Action Required**: 
  - The Canny ControlNet is insufficient to anchor the head orientation against the semantic pull of IPAdapter.
  - Must investigate alternative structural control (e.g., Depth maps, robust 3D OpenPose) or train a specific LoRA to maintain spatial adherence.
