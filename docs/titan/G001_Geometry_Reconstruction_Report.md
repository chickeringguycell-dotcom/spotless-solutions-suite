# Experiment G001: PRNet Geometry Extraction
**Status:** COMPLETE (Awaiting Human Acceptance)
**Date:** July 18, 2026

## Objective
To prove that PRNet can extract a flat identity-preserving UV map (texture), depth map, and 3D geometry from a single front-facing photograph (GB001: `1_SOURCE_PORTRAIT.jpg`) without requiring complex multi-view input. This fills the missing "Single-Shot 3D Face Reconstruction" capability in Project Titan.

## Procedure
1. Conducted a full model and license audit for PRNet. Found the legacy TensorFlow 1.15 weights and built a compatible environment (`titan_tf115`) to run it locally on CPU/GPU.
2. Traced the source code and resolved dependency collisions (protobuf <= 3.20.0).
3. Overcame two major Python datatype bugs in legacy `skimage.io.imsave` where `float64` images caused I/O crashes:
   - Patched `demo.py` line 78 (`isImage` save).
   - Patched `utils/write.py` line 96 (`texture` save).
   - Patched `demo.py` line 102 (`depth` save).
4. Ran PRNet inference on the Golden Benchmark `1_SOURCE_PORTRAIT.jpg`.

## Results
PRNet successfully outputted the following evidence artifacts to `evidence/photo_skill_acquisition/G001_PRNet`:
- `1_SOURCE_PORTRAIT.obj`: 3D Face Mesh geometry (6.8 MB).
- `1_SOURCE_PORTRAIT.mtl`: Material definition.
- `1_SOURCE_PORTRAIT_texture.png`: Flattened UV texture map containing the identity of the source subject.
- `1_SOURCE_PORTRAIT_depth.jpg`: Z-depth map of the face.
- `1_SOURCE_PORTRAIT_depth.mat`: Raw depth matrix.

## Conclusion
The G001 Experiment is a success from an engineering perspective. PRNet correctly performs Single-Shot 3D Face Reconstruction and UV Position Map generation from a 2D photograph. 

## Next Steps (I001)
The next experiment (I001) will feed the PRNet outputs (UV texture, depth map, or 3D renderings) into an IP-Adapter/ControlNet ablation to prove we can synthesize a novel view (such as the Gemini left-facing profile target) while perfectly preserving the identity.

> [!WARNING]
> **Awaiting Human Acceptance**
> In accordance with Rule 17 (Victory Gate), I cannot declare this a full victory until the user visually inspects the `.obj`, `_texture.png`, and `_depth.jpg` files in the `G001_PRNet` directory to confirm they match expectations for Avatar Forge.
