# Vehicle Forge Technology Survey v1

## 1. Executive Summary
The Vehicle Forge will serve as the premier automated manufacturing pipeline for both terrestrial vehicles and spacecraft within Viper Studios. Unlike organic characters, vehicles are highly modular, rigidly defined, mechanically constrained, and heavily reliant on physical simulation (suspension, thrusters, collision). This survey evaluates the current state of the art in vehicle modeling and physics pipelines to determine how Viper Studios will approach hard-surface procedural generation and physics integration.

## 2. Technology Survey

The following 20 areas represent the current landscape of vehicle creation and physics pipelines:

### 2.1 Blender Vehicle Workflows (Standard Hard-Surface)
- **License:** GPL (Open Source)
- **Maturity:** Production Ready (High)
- **Strengths:** Excellent subdivision surface modeling, boolean toolsets (e.g., HardOps/Boxcutter), great ecosystem.
- **Weaknesses:** Highly manual. Requires an artist to click and drag. Not inherently parametric.
- **Automation Level:** Low (unless scripted via Python).
- **Modularity:** Dependent on the artist's discipline.
- **Physics/Export Support:** Needs external physics engines; exports well to FBX/GLTF.
- **Integration Difficulty:** Low (Headless Blender is already a core component).
- **Decision:** **HYBRIDIZE** (Use headless Blender as the backend geometry compiler).

### 2.2 Blender Geometry Nodes
- **License:** GPL (Open Source)
- **Maturity:** Rapidly Maturing
- **Strengths:** Fully procedural, mathematically driven generation. Excellent for generating arrays, cables, treads, and modular snapping.
- **Weaknesses:** Steep learning curve; performance can drag with massive graphs.
- **Automation Level:** Very High.
- **Modularity:** Native.
- **Physics/Export Support:** Generates static mesh well; physics must be applied downstream.
- **Integration Difficulty:** Medium.
- **Decision:** **ADAPT** (Use Geometry Nodes for procedural greebling and mechanical part generation).

### 2.3 CAD-Inspired Parametric Modeling (e.g., FreeCAD / OpenSCAD)
- **License:** LGPL / GPL
- **Maturity:** High (for engineering), Low (for games)
- **Strengths:** Mathematically perfect, history-based modeling, infinitely adjustable.
- **Weaknesses:** Produces terrible topology for real-time rendering. No UV maps.
- **Automation Level:** High.
- **Modularity:** Very High.
- **Integration Difficulty:** High.
- **Decision:** **REPLACE** (Do not use raw CAD. Instead, build a node-based parametric system that outputs game-ready quads/tris).

### 2.4 Kitbash Workflows
- **License:** Commercial (typically individual licenses)
- **Maturity:** Production Ready
- **Strengths:** Instant high-fidelity results. Drag-and-drop mechanical parts (engines, wings, struts).
- **Weaknesses:** Repetitive if the pool is small. Legal/licensing issues for AI generative platforms unless internal libraries are created.
- **Automation Level:** Medium (Can be scripted).
- **Decision:** **ADAPT** (Build an internal Viper Studios proprietary kitbash library to assemble vehicles procedurally).

### 2.5 Hard-Surface Modeling Pipelines (General)
- **Decision:** **HYBRIDIZE** (Combine boolean-driven mesh operations with subdivision surfaces).

### 2.6 Open-Source Procedural Vehicle Generation
- **Examples:** CityEngine (Commercial), Various GitHub experiments.
- **Maturity:** Low (for vehicles).
- **Strengths:** Fast city/traffic generation.
- **Weaknesses:** Often lacks heroic asset quality (hero spaceships/cars).
- **Decision:** **REPLACE** (Build a bespoke modular assembly graph).

### 2.7 BeamNG-Style Vehicle Structures
- **License:** Proprietary (Commercial)
- **Maturity:** Extremely High (for soft-body simulation).
- **Strengths:** Unparalleled node/beam soft-body physics, realistic damage.
- **Weaknesses:** Very expensive computationally; completely incompatible with standard engines (Unreal/Unity) without heavy compromises.
- **Decision:** **REPLACE** (While fascinating, node/beam physics is too isolated. Viper must focus on rigid-body and skeletal damage pipelines for broad compatibility).

### 2.8 Unreal Chaos Vehicles
- **License:** Unreal EULA (Commercial)
- **Maturity:** High.
- **Strengths:** Native to UE5, supports complex suspensions, aerodynamic forces.
- **Weaknesses:** Only works in Unreal. Requires specific bone hierarchies and wheel setups.
- **Decision:** **ADAPT** (Target Chaos vehicle bone structures during the Engine Compatibility phase).

