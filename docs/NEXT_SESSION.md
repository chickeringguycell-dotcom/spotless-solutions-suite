# NEXT SESSION OBJECTIVES

## Immediate Blocker
The physical ComfyUI compute node is non-functional.
Error: `ImportError: DLL load failed while importing _rigid_transform_cy: An Application Control policy has blocked this file`

## Next Required Actions
1. **Restore Generation Capability**: Locate the AppLocker blocking scipy DLL module, adjust the PYTHONPATH, or decouple the dependency from `main.py` so the ComfyUI server can boot successfully.
2. **Resume Experiment 005**: Once ComfyUI is online, execute the isolated ControlNet Smoke Test using the new `CANNY_PROFILE` geometry.
3. **Dual-Conditioning Run**: Complete Experiment 005 by combining IP-Adapter with the newly verified Canny geometry.
