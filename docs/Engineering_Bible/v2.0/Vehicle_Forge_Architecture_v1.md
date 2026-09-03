# Vehicle Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** To serve as an automated, kitbash-oriented assembly line for constructing physics-ready vehicles and spacecraft.
- **Why it exists:** AI image-to-mesh generators produce monolithic blobs that cannot function mechanically. Vehicles require distinct, separate parts (wheels, doors, suspensions) and explicit physical properties to function in game engines. The Vehicle Forge solves this by utilizing procedural assembly rather than generative sculpting.
- **Inputs:** Semantic requests, concept art, reference images.
- **Outputs:** Fully assembled, hierarchically correct, and physics-rigged 3D vehicles (terrestrial, aerial, space, naval) ready for Engine Compatibility translation.
- **Dependencies:** Proprietary Kitbash Part Library, Headless Blender Geometry Nodes, SentinelQC mechanical validators.
- **Current status:** Architecture Phase

## 2. Mission
The Vehicle Forge's mission is to guarantee that any vehicle requested by the user is mathematically constructed with functioning mechanics, proper topology, and rigid body separation, ensuring it is instantly drivable, flyable, or sailable in downstream game engines.

## 3. Scope
The Vehicle Forge handles hard-surface mechanical assembly. It does not handle organic characters or terrain. Its scope includes:
- Terrestrial vehicles (wheeled, tracked, hover).
- Aircraft and Spacecraft (modular thruster, wing, and hull assemblies).
- Naval vessels.
- Mechs and walkers.
It defines the hierarchy, physical metadata (center of mass, constraints), and hardpoints, but delegates final engine-specific formatting to the Engine Compatibility Forge.

## 4. Long-Term Vision
The Vehicle Forge will become an intelligent "Virtual Engineer." Given a prompt like "Build a 4x4 off-road rover," the Forge will not just place wheels; it will mathematically calculate the required wheelbase, select appropriate suspension struts, assemble a working steering linkage, and calculate the optimal center of mass—all procedurally sourced from the Kitbash Library.

## 5. Design Philosophy
- **Procedural Assembly over Sculpting:** We do not "sculpt" a car; we build it from parts. 
- **Mechanical Separation:** A wheel is a distinct object, never welded to the chassis. A door is a distinct object on a hinge constraint.
- **Snap-Point Architecture:** Every part in the Kitbash Library has defined socket points. Assembly is a graph of connected sockets.
- **Physics-First:** If it has wheels, it has suspension constraints. Physics metadata is generated alongside the geometry, not added as an afterthought.

---

## 6. Manufacturing Pipeline

The Vehicle Forge operates as a 6-station manufacturing line.

### Station 1: Concept & Specification
- **Purpose:** Translate user intent or reference images into a structural blueprint.
- **Inputs:** Text prompts, reference photos.
- **Outputs:** JSON blueprint defining vehicle class, dimensions, part requirements, and mechanical layout.
- **Dependencies:** LLM logic for semantic parsing.
- **SentinelQC Checkpoints:** Validates blueprint feasibility (e.g., a car must have wheels or hover pads).

### Station 2: Chassis & Frame Generation
- **Purpose:** Construct the core structural foundation based on the blueprint dimensions.
- **Inputs:** JSON blueprint.
- **Outputs:** Core chassis mesh, primary attachment sockets.
- **Dependencies:** Procedural generation algorithms (Headless Blender).
- **SentinelQC Checkpoints:** Validates structural integrity and symmetry of the chassis.

### Station 3: Modular Assembly (The Kitbash Engine)
- **Purpose:** Attach library parts (engines, wheels, wings, cockpits) to the chassis sockets.
- **Inputs:** Chassis mesh, part requests.
- **Outputs:** Assembled vehicle hierarchy.
- **Dependencies:** Viper Studios Modular Part Library.
- **SentinelQC Checkpoints:** Validates attachment point alignment and modular compatibility (no clipping/intersections).

### Station 4: Rigging & Physics Constraints
- **Purpose:** Apply bones, constraints, and physical properties to moving parts.
- **Inputs:** Assembled vehicle hierarchy.
- **Outputs:** Rigged vehicle with physics metadata (suspension limits, center of mass).
- **Dependencies:** Headless Blender Armature tools.
- **SentinelQC Checkpoints:** Validates suspension geometry, steering geometry, wheel alignment, and center of mass.

### Station 5: Geometry Processing
- **Purpose:** Generate collisions, LODs, and hardpoints for weapons/accessories.
- **Inputs:** Rigged vehicle.
- **Outputs:** Full game-ready asset suite.
- **Dependencies:** V-HACD for collisions, Decimation tools for LODs.
- **SentinelQC Checkpoints:** Validates collision meshes enclose the geometry and LOD integrity.

### Station 6: Pre-Export Preparation
- **Purpose:** Final checks and preparation before handing off to the Engine Compatibility Forge.
- **Inputs:** Complete asset suite.
- **Outputs:** Approved universal vehicle package (USD/GLTF).
- **Dependencies:** SentinelQC.
- **SentinelQC Checkpoints:** Final export readiness and animation readiness validation.

---

## 7. Node Graph Definition

The Forge is built on the following Directed Acyclic Graph (DAG):