### 2.9 Unity Vehicle Systems (WheelColliders)
- **License:** Unity EULA (Commercial)
- **Maturity:** High.
- **Strengths:** Simple setup, widely used.
- **Weaknesses:** Prone to jitter, often requires third-party assets (e.g., Edy's Vehicle Physics) for realism.
- **Decision:** **ADAPT** (Target standard Unity WheelCollider hierarchies).

### 2.10 PhysX Vehicle Pipelines
- **License:** BSD 3-Clause (Open Source via Nvidia)
- **Maturity:** Very High.
- **Strengths:** Industry standard for a decade.
- **Weaknesses:** Being phased out in some engines (like Unreal moving to Chaos).
- **Decision:** **HYBRIDIZE** (Support generic PhysX constraints as a universal baseline).

### 2.11 Starfield Ship Construction (Modding)
- **License:** Bethesda EULA
- **Maturity:** High.
- **Strengths:** Highly modular, snap-point based, interior/exterior synchronization.
- **Weaknesses:** Requires strict `.nif` formatting and Havok behavior logic.
- **Decision:** **ADAPT** (Build Viper Studios vehicles using snap-point metadata so they translate seamlessly into Starfield ship modules).

### 2.12 Starfield Vehicle Mods (Rovers/Landers)
- **Maturity:** Emerging.
- **Decision:** **ADAPT** (Track emerging community standards for Starfield surface vehicles).

### 2.13 Skyrim Carriage/Vehicle Systems
- **Maturity:** Low (Engine was never designed for vehicles).
- **Strengths:** Simple rigid body attachments.
- **Weaknesses:** Terribly physics stability.
- **Decision:** **ADAPT** (Support simple skeletal mounts/carriages).

### 2.14 Spacecraft Construction Pipelines
- **Strengths:** Modular by nature (thruster, hull, cockpit, wings).
- **Decision:** **ADOPT** (Embrace a modular, snap-point driven assembly architecture for spacecraft).

### 2.15 Modular Vehicle Systems
- **Strengths:** Allows infinite variations from a finite set of parts.
- **Decision:** **ADOPT** (This is the core paradigm for the Vehicle Forge).

### 2.16 Suspension Systems
- **Decision:** **HYBRIDIZE** (Generate constraints mathematically based on wheel placement, outputting generic spring/damper values to be interpreted by target engines).

### 2.17 Wheel and Track Systems
- **Decision:** **ADAPT** (Generate separate continuous meshes for tracks with UV scrolling logic, and distinct rigid bodies for wheels).

### 2.18 Damage Systems
- **Decision:** **HYBRIDIZE** (Generate pre-fractured geometry using Voronoi algorithms in headless Blender, controlled by morph targets/blendshapes for denting).

### 2.19 LOD Generation
- **Decision:** **ADOPT** (Use headless decimation or specialized open-source tools like Simplygon alternatives).

### 2.20 AI-Assisted Hard-Surface Generation
- **Examples:** Meshcapade, Tripo3D, CSM, Trellis.
- **Maturity:** Medium.
- **Strengths:** Good for quick concepting and organic hard-surface shapes.
- **Weaknesses:** Terrible topology, inaccurate scaling, non-manifold geometry, lacks mechanical separation (everything is one blob).
- **Decision:** **HYBRIDIZE** (Use AI to generate the concept and height maps, but rely on procedural kitbash assembly for the actual geometry).

---

## 3. Competitive Benchmark

| Pipeline | Modularity | Physics Prep | Engine Agnostic | Topology Quality |
| :--- | :--- | :--- | :--- | :--- |
| **Traditional (Maya/Blender)** | High (Manual) | Manual | Yes | High |
| **Generative AI (e.g., Tripo)** | Low (Blob mesh) | None | Yes | Low |
| **Starfield Ship Builder** | Very High | Native | No (Creation Engine) | High |
| **Viper Studios Vehicle Forge** | Very High (Automated)| Automated | Yes (Export Forge) | High (Kitbash based)|

**What they do better:** Starfield's in-game builder is highly visual and instantly playable.
**What we do better:** Viper Studios is engine-agnostic, enabling a ship built for Starfield to be instantly rigged and driven in Unreal Engine or VRChat. We also automate the physics constraints.

---

## 4. Long-Term Vehicle Forge Vision

The Vehicle Forge will not attempt to generate a car or spaceship as a single monolithic AI mesh. 
Instead, it will function as an **Automated Hard-Surface Assembly Plant**. 

1. **Semantic Understanding:** Helios understands the request ("A heavy industrial lunar rover").
2. **Chassis Generation:** The Forge generates a base chassis mathematically based on wheel/track requirements.
3. **Modular Assembly:** The Forge pulls verified, perfectly-topologized mechanical components (wheels, suspension arms, cockpits, thrusters) from an internal Kitbash Library and snaps them together using predefined sockets.
4. **Procedural Greebling:** Headless Blender Geometry Nodes scatter pipes, wires, and panels over the surface.
5. **Physics Rigging:** The Forge automatically identifies wheels and applies suspension bones and limits.
6. **Materializing:** The asset is sent to the Material Forge for intelligent weathering (e.g., lunar dust accumulating on the lower chassis).

---

## 5. Architecture Decision Record (ADR)

**Decision:** The Vehicle Forge will abandon monolithic Image-to-3D AI generation in favor of a **Procedural Modular Assembly (Kitbashing) Architecture** driven by snap-points, combined with procedural greebling.

**Justification:**
1. **Mechanical Reality:** Vehicles require exact mechanical separation (doors must open, wheels must spin, suspensions must compress). Current 3D AI models bake everything into a single continuous mesh, making them useless for gameplay without days of manual cleanup.
2. **Physics First:** A modular system allows the Forge to inherently understand what a part *is*. If the Forge places a wheel from the library, it knows exactly where the axle is and can automatically generate the physics constraints for Unity/Unreal.
3. **Topology:** Hard-surface rendering requires perfect normals and bevels. Pulling from a verified kitbash library guarantees AAA topology.

---

## 6. Recommendation
Proceed with the Vehicle Forge Architecture planning based on the **Modular Assembly / Kitbash** paradigm. Do not attempt to rely on current Image-to-Mesh AI for final vehicle geometry. AI should be used for concepting and material generation, while the actual mesh is assembled procedurally.
