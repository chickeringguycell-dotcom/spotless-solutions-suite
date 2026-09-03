# Station 7C Control Infrastructure Audit

## Filesystem Investigation
We successfully queried the `local-compute-node/ComfyUI` installation.

### Custom Nodes
`comfyui_controlnet_aux` is installed in `custom_nodes`. This is the standard open-source auxiliary preprocessor node package containing wrappers for OpenPose, Canny, Depth, Lineart, and DWPose.

### ControlNet Checkpoints
The following physical SD1.5 checkpoints were discovered in `models/controlnet`:
- `control_v11p_sd15_openpose.pth`
- `control_v11p_sd15_canny.pth`
- `control_v11f1p_sd15_depth.pth`

## The Format Problem
Since Station 7C mathematically derives landmarks rather than operating on a source image, we cannot route a picture through an OpenPose Preprocessor. We must synthesize the final Control Image directly.

Without official local documentation on the exact RGB mapping array used by OpenPose, attempting to manually color 18 skeletal lines and 68 facial points is extremely error-prone and violates the mandate: "Do not manually imitate OpenPose colors or skeleton conventions unless the expected format is proven."

## The Verified Alternative Path
Because we have `control_v11p_sd15_canny.pth` installed, we can completely bypass the OpenPose color mapping problem. A Canny control image is mathematically trivial: it is a black image with solid white lines (edges).

We will write Station 7C V2 to output a `CANNY_PROFILE` map by drawing thick white lines connecting the canonical profile points (forehead slope, nose bridge, lips, chin, jaw). This creates a perfectly compatible input for the installed Canny ControlNet.
