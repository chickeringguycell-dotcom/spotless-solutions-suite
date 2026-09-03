# Titan Missing-Capability Fingerprint

## 1. Identity Representation
A stable representation of the person that survives camera changes.
- **Technical clues**: identity_encoder, FaceID, ArcFace, InsightFace, identity_embedding, shared_identity_latent, identity_loss.

## 2. Camera and View Control
Explicit generation of front, profile, three-quarter, and rear views.
- **Technical clues**: camera_condition, azimuth, elevation, focal length, ray embedding, novel view synthesis.

## 3. Geometry-Aware Face Understanding
A human-head representation rather than ordinary 2D pixels.
- **Technical clues**: PRNet, 3DMM, FLAME, depth, surface normals, dense correspondence, PyTorch3D, nvdiffrast.

## 4. Cross-View Consistency
A mechanism preventing the person from changing between views.
- **Technical clues**: cross_view_attention, epipolar attention, synchronized denoising.

## 5. Occlusion Completion
Inference of regions absent from the source (e.g., ear depth, side of nose, rear skull).
- **Technical clues**: visibility masks, confidence maps, 3D priors.

## 6. UV-Style Semantic Canonicalization
Generation of a flattened identity reference whose facial regions remain semantically organized.
- **Technical clues**: UV position map, semantic face atlas, dense face correspondence.

## 7. Full-Body Identity Extension
Preservation of head-to-body scale, age, skin tone, clothing, and proportions when extrapolating beyond the portrait.
