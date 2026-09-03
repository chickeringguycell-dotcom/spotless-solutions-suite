# Building Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** To serve as a highly structured, procedurally driven architectural compiler that constructs navigable, game-ready buildings from modular components.
- **Why it exists:** Current AI 3D generators produce solid, non-navigable blobs. Buildings in games require exact dimensions, walkable interiors, functioning doors, instanced geometry for performance, and collision meshes. The Building Forge guarantees these requirements by utilizing mathematical shape grammars and modular assembly rather than generative sculpting.
- **Inputs:** Semantic requests, floor plans, reference art, city zoning parameters.
- **Outputs:** Fully assembled, hierarchically optimized, and navigable 3D buildings ready for Engine Compatibility translation.
- **Dependencies:** Proprietary Modular Asset Library, Python-based Shape Grammar Engine, Headless Blender Geometry Nodes, SentinelQC architectural validators.
- **Current status:** Architecture Phase

## 2. Mission
The Building Forge's mission is to mathematically construct buildings that look visually stunning while remaining strictly logical. Every generated building must have a valid entrance, connected interior rooms, physically plausible load-bearing geometry, and perfect modular snapping, ensuring it is instantly usable in downstream game engines.

## 3. Scope
The Building Forge handles static architectural assembly. Its scope includes:
- Single rooms and small props.
- Residential houses and commercial buildings.
- Large-scale skyscrapers and space stations.
- Interior room generation and navigation meshes.
It defines the structural layout, modular instances, materials, and collisions, delegating final engine-specific formatting to the Engine Compatibility Forge.

## 4. Long-Term Vision
The Building Forge will become an intelligent "Virtual Architect." Given a prompt like "Build a 3-story cyberpunk apartment complex with a rooftop bar," the Forge will divide the volume, establish load-bearing walls, route staircases, populate rooms based on their designated purpose (e.g., placing beds in bedrooms via the Furniture Forge), and output a highly optimized instanced hierarchy.

## 5. Design Philosophy
- **Modular Assembly over Sculpting:** We construct buildings from distinct, perfectly modeled pieces (walls, floors, windows) to preserve instancing and performance.
- **Shape Grammar & Wave Function Collapse:** Buildings are fundamentally rules-based. We use grammar to define the macro volume and WFC to populate the micro grid logic.
- **Navigability First:** A building is useless in a game if a player cannot enter it. SentinelQC will reject any building lacking doors or continuous interior navigation.
- **Instancing:** Never generate 10,000 unique window meshes. Generate 1 window mesh and instance it 10,000 times.

---

## 6. Manufacturing Pipeline

The Building Forge operates as a 7-station manufacturing line.

### Station 1: Concept & Grammar Parsing
- **Purpose:** Translate user intent into a strict 3D volumetric envelope and architectural ruleset.
- **Inputs:** Text prompts, reference photos, bounding box constraints.
- **Outputs:** Evaluated Shape Grammar string defining macro massing.
- **Dependencies:** Python Shape Grammar parser.
- **SentinelQC Checkpoints:** Validates structural dimensions and grid alignment.

### Station 2: Grid & Layout Generation
- **Purpose:** Subdivide the macro massing into distinct floors, rooms, and corridors.
- **Inputs:** Macro shape grammar.
- **Outputs:** 3D semantic voxel grid (e.g., [x,y,z] = "wall", "empty", "stairwell").
- **Dependencies:** Wave Function Collapse Engine.
- **SentinelQC Checkpoints:** Validates room connectivity and doorway accessibility.

### Station 3: Modular Assembly (The Kitbash Engine)
- **Purpose:** Populate the semantic grid with actual 3D modular assets.
- **Inputs:** Semantic grid, architectural style preference.
- **Outputs:** Assembled building hierarchy (instanced pointers, not merged meshes).
- **Dependencies:** Viper Studios Modular Asset Library.
- **SentinelQC Checkpoints:** Validates modular snapping (no gaps between walls) and structural integrity.

