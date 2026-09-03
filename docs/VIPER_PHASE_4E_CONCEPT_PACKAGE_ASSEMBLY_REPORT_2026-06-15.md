# VIPER PHASE 4E CONCEPT PACKAGE ASSEMBLY REPORT

Date: 2026-06-15

Status: implemented and validated.

Copy button note: this report is intended to appear as the newest report on the Website/Forge Reports page, directly under the top `COPY LATEST REPORT` button.

## Mission

Build a lightweight Concept Package Assembly pass for VehicleForge and SpacecraftForge.

This phase prepares concept work for later structured parts, proxy previews, and future export planning.

No heavy editors were built.
No mesh generation was built.
No texture baking was built.
No Export Forge was built.
No Shipyard integration was built.
No heavy viewers were added.
No legacy systems were deleted.
No protected assets were moved.

## Source Of Truth

Used:

- `VIPER_PHASE_4D_WORKSPACE_ASSET_INTEGRATION_REPORT_2026-06-15.md`
- `VIPER_PHASE_4C_CONCEPT_REFINEMENT_LOOPS_REPORT_2026-06-14.md`
- `VIPER_VEHICLE_AND_SPACECRAFT_FORGE_MASTER_PLAN_2026-06-14.md`

## Summary

VehicleForge and SpacecraftForge can now assemble lightweight concept packages:

```text
Product Library Card
  -> Selected Preview
  -> Linked Reusable Assets
  -> Revision / Generation History
  -> Target Profile
  -> Export Readiness Check
  -> Aria Creative Summary
  -> Gaius Practical Warnings
  -> Review Queue
```

This is not an export package. It is a Forge-owned review package for concept approval and future construction planning.

## New Model

Added `ForgeConceptPackage`.

Fields:

- `id`
- `workspaceId`
- `productId`
- `jobId`
- `selectedPreviewId`
- `linkedReusableAssetIds`
- `revisionRequestIds`
- `generationRequestIds`
- `targetProfileId`
- `readinessCheckId`
- `ariaCreativeSummary`
- `gaiusPracticalWarnings`
- `packageStatus`
- `createdAt`
- `updatedAt`

Statuses:

- `draft`
- `assembled`
- `needs_revision`
- `approved`
- `archived`

Storage:

- `data/forge/concept-packages.json`

## New APIs

Added:

- `GET /api/forge/concept-packages`
- `POST /api/forge/concept-packages`
- `GET /api/forge/concept-packages/:conceptPackageId`
- `POST /api/forge/concept-packages/:conceptPackageId/actions`

Package actions support:

- `approve`
- `approve_package`
- `request_revision`
- `archive`
- `archive_package`
- `assemble`
- `reopen`

Updated:

- `GET /api/forge/summary`
- `GET /api/forge/review-queue`

## Package Assembly Behavior

The assembly service validates:

- Product exists.
- Product belongs to VehicleForge or SpacecraftForge.
- At least one preview exists.
- Selected preview exists and belongs to the selected product.
- Target profile exists.
- Readiness check exists or can be created.
- Linked reusable assets are valid when present.
- Linked reusable assets are approved reusable material.
- Linked reusable assets are compatible with the workspace.

The service does not require `ready_for_export`.

If no readiness check exists, the service creates one using the selected product, job, preview, target profile, and metadata.

The package status becomes:

- `assembled` when concept review can continue.
- `needs_revision` when the product is already marked needs revision, readiness is blocked/not ready, or reusable asset lane violations exist.

Package actions can later approve, request revision, reopen, or archive the package.

## Vehicle Package Content

VehicleForge packages summarize:

- vehicle class
- vehicle role
- mobility type
- propulsion type
- passenger/operator count
- cargo notes
- mount notes
- material notes
- scale summary
- selected preview
- linked reusable assets
- readiness warnings

The package is metadata and review state only. It does not create meshes, exports, heavy previews, or editor state.

## Spacecraft Package Content

SpacecraftForge packages summarize:

- spacecraft class
- spacecraft role
- hull notes
- cockpit notes
- engine notes
- landing gear notes
- weapon mount notes
- docking notes
- room/module notes
- material notes
- scale summary
- selected preview
- linked reusable assets
- readiness warnings

Starfield target support remains readiness/planning only. No Starfield export package is generated.

## Aria Summary Behavior

Aria package summaries are generated from existing product, preview, reusable asset, material, and scale data.

Aria focuses on:

- creative concept direction
- selected preview context
- style/material identity
- linked reusable asset cues
- suggested next creative step

Aria does not validate export readiness or source rights.

## Gaius Warning Behavior

Gaius practical warnings are generated from:

- Export Readiness warnings
- missing requirements
- export blocked state
- product revision state
- linked reusable asset lanes
- source-rights status

Gaius focuses on:

- missing metadata
- lane/source-rights warnings
- practical next action
- reminder that the package is not an export package

