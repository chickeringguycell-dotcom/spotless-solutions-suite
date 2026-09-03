# Export Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** To serve as the final compilation and packaging engine for all assets leaving Viper Studios, guaranteeing that exported assets are perfectly formatted, dependency-complete, and engine-ready for platforms like Unreal, Unity, Godot, Starfield, and VRChat.
- **Why it exists:** Complex 3D assets often fail on import into target engines due to missing textures, broken rigs, incorrect axis alignments, or unsupported material nodes. The Export Forge eliminates these "production escapes" by fully automating the dependency resolution and packaging process.
- **Inputs:** Final 3D meshes (GLTF/FBX/USD), MaterialX graphs, animation files, physics definitions, and metadata from Project Memory.
- **Outputs:** Game-ready engine packages (e.g., Unreal `.uasset` structures, Unity `.unitypackage`, VRChat SDK-ready bundles) and standard interchange formats.
- **Dependencies:** Target engine SDKs, USD pipelines, FBX SDK, headless Blender/Python processing tools.
- **Current status:** Architecture Phase

## 2. Mission
The Export Forge's mission is to guarantee that every asset leaving Viper Studios will drag-and-drop seamlessly into its target environment without requiring the end-user to manually relink materials, fix bone orientations, or rescale geometry.

## 3. Scope
The Export Forge handles the final stage of the asset lifecycle. It is responsible for:
- Gathering all necessary dependencies (meshes, textures, materials, animations).
- Applying engine-specific conversions (coordinate systems, scale, bone naming).
- Compiling final distribution packages.
- Generating manifest and metadata files.
- Running final validation checks before pushing the asset to the user.

## 4. Long-Term Vision
The Export Forge will evolve into an automated deployment hub that not only packages assets but dynamically publishes them. Helios will be able to instruct the Forge to "package this Colonial Viper for Starfield and publish it as a mod," and the Forge will handle everything from texture conversion to automated mod repository uploading.

## 5. Design Philosophy
- **Immutability of Source:** The Export Forge never alters the original data in Project Memory. It only creates transformed, engine-specific copies.
- **Zero-Trust Validation:** Never assume the source data is complete. Always traverse the dependency tree to ensure all required textures and materials are packaged.
- **Universal to Specific:** All assets are assumed to be in the universal Viper format (USD/MaterialX/GLTF) until the final node, where they are strictly transformed into the target engine's required format.
- **Atomic Exports:** An export succeeds completely or fails completely. There are no "partially broken" packages.

---

## 6. Manufacturing Pipeline

The Export Forge operates as a 4-station sequential manufacturing line.

### Station 1: Asset Collation Station
- **Purpose:** Gather the requested asset and aggressively trace its dependency tree.
- **Inputs:** Asset ID, Target Engine Request.
- **Outputs:** A flattened, localized directory of all required files.
- **Dependencies:** Project Memory database.
- **SentinelQC Checkpoints:** Validates that no file references point to missing assets or external paths.

### Station 2: Format Translation Station
- **Purpose:** Convert universal formats into engine-specific formats (e.g., Z-up to Y-up, MaterialX to native shaders).
- **Inputs:** Universal USD/GLTF/MaterialX files.
- **Outputs:** Converted geometry and material definitions.
- **Dependencies:** FBX SDK, USD toolchain.
- **SentinelQC Checkpoints:** Validates vertex counts remain identical and bone hierarchies are preserved after translation.

### Station 3: Packaging & Metadata Station
- **Purpose:** Compress textures, generate LODs, and build the manifest.
- **Inputs:** Translated assets.
- **Outputs:** Complete package structure with metadata.
- **Dependencies:** Texture compression libraries, LOD generators.
- **SentinelQC Checkpoints:** Validates package completeness and manifest integrity.

### Station 4: Final Validation Station
- **Purpose:** Ensure the final compiled package is fully functional and adheres to target engine limits.
- **Inputs:** Final Engine Package.
- **Outputs:** Approved Export Asset.
- **Dependencies:** Engine-specific command-line validators (if available).
- **SentinelQC Checkpoints:** Final engine compatibility check.

---

## 7. Node Graph Definition

The Export Forge utilizes a Directed Acyclic Graph (DAG) for processing.

