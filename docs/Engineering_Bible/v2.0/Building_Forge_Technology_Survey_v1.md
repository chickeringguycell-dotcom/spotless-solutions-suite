# Building Forge Technology Survey v1

## 1. Executive Summary
The Building Forge will serve as the automated manufacturing pipeline for architectural structures, ranging from single rooms to massive skyscrapers and space stations. Unlike characters or vehicles, buildings demand extremely strict adherence to orthogonal grid systems, spatial reasoning, walkable interior topologies, and modular repetition (windows, doors, floors). This survey evaluates current architectural and procedural generation technologies to determine Viper Studios' approach to automated building synthesis.

## 2. Technology Survey

The following 20 areas represent the current landscape of building creation pipelines:

### 2.1 Blender Architectural Workflows (ArchViz)
- **License:** GPL (Open Source)
- **Maturity:** Very High
- **Strengths:** Excellent boolean operations (e.g., Archipack, Fluent), great array tools for floors/windows.
- **Weaknesses:** Highly manual. Focused on offline rendering rather than game-ready modularity.
- **Automation Level:** Low (unless driven by scripts).
- **Modularity:** High, if the artist enforces it.
- **Procedural Capability:** Low.
- **Export/Engine Compatibility:** Standard FBX/GLTF exports.
- **Integration Difficulty:** Low (Headless Blender is already integrated).
- **Decision:** **HYBRIDIZE** (Use headless Blender for the low-level geometry operations and boolean window/door cutting).

### 2.2 Blender Geometry Nodes
- **License:** GPL (Open Source)
- **Maturity:** High
- **Strengths:** Unparalleled free, open-source procedural generation. Excellent for scattering instanced meshes (bricks, shingles) and arraying walls.
- **Weaknesses:** Graph complexity scales exponentially for interior/exterior layout logic.
- **Automation Level:** High.
- **Modularity:** Very High.
- **Export/Engine Compatibility:** Produces heavy static meshes unless instance data is preserved.
- **Integration Difficulty:** Medium.
- **Decision:** **ADAPT** (Utilize Geometry Nodes for procedural detailing, facade generation, and roof tiling).

### 2.3 CAD Workflows (AutoCAD / Revit)
- **License:** Commercial
- **Maturity:** Industry Standard
- **Strengths:** Mathematically perfect, standardized blueprints.
- **Weaknesses:** Awful topology for games. Over-engineered for visual assets.
- **Automation Level:** Low (mostly manual drafting).
- **Integration Difficulty:** High.
- **Decision:** **REPLACE** (Do not use CAD data directly. Instead, extract basic 2D floor plans and extrude them procedurally).

### 2.4 BIM / IFC Standards (Building Information Modeling)
- **License:** Various / OpenBIM (ISO 16739)
- **Maturity:** Very High
- **Strengths:** Semantic definitions (a door knows it is a door and links to a wall).
- **Weaknesses:** Extraneous data not needed for game engines.
- **Procedural Capability:** Low (it is a storage standard).
- **Decision:** **ADAPT** (Adopt the *semantic philosophy* of BIM—where parts know their architectural purpose—but build our own lightweight JSON schema).

### 2.5 Parametric Architecture (e.g., Grasshopper for Rhino)
- **License:** Commercial
- **Maturity:** High
- **Strengths:** Incredible algorithmic form-finding and sweeping organic structures.
- **Weaknesses:** Proprietary, expensive, outputs heavy NURBS/mesh data.
- **Decision:** **REPLACE** (Replicate specific generative algorithms using Python and Geometry Nodes).

### 2.6 Modular Construction Systems (Game Dev Standard)
- **License:** N/A (Methodology)
- **Maturity:** Very High
- **Strengths:** The AAA standard. Snap-to-grid walls, floors, and ceilings. Highly optimized for memory.
- **Weaknesses:** Produces repetitive "grid-like" structures without careful vertex blending.
- **Automation Level:** Medium (usually hand-placed in level editors).
- **Decision:** **ADOPT** (This is the fundamental paradigm Viper Studios will use for the Building Forge).

