# VIPER STUDIOS MASTER REPOSITORY AUDIT REPORT

This report provides a full audit of duplicate assets, meshes, textures, animations, and large files in the Viper Studios repository, categorized as **KEEP**, **REVIEW**, or **SAFE TO REMOVE**.

> [!WARNING]
> No files have been deleted. This is a report-only audit. We will wait for your explicit approval before performing any cleanup or moving any files.

---

## 1. Exact Duplicate File Groups (Bitwise Identical)

These groups of files are bitwise identical (sharing the same MD5 hashes). The canonical copy is marked to **KEEP**, while redundant duplicates are marked as **SAFE TO REMOVE** or **REVIEW**.

### Group A: Audio Previews (Size: 0.00 MB / negligible)
- **KEEP (Canonical)**: `artifacts/api-server/public/aria_preview_alloy.mp3`
- **SAFE TO REMOVE**:
  - `artifacts/api-server/public/aria_preview_fable.mp3`
  - `artifacts/api-server/public/aria_preview_onyx.mp3`
  - `artifacts/api-server/public/aria_voice_alloy.mp3`
- *Rationale*: Bitwise identical audio preview files. One canonical copy is sufficient.

### Group B: Aria Base Production Targets (Size: 2.02 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/avatar-concepts/aria-base-360-form-production-target-v1.png`
- **SAFE TO REMOVE**:
  - `artifacts/avatar-references/aria-base-360-form-production-target-v1.png`
- *Rationale*: Duplicate copy in the development `avatar-references` directory.

### Group C: Aria Base Wire Targets (Size: 2.73 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/avatar-concepts/aria-base-360-wire-uv-production-target-v1.png`
- **SAFE TO REMOVE**:
  - `artifacts/avatar-references/aria-base-360-wire-uv-production-target-v1.png`
- *Rationale*: Duplicate copy in the development `avatar-references` directory.

### Group D: Aria UV Reference Maps (Size: 2.50 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/avatar-concepts/aria-body-texture-uv-reference-v1.png`
- **SAFE TO REMOVE**:
  - `artifacts/api-server/public/references/aria/aria_body_skin_uv_reference_board_v2.png`
  - `artifacts/api-server/public/references/aria/aria_skin_uv_concept_v1.png`
  - `artifacts/api-server/public/skins/aria/aria-body-texture-uv-reference-v1.png`
- **REVIEW (Local Bundler Asset)**:
  - `artifacts/viper-studio/assets/aria-body-texture-uv-reference-v1.png`
- *Rationale*: Exact duplicate reference maps replicated in public endpoints. The copy inside `viper-studio/assets` should be reviewed to see if the mobile bundler can resolve it directly from the public asset endpoint instead of packaging a duplicate.

### Group E: Aria Character Base Maps (Size: 1.98 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/avatar-concepts/aria-character-base-reference-v1.png`
- **SAFE TO REMOVE**:
  - `artifacts/api-server/public/references/aria/aria_character_base_reference_board_v2.png`
  - `artifacts/api-server/public/references/aria/aria_character_base_reference_v1.png`
  - `artifacts/api-server/public/skins/aria/aria-character-base-reference-v1.png`
- **REVIEW (Local Bundler Asset)**:
  - `artifacts/viper-studio/assets/aria-character-base-reference-v1.png`

### Group F: Aria Face UV reference Maps (Size: 1.87 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/avatar-concepts/aria-face-uv-reference-v1.png`
- **SAFE TO REMOVE**:
  - `artifacts/api-server/public/references/aria/aria_face_skin_uv_reference_board_v2.png`
  - `artifacts/api-server/public/references/aria/aria_face_uv_reference_v1.png`
  - `artifacts/api-server/public/skins/aria/aria-face-uv-reference-v1.png`
- **REVIEW (Local Bundler Asset)**:
  - `artifacts/viper-studio/assets/aria-face-uv-reference-v1.png`

