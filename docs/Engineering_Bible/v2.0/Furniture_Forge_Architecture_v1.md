# Furniture Forge Architecture v1

## 1. Forge Executive Summary
- **Mission:** To serve as a high-precision, parametric assembly engine for interior props, fixtures, and furniture, ensuring all items conform strictly to human ergonomic scales and interactive constraints.
- **Why it exists:** AI image-to-mesh generators produce fused, non-interactive props with incorrect topology (e.g., a chair where the cushion is welded to the wooden frame, with no clear sitting point). Game engines require distinct separation of materials, clean collisions, and defined interaction sockets (e.g., "Sit Here"). The Furniture Forge solves this by utilizing hybrid parametric-kitbash assembly rather than generative sculpting.
- **Inputs:** Semantic requests, style reference images, room layouts.
- **Outputs:** Fully assembled, human-scaled, interactive, and physics-ready 3D furniture ready for Engine Compatibility translation.
- **Dependencies:** Proprietary Furniture Kitbash Library, Python Parametric solvers, Headless Blender Geometry Nodes, SentinelQC ergonomic validators.
- **Current status:** Architecture Phase

## 2. Mission
The Furniture Forge's mission is to mathematically construct interactive interior props that look visually distinct but are structurally guaranteed to function. A generated chair must have a defined sit-point at the correct height for an Avatar Forge human, and a drawer must be a separate, animatable mesh.

## 3. Scope
The Furniture Forge handles interactive static and dynamic interior props. Its scope includes:
- Seating (chairs, sofas, benches).
- Tables and desks.
- Storage (bookshelves, cabinets, dressers).
- Fixtures (lamps, rugs, paintings).
It defines the structural layout, modular instances, materials, interaction sockets, and collisions, delegating final engine-specific formatting to the Engine Compatibility Forge.

## 4. Long-Term Vision
The Furniture Forge will become an intelligent "Virtual Interior Designer." Given a prompt like "Furnish a 1970s retro living room," the Forge will query the room dimensions from the Building Forge, procedurally generate the required parametric seating and tables, drop them into the room using smart layout algorithms, and establish the navmesh clearances.

## 5. Design Philosophy
- **Parametric Frames over Sculpting:** A table is simply a parametric surface with four legs. We mathematically generate the bounding frame and snap kitbash components to the joints.
- **Human Scale First:** The Forge uses the Avatar Forge's standard metrics as the ground truth. A seat cushion is always placed precisely at the standard human sitting height.
- **Socket-Based Interaction:** Furniture is not just geometry; it is a gameplay object. The Forge embeds invisible sockets (`socket_sit`, `socket_grab`) into the mesh for instant engine compatibility.
- **Clean Topology:** Hard-surface furniture requires perfect bevels and UV mapping, achievable only through verified kitbash libraries and procedural math, not voxel/blob AI.

---

## 6. Manufacturing Pipeline

The Furniture Forge operates as a 6-station manufacturing line.

### Station 1: Concept & Classification
- **Purpose:** Translate user intent into a strict parametric blueprint and classify the furniture type.
- **Inputs:** Text prompts, reference photos.
- **Outputs:** Evaluated JSON blueprint defining the furniture class, dimensions, style, and required sub-components.
- **Dependencies:** LLM logic for semantic parsing.
- **SentinelQC Checkpoints:** Validates realistic dimensional constraints (e.g., rejecting a request for a 20-foot tall dining chair).

### Station 2: Parametric Frame Generation
- **Purpose:** Construct the invisible mathematical skeleton of the furniture based on standard ergonomic rules.
- **Inputs:** JSON blueprint.
- **Outputs:** Node graph of primary joints (e.g., 4 leg joints, 1 seat plane, 1 backrest plane).
- **Dependencies:** Python geometric solvers.
- **SentinelQC Checkpoints:** Validates the frame against the Avatar Scale Standard.

### Station 3: Modular Assembly (The Kitbash Engine)
- **Purpose:** Attach high-quality library parts (legs, arms, cushions) to the parametric frame.
- **Inputs:** Parametric frame, style preference.
- **Outputs:** Assembled furniture hierarchy.
- **Dependencies:** Viper Studios Furniture Part Library.
- **SentinelQC Checkpoints:** Validates modular snapping (joinery integrity) and prevents mesh intersection.

### Station 4: Interaction & Physics
- **Purpose:** Embed gameplay sockets, animations (drawers), and collisions.
- **Inputs:** Assembled furniture.
- **Outputs:** Interactive furniture hierarchy.
- **Dependencies:** Headless Blender Armature/Socket tools, V-HACD.
- **SentinelQC Checkpoints:** Validates sit/use socket placement and collision mesh conformity.

### Station 5: Detailing & Material Assignment
- **Purpose:** Apply procedural textures, upholstery logic, and surface details (scratches, dust).
- **Inputs:** Interactive furniture hierarchy.
- **Outputs:** Textured asset suite.
- **Dependencies:** Material Forge.
- **SentinelQC Checkpoints:** Validates UV mapping, material assignment, and cushion deformation limits.

### Station 6: Pre-Export Preparation
- **Purpose:** Final checks before handing off to the Engine Compatibility Forge.
- **Inputs:** Complete furniture asset suite.
- **Outputs:** Approved universal furniture package (USD/GLTF).
- **Dependencies:** SentinelQC.
- **SentinelQC Checkpoints:** Final export readiness validation.

---

## 7. Node Graph Definition

The Forge is built on the following Directed Acyclic Graph (DAG):

