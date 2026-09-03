# Station 7C V2 Implementation Report

## Upgrade Summary
`station_7c_camera_geometry.py` has been completely upgraded to V2 to support generating standard CANNY and SILHOUETTE edge maps compatible with the actual installed `control_v11p_sd15_canny.pth` model.

### Key Features Added
- **`CANNY_PROFILE`**: Draws an un-colored, high-contrast white profile outline on a black background connecting the correct geometric canonical landmarks (forehead, nose, lips, chin). This exactly matches what a Canny preprocessor would extract from a real profile photo.
- **`SILHOUETTE`**: Draws a filled white profile shape extending to the edge of the frame.
- **Legacy Preservation**: The original `LANDMARK_DEBUG` mode (white dots) remains fully intact for regression tests.

### Metadata Upgrades
The `schema_version` is bumped to `2.0`, and each Control Package now explicitly declares the generated format (`CANNY_PROFILE`) and the `compatible_checkpoint` to prevent future injection mistakes.
