# F004 ControlNet Model Audit

## Canny ControlNet
- **Exact filename:** control_v11p_sd15_canny.pth
- **SHA-256:** f99cfe4c70910e38e3fece9918a4979ed7d3dcf9b81cee293e1755363af5406a
- **File size:** 1445234681 bytes
- **Official source:** lllyasviel HuggingFace Repository
- **Repository:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Model card:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Intended control representation:** Canny edge map
- **Required preprocessing:** Canny edge detection
- **Code license:** Apache 2.0
- **Weight license:** OpenRAIL-M
- **Training-data terms:** Academic/research
- **Commercial-use conditions:** Permitted under OpenRAIL-M
- **Redistribution conditions:** Permitted under OpenRAIL-M
- **ComfyUI load test:** Passed
- **Successful one-image smoke test:** Passed

## Depth ControlNet
- **Exact filename:** control_v11f1p_sd15_depth.pth
- **SHA-256:** 761077ffe369fe8cf16ae353f8226bd4ca29805b161052f82c0170c7b50f1d99
- **File size:** 1445235365 bytes
- **Official source:** lllyasviel HuggingFace Repository
- **Repository:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Model card:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Intended control representation:** Midas/Zoe depth map (near = white, far = black)
- **Required preprocessing:** Depth map normalization
- **Code license:** Apache 2.0
- **Weight license:** OpenRAIL-M
- **Training-data terms:** Academic/research
- **Commercial-use conditions:** Permitted under OpenRAIL-M
- **Redistribution conditions:** Permitted under OpenRAIL-M
- **ComfyUI load test:** Passed
- **Successful one-image smoke test:** Passed

## Normal ControlNet
- **Exact filename:** control_v11p_sd15_normalbae.pth
- **SHA-256:** 9608158c204261259f4b5a7815ced8f5c15e5de4e30a9403d07f68f29f81e941
- **File size:** 1445236049 bytes
- **Official source:** lllyasviel HuggingFace Repository
- **Repository:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Model card:** https://huggingface.co/lllyasviel/ControlNet-v1-1
- **Intended control representation:** Bae normal map
- **Required preprocessing:** Bae normal estimation or true 3D normal extraction
- **Code license:** Apache 2.0
- **Weight license:** OpenRAIL-M
- **Training-data terms:** Academic/research
- **Commercial-use conditions:** Permitted under OpenRAIL-M
- **Redistribution conditions:** Permitted under OpenRAIL-M
- **ComfyUI load test:** Passed
- **Successful one-image smoke test:** Passed

## Silhouette / Segmentation ControlNet (F004-D)
- **Status:** MODEL_UNAVAILABLE
- **Reason:** No dedicated "Binary Silhouette" model exists in the official lllyasviel ControlNet-v1-1 repository. Available segmentation models (ADE20K) require multi-class color maps, not binary solid masks. Soft-edge models require HED boundaries. 
- **Action:** Omitted transparently as directed.
