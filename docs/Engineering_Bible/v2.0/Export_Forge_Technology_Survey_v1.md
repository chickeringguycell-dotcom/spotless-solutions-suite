# Export Forge Executive Summary
**Mission**: To serve as the universal delivery system for all Viper Studios 3D assets, converting internal raw generated data into game-ready, engine-specific, and platform-compliant packages (Starfield, Skyrim, VRChat, IMVU, Unity, Unreal, Godot).
**Why it exists**: Content creators currently face massive friction manually converting models, configuring materials, packing textures, and building LODs/collisions for different engines. The Export Forge automates this final mile.
**Inputs**: Viper Studios intermediate formats (high-poly meshes, canonical textures, raw rigs, node graphs, SentinelQC metadata).
**Outputs**: Engine-ready packages (GLB, USDZ, FBX, .ba2 + .esp, VRC Avatar packages, IMVU Cal3D).
**Dependencies**: Project Memory, SentinelQC Inspection Station, all upstream Forges (Avatar, Clothing, Vehicle, etc.).
**Current Status**: Survey / Architecture / Academy Phase

---

# Technology Survey & Competitive Benchmark

## Core Export Formats

### 1. GLTF / GLB
- **License**: Khronos Group (Open Standard)
- **Status**: Commercial / Open Source
- **Maturity**: Very High (Production standard for web/Unity)
- **Strengths**: Lightweight, standard PBR material support, embedded textures, JSON extensible metadata.
- **Weaknesses**: Limited complex rigging/constraint support, not natively supported by some older engines (e.g., Skyrim).
- **Format / Engine Compatibility**: Godot, Unity, Web, Unreal (via plugins).
- **Material / Rigging / Animation Support**: Standard PBR / Standard Skeletal / Basic Animation.
- **Collision / LOD / Metadata**: Requires extensions.
- **Integration Difficulty**: Low.

### 2. FBX
- **License**: Autodesk Proprietary (closed source SDK)
- **Status**: Commercial
- **Maturity**: Very High (Industry standard)
- **Strengths**: Universal compatibility (Unity, Unreal, Maya, Blender). Excellent rig and animation support.
- **Weaknesses**: Proprietary, closed source, prone to version mismatches, opaque ASCII/Binary specs.
- **Format / Engine Compatibility**: Unity, Unreal, VRChat (Unity relies on FBX).
- **Material / Rigging / Animation Support**: Excellent (custom shaders can be lost, however).
- **Collision / LOD / Metadata**: Supported via naming conventions.
- **Integration Difficulty**: Medium (due to proprietary SDK).

### 3. USD / USDZ (OpenUSD)
- **License**: Apache 2.0
- **Status**: Open Source
- **Maturity**: High (Rapidly growing, pushed by Pixar/Apple/NVIDIA)
- **Strengths**: Layered overrides, massive scene composition, incredible metadata support, non-destructive workflows.
- **Weaknesses**: Overkill for single assets, high learning curve, integration is still maturing in some game engines.
- **Format / Engine Compatibility**: Unreal Engine, Omniverse, Unity (improving), Apple ecosystem.
- **Material / Rigging / Animation Support**: USD Shade, USD Skel (very strong).
- **Collision / LOD / Metadata**: Native and robust.
- **Integration Difficulty**: High.

### 4. OBJ
- **License**: Open Standard
- **Status**: Open Source
- **Maturity**: Ancient but reliable
- **Strengths**: Universally supported for static meshes. Simple text format.
- **Weaknesses**: No rigging, no animation, outdated material system (MTL).
- **Integration Difficulty**: Very Low.

### 5. COLLADA (DAE)
- **License**: Khronos Group
- **Status**: Open Source (Deprecated)
- **Maturity**: Deprecated in favor of GLTF.
- **Strengths**: XML based.
- **Weaknesses**: Bloated, inconsistent implementations across engines.
- **Integration Difficulty**: Low, but not recommended.

## Engine & Platform Export Pipelines

### 6. Blender Export Pipeline
- **Maturity**: High. 
- **Strengths**: Massive community support, Python API allows deep automation for batch exporting.
- **Weaknesses**: Headless operation can be tricky but doable.
- **Integration Difficulty**: Medium.

### 7. Assimp (Open Asset Import Library)
- **License**: BSD
- **Status**: Open Source
- **Maturity**: High
- **Strengths**: Supports 40+ formats, standardizes mesh data structure.
- **Weaknesses**: Better for importing than exporting complex game-ready packages (e.g., struggles with advanced PBR material translations across engines).
- **Integration Difficulty**: Medium.

### 8. Unreal Engine Import/Export Workflows
- **Maturity**: High (Datasmith, FBX, USD).
- **Requirements**: Requires specific LOD naming, collision prefixes (UCX_, UBX_), and packed textures for optimal performance.

### 9. Unity Import/Export Workflows
- **Maturity**: High (FBX primarily, GLTF via plugins).
- **Requirements**: Specific rig setups (Humanoid), meta files are critical.

### 10. Godot Import/Export Workflows
- **Maturity**: High (GLTF is a first-class citizen).
- **Requirements**: Best integrated via GLTF/GLB with standard PBR.

### 11. VRChat Avatar Export Pipeline
- **Requirements**: Relies entirely on Unity FBX imports. Requires VRChat SDK integration, specific PhysBones setup, strict poly/material limits for quest compatibility.
- **Automation Level**: Low (mostly manual Unity setup today).

### 12. IMVU Product Export Requirements
- **Requirements**: Cal3D files (.xaf, .xpf) or FBX via IMVU Studio. Very strict skeleton requirements, strict poly limits.

