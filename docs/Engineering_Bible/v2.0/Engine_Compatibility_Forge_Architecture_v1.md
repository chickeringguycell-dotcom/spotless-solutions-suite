# Engine Compatibility Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** To serve as the definitive translation layer ensuring all Viper Studios assets conform perfectly to the strict, often esoteric, requirements of specific target engines (Starfield, Skyrim, VRChat, IMVU, Unity, Unreal, Blender, Godot).
- **Why it exists:** Even a flawlessly created asset will fail in-game if it violates engine-specific constraints (e.g., bone naming conventions for Skyrim, poly limits for VRChat, coordinate handedness in Unreal). The Engine Compatibility Forge guarantees automated adaptation of universal assets into precise engine-ready formats.
- **Inputs:** Universal format assets (USD, glTF, MaterialX), target platform specification.
- **Outputs:** Engine-specific models, materials, rigs, collisions, and naming conventions.
- **Dependencies:** Target engine SDKs, headless Blender/Python translation layers, format converters.
- **Current status:** Architecture Phase

## 2. Mission
The mission of the Engine Compatibility Forge is to eliminate all friction between universal asset creation and specific game engine deployment. Creators should never have to manually rename bones, flip normals, convert textures, or rebuild materials to get their assets working in a target platform.

## 3. Scope
The Engine Compatibility Forge sits immediately prior to the Export Forge. While the Export Forge handles packaging and delivery, the Engine Compatibility Forge handles structural translation. This includes mesh limits, bone hierarchy constraints, shader translation, coordinate system conversion, and strict naming conventions.

## 4. Long-Term Vision
The Forge will evolve into an intelligent, dynamically updating compatibility database. When a new engine version releases (e.g., Unreal Engine 6), the Forge Evolution Agent will automatically ingest the new SDK rules, updating the translation nodes so all past and future assets remain universally compatible.

## 5. Design Philosophy
- **Universal Ground Truth:** All assets exist in an engine-agnostic format (USD/glTF) first. Engine compatibility is always a non-destructive translation step, never a permanent modification of the source.
- **Strict Enforcement:** The Forge does not make artistic choices; it applies rigid mathematical and structural transformations.
- **Engine-First Rules:** If a target engine has a limitation (e.g., maximum 65k vertices per mesh), the Forge will automatically split or decimate the mesh rather than allowing an import error.

---

## 6. Manufacturing Pipeline

The Engine Compatibility Forge operates as a sequential 5-station line.

### Station 1: Asset Ingestion & Rule Detection
- **Purpose:** Analyze the incoming universal asset and load the strict rulebook for the target engine.
- **Inputs:** Asset ID, Target Engine (e.g., "Skyrim SE").
- **Outputs:** Loaded compatibility rule dictionary, asset readiness report.
- **Dependencies:** Compatibility Rules Database.
- **SentinelQC Checkpoints:** Validates target engine is supported and rules are available.

### Station 2: Structural Translation
- **Purpose:** Apply physical transformations to meshes, skeletons, and collision hulls.
- **Inputs:** Universal Mesh/Rig, Rule Dictionary.
- **Outputs:** Engine-scaled geometry, correctly named bone hierarchy, engine-specific collision hulls (e.g., `.hkx` for Havok).
- **Dependencies:** Headless Blender, V-HACD, Havok Tools (via adapter).
- **SentinelQC Checkpoints:** Vertex/Bone limits validated. Axis alignment verified.

### Station 3: Material & Texture Translation
- **Purpose:** Convert MaterialX graphs and PBR textures into the exact shading model and texture format required.
- **Inputs:** MaterialX XML, Raw PBR maps.
- **Outputs:** Engine native materials (e.g., Unreal Material Instances, Skyrim `.bgsm`), compressed textures (e.g., BC7 `.dds`).
- **Dependencies:** MaterialX compiler, NVTT texture tools.
- **SentinelQC Checkpoints:** Texture compression validity and material path verification.

### Station 4: Metadata & Packaging Translation
- **Purpose:** Generate any necessary engine-specific metadata files.
- **Inputs:** Asset metadata.
- **Outputs:** Engine description files (e.g., Unity `.meta`, VRChat Avatar descriptor).
- **Dependencies:** Python JSON/XML parsers.
- **SentinelQC Checkpoints:** Syntax validation on metadata files.

### Station 5: Compatibility Verification
- **Purpose:** Perform a final rigorous check against the engine rulebook before handing off to the Export Forge.
- **Inputs:** Fully translated asset suite.
- **Outputs:** Approved engine-specific asset data.
- **Dependencies:** SentinelQC.
- **SentinelQC Checkpoints:** Final "import readiness" validation.

---

## 7. Node Graph Definition

The Forge is built on the following Directed Acyclic Graph (DAG):