### 2.7 Kitbash Architecture
- **License:** Commercial (KitBash3D, etc.)
- **Maturity:** High
- **Strengths:** Instant high-fidelity cities and buildings.
- **Weaknesses:** Often non-modular (baked buildings) or difficult to enter (no interiors).
- **Decision:** **ADAPT** (Create an internal library of modular, interior-ready architectural kits).

### 2.8 Houdini Procedural Buildings
- **License:** Commercial (SideFX)
- **Maturity:** Extremely High
- **Strengths:** The gold standard for procedural architecture (e.g., Matrix Awakens city).
- **Weaknesses:** Very expensive licensing, proprietary engine, difficult to execute headlessly without expensive server licenses.
- **Automation Level:** Very High.
- **Decision:** **REPLACE** (We must build a free, open-source equivalent using Python and Blender Geometry Nodes to avoid SideFX licensing bottlenecks).

### 2.9 Unreal PCG (Procedural Content Generation)
- **License:** Unreal EULA
- **Maturity:** Maturing
- **Strengths:** Incredible real-time instancing and rule-based generation natively in UE5.
- **Weaknesses:** Locked exclusively to Unreal Engine.
- **Engine Compatibility:** Zero (outside Unreal).
- **Decision:** **ADAPT** (Viper Studios will generate the modular pieces and the assembly manifest, which can then be interpreted by Unreal PCG at runtime if desired).

### 2.10 Unity Procedural Environments
- **License:** Unity EULA
- **Strengths:** Good third-party ecosystem (e.g., DunGen, Archimatix).
- **Weaknesses:** Fragmented, locked to Unity.
- **Decision:** **REPLACE** (Generate universally outside the engine).

### 2.11 Open-Source Building Generators (e.g., OSM2World, CityEngine alternatives)
- **Maturity:** Low to Medium
- **Strengths:** Great for converting 2D map data (OpenStreetMap) into 3D blocks.
- **Weaknesses:** Low detail, no interiors, basic textures.
- **Decision:** **HYBRIDIZE** (Use OSM-style footprint algorithms to generate base floorplans).

### 2.12 Shape Grammar Systems (CGA Shape Grammar)
- **License:** Mostly Academic / Proprietary (CityEngine)
- **Maturity:** High
- **Strengths:** The best mathematical way to recursively divide a volume into floors, facades, and windows.
- **Weaknesses:** Complex to write parsers for.
- **Decision:** **ADAPT** (Build a simplified open-source Python shape grammar interpreter to drive building facades).

### 2.13 Interior Generation Systems (Dungeon Generators)
- **Maturity:** High (for 2D/grid based)
- **Strengths:** Wave Function Collapse (WFC) and BSP trees excel at making navigable rooms.
- **Weaknesses:** Often look "gamey" or lack realistic architectural flow (e.g., plumbing, load-bearing walls).
- **Decision:** **HYBRIDIZE** (Use Wave Function Collapse algorithms for interior room layout, constrained by realistic architectural rules).