### 13. Starfield Mod Asset Pipeline
- **Tools**: Creation Kit, Archive2 (.ba2), NifSkope (Starfield fork), Blender Starfield Geometry Bridge.
- **Requirements**: Meshes must be converted to .nif (with BSXFlags and collision). Textures must be converted to .dds. Packed into .ba2.
- **Automation Level**: Medium (AssetWatcher handles textures, but nif setup is manual).

### 14. Skyrim Mod Asset Pipeline
- **Tools**: Creation Kit, NifSkope, Bodyslide/Outfit Studio (for clothing/armor).
- **Requirements**: Legacy .nif format, distinct partition slots for clothing, Havok physics.

## Core Workflows

### 15. Texture Packing Workflows
- **State of Art**: Substance Automation Toolkit / ImageMagick / custom Python PIL scripts.
- **Need**: Engines require different packed channels (e.g., Unreal: RMA [Roughness, Metalness, AO], Unity: Metallic/Smoothness).

### 16. Material Conversion Workflows
- **State of Art**: MaterialX / USD Shade.
- **Need**: Translating Viper Studio's standard PBR into Unity Shader Graph, Unreal Materials, or Creation Kit material files.

### 17. LOD Export Workflows
- **State of Art**: Simplygon (Commercial), InstaLOD (Commercial), Blender Decimate modifier / Quadric Edge Collapse (Open Source).
- **Need**: Auto-generating LOD0 - LOD3 and packaging them according to engine specs (e.g., Unreal LOD groups).

### 18. Collision Mesh Export Workflows
- **State of Art**: V-HACD (Open Source volumetric hierarchical approximate convex decomposition).
- **Need**: Auto-generating convex hulls for game engines.

### 19. Metadata Packaging
- **State of Art**: JSON manifests, USD metadata.
- **Need**: Every export must carry provenance (Canonical UUID, generation trace) to satisfy SentinelQC.

### 20. Validation / Report Generation
- **State of Art**: Custom CI/CD pipelines.
- **Need**: SentinelQC Export Readiness module must validate poly count, bone count, and format compliance before the user downloads.

---

# Architecture Decision Record (ADR)

| Technology / Domain | Decision | Justification |
| :--- | :--- | :--- |
| **GLTF / GLB** | **ADOPT** | The primary universal delivery format for web, Godot, and base geometry. Lightweight, open standard. |
| **FBX** | **HYBRIDIZE** | Use Blender's Python API to generate FBX files headlessly because FBX is mandatory for VRChat and legacy Unity workflows, but avoid embedding the Autodesk SDK. |
| **OpenUSD** | **ADAPT** | The future of Viper Studios' internal scene composition and high-end Unreal/Omniverse export. Adapt it for complex scene graphs and material preservation. |
| **OBJ / COLLADA** | **REPLACE** | Do not use. Outdated and lacks modern material/rigging support. Replaced entirely by GLTF. |
| **Assimp** | **REPLACE** | Too generalized for highly specific game engine exports. Replace with targeted Python/Blender headless export scripts. |
| **Texture Packing** | **REPLACE** | Build a custom automated Python/OpenCV pipeline to pack ORM (Occlusion/Roughness/Metallic) dynamically based on the target engine. |
| **VRChat / IMVU Pipeline** | **HYBRIDIZE** | Generate the exact FBX/Cal3D and directory structure required, but the user must perform the final Unity/IMVU Studio upload, as API access for direct upload is restricted/prohibited. |
| **Starfield / Skyrim Pipeline** | **ADAPT** | Adapt community tools (NifSkope headless/CLI scripts, AssetWatcher) to automate .nif conversion and .ba2 packing directly from Viper Studios. |
| **LOD Generation** | **ADAPT** | Adapt open-source V-HACD for collision and open-source quadric mesh decimation (via Blender API) for LODs, avoiding expensive Simplygon licenses. |

---

# Long-term Export Forge Vision

The Export Forge is a fully automated compilation target. The user never "exports" manually. The user selects a target (e.g., "Starfield Mod", "VRChat Quest Avatar", "Unreal 5 Asset") and Helios orchestrates the Export Forge Manufacturing Line.

**The Export Manufacturing Line Stations:**
1. **Target Analysis Station**: Reads the requested engine/platform limits (poly count, bone limit, texture size).
2. **Decimation & LOD Station**: Generates LOD0 to LOD3 via headless Blender scripts to hit the target polygon limits.
3. **Collision Station**: Uses V-HACD to generate UCX_ collision hulls.
4. **Rig Retargeting Station**: Ensures the skeleton matches the target platform (e.g., Humanoid for VRChat, IMVU specific rig).
5. **Texture Packing Station**: Converts raw PBR textures into the specific packed formats (RMA, Metallic-Smoothness) and resizes to target limits.
6. **Material Translation Station**: Generates MaterialX or engine-specific material definition files.
7. **Format Compilation Station**: Compiles into GLB, FBX, or USDZ.
8. **Package Assembly Station**: Gathers the mesh, textures, materials, and metadata into a final `.zip`, `.ba2`, or `.unitypackage`.
9. **SentinelQC Export Gate**: Validates the final package against the platform specifications and verifies Canonical Provenance.

**Recommendation:**
Do not write custom C++ exporters. Use headless Blender via its Python API (`bpy`) as the core engine for the Format Compilation Station, combined with custom Python image processing for the Texture Packing Station. This leverages massive open-source momentum while allowing Viper Studios to perfectly orchestrate engine-specific asset packages.
