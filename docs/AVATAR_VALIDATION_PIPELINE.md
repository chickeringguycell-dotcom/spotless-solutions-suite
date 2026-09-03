# Known Good Avatar Validation Pipeline

This document outlines the hardened, proven, end-to-end pipeline for validating generated `AvatarAssets` before they are safely allowed to load in the 3D Forge.

## The 6-Step Validation Flow

1. **Trigger**: An agent (or human) triggers an Avatar Generation task.
2. **Compute Execution**: The Provider Manager routes this to the Local Compute Node.
3. **Rigorous Validation (Backend)**: The backend returns a highly structured `AvatarAsset` schema containing:
   - `heightMeters`
   - `rigProfile` (e.g., `vrm`, `mixamo`)
   - `topology` (poly count, watertight checks)
   - `skeletonReady` (true/false)
   - `blendshapesReady` (true/false)
   - `validationStatus` (`pass`, `warning`, `fail`)
   - `issues` (an array of explicit string errors)
4. **Holographic Dashboard Inspection**: The avatar enters the Review Gate. The UI parses the schema and renders a **Gaius Technical Inspection** block.
   - If `validationStatus` is a warning or fail, the asset name is automatically forcefully prefixed with `[PROTOTYPE]`.
5. **Memory Persistence**: If approved, it is stored in Project Memory with its validation constraints intact.
6. **Ghost Rendering & Warnings**: The `AvatarGhostPreview` loads the validation data in the 3D Forge. 
   - Instead of silently failing, it displays a hovering HTML tag above the avatar.
   - The tag explicitly highlights `⚠ ARKit Blendshapes` or `✗ Topology is not watertight`.
   - The entire ghost wireframe changes color based on severity (Green for Pass, Orange for Warning, Red for Critical Failure).

## Manual QA Checklist

To verify this pipeline works locally and enforces safe loading protocols:

- [ ] Ensure the Python Local Compute Node is running (`uvicorn main:app --reload`).
- [ ] Open the Holographic Dashboard and submit: `/goal generate an avatar of Aria`
- [ ] Wait for the compute job to finish and appear in the Review Queue.
- [ ] Look at the Gaius Technical Inspection card. It should explicitly warn about "Missing ARKit blendshapes".
- [ ] Verify the backend JSON output correctly notes `is_test_mock_copy: true`.
- [ ] Click Approve and reload the page. Verify the Avatar and its validation state persist.
- [ ] Open the Avatar Forge tab.
- [ ] Verify a physical `.glb` avatar loads safely (or glowing Orange ghost if it fails inspection).
- [ ] Verify the floating tag reads "INSPECTION: WARNING" and lists the topology and blendshape issues.
- [ ] Test Ghost Fallback: Inject an invalid URL (e.g., `mock://missing`) and verify it gracefully falls back to the translucent ghost with "Mock or Missing URL".
- [ ] Test VRM Fallback: Inject a `.vrm` URL and verify it falls back to the ghost with "VRM explicitly fallback-only until dedicated loader built."
- [ ] Test Unsafe URL Rejection: Inject an external URL (`https://example.com/avatar.glb`) and verify the `SafeAvatarLoader` actively blocks it and displays "Unsafe external URL blocked".
- [ ] Verify in the Project Asset list that the name is prefixed with `[PROTOTYPE]`.

## What remains before real VRM/GLB loading?
The validation architecture and safe URL loading protections are mathematically locked in. We can now safely introduce a real VRM loader into `SafeAvatarLoader`, wrapped in these exact same `ErrorBoundary` protections. When a real VRM drops from a future node (like a local LLM-rigging agent), it will run through this exact same Gauntlet.
