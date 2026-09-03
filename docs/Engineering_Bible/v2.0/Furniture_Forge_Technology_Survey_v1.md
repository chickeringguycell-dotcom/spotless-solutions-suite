# Furniture Forge Technology Survey v1

## 1. Executive Summary

- **Mission:** Evaluate the state of the art in furniture creation systems to design a universal, modular Furniture Forge for Viper Studios.
- **Why it exists:** Furniture requires a blend of hard-surface precision (wood/metal) and soft-body organic simulation (cushions/cloth). Generating furniture for varied game engines requires standardized bounds, interactable sockets (e.g., sit points for Avatars), and collision meshes that accommodate interior pathfinding.
- **Inputs:** Dimensions, style prompts, material selections, and modular kitbash parts.
- **Outputs:** Rigged, modular, game-ready GLTF/USDz furniture assemblies with Avatar-compatible sit/interaction nodes.
- **Dependencies:** Avatar Forge (for human scaling/interaction nodes), Material Forge, and Export Forge.
- **Current status:** Survey / Architecture Planning.

---

## 2. Technology Survey & Competitive Benchmark

### 2.1 Blender Furniture Workflows
- **License:** GPL (Open Source)
- **Maturity:** Production-ready
- **Strengths:** Excellent hard-surface modeling, precise edge bevelling, robust UV mapping.
- **Weaknesses:** Highly manual.
- **Automation Level:** Low
- **Modularity:** Low
- **Integration Difficulty:** Low.

### 2.2 Blender Geometry Nodes
- **License:** GPL (Open Source)
- **Maturity:** High
- **Strengths:** Fully procedural generation of shelves, tables, and cabinets using mathematical bounding boxes.
- **Weaknesses:** Node graphs can be complex to maintain; requires realizing instances for export.
- **Automation Level:** High
- **Modularity:** Very High
- **Integration Difficulty:** Medium.

### 2.3 Parametric Furniture Systems
- **License:** Varies (e.g., Grasshopper, Sverchok)
- **Maturity:** High
- **Strengths:** Dimensionally accurate, scalable, and responsive to bounding box changes.
- **Weaknesses:** Often outputs CAD-style topology not suited for real-time rendering.
- **Procedural Capability:** Elite
- **Integration Difficulty:** High.

### 2.4 CAD Furniture Workflows
- **License:** Commercial / Open Source (FreeCAD)
- **Maturity:** Industry Standard (Architecture/Manufacturing)
- **Strengths:** Precision engineering, exact joinery (dovetails, mortise and tenon).
- **Weaknesses:** Outputs N-gons and heavy geometry requiring aggressive retopology.
- **Engine Compatibility:** Low
- **Integration Difficulty:** High.

### 2.5 Open-Source Furniture Generators
- **License:** Varies
- **Maturity:** Experimental
- **Strengths:** Fast generation of generic tables/chairs based on bounding boxes.
- **Weaknesses:** Lacks AAA visual fidelity, often produces basic geometric primitives.
- **Automation Level:** High
- **Integration Difficulty:** Medium.

### 2.6 IKEA-Style Modular Assembly Concepts
- **License:** Concept
- **Maturity:** Industry Standard
- **Strengths:** Parts (legs, tabletops, brackets) are standardized and interchangeable.
- **Weaknesses:** Can lead to repetitive asset design if the kitbash library isn't diverse.
- **Modularity:** Extremely High
- **Integration Difficulty:** Low.

### 2.7 Kitbash Furniture Libraries
- **License:** Asset-dependent
- **Maturity:** Production-ready
- **Strengths:** Rapid assembly of high-fidelity furniture from pre-built libraries.
- **Weaknesses:** Large storage overhead; requires consistent texture scaling (texel density).
- **Modularity:** High
- **Integration Difficulty:** Low.

### 2.8 Procedural Furniture Generation
- **License:** Concept (e.g., Houdini Engine)
- **Maturity:** Production-ready
- **Strengths:** Rule-based generation (e.g., "if table > 2m, add middle support leg").
- **Weaknesses:** Expensive to develop custom procedural rulesets for every style.
- **Procedural Capability:** High
- **Integration Difficulty:** High.

