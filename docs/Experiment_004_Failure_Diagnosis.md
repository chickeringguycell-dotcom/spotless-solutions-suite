# Experiment 004 Root Cause Failure Diagnosis

## The Diagnosis
The failure of Experiment 003 to produce a measurable human face was **NOT** caused by a "latent space collision" between IP-Adapter and ControlNet.

The root cause was a **FORMAT_MISMATCH** originating at Station 7C.

## Evidence

1. **The Code Audit:** 
   `station_7c_camera_geometry.py` does not output a valid OpenPose skeleton. It outputs a scatterplot of white dots `(255, 255, 255)` on a black background.
2. **ControlNet Expectation:** 
   The `control_v11p_sd15_openpose.pth` model is rigidly trained on the standard 18-point/68-point OpenPose colored heatmap encoding. It cannot interpret white dots.
3. **The Ablation Results:**
   - When ControlNet was used *without* IP-Adapter (Run B), the output was an unmeasurable blob. This proves the ControlNet path independently failed due to bad input.
   - When IP-Adapter was used *without* ControlNet (Run C), it succeeded.

## Required Conclusions (Classification)

- IP-Adapter Independent Path: **VERIFIED**
- ControlNet Independent Path: **FAILED** (due to bad input)
- Station 7C Control Compatibility: **FORMAT_MISMATCH**
- Dual Conditioning: **UNRESOLVED** (Cannot be tested until ControlNet receives valid input)
- SentinelQC Missing-Data Handling: **VERIFIED** (Updated to NOT_MEASURED)

## Next Single Improvement
We must completely rewrite `station_7c_camera_geometry.py` (or introduce a new adapter) to render standard, color-coded OpenPose skeleton lines and facial contours that the `control_v11p_sd15_openpose.pth` model can actually read. Only then can we truly test Dual Conditioning.
