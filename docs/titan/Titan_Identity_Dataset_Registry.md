# Titan Identity Dataset Registry

## Phase 1 — Dataset License Truth Audit

| Dataset Candidate | Dataset License | Image License | Commercial Training Rights | Identity Rights | Verdict |
|:---|:---|:---|:---|:---|:---|
| **DigiFace-1M** | Custom (Microsoft) | Synthetic | `RESEARCH_ONLY` | Synthetically clear, but MS restricts commercial use | `RESEARCH_ONLY` |
| **SynFace** | Custom | Synthetic | `RESEARCH_ONLY` | Synthetically clear | `RESEARCH_ONLY` |
| **DCFace** | Custom | Synthetic | `RESEARCH_ONLY` | Synthetically clear | `RESEARCH_ONLY` |
| **SFace** | Custom | Synthetic | `RESEARCH_ONLY` | Synthetically clear | `RESEARCH_ONLY` |
| **MakeHuman Assets** | AGPL/CC0 (varies) | Synthetic | `COMMERCIAL_TRAINING_CONFIRMED` (if CC0 used) | Cleared | `SYNTHETIC_GENERATION_PERMITTED` |
| **MB-Lab Assets** | AGPL | Synthetic | `COMMERCIAL_TRAINING_POSSIBLE_WITH_CONDITIONS` | Cleared | `LICENSE_REVIEW_REQUIRED` (viral copyleft risks) |
| **CelebA/VGGFace/MS-Celeb** | Custom/None | Copyrighted | `LICENSE_BLOCKED` | Biometric consent missing | `LICENSE_BLOCKED` |
| **CC0 Human Meshes** | CC0 | Synthetic | `COMMERCIAL_TRAINING_CONFIRMED` | Cleared | `SYNTHETIC_GENERATION_PERMITTED` |

### Conclusion
Every major pre-rendered synthetic dataset (DigiFace, DCFace, SynFace) is explicitly restricted to Non-Commercial Research use by their creators (e.g., Microsoft). No existing pre-rendered dataset is legally usable for Viper Studios. 

The only legally viable path for Titan is to procedurally generate our own dataset using legally usable 3D assets (e.g., CC0 human meshes, procedural generation with commercial licenses).

---

## Phase 2 — Dataset Path Decision

**Selection**: C. VERIFIED CC0 OR COMMERCIAL ASSET COMBINATION

**Justification**: A scan of the local Viper Studios workspace revealed `artifacts/avatar-sources/makehuman/viper_female_base_v1_imported.blend`, which is explicitly exported under the CC0 license. By manipulating the morph targets/shape keys procedurally via Blender, Viper Studios can construct an infinitely scalable, commercially unencumbered synthetic dataset without relying on tainted open-source face sets.
