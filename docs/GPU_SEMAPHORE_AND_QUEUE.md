# Local Compute Node: GPU Semaphore and Job Queue

## Purpose
Consumer GPUs have limited VRAM (typically 8GB to 24GB). Viper Studios orchestrates heavy AI workloads including SDXL image generation and (soon) TRELLIS/SAM3D for Image-to-3D. 

If multiple heavy inference tasks are submitted simultaneously, loading multiple models into VRAM will immediately trigger an Out-Of-Memory (OOM) crash, which violates the Viper Studios design philosophy: *Never let an AI failure crash the Forge.*

To prevent this, the local-compute-node implements a strict **GPU Semaphore** (a locking mechanism) that enforces a queue. 

## How it Works
1. **Lightweight Jobs**: Actions like simple metadata fetching or mock procedural fallbacks bypass the semaphore entirely. They execute immediately and concurrently.
2. **Heavy Jobs**: Requests categorized as image, image-to-3d, vatar, or material will pause execution if the GPU is currently busy.
3. **Queue State**: While waiting, the job's state is set to queued_waiting_for_gpu. Once it acquires the lock, it transitions to unning_on_gpu.

## Configuration
By default, the semaphore only allows **1** heavy job at a time.
If you are running on a multi-GPU setup or an enterprise A100 that can handle concurrent SDXL and TRELLIS runs, you can increase this limit via the environment variable:

`ash
export MAX_GPU_JOBS=2
uvicorn main:app --port 8000
`

## Diagnostics
The Holographic Dashboard directly polls the Python node and displays the real-time state of the semaphore in the upper left Persistence Diagnostics panel:
GPU ACTIVE: 1 / 1 | QUEUE: 2

## Safety and Timeout
- **Timeout**: The lock implements a strict 10-minute timeout (600s). If a job gets permanently stuck in ComfyUI or TRELLIS, the lock breaks automatically, preventing the entire studio from hanging indefinitely.
- **Graceful Fallback**: If a real GPU provider fails during execution (e.g., missing checkpoint, runtime error), the lock is released in a inally block, and the job safely degrades to the Mock Image Provider, ensuring the UI pipeline continues uninterrupted.
