# Titan Identity Encoder Training Results

## Phase 6 — Encoder Stage B (Small Overfit Test)
- **Status**: `BLOCKED`
- **Reason**: The physical Viper Synthetic Identity Dataset V0 could not be rendered due to a missing Blender installation on the local compute node (`HARDWARE BLOCKED`). Training cannot commence without the image assets.

## Phase 7 — Encoder Stage C (Held-Out Test)
- **Status**: `BLOCKED`
- **Reason**: Dependency failure from Stage B.

## Phase 8 — Domain-Gap Truth
- **Status**: `REAL_PHOTO_GENERALIZATION_UNVERIFIED`
- **Limitation Documented**: A synthetic success (if achieved) will likely suffer domain gaps against real photos due to:
  - Skin texture
  - Camera noise
  - Hair complexity
  - Makeup
  - Age
  - Occlusion
  - Lighting
  - Compression
  - Real facial asymmetry
  - Background contamination
