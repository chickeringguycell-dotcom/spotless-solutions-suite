# Open-Source Code Lessons for Titan

This document formalizes the Mission A architectural findings extracted from the official Qwen-Image and FLUX repositories and whitepapers. These are engineering lessons to be built into Project Titan.

## 1. Attention & Caching Behavior
**Lesson**: Cross-Attention Caching (FLUX)
**Classification**: `OBSERVED IN CODE`
**Detail**: The FLUX architecture allows the caching of text-encoder cross-attention maps for identical prompt structures across multiple steps. If the Mistral-3 instruction doesn't change between frames, the text-embedding compute is skipped entirely. 
**Titan Proposal**: Implement `Viper_Context_Cache` in our engine so that static scene elements (lighting, style, static identity instructions) do not recompute their embeddings on every frame or iterative edit.

## 2. Multi-Reference Handling
**Lesson**: Multi-Module DiT Injection (Qwen-Image)
**Classification**: `OBSERVED IN DOCUMENTATION`
**Detail**: Qwen handles multiple reference images not by concatenating them into a giant latent grid (which destroys spatial coherence), but by mapping each image to independent reference tokens that the DiT queries natively.
**Titan Proposal**: Do not stitch Survey photos together. Titan must convert the Front, Profile, and Detail photos into independent identity embeddings and feed them as a batched list.

## 3. Mask Handling & Inpainting
**Lesson**: VAE Native Mask Concatenation
**Classification**: `STRONGLY INFERRED`
**Detail**: Modern open-source inpainting models do not rely solely on pixel-space masking. They concatenate a downsampled boolean mask directly into the latent noise tensor at the VAE stage, forcing the diffusion model to recognize the boundary natively.
**Titan Proposal**: When SentinelQC orders a correction, Titan must pass a native latent mask, not just an alpha-channel pixel overlay.

## 4. Memory Management Techniques
**Lesson**: GGUF Block Swapping
**Classification**: `OBSERVED IN CODE` (Community repositories)
**Detail**: To run large 7B models on 8GB VRAM, the community uses bitsandbytes and GGUF block swapping, pushing inactive attention heads to system RAM (DDR4/5) and only keeping active layers in VRAM (GDDR6).
**Titan Proposal**: If Viper Studios pursues quantized local execution, we must adopt dynamic layer-offloading rather than attempting to load the entire graph into VRAM simultaneously.

## 5. Step-Count Latent Anchoring
**Lesson**: Over-Diffusion Destroys Identity
**Classification**: `POSSIBLE`
**Detail**: Continuous observation of flow-matching (FLUX) and DiT (Qwen) indicates that the final 20% of generation steps are heavily biased toward the model's global priors (beautification, symmetry) rather than the strict reference inputs.
**Titan Proposal**: Develop a `Viper_Latent_Interceptor` that extracts the 3D mesh or image just before the final normalization steps to preserve raw asymmetry.

## Stable Diffusion 3.5 Medium (MMDiT-X)
- **Multi-Encoder Text Parsing**: Using three different language models (CLIP-L, CLIP-G, T5-XXL) provides superior adherence to spatial syntax over single-encoder architectures.
- **Multi-Encoder Text Parsing**: Using three different language models (CLIP-L, CLIP-G, T5-XXL) provides superior adherence to spatial syntax over single-encoder architectures.
- **Latent Inpainting Concatenation**: Mask-conditioned latent processing can restrict edits, but boundary behavior and collateral drift require validation.
- **Identity LoRA**: Identity LoRA is a candidate method requiring controlled evaluation. LoRA may improve subject consistency but does not guarantee exact identity preservation.
