# Provider Selection QA Matrix

| Prompt | Task Type | Selected Provider | Fallback Provider | Reason | Pass/Fail |
|--------|-----------|-------------------|-------------------|--------|-----------|
| "Generate a Colonial Viper concept image" | `image` (Expected: `image`) | `local_comfyui` (Expected: `local_comfyui`) | `mock_sdxl` | Standard image generation. Selected Local ComfyUI. | ✅ PASS |
| "Turn this approved vehicle image into a 3D model" | `image-to-3d` (Expected: `image-to-3d`) | `trellis_3d` (Expected: `trellis_3d`) | `mock_trellis` | Standard object generation. Selected TRELLIS. | ✅ PASS |
| "Build an avatar from this body reference" | `avatar` (Expected: `avatar`) | `sam_3d` (Expected: `sam_3d`) | `mock_avatar_forge` | Intent matches specialized body reconstruction or reference. Selected SAM 3D. | ✅ PASS |
| "Reconstruct a human body mesh" | `avatar` (Expected: `avatar`) | `sam_3d` (Expected: `sam_3d`) | `mock_avatar_forge` | Intent matches specialized body reconstruction or reference. Selected SAM 3D. | ✅ PASS |
| "Create a chair prop from this image" | `image-to-3d` (Expected: `image-to-3d`) | `trellis_3d` (Expected: `trellis_3d`) | `mock_trellis` | Standard object generation. Selected TRELLIS. | ✅ PASS |
| "Generate a material texture for brushed steel" | `image` (Expected: `image`) | `local_comfyui` (Expected: `local_comfyui`) | `mock_sdxl` | Standard image generation. Selected Local ComfyUI. | ✅ PASS |
| "Parse this scene into separate objects" | `image-to-3d` (Expected: `image-to-3d`) | `sam_3d` (Expected: `sam_3d`) | `mock_trellis` | Intent matches specialized scene parsing/segmentation. Selected SAM 3D. | ✅ PASS |
| "Make a VRM-ready character" | `avatar` (Expected: `avatar`) | `open_avatar` (Expected: `open_avatar`) | `mock_avatar_forge` | Standard avatar generation intent. Selected OpenAvatar. | ✅ PASS |
| "Create a creature like Fluffy" | `avatar` (Expected: `avatar`) | `open_avatar` (Expected: `open_avatar`) | `mock_avatar_forge` | Standard avatar generation intent. Selected OpenAvatar. | ✅ PASS |
| "Generate a structure layout" | `structure` (Expected: `structure`) | `mock_blender` (Expected: `mock_blender`) | `mock_blender` | Standard procedural generation. Selected Mock Blender. | ✅ PASS |
