# Viper Phase 3C App-To-Forge Migration Report

Date: 2026-06-14

Scope: Phase 3C implementation. Began moving duplicated mobile generation and review behavior into Website/Forge services. No legacy screens were deleted, Workshop/ThreeViewer/Viewer/Shipyard/IMVU Creator were not removed, protected assets were not moved, and no new heavy mobile dependencies were added.

## Executive Result

Phase 3C completed the first real app-to-Forge migration slice:

- Foundry, Worldforge, and Wardrobe no longer hand-build their own direct generation request logic.
- Those legacy mobile panels now call one shared Forge generation-preview bridge.
- Generated outputs still display in the old mobile UI, but they also create Forge generation request and preview records through the shared service path.
- Mobile Home approve/revision actions now use the Forge Job Review service instead of only changing the job state.

This keeps mobile functional while shifting ownership of generation metadata, preview records, and review actions toward Website/Forge.

## What Was Moved Off Mobile

### Duplicated generation request construction

Moved out of individual legacy panels:

- repeated `/api/imagine` fetch setup
- repeated auth/header construction
- repeated prompt-result parsing
- per-screen generation metadata decisions

New shared mobile bridge:

- `artifacts/viper-studio/lib/forgeJobs.ts`
  - `requestForgeGenerationPreview()`

The helper sends normal image generation requests to `/api/imagine`, but includes Forge metadata so the server creates:

- Forge generation request
- Forge preview record
- job/product links when IDs are available
- mobile requester metadata

### Mobile job review actions

Mobile Home now uses:

- `applyMobileForgeJobReviewAction()`

Instead of directly calling the general job state update for approve/revision buttons.

This routes mobile review decisions through the same Job Review service Website/Forge uses.

## What Was Bridged To Website/Forge

### Foundry

File:

- `artifacts/viper-studio/app/(legacy)/foundry.tsx`

Now uses:

- `requestForgeGenerationPreview()`

Forge routing:

- Weapons/Tools -> `WeaponForge`
- Engines -> `VehicleForge`
- Other component/prop concepts -> `FurnitureForge`

Output:

- mobile still shows the generated component image
- Forge receives a generation request
- Forge receives a component preview record

### Worldforge

File:

- `artifacts/viper-studio/app/(legacy)/worldforge.tsx`

Now uses:

- `requestForgeGenerationPreview()`

Forge routing:

- `WorldForge`

Output:

- mobile still shows the generated environment image
- Forge receives a generation request
- Forge receives an environment preview record

### Wardrobe

File:

- `artifacts/viper-studio/app/(legacy)/wardrobe.tsx`

Now uses:

- `requestForgeGenerationPreview()`

Forge routing:

- `ClothingForge`

Guardrail:

- prompt wording was kept to clothing/outfit concepts on a simple reference mannequin
- no skin texture generation
- no new avatar base generation
- no MakeHuman/MPFB path

Output:

- mobile still shows the generated clothing concept
- Forge receives a generation request
- Forge receives a clothing preview record

### `/api/imagine` Forge metadata

File:

- `artifacts/api-server/src/routes/imagine.ts`

Updated to accept:

- `forge.requestedBy`

Default:

- mobile bridged requests are marked as `requestedBy: "mobile"`

Existing `/api/imagine` behavior is preserved for callers that do not pass Forge metadata.

## What Still Remains Mobile-Heavy

These remain intentionally untouched in Phase 3C:

- `artifacts/viper-studio/app/(legacy)/workshop.tsx`
  - texture generation still uses direct `/api/imagine`
  - build requirements still call `/api/build-requirements`
  - includes avatar/skin-adjacent texture paths, so it was not migrated in this pass
- `artifacts/viper-studio/app/(legacy)/devstudio.tsx`
  - still has direct generation logic
  - includes avatar texture slot paths and product map tooling
  - should be split carefully before migration
- `artifacts/viper-studio/app/(tabs)/chat.tsx`
  - chat craft-image generation still calls `/api/imagine`
  - should become a Forge preview request once the chat-to-job context is clearer
- `artifacts/viper-studio/app/(tabs)/settings.tsx`
  - avatar image generation remains direct
  - should remain untouched until avatar/public-scope rules are reviewed
- `artifacts/viper-studio/lib/gameProfiles.ts`
  - game profile rule text still lives on mobile
- `artifacts/viper-studio/contexts/AppContext.tsx`
  - still injects local game profile blocks into chat prompts

## Build Requirements And Target Profile Findings

Current build requirements are already server-backed:

- `artifacts/api-server/src/routes/build-requirements.ts`
- mobile Workshop calls `/api/build-requirements`

However, the broader target/game profile rule engine is still mobile-shaped:

- `GAME_PROFILES` lives in mobile code
- AppContext appends profile blocks into prompts locally
- Settings displays and switches profiles locally

Recommended next service:

- Forge Target Profile / Export Readiness service

Mobile should eventually show:

- selected target summary
- warnings
- readiness status

Website/Forge should own:

- target profile rules
- export readiness checks
- package/build constraints

## What Stayed Untouched

No deletion or removal was performed.

Untouched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- protected Aria assets
- protected Gaius assets
- existing API routes
- legacy route access
- ThreeViewer internals
- `three-scripts.ts`
- MakeHuman/MPFB remains out of active scope
- public avatar generation remains out of active scope
- skin generation remains out of active scope

## New APIs Or Clients Used

Existing API used:

- `POST /api/imagine`
  - now accepts optional Forge `requestedBy` metadata
  - still preserves existing non-Forge image response behavior

Existing Forge APIs/services used by mobile:

- Generation Service
- Preview Service
- Job Review Service
- Product Library Service

New mobile client helper:

- `requestForgeGenerationPreview()`

Existing mobile client helper now used by Home:

- `applyMobileForgeJobReviewAction()`

## Test Results

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- Existing mobile tests: 60 passed, 0 failed
- Forge workflow smoke test with temporary storage

Smoke test proved:

1. Create Forge job.
2. Create mobile-requested generation request.
3. Complete generation request.
4. Create preview record.
5. Link preview to generation request.
6. Link preview to job.
7. Create product card linked to preview/job.
8. Attach product through Job Review service.
9. Approve result through Job Review service.
10. Request product revision through Product Library service.
11. Duplicate product for revision.
12. Confirm job review actions and product history exist.

Smoke result:

`PHASE3C_FORGE_WORKFLOW_SMOKE_OK`

## Risks

- Native Android bundle size is unchanged by this service migration; Phase 2D already showed the native bundle remains eager.
- Foundry/Worldforge/Wardrobe still keep local AsyncStorage draft records so the old screens remain operational.
- The smoke test used a fake preview URL and service-layer records; it did not call the real image-generation provider.
- `WorldForge`, `WeaponForge`, and `ClothingForge` are still placeholder/deferred workspaces, so this is a metadata/preview bridge only, not full workspace implementation.
- DevStudio and Workshop contain avatar/skin-adjacent generation paths and need careful separation before migration.

## Recommended Phase 3D Next Step

Continue migration in small slices:

1. Split DevStudio generation into non-avatar product paths and protected/avatar paths.
2. Move only non-avatar DevStudio product generation to `requestForgeGenerationPreview()`.
3. Add a Forge Target Profile / Export Readiness service.
4. Move mobile `GAME_PROFILES` prompt-block ownership to that service.
5. Bridge Chat craft-image output into Forge previews when a job/workspace context exists.

Do not migrate Workshop avatar/skin texture generation until the public-avatar and skin-generation retirement rules are rechecked.
