# Titan IP-Adapter FaceID Classification

**Candidate:** IP-Adapter FaceID (SD 1.5)
**Status:** `USEFUL_ADAPTER`

## Forensic Evaluation Answers
- **Does it preserve recognizable facial identity?** `PARTIAL`. It preserves the facial layout but drifts in micro-details (skin, eye shape), producing a stylized approximation rather than a photorealistic reconstruction.
- **Does it produce a true profile?** `FAIL`. Conditioned on a frontal identity embedding, it forces the geometry back toward the camera, resulting in a 3/4 view despite strict prompting.
- **Does it preserve ears, hairline, skull, neck, and shoulders?** `FAIL`. The InsightFace embedding crops closely to the face. The SD1.5 prior invents the rest of the skull, hair, and neck entirely.
- **Does it maintain identity across three seeds?** `PARTIAL`. The layout remains similar, but the generated hair, skin texture, and lighting drift significantly across seeds.
- **Can it contribute to a composite Titan pipeline?** `YES`. It is mechanically sound and computationally light, but must be paired with a geometric ControlNet (to force pose) and likely a stronger base model (SDXL) for photorealism.
- **Are its code and weights commercially usable?** `YES` (under standard open-source licenses for IP-Adapter/Diffusers, provided the base checkpoint is commercial).

## Isolated Root Cause of Parity Failure
**H. FaceID architecture preserves face identity but not full-head identity.**
The architecture successfully isolates the inner facial region (eyes, nose, mouth) but discards the cranial shape, hairline, ears, and neck. Furthermore, without a dedicated geometric ControlNet, the SD1.5 cross-attention struggles to warp a frontal embedding into a 90-degree profile.
