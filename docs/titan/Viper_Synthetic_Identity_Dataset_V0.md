# Viper Synthetic Identity Dataset V0

## Phase 2 — Choose the Cleanest Feasibility Path
**Selection**: B. VIPER-OWNED SYNTHETIC DATASET GENERATED FROM LEGALLY USABLE 3D ASSETS

**Justification**: All existing large-scale synthetic datasets (DigiFace-1M, etc.) strictly prohibit commercial use. Real-face datasets lack biometric consent. Therefore, Viper Studios must render its own dataset using fully licensed or CC0 geometry and procedural textures.

---

## Phase 3 — Dataset V0 Design

**Target Initial Scale**:
- 8 synthetic identities
- Five required views per identity: Front, Left 3/4, Right 3/4, Left profile, Right profile.
- Lighting: Neutral Studio (500W Area light).
- Background: Transparent/Neutral.
- Consistent image resolution: 256x256.
- Exact camera intrinsics: 85mm portrait focal length.

**Meaningful Variations**:
- Due to mechanical limitations of a headless FBX import in script, the V0 mechanical dataset modifies global head-bone scaling deterministically via Python `random.seed(identity_id)`. This provides gross geometric differentiation (skull proportion/face width) to verify if the encoder can learn physical differences without relying on textures.

**Dataset Splits**:
- `train/`: Front, Left 3/4, Right 3/4, Left Profile.
- `validation_pose/`: Right Profile (Held out for Stage C).

---

## Phase 4 — Physical Rendering
A Python script (`render_viper_synthetic_v0.py`) has been written to execute inside Blender in headless mode. It imports the CC0 `viper_female_base_v1.fbx`, deterministically scales the head bone per identity, orbits the camera 0, 45, and 90 degrees, and outputs rendered PNGs and a `manifest.json` containing SHA-256 hashes to `services/project-titan-3d/evidence/photo_skill_acquisition/titan_identity_encoder/dataset_v0/`.

**Storage Status**:
- Currently defined theoretically.
- Do not download/generate >50 GB without explicit approval.
- Path: `services/project-titan-3d/evidence/photo_skill_acquisition/titan_identity_encoder/dataset_v0/`
