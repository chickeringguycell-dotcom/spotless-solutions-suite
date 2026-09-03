# Viper Synthetic Dataset Asset License Matrix

## Phase 1 — Local Human-Asset Inventory

| Asset / System | Path | Creator / Source | Code/Mesh License | Training Rights | Verdict |
|:---|:---|:---|:---|:---|:---|
| **MakeHuman Base Meshes** | `artifacts/avatar-sources/makehuman/exports/viper_female_base_v1.fbx` | MakeHuman Team | CC0 | Explicitly permitted for derivatives and ML training | `TRAINING_USE_CONFIRMED` |
| **MB-Lab** | (Not found locally) | MB-Lab | AGPL | Viral copyleft risks for commercial ML | `LICENSE_BLOCKED` |
| **Aria/Gaius Legacy Meshes** | `artifacts/aria-base-clay-v1.blend` | Viper Studios (MakeHuman derived) | CC0 base + Viper | Permitted | `TRAINING_USE_CONFIRMED` |
| **Monster Fluff** | `artifacts/characters/Monster_Fluff_V1_CC5_Handoff/` | Viper Studios | Proprietary | N/A (Not human) | `REJECT` |
| **Local Canonical Face** | `local-compute-node/canonical_face.obj` | Viper Studios | Proprietary | Permitted for Viper | `TRAINING_USE_CONFIRMED` |

### Summary
The `viper_female_base_v1_imported.blend` generated via MakeHuman CC0 export provides a verified, legally unencumbered 3D human asset. This geometry can be randomized procedurally via shape keys (morphs) to generate unique synthetic identities without relying on tainted datasets like FLAME or CelebA.