### Group G: Aria Portraits (Size: 2.21 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/textures/aria-portrait.png`
- **REVIEW (Local Bundler Asset)**:
  - `artifacts/landing-page/public/aria-portrait.png`
  - `artifacts/viper-studio/assets/aria-portrait.png`

### Group H: Aria Faces (Size: 2.08 MB)
- **KEEP (Canonical)**: `artifacts/api-server/public/textures/aria_face.png`
- **SAFE TO REMOVE**:
  - `artifacts/api-server/public/textures/aria_face_canonical.png`
- **REVIEW (Local Bundler Asset)**:
  - `artifacts/viper-studio/assets/aria-face-sheet.png`

### Group I: Fluffy Mascot Reference Concepts (Size: ~2.50 MB each / 11 groups)
- **KEEP (Canonical)**: `artifacts/characters/fluff_v1_quick_prototype/references/ChatGPT Image Jun 12, ...`
- **SAFE TO REMOVE**:
  - `artifacts/characters/Monster_Fluff_V1_CC5_Handoff/references/ChatGPT Image Jun 12, ...`
- *Rationale*: A set of 11 identical PNG reference images duplicated between `fluff_v1_quick_prototype` and `Monster_Fluff_V1_CC5_Handoff` folders.

---

## 2. Unique Large Files (> 1 MB)

These are unique files (not matching duplicate hashes) consuming significant disk space.

| File Path | Size (MB) | Category | Rationale |
|---|---|---|---|
| `artifacts/api-server/public/avatars/aria/aria-v4-walk.glb` | 189.63 MB | **KEEP** | Primary Aria 3D runtime walkthrough model |
| `artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb` | 176.65 MB | **KEEP** | Primary Aria 3D rigged model |
| `artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb` | 175.66 MB | **KEEP** | Primary Aria 3D skinned model |
| `artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb` | 148.09 MB | **KEEP** | Animation test harness |
| `artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx` | 94.38 MB | **KEEP** | Master source model |
| `artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx` | 79.04 MB | **KEEP** | Master source model |
| `artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb` | 76.52 MB | **KEEP** | Y-up preview asset |
| `artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb` | 76.52 MB | **KEEP** | Preview asset |
| `artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_...` | 74.91 MB | **REVIEW** | Failed experiment GLB copies. Can be cleaned up if no longer referenced. |
| `artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx` | 59.69 MB | **KEEP** | Primary Gaius/Guy motion source |
| `artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle_F.fbx` | 52.68 MB | **REVIEW** | Camilla motion source. Needs retarget testing before direct removal. |
| `artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Walk_F.fbx` | 52.68 MB | **REVIEW** | Camilla motion source. Needs retarget testing before direct removal. |
| `artifacts/characters/Monster_Fluff_V1_CC5_Handoff/Fluff_V1_quick_prototype.blend1` | 2.65 MB | **SAFE TO REMOVE** | Blender backup file (`.blend1` are auto-saved local file revisions) |
| `artifacts/characters/Monster_Fluff_V1_CC5_Handoff/Fluff_V1_quick_prototype.blend` | 2.57 MB | **KEEP** | Master Blender source file for Fluffy mascot |
| `phone-screen-after-forge-fix.png` | 2.60 MB | **SAFE TO REMOVE** | Legacy debugging screenshot at root |
| `artifacts/api-server/public/models/colonial-viper/viper_complete.obj` | 1.44 MB | **KEEP** | Colonial Viper 3D mesh model |

---

## 3. Recommended Actions & Next Steps

1. **Retain Bundler assets on REVIEW**: Do not remove `artifacts/viper-studio/assets/...` or `artifacts/landing-page/public/...` copies until we confirm the Expo bundler/landing site build configuration can successfully import assets directly from the shared endpoint.
2. **Remove Redundant Web Public copies**: Clear out redundant duplicates inside `api-server/public/references/` and duplicates of Fluffy reference images inside the handoff folders.
3. **Delete `.blend1` and debug logs/images**: Safely purge all `.blend1` auto-backups and root-level mobile debug screenshots to free up disk capacity.
