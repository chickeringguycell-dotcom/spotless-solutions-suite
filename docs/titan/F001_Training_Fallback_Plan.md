# F001 Training Fallback Plan

If no commercially usable pretrained solution meets the requirement, Titan will produce its own model.

## Plan Summary
- **Foundation architecture:** Stable Diffusion 1.5 + IP-Adapter + Image-native View Synthesis (e.g., ControlNet Azimuth/Elevation conditioning) OR Triplane 3D-GAN.
- **Legally Reused Components:** SD1.5 Base Model (CreativeML Open RAIL-M), IP-Adapter (Apache 2.0).
- **Required training objective:** Train a ControlNet or LoRA to explicitly control camera azimuth/elevation for human portraits, or train a Triplane generator.
- **Multi-view identity dataset requirements:** High-quality multi-view dataset of humans (360 degrees).
- **Synthetic-data options:** Render realistic humans using commercially licensed Unreal Engine Metahumans.
- **Commercially licensed data options:** Purchasing stock multi-view human scans.
- **Compute requirements:** 8x A100 80GB (Cloud).
- **Estimated training time:** 2-4 weeks.
- **8 GB local-development strategy:** Train on low-res (256x256) subsets locally for code validation before cloud deployment.
- **Production licensing:** Fully owned by Viper Studios.
