# Known Good Image-to-3D Pipeline

This document outlines the hardened, proven, end-to-end pipeline for converting an approved `ImageAsset` into a physically loaded `MeshAsset` in the Forge Environment.

## The 10-Step Pipeline

1. **Trigger**: The user clicks "Generate 3D Model" on an approved Image Asset in the Holographic Dashboard.
2. **Orchestration**: The `HolographicDashboard` dispatches a `JOB_SUBMITTED` action.
3. **Agent Routing**: The `ImageTo3DAgent` intercepts this action, normalizes the payload, and forwards it to the `ProviderManager`.
4. **Provider Abstraction**: The `ProviderManager` routes the request to the `Local Compute Node` (currently using the `image-to-3d` mock adapter).
5. **Compute Execution**: The Python FastAPI backend (`main.py`) processes the job. It copies a known-good test `.glb` into `outputs/meshes/` and writes a detailed JSON manifest to `outputs/metadata/`.
6. **Return Payload**: The Python node returns a `meshUrl` pointing statically to `http://localhost:8000/outputs/meshes/<assetId>.glb`.
7. **Asset Creation**: The frontend creates a pending `MeshAsset` in Project Memory containing the `meshUrl` and linking back to the `sourceImageAssetId`.
8. **Review Gate**: The mesh enters the Review Gate. The user inspects the topology metadata and approves it.
9. **Memory Persistence**: The mesh transitions to `approved` in Project Memory (IndexedDB).
10. **Safe Rendering**: `ForgeEnvironment3D` maps the approved mesh to a `SafeMeshLoader`. The loader securely fetches the local URL, parses the `.glb`, extracts mesh counts, and dynamically updates the floating diagnostic tag to **LOADED (REAL)**.

## Hardened Safety Measures

- **URL Validation**: The frontend strictly checks that the `meshUrl` begins with `http://localhost:8000/outputs/meshes/` or `mock://`. Any other external URL is aggressively blocked and triggers the ghost fallback.
- **Error Boundaries**: If the `.glb` file is 404, corrupt, or causes an out-of-memory exception in Three.js, a React `ErrorBoundary` and `Suspense` block catch the failure and instantly render a translucent Ghost Preview wireframe instead.
- **Diagnostic Transparency**: The Floating HTML tag explicitly lists the `fallbackReason` (e.g., "Unsupported format", "Unsafe external URL blocked", "Mock or Missing URL").

## Manual QA Checklist

To verify this pipeline works locally:

- [ ] Ensure the Python Local Compute Node is running (`uvicorn main:app --reload`).
- [ ] Approve any generated image in the Holographic Dashboard.
- [ ] Click "Generate 3D Model" on the approved image.
- [ ] Wait for the compute job to finish.
- [ ] Observe the new 3D Model appear in the Review Queue.
- [ ] Approve the 3D Model.
- [ ] Verify a physical 3D mesh (not a wireframe) appears in the Forge.
- [ ] Verify the floating diagnostic tag turns bright green and reads **LOADED (REAL)**.
- [ ] Look at the terminal running the Python node to verify it received the `image-to-3d` payload.