Gaius does not rewrite creative intent.

## Website UI Changes

Added a Concept Package panel to:

- VehicleForge
- SpacecraftForge

The panel shows:

- package status
- selected product
- selected preview
- linked reusable asset count
- revision count
- target profile
- readiness status
- Aria package summary
- Gaius package warnings

Actions:

- Assemble Package
- Approve
- Request Revision
- Archive

Added a Package Contents panel showing:

- package id
- package status
- selected preview
- readiness check
- linked asset count
- linked reusable asset lane/source-rights summaries

## Review Queue Changes

Review Queue now includes concept packages as item type:

- `concept_package`

Review Queue surfaces:

- assembled packages as pending review
- packages needing revision
- approved packages
- archived packages

Reasons include:

- package status
- selected preview
- linked reusable asset count
- revision request count
- generation request count
- readiness check id
- first Gaius warnings

## Product Library Update

Product Library metadata capacity was widened so products can safely retain:

- upload/source fields
- reusable asset relationship fields
- package fields
- readiness fields
- revision fields

This was required because Phase 4D/4E products can now carry multiple service links at once.

## Mobile Impact

Mobile remains lightweight.

Mobile may display:

- package status
- package summary
- readiness warning count

Mobile does not gain:

- package editing
- heavy previews
- mesh generation
- texture baking
- Export Forge
- Shipyard integration
- large Asset Library browsing

Package assembly is Website/Forge owned.

## New And Updated Files

New:

- `artifacts/api-server/src/lib/forge/conceptPackageService.ts`
- `docs/VIPER_PHASE_4E_CONCEPT_PACKAGE_ASSEMBLY_REPORT_2026-06-15.md`

Updated:

- `artifacts/api-server/src/lib/forge/types.ts`
- `artifacts/api-server/src/lib/forgeStore.ts`
- `artifacts/api-server/src/routes/forge.ts`
- `artifacts/api-server/src/lib/forge/reviewQueueService.ts`
- `artifacts/api-server/src/lib/forge/productLibrary.ts`
- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`
- `artifacts/landing-page/src/index.css`

## Validation

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- API build
- API server health check
- Existing mobile tests
- Forge smoke test
- VehicleForge browser check
- SpacecraftForge browser check

Mobile test result:

- 60 tests passed

Browser check result:

- VehicleForge shell opens.
- SpacecraftForge shell opens.
- Concept Package panel appears.
- Package Contents panel appears.
- Assemble Package action appears.
- Aria package summary appears.
- Gaius package warnings appear.
- Spacecraft internal-only lane remains visible.
- No browser console errors were observed during workspace checks.

Smoke test proved:

1. VehicleForge concept product exists.
2. SpacecraftForge concept product exists.
3. Linked reusable assets exist.
4. Concept package assembles for VehicleForge.
5. Concept package assembles for SpacecraftForge.
6. Package includes selected preview.
7. Package includes linked reusable assets.
8. Package includes Aria summary.
9. Package includes Gaius warnings.
10. Review Queue shows packages.
11. Mobile responsibilities remained lightweight.

Smoke IDs:

- Vehicle product: `product-0080e1c5`
- Spacecraft product: `product-1a574d58`
- Vehicle upload: `upload-2e84d5d1`
- Spacecraft upload: `upload-df05e103`
- Vehicle concept package: `concept-package-197963bb`
- Spacecraft concept package: `concept-package-7a305faa`

Smoke package states:

- Vehicle package: `approved`
- Spacecraft package: `needs_revision`

## Risks

- Concept package relationship data depends on product metadata and service links staying synchronized.
- Revision request ids are inferred from current product history where explicit package revision links do not yet exist.
- Aria and Gaius summaries are deterministic summaries from existing data, not model-generated guidance.
- Internal-only assets must continue to remain clearly marked and separated from public-safe product flows.
- Future structured part records should avoid overloading product metadata further.

## What Stayed Untouched

Untouched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- protected Aria assets
- protected Gaius assets
- protected wardrobe assets
- MakeHuman
- MPFB
- Export Forge
- mesh generation
- texture baking
- heavy mobile viewers

## Recommended Phase 4F Next Step

Build a lightweight Structured Part Planning pass.

Phase 4F should let VehicleForge and SpacecraftForge derive planned part records from an approved concept package:

- VehicleForge: chassis, body, cabin, mobility system, cargo/tools/mounts, material set.
- SpacecraftForge: hull, cockpit, engines, landing gear, weapon mounts, modules/rooms, material set.

These should be planning records only.

Do not build mesh generation, heavy viewers, Shipyard integration, Export Forge, or target package exports yet.

## Success Condition

Success condition met.

VehicleForge and SpacecraftForge can assemble lightweight concept packages from products, previews, reusable assets, revisions, target profiles, readiness checks, and guide summaries without becoming heavy editors or export systems.