### Station 4: Detailing & Utilities
- **Purpose:** Place non-structural details (AC units, pipes, signs, trim).
- **Inputs:** Assembled building.
- **Outputs:** Detailed building hierarchy.
- **Dependencies:** Headless Blender Geometry Nodes (scattering).
- **SentinelQC Checkpoints:** Validates detailing does not block doorways or navigation paths.

### Station 5: Geometry Processing & Optimization
- **Purpose:** Generate collisions, navigation meshes, and HLODs (Hierarchical Level of Detail).
- **Inputs:** Detailed building hierarchy.
- **Outputs:** Full game-ready asset suite.
- **Dependencies:** V-HACD, Recast/Detour (for navmeshes).
- **SentinelQC Checkpoints:** Validates navmesh continuity and collision boundaries.

### Station 6: Material Assignment
- **Purpose:** Apply procedural textures and masks.
- **Inputs:** Asset suite.
- **Outputs:** Textured building hierarchy.
- **Dependencies:** Material Forge.
- **SentinelQC Checkpoints:** Validates UV mapping and material assignment completeness.

### Station 7: Pre-Export Preparation
- **Purpose:** Final checks before handing off to the Engine Compatibility Forge.
- **Inputs:** Complete building asset suite.
- **Outputs:** Approved universal building package (USD/GLTF).
- **Dependencies:** SentinelQC.
- **SentinelQC Checkpoints:** Final export readiness validation.

---

## 7. Node Graph Definition

The Forge is built on the following Directed Acyclic Graph (DAG):

| Node Name | Description |
| :--- | :--- |
| **Concept Intake** | Parses user prompt or image into an architectural style and bounding box. |
| **Reference Analysis** | Extracts window patterns, facade rhythm, and roof styles from reference art. |
| **Modular Asset Library** | Database query node to retrieve verified 3D architectural pieces. |
| **Shape Grammar Engine** | Executes recursive rules to define building mass and exterior facades. |
| **Wave Function Collapse Engine** | Resolves interior floorplans by collapsing logical tile probabilities. |
| **Structural Grid Builder** | Defines the mathematical grid (e.g., 3m x 3m x 4m cells). |
| **Foundation Builder** | Adjusts the bottom grid layer to conform to theoretical terrain. |
| **Wall Builder** | Instantiates wall modules on the grid edges. |
| **Floor Builder** | Instantiates floor modules within grid cells. |
| **Roof Builder** | Generates flat, pitched, or complex roofs capping the structure. |
| **Door & Window Placement** | Replaces solid walls with fenestration modules based on logic rules. |
| **Stair & Elevator Builder** | Creates vertical navigation paths connecting floors. |
| **Interior Room Generator** | Tags specific enclosed volumes for downstream furnishing. |
| **Utility Routing** | Generates pipes, ducts, and wiring along walls/ceilings procedurally. |
| **Collision Builder** | Generates simple box/plane colliders for walls and floors. |
| **Navigation Mesh Builder** | Bakes a walkable navmesh for AI pathfinding. |
| **LOD & Instancing Optimizer** | Groups identical modules into instanced arrays and generates HLOD proxy meshes. |
| **Material Assignment** | Assigns Material Forge definitions to the modular pieces. |
| **Engine Translation** | Hand-off node pointing to the Engine Compatibility Forge. |
| **Building Export** | Final staging node. |

---

## 8. Technology Mapping

| Node Category | Strategy | Primary Tool/Format |
| :--- | :--- | :--- |
| **Shape Grammar & WFC** | **REPLACE** | Custom Python implementation tailored for lightweight game grids. |
| **Modular Asset Library** | **REPLACE** | Proprietary Viper Studios database of strict grid-aligned kits. |
| **Assembly / Instancing** | **HYBRIDIZE** | Python logic outputting USD/GLTF instance data. |
| **Detailing (Pipes/AC)** | **ADAPT** | Headless Blender Geometry Nodes. |
| **Navmesh Generation** | **ADOPT** | Recast/Detour (open-source standard). |
| **Collision Generation** | **ADAPT** | Bounding box math (cheaper and more accurate than mesh collision for walls). |
| **LOD Generation** | **ADOPT** | Hierarchical mesh merging algorithms. |

