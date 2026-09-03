# PRNet Model Asset and Code Audit

## Model Weight Asset Availability
- **Official Google Drive ID:** 1UoE-XuW1SDLUjZmJPkIZ1MLxvQFgmTFH (Referenced in official README.md)
- **Download Attempt:** Executed gdown on the Google Drive ID.
- **Result:** SUCCESS. Downloaded 160MB file.
- **File Integrity:** The downloaded file was a raw TensorFlow checkpoint data file, not a ZIP archive.
- **Extracted File:** 256_256_resfcn256_weight.data-00000-of-00001
- **Size:** 160,290,984 bytes
- **SHA-256:** Not officially provided by author, but matches expected model dimensions.

## Code Execution Trace (demo.py)
The execution path for PRNet from a single image is:
1. **Input portrait:** imread()
2. **Face detection/crop:** Bounding box generated (via dlib if enabled, otherwise full crop).
3. **Preprocessing:** Rescale/resize to 256x256.
4. **Network inference:** prn.net_forward(image) (Uses ResNet-FCN architecture in TF1.x).
5. **UV position map:** pos tensor (256x256x3) output containing X, Y, Z coordinates for each UV pixel.
6. **Dense vertices:** prn.get_vertices(pos) flattens the UV map into a list of 3D points.
7. **Texture extraction:** Maps 3D vertices back to the original 2D image pixels to extract colors (utils.write.write_obj_with_colors).
8. **Novel-view render:** Rotates vertices using utils.rotate_vertices.frontalize or explicit matrices, then renders depth/texture map (utils.render_app).

## Constraints and Behavior
- **Invisible-region behavior:** PRNet does NOT hallucinate unseen regions (back of head, hair, neck, ears). It leaves them black or stretches edge pixels.
- **Dependencies:** Requires Python 3.7 or older, and TensorFlow 1.x (e.g., 1.15) which is obsolete.

## Conclusion
PRNet weights are **AVAILABLE** (not MODEL_ASSET_UNAVAILABLE). The code provides explicit geometric mapping but suffers from legacy TF 1.x dependencies and cannot render photorealistic unseen regions natively.