| Node Name | Description |
| :--- | :--- |
| **Concept Intake** | Parses user prompt or image into a style and bounding box. |
| **Reference Analysis** | Extracts silhouettes and material requests from reference art. |
| **Furniture Type Classifier** | Routes the logic to specific sub-graphs (Seating, Storage, Surface). |
| **Parametric Frame Builder** | Generates the invisible skeletal bounds based on ergonomics. |
| **Modular Part Library** | Retrieves verified 3D components (legs, handles, cushions). |
| **Joinery System** | Mathematically connects modular parts (e.g., mortise and tenon alignment). |
| **Cushion & Upholstery System** | Generates or scales soft-body meshes for seating surfaces. |
| **Surface Detail System** | Scatters props (books on a shelf) or adds procedural bevels. |
| **Interaction Socket Builder** | Places standard engine sockets (e.g., `attach_point`, `sit_point`). |
| **Sit / Use Point Validator** | SentinelQC node ensuring the interaction point isn't blocked. |
| **Collision Builder** | Generates simple box colliders optimized for performance. |
| **LOD Generator** | Decimates the assembly for distant viewing. |
| **Material Assignment** | Assigns Material Forge definitions (e.g., Leather, Oak) to parts. |
| **Scale Validator** | Final check against the Avatar scale standard. |
| **Engine Translation** | Hand-off node pointing to the Engine Compatibility Forge. |
| **Furniture Export** | Final staging node. |

---

## 8. Technology Mapping

| Node Category | Strategy | Primary Tool/Format |
| :--- | :--- | :--- |
| **Parametric Frames** | **REPLACE** | Custom Python algorithms tailored to ergonomic standards. |
| **Modular Part Library** | **REPLACE** | Proprietary Viper Studios database of furniture components. |
| **Assembly / Instancing** | **HYBRIDIZE** | Headless Blender Geometry Nodes and Python socket matching. |
| **Upholstery / Cloth** | **ADAPT** | Blender cloth simulation (executed headlessly for static draping). |
| **Interaction Sockets** | **ADAPT** | USD native `Xform` nodes marked with specific semantic tags. |
| **Collision Generation** | **ADAPT** | Bounding box math (preferred over complex mesh collisions for furniture). |
| **LOD Generation** | **ADOPT** | Open-source mesh decimation algorithms. |

---

## 9. SentinelQC Integration

Validation for furniture is strictly ergonomic, mechanical, and spatial:
- **Human Scale Correctness:** Ensures chairs are roughly 45cm high at the seat, desks 75cm high.
- **Sit/Use Socket Placement:** Validates that a `sit` socket exists on seating furniture and faces the correct orientation.
- **Structural Stability:** Ensures tables have legs that touch the zero Z-plane.
- **Joinery Integrity:** Validates that male and female sockets match perfectly without vertex gapping.
- **Cushion Deformation Limits:** Prevents cloth sim from clipping through hard-surface wood frames.
- **Collision Meshes:** Ensures colliders are simple primitives to optimize engine physics.
- **Navmesh Clearance:** Validates the footprint allows AI to walk around it.
- **Modular Compatibility:** Rejects intersecting kitbash parts.
- **LOD Integrity:** Validates proxy mesh simplification.
- **Material Assignment:** Ensures every face has a valid material definition (no missing textures).
- **Export Readiness:** Final topological check.
- **Engine Compatibility:** Handoff validation.

---

## 10. Future Expansion

Placeholders are reserved in the architecture for:
- **Procedural Room Furnishing:** Taking a room from the Building Forge and auto-populating it intelligently.
- **Smart Room Layouts:** Algorithms determining optimal furniture placement (e.g., TV faces the couch).
- **Destructible Furniture:** Generating Voronoi fractured variants (e.g., breakable wooden crates).
- **Animated Drawers and Doors:** Generating separate meshes with hinge constraints for interactive looting systems.
- **Cloth Cushions:** Real-time cloth setups for engine physics.
- **Scanned Furniture Reconstruction:** Taking photogrammetry scans and using AI to reverse-engineer them into modular, clean-topology components.
- **Style Transfer:** Changing a "Victorian" room to a "Sci-Fi" room by instantly swapping the modular library while keeping the parametric frame.
- **IMVU Furniture Workflows:** Specific translation nodes for IMVU's strict furniture node requirements.

---

## 11. Architecture Decision Record (ADR)

**Decision:** We are building the Furniture Forge utilizing a **Hybrid Parametric-Kitbash Architecture**, deliberately rejecting monolithic Image-to-3D AI generation for interactive interior props.

**Why this architecture is superior:**
1. **Ergonomics & Interactivity:** A monolithic AI mesh of a chair doesn't know it's a chair; it has no semantic sit point and its scale is often random. The Parametric architecture guarantees that every chair generated perfectly matches human ergonomics and contains the exact metadata (sockets) required for an avatar to interact with it.
2. **Material Separation:** Furniture requires sharp material separation (e.g., polished wood frame vs. soft fabric cushion). AI models blend these materials at the edges. Kitbashing ensures clean geometric separation, allowing the Material Forge to apply perfect procedural textures.
3. **Performance:** A monolithic AI bookshelf generates thousands of polygons for a flat plane. A parametric kitbash bookshelf generates 6 simple boxes, maintaining AAA performance.
4. **Animation Readiness:** Parametric assembly allows a drawer to be generated as an independent, rigged object. This is impossible with monolithic AI blobs, making our architecture fundamentally superior for interactive game development.
