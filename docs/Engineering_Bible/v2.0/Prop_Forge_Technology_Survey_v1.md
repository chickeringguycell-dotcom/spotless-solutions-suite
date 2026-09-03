# Prop Forge Technology Survey v1

## 1. Executive Summary

- **Mission:** Evaluate the state of the art in prop creation systems to design a universal Prop Forge for Viper Studios.
- **Why it exists:** Props represent the vast majority of environmental clutter and interactive objects in a game (cups, weapons, tools, loose clutter). Unlike furniture or vehicles, props range wildly in scale (from a coin to a grand piano) and often require specialized physics definitions (e.g., destructible crates, grabbable tools).
- **Inputs:** Style prompts, reference images, photogrammetry scans, and canonical kitbash assets.
- **Outputs:** Optimized, physics-ready GLTF/USDz props with Engine-Agnostic metadata (`ViperPropDef`).
- **Dependencies:** Material Forge, Export Forge.
- **Current status:** Survey / Architecture Planning.

---

## 2. Technology Survey & Competitive Benchmark

### 2.1 Blender Prop Workflows
- **License:** GPL (Open Source)
- **Maturity:** Production-ready
- **Strengths:** Universal industry standard for hard-surface and organic modeling; excellent unwrapping tools.
- **Weaknesses:** Highly manual per-asset creation process.
- **Automation Level:** Low
- **Modularity:** Low
- **Integration Difficulty:** Low.

### 2.2 Blender Geometry Nodes
- **License:** GPL (Open Source)
- **Maturity:** High
- **Strengths:** Excellent for scattering setups, procedural cables, chains, and structural clutter.
- **Weaknesses:** Can be overkill for a simple hero prop like a single coffee mug.
- **Automation Level:** High
- **Integration Difficulty:** Medium.

### 2.3 Kitbash Systems
- **License:** Asset-dependent
- **Maturity:** Production-ready
- **Strengths:** Extremely fast way to generate complex sci-fi or mechanical props (e.g., engines, generators).
- **Weaknesses:** Texture consistency and draw-call explosions if not properly atlased.
- **Modularity:** Very High
- **Integration Difficulty:** Low.

### 2.4 Modular Prop Systems
- **License:** Concept
- **Maturity:** High
- **Strengths:** Props broken into standardized attachable pieces (e.g., gun barrels, scopes).
- **Weaknesses:** Requires strict node-socket coordinate alignment.
- **Modularity:** High
- **Integration Difficulty:** Medium.

### 2.5 Photogrammetry
- **License:** Varies (RealityCapture, Meshroom, Polycam)
- **Maturity:** Industry Standard
- **Strengths:** Unmatched photorealism for organic clutter (rocks, food, garbage).
- **Weaknesses:** Terrible topology; specular highlights get baked in; requires massive cleanup.
- **Automation Level:** Medium
- **Integration Difficulty:** High (requires an automated retopology pipeline).

### 2.6 AI Prop Generation
- **License:** Varies (Stable3D, TripoSR)
- **Maturity:** Experimental to Maturing
- **Strengths:** Instantaneous generation of distinct props from a single image or text prompt.
- **Weaknesses:** Lacks sub-D surface cleanliness; often non-manifold; struggles with hollow objects (e.g., mugs, bowls).
- **Automation Level:** Very High
- **Integration Difficulty:** High (requires aggressive SentinelQC topology repair).

### 2.7 Open-Source Prop Libraries
- **License:** CC0 (Poly Haven, AmbientCG)
- **Maturity:** Production-ready
- **Strengths:** Free, high-quality baselines for standard props.
- **Weaknesses:** Cannot generate bespoke or stylized IP-specific props.
- **Integration Difficulty:** Low.

### 2.8 Procedural Prop Generation
- **License:** Concept (Houdini)
- **Maturity:** Production-ready
- **Strengths:** Generates infinite variations (e.g., 100 uniquely shaped potions).
- **Weaknesses:** Expensive to set up the rulesets.
- **Integration Difficulty:** High.

### 2.9 Asset Packing Systems
- **License:** Concept
- **Maturity:** Industry Standard
- **Strengths:** Combining multiple small props into single texture atlases to save draw calls.
- **Weaknesses:** UV packing algorithms can be complex to automate cleanly.
- **Integration Difficulty:** Medium.

### 2.10 Hero Prop Workflows
- **License:** Concept
- **Maturity:** Industry Standard
- **Strengths:** Extremely high fidelity for props seen up-close (weapons, quest items).
- **Weaknesses:** Expensive vertex counts; requires manual normal baking.
- **Integration Difficulty:** Low.

### 2.11 Small Object Workflows
- **License:** Concept
- **Strengths:** Aggressive LODing and cheap billboard impostors for distant clutter.
- **Integration Difficulty:** Low.

### 2.12 Physics-Ready Props
- **License:** Concept
- **Strengths:** Defined Mass, Restitution (bounciness), and Friction values allowing engine simulations.
- **Weaknesses:** Requires engine-specific translation of physical units.
- **Integration Difficulty:** Medium.

### 2.13 Interactive Props
- **License:** Concept
- **Strengths:** Assigns interact nodes (`Grab_Root`, `Use_Root`) for VR and standard games.
- **Weaknesses:** Interaction skeletons vary heavily by engine (e.g., Unity XR vs Unreal VR).
- **Integration Difficulty:** High.

