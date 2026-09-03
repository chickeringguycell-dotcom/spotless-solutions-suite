# VIPER PHASE 3G ASSET INTAKE SERVICE REPORT

Date: 2026-06-14

Scope: lightweight Forge Asset Intake for SAFE_PRODUCT manual references. Metadata-only intake was built first. No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, protected assets, avatar/skin systems, MakeHuman, and MPFB were not moved or reactivated.

## Mission

Close the ownership gap for manual SAFE_PRODUCT references:

Manual SAFE_PRODUCT reference upload -> Asset Intake record -> Preview record -> Product Library card -> Review Queue item

## New Service

Created:

- `artifacts/api-server/src/lib/forge/assetIntakeService.ts`

The service supports metadata-only intake records for:

- vehicle references
- spacecraft part references
- weapon/tool references
- furniture/prop references
- building/environment references
- material/texture references
- clothing concept references

The service blocks obvious protected/avatar/skin/internal terms and only allows product-safe Forge workspaces:

- `VehicleForge`
- `WeaponForge`
- `FurnitureForge`
- `BuildingForge`
- `TextureMaterialForge`
- `ClothingForge`

## New APIs

Added:

- `GET /api/forge/assets/intake`
- `POST /api/forge/assets/intake`
- `GET /api/forge/assets/intake/:assetId`
- `PATCH /api/forge/assets/intake/:assetId`
- `POST /api/forge/assets/intake/:assetId/claim-product`

The first pass is intentionally metadata-only. Real file upload/storage is still deferred.

## Data Model

Asset Intake records include:

- asset id
- source type
- upload/reference type
- original filename
- local/mobile source note
- target workspace
- safe product category
- linked product id
- linked job id
- linked preview id
- source/license status
- review status
- title
- description
- reference URL or local URI note
- metadata
- created date
- updated date

Review statuses:

- pending
- approved
- needs_revision
- rejected
- archived

## Product Library Changes

Product Library cards now support:

- `intakeAssetIds`
- linked manual intake preview IDs
- metadata showing latest asset intake id
- source/license status from Asset Intake
- source notes from manual references

Generated output history remains separate as `generationHistory`.

## Preview Flow

When an intake record is created, Forge creates or links a Preview Service record.

For real web/data URLs, the preview may be a `preview_image`.

For local mobile URIs, the preview is treated as metadata/proxy ownership. This avoids pretending that a local phone file has already been uploaded into permanent Forge storage.

## Product Claim Flow

The claim-product endpoint can:

- create a new Product Library card
- update an existing Product Library card
- attach the intake asset id
- attach the preview id
- update preview metadata with product ownership
- attach product/preview to a linked job when a job id exists

## Mobile Changes

Updated:

- `artifacts/viper-studio/lib/forgeJobs.ts`
- `artifacts/viper-studio/app/(legacy)/devstudio.tsx`

Mobile now has helpers for:

- creating Asset Intake metadata records
- claiming Asset Intake records into Product Library cards

Dev Lab now bridges SAFE_PRODUCT manual references:

- manual photo import
- camera capture

CreatorHub now bridges SAFE_PRODUCT manual references:

- vehicle map uploads
- non-avatar clothing map uploads
- prop/furniture map uploads
- environment/building map uploads

Local compatibility remains first:

- Dev Lab AsyncStorage records remain.
- CreatorHub local map state remains.
- If Forge metadata intake fails, local mobile behavior still works.

Mobile stores returned Forge IDs where available:

- `forgeAssetIntakeId`
- `forgeAssetIntakeIds`
- `forgePreviewIds`
- `forgeProductId`

## Website UI Changes

Updated:

- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`

Forge dashboard now shows:

- Asset Intake status panel
- Asset Intake dashboard panel
- pending asset count
- category
- workspace
- linked product state
- source/license status
- approve action
- needs revision action
- archive action

Product Library cards now show manual intake count.

## Review Queue Changes

Review Queue now includes:

- generation requests
- previews
- products
- export readiness checks
- asset intake records

Asset Intake queue items show:

- source type
- source/license status
- product-link state
- workspace
- review status

Rejected Asset Intake records map to archived in the general Review Queue state model.

## What Stayed Local

Still local / deferred:

- actual binary file upload
- permanent asset storage
- upload scanning
- file deduplication
- asset library browsing
- mesh or texture processing
- ThreeViewer preview
- full 3D render preview

The current service records ownership metadata and links to previews/products without creating a full Asset Library.

## What Stayed Untouched

Not touched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- ViperCreatorShell
- DressingRoom
- protected Aria assets
- protected Gaius assets
- avatar generation
- skin generation
- body/face/hair/makeup generation
- MakeHuman
- MPFB
- Export Forge
- Spacecraft Forge
- Animation Forge

## Validation

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- Existing mobile tests
- API build
- Forge dashboard browser smoke check

Mobile tests:

- 60 tests passed

Node warning observed:

- Existing module type warning for mobile test files. No new failure.

## Smoke Test Results

Forge Asset Intake smoke test passed.

Created:

- Asset Intake record: `asset-00994476`
- Preview record: `preview-8220c65e`
- Product Library card: `product-16797f79`

Confirmed:

- preview linked to intake
- product stores intake asset id
- Review Queue includes asset intake item
- asset review status updated to approved
- protected/avatar intake attempt was blocked

Blocked protected test message:

`safeProductCategory must be a SAFE_PRODUCT category.`

## Risks

- Metadata-only intake does not prove that a referenced file is permanently available.
- Local mobile URI previews are not real uploaded assets yet.
- Source/license status is user/system declared, not verified by an automated scanner.
- CreatorHub remains a mixed legacy file, so future work must continue to avoid avatar/protected paths.
- Asset Intake is not a full Asset Library and should not be treated as one yet.

## Recommended Phase 3H Next Step

Build the real Forge upload/storage layer:

1. Add binary upload support for SAFE_PRODUCT references.
2. Store uploaded files in a controlled Forge asset storage area.
3. Add source/license confirmation metadata.
4. Add file size/type validation.
5. Add upload scanning hooks.
6. Upgrade Preview records from metadata-only proxy records to durable preview records when a file is actually stored.

Success condition for Phase 3H:

Manual SAFE_PRODUCT references become durable Forge-owned assets, not just metadata-owned references.
