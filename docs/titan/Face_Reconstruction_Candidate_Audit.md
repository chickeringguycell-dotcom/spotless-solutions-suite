# Face Reconstruction Candidate Audit

## MICA (Towards Metrical 3D Face Reconstruction)
- **Classification:** GEOMETRY_FOUNDATION (Tier B)
- **Repository:** https://github.com/Zielon/MICA
- **Capabilities:** Extracts metric, expression-independent 3D facial shapes from a single photo.
- **Missing Elements:** Texture, full body, back of head.
- **License Status:** Requires review of underlying FLAME license terms.

## DECA (Detailed Expression Capture and Animation)
- **Classification:** GEOMETRY_FOUNDATION (Tier B)
- **Repository:** https://github.com/YadiraF/DECA
- **Capabilities:** FLAME topology tracking, detailed displacement maps for wrinkles/pores.
- **Missing Elements:** Novel view generation.
- **License Status:** FLAME license requires careful commercial review.

## Deep3DFaceRecon_pytorch
- **Classification:** UV_REFERENCE_FOUNDATION (Tier B)
- **Repository:** https://github.com/sicxu/Deep3DFaceRecon_pytorch
- **Capabilities:** Weakly supervised reconstruction, extracts flat facial texture maps.
- **Missing Elements:** Generative completion of unseen areas.
- **License Status:** Check underlying 3DMM dataset restrictions (e.g. BFM).

## PRNet
- **Classification:** GEOMETRY_FOUNDATION (Tier B)
- **Repository:** Local / Official
- **Capabilities:** Generates UV Position maps directly from pixels.
- **Missing Elements:** High-res texture, back of head.
- **License Status:** Code MIT, Weights trained on non-commercial 300W-LP.