| Node Name | Description |
| :--- | :--- |
| **Asset Collection** | Retrieves the primary asset from Project Memory. |
| **Dependency Resolution** | Recursively finds all linked textures, materials, and rigs. |
| **Validation** | Pre-export check to ensure all data is valid. |
| **Format Translation** | Converts GLTF/USD into FBX or engine-native geometry formats. |
| **Material Translation** | Converts MaterialX graphs into target engine material scripts. |
| **Texture Packaging** | Resizes, compresses, and packs textures based on engine profiles. |
| **Skeleton Packaging** | Adjusts root bones, axis alignments, and naming conventions. |
| **Animation Packaging** | Bakes animations and retargets if necessary. |
| **LOD Packaging** | Generates or packages pre-existing Level of Detail meshes. |
| **Collision Packaging** | Generates simplified convex hull collision meshes for the asset. |
| **Metadata Generation** | Creates JSON/XML metadata for the asset. |
| **Manifest Generation** | Creates a manifest of all files included in the export. |
| **Engine Translation** | Organizes the files into engine-specific folder structures (e.g., Content/ folder for Unreal). |
| **Optimization** | Final pass compression (e.g., zipping the package). |
| **Export Validation** | SentinelQC node that inspects the final package. |
| **Final Package Builder** | Writes the final `.zip`, `.uasset`, or `.unitypackage` to disk. |

---

## 8. Technology Mapping

| Node Category | Strategy | Primary Tool/Format |
| :--- | :--- | :--- |
| **Format Translation** | **ADOPT** | Universal Scene Description (USD) toolchain / glTF-Transform. |
| **Material Translation** | **ADAPT** | MaterialX Python SDK (translating to Unreal/Unity native formats). |
| **Texture Packaging** | **ADOPT** | Open-source texture compression (nvtt, crunch). |
| **Skeleton Packaging** | **HYBRIDIZE** | Headless Blender Python scripts for axis conversion + FBX SDK. |
| **Collision Packaging** | **ADAPT** | V-HACD for automatic convex collision generation. |
| **Final Package Builder** | **REPLACE** | Custom Python logic to construct exact engine folder hierarchies. |

---

## 9. SentinelQC Integration

SentinelQC acts as the final gatekeeper before the user receives the asset.

- **File Integrity:** Checks for corrupt headers in exported FBX/GLTF files.
- **Metadata:** Ensures the manifest JSON is valid and matches the actual contents.
- **Dependencies:** Validates that no texture paths point to absolute local directories (e.g., `C:/Users/...`).
- **Textures:** Verifies correct compression formats (BC7 for PC, ASTC for Mobile).
- **Materials:** Ensures all material slots on the mesh have a corresponding material definition.
- **Rigs:** Validates that the root bone is correctly placed at (0,0,0) and rotation is applied.
- **Animations:** Validates that animation tracks do not reference missing bones.
- **Collisions:** Verifies collision meshes do not exceed maximum convex hull limits.
- **LODs:** Ensures LOD1 has fewer vertices than LOD0, LOD2 fewer than LOD1, etc.
- **Manifests:** Performs a cryptographic hash check on all packaged files against the manifest.
- **Engine Compatibility:** Validates folder structures (e.g., Unreal packages must have a `.uproject` or sit in a `Content` directory).
- **Package Completeness:** Fails the export if even a single dependency is missing.

---

## 10. Future Expansion

Placeholders are reserved in the architecture for:
- **Cloud Publishing:** Direct API integration to publish to Fab, Unity Asset Store, or Booth.
- **One-Click Deployment:** Automatically pushing the asset directly into a running instance of Unreal Engine or Unity via a live link bridge.
- **Automated Mod Packaging:** Wrapping the asset in Bethesda `.ba2` archives and generating `.esp` files for immediate Skyrim/Starfield modding.
- **Repository Publishing:** Exporting to a Git LFS repository.
- **Digital Signatures:** Cryptographically signing assets to prove provenance and authorship.
- **Asset Versioning:** Embedding version history directly into the package.
- **Differential Exports:** Only exporting the files that changed since the last export to save bandwidth and time.

---

## 11. Architecture Decision Record (ADR)

**Decision:** We are building the Export Forge as a modular, headless packaging pipeline utilizing Universal Scene Description (USD) as the primary transport layer and custom Python scripts for strict engine conformity.

**Why this architecture is superior:**
1. **Eliminates the "Import Error" Paradigm:** Traditional workflows require the user to manually fix scaling, rotation, and broken material links after importing an FBX. The Export Forge shifts this burden to the server, ensuring perfect drag-and-drop compatibility.
2. **Modular Engine Support:** Because the translation nodes are abstracted, adding a new target engine (e.g., Godot 5, or a proprietary in-house engine) only requires writing a new Engine Translation Node, without altering the rest of the Forge.
3. **Automated Collisions & LODs:** Usually an afterthought left to the user, this architecture forces the automatic generation of game-ready optimization structures.
4. **Guaranteed Provenance:** SentinelQC validation ensures that a broken asset cannot leave the Headquarters, significantly reducing user frustration and increasing trust in the Viper Studios platform.