### 2.14 Structural Workflows
- **Strengths:** Ensures buildings look physically viable (pillars supporting roofs).
- **Decision:** **ADAPT** (Implement basic load-bearing logic in the assembly graph so floating structures aren't generated).

### 2.15 Building Photogrammetry
- **Maturity:** High (Google Earth, Drone scans)
- **Strengths:** Photoreal exteriors.
- **Weaknesses:** Completely melted, unusable topology. No interiors. Useless for gameplay.
- **Decision:** **REPLACE** (Do not use raw photogrammetry. Use AI to extract clean tiled textures from photos, then apply them to procedural modular walls).

### 2.16 LOD Generation (Hierarchical)
- **Strengths:** Merges modular pieces into single proxy meshes for distant viewing (HLODs).
- **Decision:** **ADOPT** (Mandatory for city-scale environments).

### 2.17 Collision Generation
- **Decision:** **HYBRIDIZE** (Generate simple box colliders for modular walls/floors rather than relying on complex mesh collisions).

### 2.18 AI-Assisted Building Generation
- **Examples:** Blockade Labs (Skyboxes), various emerging 3D GenAI.
- **Maturity:** Low (for usable 3D buildings).
- **Strengths:** Good for background skyboxes or 2D concept art.
- **Weaknesses:** Generates solid blocks of noise. Cannot generate a house with a working door and stairs.
- **Decision:** **REPLACE** (Do not use GenAI for building geometry. Use AI to write the Shape Grammar rules, and let procedural math build the geometry).

### 2.19 Smart Snapping Systems
- **Strengths:** Socket-based alignment (walls to floors).
- **Decision:** **ADOPT** (The core assembly paradigm).

### 2.20 Procedural City Generation
- **Decision:** **ADAPT** (While the Forge focuses on single buildings, the architecture must support inputting a city-grid JSON to mass-produce buildings).

---

## 3. Competitive Benchmark

| Pipeline | Modularity | Interiors | Engine Agnostic | Topology Quality | Cost |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Houdini (SideFX)** | Very High | Yes | Yes | High | Very High (Commercial) |
| **Unreal PCG** | Very High | Yes | No (UE only)| High | Free (in UE) |
| **Generative 3D AI** | None (Blob) | No | Yes | Low | High (API calls) |
| **Viper Building Forge**| Very High | Yes | Yes | High | Free (Open Source backend)|

**What they do better:** Houdini has decades of node development and is the absolute king of proceduralism.
**What we do better:** Viper Studios will be entirely free/open-source on the backend (Blender/Python), strictly engine-agnostic, and deeply integrated with our Material Forge for instant AAA texturing.

---

## 4. Long-Term Building Forge Vision

The Building Forge will act as an **Architectural Compiler**.
1. **Semantic Input:** Helios translates a request ("A 3-story cyberpunk apartment building with a neon facade and a rooftop bar").
2. **Grammar Expansion:** The Forge uses a Python-based Shape Grammar to define the volume, slice it into floors, and divide the floors into rooms.
3. **Modular Assembly:** Instead of sculpting the building, the Forge places predefined modular pieces (Wall_A, Window_B, Floor_C, Staircase) onto a 3D grid using Wave Function Collapse to ensure everything fits logically.
4. **Detailing:** Geometry Nodes scatter pipes, AC units, and neon signs.
5. **Optimization:** The Forge outputs an optimized hierarchical instance structure (or merged mesh), ready for the Engine Compatibility Forge.

---

## 5. Architecture Decision Record (ADR)

**Decision:** We are building the Building Forge utilizing a **Shape Grammar + Wave Function Collapse Modular Assembly Strategy**, deliberately avoiding monolithic AI geometry generation and expensive commercial procedural software (Houdini).

**Justification:**
1. **Navigability:** Buildings in games must be navigable. A monolithic AI-generated mesh is a solid block. Modular assembly guarantees that doors can open, stairs can be climbed, and interiors exist.
2. **Performance:** Game engines rely heavily on instancing (drawing the same window 1,000 times cheaply). Modular assembly preserves instancing. Monolithic generation destroys it.
3. **Independence:** By building a custom Python/Blender backend, Viper Studios avoids being locked into SideFX (Houdini) licensing fees or Unreal Engine exclusivity, fulfilling the engine-agnostic mission.
4. **Scale:** Shape grammar allows for the infinite generation of diverse buildings using a very small library of modular parts, keeping memory footprints incredibly low while maximizing visual variety.

---

## 6. Recommendation
Proceed with the Building Forge Architecture planning based on the **Modular Assembly / Shape Grammar** paradigm. Use AI exclusively for generating the logic rules (floorplans, grammar strings) and generating the PBR materials, but rely entirely on deterministic code and headless Blender for the geometric assembly.
