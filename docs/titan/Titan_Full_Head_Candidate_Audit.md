# Titan Full-Head Candidate Audit

**Phase 2: Revalidate the Next-Candidate Shortlist**

This audit evaluates candidates against the central Titan requirement: synthesizing a complete, identity-preserving head (including ears, hair, back of skull, and neck) from a single frontal portrait.

---

### 1. PanoHead
* **Exact Task:** 3D-aware GAN for full-head synthesis.
* **Input Requirements:** Image inversion (PTI) into latent space.
* **Output Capabilities:** 360° novel views, geometry (density), texture.
* **Full Head:** Yes (Includes back of head).
* **Includes Ears:** Yes.
* **Includes Rear Skull:** Yes.
* **Includes Scalp:** Yes.
* **Includes Hair:** Yes (Generates hair volume).
* **Includes Neck/Shoulders:** Yes (Upper neck).
* **Novel Views:** Yes (Full 360).
* **Preserves Identity:** Yes (High).
* **One Photograph:** Yes (Requires PTI inversion).
* **Code License:** MIT.
* **Weight License:** Non-Commercial (FFHQ-UV).
* **Dataset Restrictions:** FFHQ (Non-Commercial).
* **Commercial Status:** `DIRECT_INTEGRATION_CODE_RETRAIN_WEIGHTS`.
* **8 GB VRAM Feasibility:** Marginal (PTI requires heavy memory).
* **Expected GB001 Contribution:** Complete solution to the rear-skull and hair-volume gap.

### 2. DECA (Detailed Expression Capture and Animation)
* **Exact Task:** 3D Face Reconstruction with details.
* **Input Requirements:** Single cropped image.
* **Output Capabilities:** FLAME mesh parameters, albedo, displacement map.
* **Full Head:** Partial (FLAME topology represents the full skull, but lacks volume for hair).
* **Includes Ears:** Yes (Low detail).
* **Includes Rear Skull:** Yes (Bald).
* **Includes Scalp:** Yes (Bald).
* **Includes Hair:** No.
* **Includes Neck/Shoulders:** Yes (Neck only).
* **Novel Views:** Yes (Mesh rendering).
* **Preserves Identity:** Partial (Relies on facial shape, ignores hair).
* **One Photograph:** Yes.
* **Code License:** MIT.
* **Weight License:** FLAME (Non-Commercial).
* **Commercial Status:** `RESEARCH_ONLY` / `DIRECT_INTEGRATION_CODE_RETRAIN_WEIGHTS`.
* **8 GB VRAM Feasibility:** Excellent.
* **Expected GB001 Contribution:** Resolves ear geometry, but fails hair volume.

### 3. MediaPipe Face Mesh
* **Exact Task:** Real-time facial landmark tracking.
* **Output Capabilities:** 478 3D vertices (frontal mask).
* **Full Head:** No.
* **Includes Hair / Ears:** No.
* **Commercial Status:** `DIRECT_INTEGRATION_CODE_AND_WEIGHTS`.
* **Expected GB001 Contribution:** Insufficient geometry.

### 4. SyncDreamer
* **Exact Task:** Multiview-consistent image generation from a single image.
* **Output Capabilities:** 360° renders.
* **Full Head:** Yes.
* **Includes Hair / Ears:** Yes (Generated from depth inference).
* **Code License:** Apache 2.0.
* **Weight License:** Zero123 (Research Only).
* **8 GB VRAM Feasibility:** Marginal/Failed (Requires ~12GB+).
* **Expected GB001 Contribution:** High visual quality, but poor multi-view identity consistency for humans.

---

### Conclusion

**PanoHead** is the only candidate that mathematically reconstructs the **entire** head (ears, scalp, hair, rear skull) from a single image while preserving identity. **DECA** provides better facial detail but cannot synthesize hair volume, which is a critical failure for Titan's Gemini-parity requirement. 

Therefore, **PanoHead** is ranked above DECA despite its severe VRAM requirements and complex inversion process.