### 2.9 AI Furniture Generation Systems
- **License:** Varies (Stable3D, Meshcrafter)
- **Maturity:** Experimental
- **Strengths:** Infinite stylistic variations from text prompts.
- **Weaknesses:** Topology is often melted or non-manifold. Unreliable for flat, hard surfaces (tabletops are rarely perfectly flat).
- **Automation Level:** High
- **Integration Difficulty:** High (requires aggressive geometric flattening).

### 2.10 Joinery Systems
- **License:** Concept
- **Strengths:** Realistic connection logic (screws, brackets, wood joints).
- **Weaknesses:** Too dense for game engines. Often baked into normal maps rather than modeled.
- **Integration Difficulty:** High (usually bypassed via texture baking).

### 2.11 Upholstery Workflows
- **License:** Commercial (Marvelous Designer) / Open Source (Blender Cloth)
- **Maturity:** Industry Standard
- **Strengths:** Realistic wrinkles, folds, and seam tension.
- **Weaknesses:** Computationally expensive to simulate; must be baked to static meshes.
- **Procedural Capability:** Medium
- **Integration Difficulty:** Medium (simulate headless, bake, decimate).

### 2.12 Cushion Generation
- **License:** Concept (Blender Cloth/Pressure modifiers)
- **Maturity:** High
- **Strengths:** Generates organic, comfortable-looking cushions via pressure simulation.
- **Weaknesses:** Requires high vertex counts for realistic folds.
- **Integration Difficulty:** Low (native to Blender).

### 2.13 Wood Construction Workflows
- **License:** Concept
- **Strengths:** Aligned UVs for correct wood grain direction along the length of the geometry.
- **Weaknesses:** Requires specialized UV mapping logic to prevent cross-grain rendering.
- **Procedural Capability:** High
- **Integration Difficulty:** Medium.

### 2.14 Metal Fabrication Workflows
- **License:** Concept
- **Strengths:** Beveled edges for specular highlights, weld-seam generation.
- **Weaknesses:** Requires strict normal hardening/softening based on face angles.
- **Integration Difficulty:** Low.

### 2.15 Furniture Scanning / Photogrammetry
- **License:** Varies (RealityCapture, Meshroom)
- **Maturity:** Production-ready
- **Strengths:** Photoreal textures and organic imperfections.
- **Weaknesses:** Scans often fail on specular surfaces (glass/metal); topology is messy and unoptimized.
- **Automation Level:** Medium
- **Integration Difficulty:** Medium (requires retopology and cleanup).

### 2.16 LOD Generation
- **License:** Open Source (MeshOptimizer)
- **Maturity:** Industry Standard
- **Strengths:** Automatic mesh decimation for background props.
- **Weaknesses:** Aggressive LODs can destroy hard-surface silhouettes.
- **Integration Difficulty:** Low.

### 2.17 Collision Generation
- **License:** Open Source (V-HACD)
- **Maturity:** High
- **Strengths:** Automatically generates convex hulls preventing avatar clipping.
- **Weaknesses:** Complex shapes (e.g., curved couches) require multiple convex decomposition passes.
- **Integration Difficulty:** Low.

### 2.18 Physics-Ready Furniture
- **License:** Concept
- **Strengths:** Allows furniture to be pushed, knocked over, or broken in-game.
- **Weaknesses:** Requires accurate mass and Center of Mass (CoM) definitions to avoid "floaty" physics.
- **Integration Difficulty:** Medium.

### 2.19 Interior Decoration Systems
- **License:** Concept (Sims, House Flipper)
- **Maturity:** Production-ready
- **Strengths:** Grid/Snap-based placement, wall alignment.
- **Weaknesses:** Relies on standardized pivot points (usually bottom-center).
- **Integration Difficulty:** Low.

