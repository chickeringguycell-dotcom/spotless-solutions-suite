# Titan Retraining Requirements

**Phase 9: Direct Integration or Retraining Plan**

To satisfy the `DIRECT_INTEGRATION_CODE_RETRAIN_WEIGHTS` classification for the selected Tier A (PanoHead) architecture, Viper Studios must abandon the non-commercial FFHQ-UV model weights and execute an independent, commercial retraining pipeline.

---

### 1. Training Dataset Requirements
PanoHead's Tri-Grid Generator requires multi-view portraits with associated camera extrinsics and intrinsics. 
* **Quantity:** ~10,000 to 50,000 diverse human identities.
* **Views per Identity:** Minimum 3 to 5 (Front, Profiles, Back, Top).
* **Legal Status:** MUST BE commercially licensed stock photography, synthetic generative data (e.g., Unreal Engine Metahumans), or explicit opt-in creator scans.
* **Prohibited Datasets:** FFHQ, FFHQ-UV, MS1M, VGGFace2, 300W-LP.

### 2. Training Objectives
* **Primary Objective:** Train the Tri-Grid volume to correctly infer back-of-head and hair volume from a single frontal image.
* **Secondary Objective:** Train the discriminator to enforce photorealism specifically on the ears, neck, and scalp (areas where traditional 3DMMs fail).
* **Loss Functions:** Adversarial Loss (StyleGAN2), Multi-View Consistency Loss (Density rendering), Identity Preserving Loss (ArcFace/CosFace trained on commercial data).

### 3. GPU Hardware & Time Estimates
* **Architecture:** StyleGAN2 Tri-Grid Generator + Discriminator.
* **Resolution:** 512x512 output.
* **Hardware:** Minimum 4x A100 (80GB) or 8x RTX 4090/6000 Ada. 
* **Time:** ~7-10 days of continuous training to reach convergence.
* **Storage:** ~2 TB for the uncompressed multi-view dataset and intermediate checkpoints.

### 4. Validation Controls
To prove the retrained weights meet or exceed the Gemini targets:
1. **Control Set:** Held-out set of 500 identities.
2. **Identity Metric:** FaceNet cosine similarity > 0.85 across generated profiles.
3. **Volume Check:** Ray-cast density check to ensure hair/rear-skull volume is strictly > 0 (unlike PRNet/DECA masks).

### 5. Deployment Interface
Once retrained, the Tri-Grid module will be wrapped in the `FaceGeometryProvider` and `NovelViewRenderer` interfaces to be queried by Helios via `local-compute-node` APIs.

> [!CAUTION]  
> Do not begin this expensive training phase locally. This retraining plan must be submitted to Guy for cloud GPU allocation once the architecture itself is verified against GB001.
