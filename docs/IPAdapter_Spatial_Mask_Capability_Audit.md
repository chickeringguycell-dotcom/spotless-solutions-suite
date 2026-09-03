# IP-Adapter Spatial Mask Capability Audit

## 1. Objective
Determine whether the current `LOCAL_COMFYUI` pipeline components support spatial/attention masking for IP-Adapter to restrict its semantic influence to specific image regions (e.g., the target head).

## 2. Infrastructure Inspected
* **Provider**: `LOCAL_COMFYUI`
* **Node Installed**: `IPAdapterAdvanced` from `ComfyUI_IPAdapter_plus` extension.
* **Documentation**: `custom_nodes/ComfyUI_IPAdapter_plus/NODES.md`
* **Source Code**: `IPAdapterPlus.py`

## 3. Findings
The `IPAdapterAdvanced` node possesses an optional input named `attn_mask`.
* **Exact Node Name**: `IPAdapterAdvanced`
* **Exact Input Name**: `attn_mask`
* **Input Tensor Type**: `MASK` (ComfyUI native 2D/3D float mask tensor)
* **Expected Dimensions**: `[1, H, W]` or `[H, W]`
* **Expected Value Range**: `[0.0, 1.0]` (grayscale float)
* **Expected Polarity**: 
  * White (`1.0`) = Maximum IP-Adapter influence.
  * Black (`0.0`) = Zero IP-Adapter influence (unaffected).
* **Resize Behavior**: The node automatically resizes the mask via `T.Resize` (BICUBIC interpolation) to match the latent space dimensions or aspect ratio during application.
* **Execution Semantics**: The mask is applied to the cross-attention blocks in the U-Net. It limits the output-space influence of the IP-Adapter injection. It *does not* limit the reference-image encoding (CLIP Vision still sees the whole source image).
* **Mask Consumption**: Confirmed active in `IPAdapterPlus.py:1022` and passed deeply into the IP-Adapter hooking mechanism.

## 4. Conclusion
**Classification**: `VERIFIED_MASK_SUPPORT`

The current infrastructure is fully capable of applying an output-space attention mask to the IP-Adapter conditioning. No new extensions or downloads are required. We can proceed with Phase 2 (Target Head Mask Contract).
