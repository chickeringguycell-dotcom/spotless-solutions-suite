# Viper Studios Master Roadmap (Current Status)

*Date: June 2026*

This document serves as the **single authoritative source of truth** for the current state, architecture, and strategic direction of Viper Studios. It consolidates the Build Audit, Known-Good Pipelines, Avatar Validation, Provider Roadmap, and QA Matrix into one cohesive continuation point.

---

## 1. Core Vision & Architectural Non-Negotiables
- **Headquarters is permanent:** The primary UI is the 3D Headquarters (Holographic Dashboard, Bay 05). 
- **Forges are activated invisibly:** You do not 'visit' a Forge. The Forge environment is rendered as the backdrop while the Holographic Dashboard manages tasks.
- **Bay 05 is diagnostics only:** Bay 05 houses the 3D diagnostic overlays (like Helios Provider Selection holograms), not core asset creation.
- **Build our own first:** We prefer self-built, fully owned technology.
- **Use open source second:** High-quality open-source models (like SAM 3D, TRELLIS) are our secondary choice.
- **Paid providers are not the strategy:** We do not install paid APIs, commercial avatar services, or heavy commercial endpoints.

---

## 2. Current Project Status & Testing
**Status:** Architecture is stable. Core memory, routing, and UI fallbacks are hardened. We are now staging open-source AI integrations.
- **Valid Test GLB Generation:** Completed in commit `9b2172e`
- **Image-to-3D Production Hardening:** Completed in commit `f2ad8f9`
- **Safe GLB Loading & Fallback:** Completed
- **Real AI Model Integration:** Still not started

**Testing:** 
- `npm run typecheck` passes flawlessly.
- Provider QA Matrix: 10/10 automated tests passing for Helios NLP routing.
- Python Node passes `py_compile`.
- No Jest/PyTest integration tests exist yet.

### Relevant Commits:
* `0696a72`, `9b2172e`, `f2ad8f9`, `8003392`, `267fdd8`, `7217e1e`, `7d3b5c2`, `06c6565`

---

## 3. Systems Confirmed Built & Hardened
*Systems that are structurally complete, tested, and actively protecting the application.*

- **Helios Task Orchestration (`7d3b5c2`)**: Analyzes NLP intent and correctly routes Image, Image-to-3D, Avatar, and Procedural tasks.
- **SafeMeshLoader & Ghost Previews**: Captures 404s, corrupt GLBs, or unsafe external URLs safely. Renders a translucent wireframe instead of crashing the WebGL context.
- **Review Gate UI**: Asset approval mechanism with Holographic Dashboard.
- **Project Memory (IndexedDB)**: Asset persistence across reloads.
- **Bay 05 Provider Diagnostics (`7d3b5c2`)**: 3D holographic panel visually projecting Helios's target/fallback provider decisions.

---

## 4. Known-Good Pipelines
*End-to-end workflows that are successfully bridged from UI to Backend.*

### Image-to-3D Pipeline (Mock Backend)
1. User requests 3D from Image.
2. Helios routes to `trellis_3d` or `sam_3d`.
3. Backend processes request, copies a valid test `.glb` to `outputs/meshes/`.
4. Mesh enters Review Gate for user approval.
5. `SafeMeshLoader` renders physical mesh in Forge upon approval.

### Avatar Validation Pipeline
1. Backend returns `AvatarAsset` schema with `validationStatus` (pass/warning/fail).
2. Review Gate displays **Gaius Technical Inspection** block.
3. Assets failing checks get forceful `[PROTOTYPE]` prefixing.
4. Ghost rendering displays hovering HTML tags highlighting specific topology/rigging faults (e.g., missing ARKit blendshapes).

---

## 5. Systems Scaffolded & Mock-Only
*Systems with complete interfaces but simulated logic.*

- **Local Compute Node Client/Server**: Python server accepts requests, tracks job IDs, but uses `time.sleep()` instead of real inference.
- **ComfyUI Adapter**: Extracts JSON workflows but lacks a live local instance.
- **Procedural Generation**: Returns mock JSON blueprints.
- **Material Generation**: Returns placeholder maps.
- **Real Open-Source 3D Generation**: Returns mock JSON manifests and 404 fallback URLs.

---

## 6. Provider Selection Rules & QA Matrix (`06c6565`)
Helios utilizes a strict capability-based scoring registry (`ProviderSelector.ts`) to route intents to the correct models without hardcoding.

**Current Routing Matrix (100% Passing):**
- `"Colonial Viper concept image"` ➡️ **Image** ➡️ `local_comfyui`
- `"Turn this approved vehicle image into a 3D model"` ➡️ **Image-to-3D** ➡️ `trellis_3d`
- `"Build an avatar from this body reference"` ➡️ **Avatar** ➡️ `sam_3d`
- `"Reconstruct a human body mesh"` ➡️ **Avatar** ➡️ `sam_3d`
- `"Create a chair prop from this image"` ➡️ **Image-to-3D** ➡️ `trellis_3d`
- `"Generate a material texture for brushed steel"` ➡️ **Image** ➡️ `local_comfyui`
- `"Parse this scene into separate objects"` ➡️ **Image-to-3D** ➡️ `sam_3d`
- `"Make a VRM-ready character"` ➡️ **Avatar** ➡️ `open_avatar`

