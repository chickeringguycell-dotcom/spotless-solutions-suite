# Experiment 013 Img2Img Node & Dataflow Audit

## Nodes Investigated
- LoadImage
- VAEEncode
- KSampler
- VAEDecode
- SaveImage
- ControlNetLoader
- ControlNetApplyAdvanced
- IPAdapterAdvanced
- IPAdapterModelLoader
- CLIPVisionLoader

## Dataflow Contract
- **Image Tensor Type**: IMAGE (pixel space representation)
- **Latent Tensor Type**: LATENT (encoded spatial representation)
- **Expected Dimensions**: 512x512 (encoded to 64x64 latent)
- **VAE Ownership**: VAEDecode and VAEEncode handle pixel <-> latent conversion.
- **Model Ownership**: KSampler controls denoising with MODEL.
- **Conditioning Ownership**: ControlNetApplyAdvanced modifies CONDITIONING space via CANNY_PROFILE.
- **IP-Adapter Model Flow**: Applies global token influence to the cross-attention layers of the MODEL.
- **ControlNet Conditioning Flow**: Applies spatial bias directly to the latent noise prediction.
- **KSampler Latent Input**: Receives either EmptyLatentImage (txt2img) or VAEEncode output (img2img).

Conclusion: The dataflow contract allows VAEEncode to pipe image pixels into the latent space for Stage 2 img2img initialization.