### 2.14 Destructible Props
- **License:** Concept (Apex Destruction / Chaos Destruction)
- **Maturity:** High
- **Strengths:** Pre-fractured voronoi chunks allowing props to break upon impact.
- **Weaknesses:** Exporting pre-fractured constraints universally is extremely difficult.
- **Integration Difficulty:** Very High.

### 2.15 Collision Generation
- **License:** Open Source (V-HACD)
- **Maturity:** High
- **Strengths:** Generates convex hulls for performance-friendly physics.
- **Integration Difficulty:** Low.

### 2.16 LOD Generation
- **License:** Open Source (MeshOptimizer)
- **Maturity:** Industry Standard
- **Strengths:** Generates LOD0-LOD3 chains automatically.
- **Integration Difficulty:** Low.

### 2.17 Material Assignment
- **License:** Concept
- **Strengths:** Material IDs routing to the Material Forge for PBR textures.
- **Integration Difficulty:** Low.

### 2.18 Export Workflows
- **License:** Standard (GLTF/USDz)
- **Maturity:** High
- **Strengths:** Universal format for 3D packaging.
- **Integration Difficulty:** Low.

### 2.19 Engine Compatibility
- **License:** Concept
- **Strengths:** Dedicated adapters translate GLTF into Unreal Blueprints, Unity Prefabs, or Bethesda NIFs.
- **Integration Difficulty:** High.

### 2.20 Smart Snapping Systems
- **License:** Concept
- **Strengths:** Props that know how to align to surfaces (e.g., a cup spawning upright on a table).
- **Weaknesses:** Requires defining standard "Up" vectors and placement pivots.
- **Integration Difficulty:** Medium.

---

## 3. Architecture Decision Record (ADR)

| Technology | Decision | Justification |
| :--- | :--- | :--- |
| **Blender Workflows** | **ADAPT** | Headless Blender will be the core engine for LODs, UV packing, and coordinate alignment. |
| **Geometry Nodes** | **ADAPT** | Used for procedural scattering (e.g., a bowl filled with procedural fruit). |
| **Kitbash Systems** | **ADOPT** | High-fidelity modular parts for complex mechanical props. |
| **Photogrammetry** | **HYBRIDIZE** | Scanned data will be aggressively retopologized via automated pipelines for organic clutter. |
| **AI Prop Generation** | **ADOPT** | Unlike Furniture or Vehicles, small chaotic clutter (rocks, debris, non-mechanical props) is the *ideal* use-case for TripoSR/AI generation, provided SentinelQC runs manifold checks. |
| **Physics Definitions** | **ADOPT** | Universal metadata (`ViperPropDef`) will define mass and friction, leaving the actual simulation to the target engine. |
| **Destructibility** | **HYBRIDIZE** | Viper will pre-fracture meshes via Voronoi algorithms but leave constraint translation to the Engine Adapters. |
| **Interactive Sockets** | **ADOPT** | Canonical GLTF nodes (e.g., `Grip_Root`) will ensure props can be held correctly by Avatars. |
| **Smart Snapping** | **ADOPT** | Pivot points will strictly reside at the bottom-center of the prop's bounding box to ensure easy surface placement. |
| **LOD / Collision** | **ADAPT** | Automated via MeshOptimizer and V-HACD. |

---

## 4. Long-Term Prop Forge Vision

The Prop Forge will act as the **Clutter Engine** of Viper Studios. It will rapidly ingest text prompts or 2D images, run them through AI generators (like TripoSR), forcefully repair their topology, assign physical metadata, and package them as engine-ready interactables. It shifts the burden of prop creation from days of manual modeling to seconds of automated generation and validation.

### 4.1 The Engine-Agnostic Prop Definition (ViperPropDef)
A JSON specification defining:
- **Physics Metadata:** Mass, Center of Mass, Restitution, Friction.
- **Interaction Nodes:** `Grip_Primary`, `Grip_Secondary`.
- **Placement Logic:** `Pivot_Bottom_Center`, `Surface_Align_Z`.
- **Fracture Data:** Node visibility mapping for intact vs. broken states.

### 4.2 SentinelQC Prop Validation
SentinelQC must enforce absolute interactive readiness:
- Is the topology waterproof and manifold?
- Is the pivot point correctly aligned at the base?
- Does the `Grip_Primary` node align with the Avatar Forge's hand constraints?
- Is the scale realistic (e.g., preventing 3-meter tall coffee cups)?

---

## 5. Recommendation

**Recommendation:** The Prop Forge should adopt a **Tri-Path Architecture**:
1. **AI-Generated Path:** For rapid, organic clutter and background props (TripoSR -> Repair -> Export).
2. **Photogrammetry Path:** For ultra-real, scanned organic assets (Scan -> Retopo -> Export).
3. **Modular Kitbash Path:** For mechanical, interactive, or hero props requiring exact precision (Assemble -> Rig -> Export).

Unlike the Vehicle and Furniture Forges which rejected monolithic AI mesh generation due to strict mechanical bounds, the Prop Forge *should* heavily leverage AI generation for the vast majority of non-mechanical clutter.

The next step is to design the `Prop_Forge_Architecture_v1.md`, specifying the stations required to manage these three distinct ingestion paths and unify them through a single SentinelQC and Export pipeline.