| Node Name | Description |
| :--- | :--- |
| **Platform Detection** | Identifies the target platform and required engine version. |
| **Compatibility Rules** | Loads the specific constraints (limits, axes, naming) from the database. |
| **Asset Validation** | Pre-checks if the universal asset can physically meet target limits. |
| **Mesh Translation** | Scales, rotates, decimates, and splits geometry to match engine rules. |
| **Material Translation** | Converts universal MaterialX nodes to target engine shader logic. |
| **Texture Translation** | Flips channels (e.g., OpenGL to DirectX normals), packs RM/ORM, compresses. |
| **Skeleton Translation** | Renames bones (e.g., `mixamorig:RightArm` -> `NPC R UpperArm [RArm]`) and adjusts root orientation. |
| **Animation Translation** | Retargets animation data to the modified skeleton. |
| **Physics Translation** | Converts standard collisions into engine physics engines (Havok, PhysX, Chaos). |
| **LOD Translation** | Restructures LOD chains based on engine streaming requirements. |
| **Metadata Translation** | Generates `.meta`, `.json`, or XML definition files. |
| **Packaging** | Stages the files in the correct internal hierarchy before Export Forge takes over. |
| **Compatibility Verification** | Runs automated tests mimicking the target engine's importer. |
| **Optimization** | Cleans up temporary translation files. |
| **Final Compatibility Report** | Generates a manifest of all translations applied. |

---

## 8. Technology Mapping

| Node Category | Strategy | Primary Tool/Format |
| :--- | :--- | :--- |
| **Rules Database** | **REPLACE** | Custom internal Python dictionary/JSON structure. |
| **Mesh/Rig Translation** | **HYBRIDIZE** | Headless Blender + custom Python scripts for bone mapping. |
| **Texture Translation** | **ADOPT** | nvcompress / ImageMagick. |
| **Material Translation** | **ADAPT** | MaterialX code generation targeting specific engines. |
| **Physics Translation** | **ADAPT** | Proprietary SDK adapters where required (e.g., Havok Content Tools). |
| **Verification** | **REPLACE** | SentinelQC custom rulesets mimicking engine importers. |

---

## 9. SentinelQC Integration

Validation is engine-specific. SentinelQC will load dynamic rulesets to validate:
- **Mesh Compatibility:** Triangle limits, vertex limits, scale, Z-up vs Y-up handedness.
- **Materials:** Supported node checks, naming conventions, max material slots per mesh.
- **Textures:** Power of two rules, format (DDS/PNG/TGA), channel packing correctness (e.g., DirectX vs OpenGL Normal Y-channel).
- **Skeletons:** Exact bone naming compliance, maximum bone influences per vertex (e.g., 4 vs 8).
- **Animations:** Framerate constraints, root motion extraction.
- **Collisions:** Maximum convex hull limits, physics material assignments.
- **LODs:** Screen size transition values.
- **Metadata:** Engine-specific syntax validation.
- **Naming:** Illegal character checks, path length limits.
- **Packaging:** Folder structure validation.
- **Engine-specific restrictions:** E.g., VRChat avatar rank limitations (Poor vs Excellent).
- **Optimization:** Warning if translated asset heavily exceeds target platform norms.
- **Import Readiness:** Final guarantee that dragging the asset into the engine will not result in a red console error.

---

## 10. Supported Platforms

The initial Architecture supports translation pipelines for:
- **Starfield** (Havok, .nif/.mesh, Creation Engine 2 materials).
- **Skyrim** (Havok, .nif, Creation Engine materials).
- **VRChat** (Unity 2022+, VRChat SDK3, dynamic bone/physbone constraints, poly limits).
- **IMVU** (Cal3D / proprietary FBX, extreme texture limits).
- **Unity** (Y-up, Left-handed, HDRP/URP/Built-in material variants, .meta files).
- **Unreal Engine** (Z-up, Right-handed, .uasset preparation, Blueprint/Material instances).
- **Blender** (Native .blend, Cycles/Eevee materials).
- **Godot** (Y-up, .tres materials, .scn).

---

## 11. Future Expansion

Placeholders are reserved for:
- **Automatic Engine Updates:** Web scrapers that monitor engine release notes for API changes.
- **Compatibility Database:** A centralized, queryable repository of every known engine quirk.
- **Automatic Rule Synchronization:** TIA autonomously updating the rule database when new engine limits are discovered.
- **Engine Version Tracking:** Allowing users to target "Unity 2019.4" vs "Unity 2022.3".
- **Cloud Compatibility Testing:** Sending the asset to a headless cloud instance of Unreal/Unity to verify successful import programmatically.

---

## 12. Architecture Decision Record (ADR)

**Decision:** We are building a dedicated Engine Compatibility Forge to act as a strict transformation layer between the universal asset generation Forges (Avatar, Material, etc.) and the final Export Forge, utilizing a dynamic, data-driven compatibility rulebook.

**Why this architecture is superior:**
1. **Decoupled Generation:** The Avatar Forge doesn't need to know if it's building for Skyrim or VRChat. It just builds a perfect human. This vastly simplifies the generative AI logic.
2. **Infinite Extensibility:** Adding support for a new engine (e.g., a custom proprietary studio engine) only requires adding a new JSON rulebook and translation adapters, leaving the core Viper Studios generation pipelines untouched.
3. **Guaranteed Consistency:** By enforcing strict rules mathematically, we eliminate human error. A user will never forget to flip the Green channel on a Normal map when moving from OpenGL to DirectX.
4. **Resilience to Engine Updates:** When Epic updates Unreal Engine, we update the Unreal Translation rules in one place, and every asset in the Viper Studios ecosystem is instantly compatible with the new version.
