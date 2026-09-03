# M001 MediaPipe Geometry Ablation

**Objective:** Determine whether MediaPipe provides enough geometry control to replace PRNet for profile generation.

**Setup:**
- ControlNet (Canny) input: Rendered left-profile wireframe derived from MediaPipe Face Landmarker (Delaunay triangulation on 478 points).
- Seeds: 100, 200, 300.

**MediaPipe Capability Classification:**
LANDMARK_COMPONENT
CAMERA_COMPONENT
PROFILE_CONTROL_COMPONENT

**MediaPipe Limitation Audit:**
- Landmark count: 478
- Relative depth: Yes
- Transformation matrix: Yes
- Blendshape coefficients: Yes
- Face oval: Yes
- Ear landmarks: NONE
- Hairline coverage: NONE
- Neck coverage: NONE
- Rear-head coverage: NONE
- Metric versus normalized geometry: Normalized with estimated scale
- Camera assumptions: Orthographic / Weak perspective

**Results (vs PRNet):**
MediaPipe-derived controls can improve requested-view compliance in the tested SD 1.5 pipeline. It successfully acts as a synthetic profile control image.