| Node Name | Description |
| :--- | :--- |
| **Concept Intake** | Parses user prompt or image into a class specification. |
| **Reference Analysis** | Extracts dimensions and key features from reference art. |
| **Modular Part Library** | Database query node to retrieve verified 3D parts. |
| **Chassis Builder** | Generates the central structural node. |
| **Structural Frame** | Builds roll cages, space frames, or unibodies. |
| **Body Panel Assembly** | Snaps exterior armor/panels onto the frame. |
| **Cockpit Builder** | Assembles the pilot area (seats, controls, glass). |
| **Interior Builder** | Populates internal space (cargo, passenger bays). |
| **Powertrain Builder** | Places engines, thrusters, exhausts, and fuel tanks. |
| **Suspension Builder** | Generates linkages, springs, and dampers. |
| **Steering Builder** | Assembles steering racks and pivots. |
| **Wheel / Track Builder** | Attaches ground locomotion systems. |
| **Flight Systems** | Attaches aerodynamic control surfaces and wings. |
| **Spacecraft Systems** | Attaches RCS thrusters, warp drives, and solar panels. |
| **Hardpoint Builder** | Defines sockets for weapons or modular cargo. |
| **Collision Builder** | Generates convex hull proxy geometry for physics engines. |
| **Physics Metadata** | Calculates mass, inertia tensor, and suspension stiffness. |
| **LOD Generator** | Decimates the assembly for distance viewing. |
| **Engine Translation** | Hand-off node pointing to the Engine Compatibility Forge. |
| **Vehicle Export** | Final staging node. |

---

## 8. Technology Mapping

| Node Category | Strategy | Primary Tool/Format |
| :--- | :--- | :--- |
| **Modular Part Library** | **REPLACE** | Proprietary Viper Studios database of curated, high-quality kitbash assets. |
| **Assembly / Snapping** | **HYBRIDIZE** | Headless Blender Geometry Nodes and Python socket-matching algorithms. |
| **Rigging & Physics** | **ADAPT** | Universal rig definitions (USD Physics constraints). |
| **Collision Generation** | **ADOPT** | V-HACD (Volumetric Hierarchical Approximate Convex Decomposition). |
| **Semantic Parsing** | **HYBRIDIZE** | Vision/Language LLMs mapped to strict JSON schemas. |
| **LOD Generation** | **ADOPT** | Open-source mesh decimation algorithms. |

---

## 9. SentinelQC Integration

Validation for vehicles is strictly mechanical and mathematical:
- **Structural Integrity:** Ensures the chassis is a continuous manifold.
- **Attachment Points:** Validates that male and female sockets match and align perfectly.
- **Modular Compatibility:** Runs collision detection between attached parts to prevent clipping.
- **Symmetry:** Ensures bilateral symmetry where requested (e.g., wings must mirror).
- **Suspension Geometry:** Validates that suspension travel paths do not intersect the chassis.
- **Steering Geometry:** Ensures front wheels have clearance to rotate on the Z-axis.
- **Wheel Alignment:** Validates wheels are perfectly aligned to the ground plane and axles.
- **Collision Meshes:** Ensures hulls are strictly convex and under vertex limits.
- **Center of Mass:** Calculates and verifies CoM is physically viable (e.g., not floating above the vehicle).
- **Hardpoint Placement:** Validates weapon/accessory sockets are unoccluded.
- **Physics Metadata:** Ensures spring rates and mass values are within engine-viable ranges.
- **Animation Readiness:** Checks that all moving parts have appropriate bone weights.
- **LOD Integrity:** Ensures hierarchical decimation.
- **Export Readiness:** Final topological check.
- **Engine Compatibility:** Handoff validation.

---

## 10. Future Expansion

Placeholders are reserved in the architecture for:
- **AI Vehicle Generation:** Future transition from pure kitbash to dynamically sculpted components once topological AI improves.
- **Procedural Assembly:** Infinitely randomized traffic generation.
- **Procedural Kitbashing:** AI generating new kitbash parts to feed into the library.
- **Modular Upgrades:** In-game systems where users can swap a "Level 1 Engine" for a "Level 2 Engine".
- **Damage Systems:** Pre-calculated fracture geometry for localized destruction.
- **Destruction Systems:** Fully simulated soft-body deformation metadata.
- **Wheeled Vehicles:** Standard cars, rovers, and trucks.
- **Tracked Vehicles:** Tanks and bulldozers with UV-scrolling tread paths.
- **Aircraft:** Helicopters, jets, and VTOLs with aerodynamic metadata.
- **Spacecraft:** Modular ships utilizing RCS hardpoints.
- **Naval Vehicles:** Boats and submarines with buoyancy metadata.
- **Mechs:** Bipedal/quadrupedal walkers requiring IK-driven physics rigs.

---

## 11. Architecture Decision Record (ADR)

**Decision:** We are building the Vehicle Forge utilizing a **Procedural Assembly & Auto-Rigging Strategy** (Kitbashing via nodes and sockets), explicitly rejecting monolithic Image-to-3D AI generation for final geometry.

**Why this architecture is superior:**
1. **Mechanical Functionality:** Vehicles are machines. They must have distinct moving parts. Monolithic AI models generate cars where the wheels are fused to the fenders. Procedural assembly guarantees every wheel is an independent object capable of rotation.
2. **Physics Ready:** Because we assemble the vehicle from known parts (e.g., we know Part A is a "Suspension Arm"), the Forge can automatically generate the exact physics constraints required by Unreal Chaos or Unity WheelColliders. A monolithic AI mesh cannot be automatically rigged for physics because the system doesn't know where the axles are.
3. **AAA Topology:** The Kitbash library consists of perfectly modeled, UV-mapped, and optimized components. When combined, the resulting vehicle looks like a hand-crafted AAA asset, completely avoiding the melted, low-resolution "blob" aesthetic common to current 3D AI generation.
4. **Infinite Extensibility:** By defining a universal socket system, the community can upload new thrusters, tires, and wings into the library, allowing the procedural engine to infinitely expand its design vocabulary.