---

## 9. SentinelQC Integration

Validation for buildings is strictly topological, spatial, and logical:
- **Structural Integrity:** Ensures the building is fully enclosed (no missing walls exposing the void).
- **Dimensional Accuracy:** Validates all pieces align strictly to the defined grid metric (e.g., 10cm grid).
- **Room Connectivity:** Ensures all generated interior rooms can be accessed.
- **Doorway Accessibility:** Validates doors are not blocked by stairs or utility props.
- **Stair Geometry:** Validates staircases correctly link floor *N* to floor *N+1* with proper headroom clearance.
- **Roof Continuity:** Ensures the roof fully caps the building envelope.
- **Collision Meshes:** Ensures colliders are simple primitives (boxes/planes) to optimize engine physics.
- **Navmesh Generation:** Validates the navmesh is continuous from the front door to all accessible rooms.
- **Modular Snapping:** Checks for vertex distance anomalies indicating gaps between modular panels.
- **Instancing Efficiency:** Rejects buildings that merge thousands of walls into a single unique mesh instead of using instances.
- **LOD Integrity:** Validates proxy mesh simplification.
- **Material Assignment:** Ensures every face has a valid material definition.
- **Export Readiness:** Final topological check.
- **Engine Compatibility:** Handoff validation.

---

## 10. Future Expansion

Placeholders are reserved in the architecture for:
- **Procedural Cities:** Expanding the Shape Grammar to define street networks and city blocks.
- **Settlement Generation:** Organic, non-grid-based village layouts.
- **Destructible Buildings:** Generating Voronoi fractured wall variants for Chaos/Havok destruction.
- **Electrical Systems:** Procedural wiring generating actual light sources and switches.
- **Plumbing Systems:** Procedural piping connecting kitchens and bathrooms.
- **HVAC Systems:** Ductwork generation.
- **Scanned Building Reconstruction:** Taking a photogrammetry scan and using AI to reverse-engineer it into modular grid components.
- **Weathering:** Passing vertical coordinates to the Material Forge to add grime near the ground and sun-bleaching near the roof.
- **Style Transfer:** Swapping a "Sci-Fi" kitbash library for a "Medieval" library while maintaining the same floorplan.
- **Interior Furnishing:** Handoff integration with the Furniture Forge.

---

## 11. Architecture Decision Record (ADR)

**Decision:** We are building the Building Forge utilizing a **Shape Grammar + Wave Function Collapse + Modular Instancing Strategy**, deliberately rejecting monolithic Image-to-3D AI generation for architectural structures.

**Why this architecture is superior:**
1. **Navigability & Mechanics:** Buildings are functional spaces. A monolithic AI mesh is a solid object that cannot be entered. Our modular approach guarantees walkable interiors, opening doors, and accurate collision.
2. **Performance:** A monolithic AI building containing 100 windows generates 100 unique window meshes, destroying VRAM. The Modular Instancing strategy tells the game engine to load 1 window mesh into memory and draw it 100 times, maintaining AAA performance.
3. **Logic and Control:** Wave Function Collapse and Shape Grammar provide absolute deterministic control over the layout. If the user wants the stairs on the left, the grammar dictates it perfectly. Generative AI cannot reliably place functional stairs connecting two specific coordinates.
4. **Infinite Reusability:** Once the logic engine is built, Viper Studios can generate an infinite variety of architecture simply by swapping the modular asset library (e.g., from Cyberpunk to Fantasy), rather than retraining massive neural networks.
