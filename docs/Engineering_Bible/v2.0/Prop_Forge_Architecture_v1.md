# Prop Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** Architect a universal Clutter Engine using a Tri-Path ingestion system (AI, Photogrammetry, Kitbash) to rapidly generate, validate, and package interactive props.
- **Why it exists:** Props constitute the highest volume of distinct 3D assets in any game environment. Relying purely on manual modeling is a bottleneck. By leveraging AI for non-mechanical clutter and enforcing strict topological and physical repair via SentinelQC, Viper Studios can achieve instantaneous prop generation without sacrificing engine stability.
- **Inputs:** Text prompts, reference photos, raw 3D scans, and kitbash parts.
- **Outputs:** Optimized, manifold, physics-ready GLTF/USDz props with universal metadata (`ViperPropDef`).
- **Dependencies:** Avatar Forge (grip constraints), Material Forge.
- **Current status:** Architecture Planning / Ready for Implementation.

## 2. Mission
To standardize and accelerate the creation of game-ready props by providing three distinct ingestion paths (AI, Scan, Kitbash) that all converge into a single, rigorous repair, rigging, and validation pipeline.

## 3. Scope
- Ingestion of raw AI-generated meshes (TripoSR/Stable3D).
- Ingestion of raw photogrammetry scans.
- Assembly of modular mechanical props.
- Automated topological repair and manifold conversion.
- Automated LOD generation and collision hull extraction.
- Agnostic physics and interaction metadata generation.
- Excludes: Real-time engine physics simulation (handled by the target engine).

## 4. Long-Term Vision
The Prop Forge will act as an instantaneous asset factory. A creator simply types "a rusty sci-fi coffee mug" or uploads a photo of their desk, and within seconds, the Forge generates a flawless, interactive, LOD-ready prop that can be instantly picked up by an Avatar or scattered across a procedural room.

## 5. Design Philosophy
- **Tri-Path Ingestion:** Different props require different generation methods. Mechanical props require Kitbashing; organic rocks require Photogrammetry; chaotic background clutter requires AI.
- **Aggressive Repair:** AI and Scans produce garbage topology. The Prop Forge operates under the assumption that incoming meshes are broken and must be aggressively remeshed and cleaned before proceeding.
- **Agnostic Metadata:** A prop's physics (Mass, Friction) and interactivity (`Grip_Root`) are defined universally via JSON (`ViperPropDef`) and adapted to the engine at export.
- **Smart Placement:** Every prop must have a universally standard pivot point (Bottom-Center) to guarantee it won't clip through tables when spawned.

---

## 6. Manufacturing Pipeline

The Prop Forge operates as a 6-Station Manufacturing Line:

### Station 1: Ingestion & Path Routing (The Tri-Path)
- **Purpose:** Identifies the prop type and routes it to the correct generation mechanism.
- **Inputs:** User prompt, image, or scan data.
- **Outputs:** Raw initial mesh.
- **Dependencies:** AI Generation APIs, Photogrammetry software.
- **SentinelQC Checkpoints:** Validating input data completeness.

### Station 2: Topological Repair & Remeshing
- **Purpose:** Converts chaotic or non-manifold meshes into clean, watertight geometry.
- **Inputs:** Raw initial mesh.
- **Outputs:** Cleaned, manifold high-poly mesh.
- **Dependencies:** Quad Remesher / Blender Voxel Remesh.
- **SentinelQC Checkpoints:** Manifold check; Zero-area face rejection; Intersecting geometry repair.

### Station 3: Optimization & UVs
- **Purpose:** Generates optimal low-poly LODs and unwraps UVs for material assignment.
- **Inputs:** Cleaned high-poly mesh.
- **Outputs:** LOD0 - LOD3 meshes with packed UVs.
- **Dependencies:** MeshOptimizer, xatlas.
- **SentinelQC Checkpoints:** UV overlap detection; Texel density parity.

### Station 4: Interaction Socket & Rigging
- **Purpose:** Assigns universal interaction nodes (e.g., `Grip_Primary`, `Grip_Secondary`).
- **Inputs:** Optimized mesh.
- **Outputs:** Rigged mesh hierarchy.
- **Dependencies:** Avatar Forge hand constraints.
- **SentinelQC Checkpoints:** Socket alignment with standard Avatar hand bounds.

### Station 5: Physics & Collision
- **Purpose:** Defines mass, friction, and calculates convex hull colliders.
- **Inputs:** Rigged mesh.
- **Outputs:** Asset with `ViperPropDef` physics block and collision hull.
- **Dependencies:** V-HACD integration.
- **SentinelQC Checkpoints:** Pivot placement validation (Bottom-Center Z=0).

