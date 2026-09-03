# Viper Studios Build Audit (Current State)

*Date: June 2026*

This document provides a comprehensive audit of the Viper Studios codebase, identifying what is built, what is scaffolded, and where the safest next steps lie before injecting heavy AI models.

## 1. Systems Confirmed Built (Production Ready Structure)
- **Helios Director & Task Orchestration**: Robust event-driven task routing across Forge zones.
- **ComputeJobManager**: Polling, queueing, and state management for asynchronous AI generation jobs.
- **ProviderManager & ProviderInterfaces**: Strict interface contracts allowing seamless swapping between Mock, Local, and Commercial endpoints.
- **Project Memory & Persistence**: Approved assets are securely written to local browser storage and survive reloads.
- **ImageAsset & MeshAsset Pipelines**: End-to-end data flow from UI trigger -> Agent -> Job Queue -> Review Gate -> Project Memory.
- **Review Gate UI**: Holographic dashboard capable of parsing prompts, topology, formats, and providers for user approval.
- **SafeMeshLoader & Mesh Ghost Preview**: Highly stable React Three Fiber pipeline. Safely traps 404s, corrupt GLBs, or mock requests and falls back to a translucent wireframe without crashing the viewport.
- **Real 3D Asset Storage Path**: Python FastAPI node is configured to scaffold `outputs/meshes`, `outputs/images`, and `outputs/metadata` directories and serve them statically.

## 2. Systems Partially Built
- **Local Compute Node Client/Server**: The Python server correctly accepts HTTP requests, tracks job IDs, and returns results. However, the actual generation logic is currently simulated via `time.sleep()`.
- **ComfyUI Adapter & Presets**: The ComfyUI client is built and workflow JSONs are extracted, but requires a live local ComfyUI instance to fully validate real image outputs.
- **Avatar Ghost Preview**: Basic primitive scattering exists in the Forge for Avatars, but lacks the sophisticated error boundary and dynamic diagnostic tags present in the Mesh Ghost Preview.

## 3. Systems That Are Only Mock/Scaffolded
- **Procedural Generation**: Returns mock JSON arrays instead of actual procedural blueprints.
- **Material Generation**: Returns placeholder maps (`mock://material`).
- **Real Open-Source 3D Generation**: Currently writes a mock JSON manifest and returns a 404 local URL to test the frontend fallback logic.

## 4. Systems Needing Strengthening
- **Resident Navigation & Behaviors**: Aria, Gaius, and Fluffy remain mostly stationary or rely on very basic waypoint scripts. They do not yet dynamically react to newly spawned assets in the Forge.
- **Procedural Props**: The current architecture layers are very basic and lack spatial awareness algorithms to prevent overlapping with generated meshes.

## 5. Systems Still Missing
- **Avatar Validation Pipeline**: No automated checks exist to ensure an Avatar asset meets rigging, topology, or material standards before entering the pipeline.
- **Valid Test GLB Generation**: The Python backend does not yet execute a script that actually creates a `.glb` (even a primitive one) to prove the pipeline without triggering a fallback.

## 6. Known Risks
- The frontend `SafeMeshLoader` spaces meshes out along the X-axis using a simple index offset. If a user spawns 50 meshes, they will clip through the hangar walls.

## 7. Broken or Suspicious Code Paths
- **None detected.** Frontend `npm run typecheck` passes flawlessly with zero errors. Python `main.py` passes `py_compile` syntax checks. 

## 8. Documentation Gaps
- The `local-compute-node/README.md` is updated, but lacks explicit instructions on how to hook up specific 3D providers (like TRELLIS) once they are installed.

## 9. Test Coverage Gaps
- **Zero automated unit tests.** We are relying entirely on strict TypeScript types, React Error Boundaries, and manual visual validation. Integration tests (Jest/PyTest) should be considered before a public beta.

## 10. Recommended Next Milestone
While **Valid Test GLB Generation** (using a simple Python script to write a valid `.glb` cube instead of a 404 URL) is the next logical step for the 3D pipeline, the **Avatar Validation Pipeline** is also an excellent candidate if we wish to pivot focus back to the Avatar Forge and harden its data structures.

Both are safe to build without relying on heavy paid models.
