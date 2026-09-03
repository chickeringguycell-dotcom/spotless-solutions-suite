# Viper Studios Provider Integration Matrix

## Image Generation
- **Primary Provider**: \LocalComfyUIProvider\ (Production-Ready)
- **Fallback Provider**: \MockImageGenerationProvider\
- **Status**: The Real ComfyUI Image Pipeline is officially marked as production-ready. It integrates safely with the ComputeJobManager, GPU semaphore, Review Gate, and Project Memory persistence layers.
- **Fail-safe**: Fully validated. If the Local Compute Node is offline or ComfyUI crashes, the pipeline instantly diverts to the mock provider to maintain Forge stability.

## Image-to-3D Generation
- **Primary Provider**: \Trellis3DProvider\ (Scaffolded, Pending Validation)
- **Fallback Provider**: \MockImageTo3DProvider\ (Active)
- **Status**: Awaiting manual ComfyUI-TRELLIS installation validation. The integration scaffolding (Compute node, workflow placeholders, semaphore protection) is complete.

## Procedural Generation
- **Primary Provider**: \MockProceduralProvider\ (Active)

## Avatar Generation
- **Primary Provider**: \OpenAvatarProvider\ (Scaffolded)