### Station 6: Export & Material Packaging
- **Purpose:** Applies final materials and packages for the target engine.
- **Inputs:** Fully configured asset.
- **Outputs:** Final GLTF/USDz + `ViperPropDef`.
- **Dependencies:** Material Forge, Export Forge.
- **SentinelQC Checkpoints:** Final engine-specific naming constraint validation.

---

## 7. Node Graph

The Prop Forge utilizes a Directed Acyclic Graph (DAG) with convergence:

- **Concept Intake:** Parsing intent and type.
- **Path Router:** AI vs Scan vs Kitbash.
- *(Path A)* **AI Mesh Generator:** TripoSR/Stable3D integration.
- *(Path B)* **Scan Processor:** Photogrammetry cleanup.
- *(Path C)* **Kitbash Assembler:** Hard-surface snapping.
- **Topology Validator:** Finding holes and bad normals.
- **Voxel Remesher:** Watertight sealing.
- **Decimator:** Generating the base game-ready mesh.
- **UV Packer:** Automated atlasing.
- **Material Slot Assigner:** Prepping for Material Forge.
- **Pivot Aligner:** Forcing pivot to Bottom-Center.
- **Interaction Socket Builder:** Placing mathematical transforms for avatar hands.
- **Physics Calculator:** Volume-based mass estimation.
- **Collision Builder:** Convex decomposition (V-HACD).
- **LOD Generator:** Automated LOD chains.
- **Scale Validator:** Enforcing real-world dimension accuracy.
- **Engine Translation:** Adapting logic to Unity/Unreal/Creation Engine.
- **Prop Export:** Final serialization.

---

## 8. Technology Mapping

- **Concept Intake / Router:** ADOPT (Viper UI standards)
- **AI Mesh Generator:** ADOPT (TripoSR / Best-in-class Image-to-3D)
- **Scan Processor:** HYBRIDIZE (Open-source photogrammetry + custom cleanup)
- **Kitbash Assembler:** ADAPT (Blender Geometry Nodes)
- **Voxel Remesher:** ADAPT (Blender Voxel workflow)
- **Decimator / UV Packer:** ADAPT (MeshOptimizer / xatlas)
- **Pivot Aligner:** REPLACE (Custom Viper mathematical alignment script)
- **Interaction Socket Builder:** ADOPT (Standard GLTF nodes)
- **Physics Calculator:** REPLACE (Custom Viper logic based on bounding volume)
- **Collision Builder:** ADAPT (V-HACD)
- **LOD Generator:** ADAPT (MeshOptimizer)
- **Scale Validator:** REPLACE (Custom Viper SentinelQC rules)
- **Engine Translation:** REPLACE (Custom Viper Adapters)
- **Prop Export:** REPLACE (Custom ViperPropDef format)

---

## 9. SentinelQC Integration

SentinelQC validates functional viability before export:

- **Manifold Integrity:** Ensures the mesh is watertight for physics and lighting calculations.
- **Pivot Validation:** Verifies the pivot is precisely at the bottom center (Z=0) so the prop rests on surfaces perfectly.
- **Grip Socket Clearance:** Ensures the interaction nodes allow an avatar hand to hold the object without severe mesh clipping.
- **Bounding Volume Scale:** Prevents extreme scale hallucinations (e.g., a pencil larger than a sword).
- **Collision Hull Count:** Limits V-HACD convex hulls to prevent physics engine crashes.
- **Draw Call Efficiency:** Verifies materials are atlased where possible.
- **LOD Integrity:** Validates that LOD3 doesn't lose the essential silhouette.
- **Engine Compatibility:** Verifies naming conventions and hierarchy constraints.

---

## 10. Future Expansion

Architecture placeholders are reserved for:

- **Destructibility Workflow:** Pre-fractured voronoi chunks with constraint mapping for physics engines.
- **Procedural Clutter Spawning:** Geometry nodes designed to scatter this prop randomly across a surface (e.g., scattering books on a shelf).
- **Interactive Rigging:** Dynamic props (e.g., scissors that open/close, books that open).
- **Cloth Props:** Simulated flags, banners, or towels.
- **Fluid Props:** Props containing visual liquid shaders (e.g., potions).
- **IMVU/VRChat Workflows:** Direct exportation to standard social avatar platforms.

---

## 11. Architecture Decision Record (ADR)

**Decision:** The Prop Forge will implement a unified "Aggressive Repair" pipeline to sanitize AI-generated meshes, rather than attempting to train a flawless AI generator.

**Why this architecture is superior:**
1. **Pragmatism:** State-of-the-art AI generation still produces non-manifold, messy geometry. Trying to solve the core AI problem is beyond Viper Studio's scope.
2. **Standardization:** By voxel-remeshing and decimation every single AI output, we guarantee the asset is AAA game-ready, regardless of the AI model's internal flaws.
3. **Future-Proofing:** As AI generators improve, the Tri-Path ingestion station can swap to better models, but the robust Viper repair and validation pipeline will remain relevant and necessary.