---

## 7. Open-Source Provider Direction & SAM 3D Positioning
- **Primary Image:** Local ComfyUI (SDXL/Flux)
- **Primary Object/Prop 3D:** TRELLIS (Fast, general object extraction)
- **Primary Avatar:** OpenAvatar (Pending replacement)

**SAM 3D (Meta) Strategy:**
SAM 3D is uniquely positioned as a **specialized, optional provider** selected dynamically by Helios.
- **Why SAM 3D?** It excels at "in-the-wild" depth/volume prediction, scene segmentation, and specifically **human body/pose reconstruction** (SAM 3D Body).
- **Positioning:** It will not replace TRELLIS for basic props. It will act as the primary engine for **Avatar Body Reconstruction** and complex **Scene Parsing/Segmentation** before handing objects to TRELLIS.
- **Status:** **Scaffolded**. Interface contracts exist. We are awaiting a final license audit before downloading the real heavy PyTorch weights.

---

## 8. Known Risks & What Not To Do
- **Risk (Mesh Spacing):** `SafeMeshLoader` spaces meshes on the X-axis by simple index. Large quantities will clip through hangar walls.
- **Risk (Memory):** Loading too many high-poly mock GLBs may crash the browser tab.
- **What Not To Do:** Do NOT install paid providers. Do NOT wire up heavy DiT dependencies until the Python Local Compute Node is fully verified with a lightweight static GLB output. Do NOT bypass the Review Gate for automatic injection.

---

## 9. Next Recommended Milestones

**Option A: Vertical Slice Demonstration (CURRENT FOCUS)**
- Automate a complete 10-step End-to-End demonstration workflow where Helios decomposes a request, generates a mock image, passes the review gate, generates a mock 3D mesh, passes the review gate again, renders the physical asset in the Forge, and correctly saves/loads from the Server-backed persistence layer. Prove the entire studio works before installing heavy AI weights.

**Option B: Known-Good Avatar Pipeline Hardening (COMPLETED)**
- Successfully implemented strict URL validation and VRM fallback explicitly. (Completed in `ba8a6d1`).

**Option C: Server-backed Project Storage (COMPLETED)**
- Successfully migrated local IndexedDB Project Memory to the `api-server` via `ServerStorageAdapter` with aggressive LocalStorage fallback. (Completed in `fe6ad67`).

**Option C: Local Compute Node Job Persistence**
- Upgrade the ComputeJobManager on the Python backend to use a real task queue (like Celery or a SQLite-backed queue) so that asynchronous 3D generation jobs can survive server restarts and scale reliably when real AI models are introduced.

**Option D: Real Open-Source Provider Install Planning**
- Audit licenses, hardware requirements, and Python environments for our primary open-source targets (TRELLIS, SAM 3D, ComfyUI) to prepare the Local Compute Node for its first heavy model download.

---

## 10. Architectural Principles: The Headquarters and the Forges

This is a permanent architectural principle for Viper Studios.

The Headquarters is the application. The Forges are not separate applications, pages, or products.
Every Forge is a physical location inside the Headquarters.

Examples include:
* Avatar Forge (Avatar Lab)
* Vehicle Forge
* Building Forge
* Creature Forge
* Animation Forge
* Weapons Forge
* Clothing Forge
* Furniture Forge
* Material Forge
* Texture Forge
* Audio Forge
* World Forge
* Community Showcase

Users never "launch" a Forge. Users simply ask Aria or Gaius what they want to build.
Helios silently activates the appropriate Forge and the required tools appear naturally within the Headquarters.

The Headquarters itself never unloads. Aria, Gaius, Fluffy, lighting, navigation, living quarters, Bay 05, and all permanent Headquarters systems continue to exist regardless of which Forge is active.
Changing Forges is equivalent to walking from one room of the Headquarters to another, not opening a different application.
No future implementation should treat a Forge as a separate startup destination or independent application. This rule is permanent and ensures every AI agent preserves this design philosophy.

---

## 11. Architectural Principles: The Creator Never Manages the Pipeline

This is a permanent architectural principle of Viper Studios.

The creator should never have to decide which AI model, provider, Forge, workflow, or pipeline to use.

The creator only describes what they want to build.

Examples:
* "Create Aria from these reference photos."
* "Build a Colonial Viper."
* "Design a medieval tavern."
* "Create a futuristic rifle."
* "Generate footsteps for this creature."

Helios is solely responsible for:
* Understanding the creator's intent.
* Selecting the appropriate Forge.
* Selecting the appropriate provider.
* Selecting the appropriate workflow.
* Dispatching Compute Jobs.
* Managing GPU resources.
* Routing assets through the Review Gate.
* Storing approved assets in Project Memory.

The creator should feel as though they are collaborating with Aria and Gaius, not operating software.
The complexity of the pipeline must remain invisible.
The experience should feel natural, conversational, and effortless.

This principle is permanent and must be preserved by every future AI agent working on Viper Studios.