### 2.20 Smart Modular Snapping Systems
- **License:** Concept
- **Strengths:** Sockets allow dynamic attachment (e.g., snapping a cushion to a chair frame).
- **Weaknesses:** Requires strict coordinate naming conventions across all assets.
- **Integration Difficulty:** Medium.

---

## 3. Architecture Decision Record (ADR)

| Technology | Decision | Justification |
| :--- | :--- | :--- |
| **Blender Geometry Nodes** | **ADAPT** | The core driver for parametric generation (resizing tables, adding shelves based on bounds). |
| **IKEA-Style Kitbash** | **ADOPT** | A library of canonical parts (legs, handles, cushions) ensures fast, modular, high-quality assembly. |
| **AI Furniture Generation** | **HYBRIDIZE** | AI generates concept textures and organic shapes, but strict mathematical flattening is applied to hard surfaces (tabletops must be flat). |
| **Upholstery/Cushions** | **ADAPT** | Headless Blender cloth/pressure simulations will generate organic cushions, which are then decimated for real-time use. |
| **CAD/Joinery** | **REPLACE** | Too heavy for game engines. Joinery will be represented via baked normal maps, not modeled geometry. |
| **Photogrammetry** | **HYBRIDIZE** | Used for organic/rustic furniture textures, strictly cleaned up via automated retopology pipelines. |
| **Wood Construction UVs** | **ADOPT** | Procedural mapping rules will ensure wood grain aligns with the longest axis of any bounding box. |
| **Smart Modular Snapping** | **ADOPT** | Strict socket nodes (`sit_point`, `snap_cushion`) ensure compatibility with Avatar constraints and modular swapping. |
| **Collision (V-HACD)** | **ADAPT** | Automated convex decomposition to ensure player pathfinding and physics interaction. |
| **Physics/LOD** | **ADOPT** | Standardized metadata (Mass, CoM) and automated MeshOptimizer LOD chains. |

---

## 4. Long-Term Furniture Forge Vision

The Furniture Forge will operate as a **Parametric Assembly System**. It combines the precision of Geometry Nodes for hard surfaces with the organic simulation of cloth pressure for upholstery. 

### 4.1 The Engine-Agnostic Furniture Definition (ViperFurnitureDef)
A JSON specification defining:
- **Hierarchy:** Frame, Cushions, Drawers, Handles.
- **Physics Metadata:** Mass, Center of Mass, Friction.
- **Interaction Nodes:** `Sit_Root`, `Sleep_Root`, `Open_Drawer_Axis`.
- **Material Zones:** Base Wood, Accent Metal, Fabric Upholstery.
- **Bounding Volumes:** Exact X, Y, Z dimensions for grid-based interior decorators.

### 4.2 Cross-Domain Application
- **VRChat / Unity:** `Sit_Root` nodes map directly to VRC Station components.
- **Starfield / Skyrim:** Furniture acts as interactable markers; bounding boxes ensure they fit in hab modules.
- **Unreal Engine:** Collision hulls map to standard static mesh physics.

### 4.3 SentinelQC Mechanical Validation
SentinelQC must enforce physical and interactive reality:
- Is the tabletop perfectly flat (Z-variance = 0)?
- Does the `Sit_Root` node align properly with the Avatar Forge's human scale?
- Is the Center of Mass low enough that the item won't tip over erratically?
- Are the UVs scaled to the correct universal texel density?

---

## 5. Recommendation

**Recommendation:** The Furniture Forge should adopt a Hybrid Parametric-Kitbash architecture. It should rely on Blender Geometry Nodes to procedurally scale frames (tables/shelves) while snapping high-fidelity, cloth-simulated canonical cushions and kitbash parts (handles/legs) to those frames. AI generation should be restricted to textural detail and organic embellishments to prevent non-manifold hard surfaces.

The next step is to design the `Furniture_Forge_Architecture_v1.md`, specifying the manufacturing line stations required to intake kitbash parts, apply parametric logic, simulate upholstery, and validate interaction nodes via SentinelQC.
