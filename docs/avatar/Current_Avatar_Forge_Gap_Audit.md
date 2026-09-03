# Current Avatar Forge Gap Audit

## Current-System Architecture Audit

This audit evaluates the legacy Avatar Forge systems against the new **Game-Development Avatar Architecture Mandate**.

| Component | Current State | Classification | Notes |
|:---|:---|:---|:---|
| **Base Meshes** | Legacy MakeHuman/MPFB (Retired scope) | `REPLACE` | We need a new photorealistic, deformation-safe canonical topology. |
| **Skeletons** | Basic Humanoid (MakeHuman derived) | `REPLACE` | Lacks twist bones, correctives, and full game-engine compatibility. |
| **Facial Controls** | Rudimentary Shapekeys | `REPLACE` | Needs full FACS/ARKit compliance for speech and emotional fidelity. |
| **UV Layouts** | Single-atlas MakeHuman standard | `REPLACE` | Must support UDIMs or high-res modular mapping for photorealism. |
| **Clothing Systems** | Single-mesh proxy overrides | `REPLACE` | Must transition to modular slots (Head, Torso, Legs, Feet) with proper body masking. |
| **Body-Part Segmentation**| Monolithic avatar mesh | `REPLACE` | Transitioning to game-ready modular segments. |
| **Animation Controllers**| Basic standalone clips | `ADAPT` | Need to upgrade to a state-machine driven Behavior Controller for Helios. |
| **Helios Hooks** | Rudimentary script triggers | `ADAPT` | Must be upgraded to semantic intention layers (e.g., "Walk to Forge"). |
| **Export Logic** | Direct single-mesh GLTF/FBX dump | `ADAPT` | Must be expanded into the new Target-Specific Export Profiles system. |
| **LODs (Level of Detail)**| None | `MISSING` | Critical requirement for game performance and Headquarters optimization. |
| **Collision/Physics** | Basic or None | `MISSING` | Need capsule colliders, cloth physics profiles, and hair dynamics. |
| **Forge UI Assumptions** | Single monolithic avatar generation | `ADAPT` | The UI must treat generation as manufacturing a modular package. |

### Summary
The legacy system was built like a traditional metaverse avatar generator. To achieve photorealism and game-character modularity, the entire core rig, topology, and clothing system must be replaced. The export and UI layers will be adapted to support this new canonical format.
