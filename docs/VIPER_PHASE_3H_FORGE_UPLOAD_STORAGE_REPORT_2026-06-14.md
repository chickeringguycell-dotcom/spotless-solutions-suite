# VIPER PHASE 3H FORGE UPLOAD STORAGE REPORT

Date: 2026-06-14

Scope: durable Forge upload/storage layer for SAFE_PRODUCT manual reference images. No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, protected assets, avatar/skin systems, MakeHuman, and MPFB were not moved or reactivated.

## Mission

Upgrade Phase 3G Asset Intake from metadata-only ownership to durable Forge-owned uploaded assets:

SAFE_PRODUCT image upload -> Forge controlled storage -> Asset Intake record -> Preview record -> Product Library card -> Review Queue item

## New Service

Created:

- `artifacts/api-server/src/lib/forge/uploadStorageService.ts`

The service stores first-pass SAFE_PRODUCT reference images in Forge controlled storage and creates linked records across:

- Upload Storage
- Asset Intake
- Preview Service
- Product Library
- Job Review attachments when a job id exists

## New APIs

Added:

- `GET /api/forge/uploads`
- `POST /api/forge/uploads`
- `GET /api/forge/uploads/:uploadId`
- `PATCH /api/forge/uploads/:uploadId`

`POST /api/forge/uploads` currently uses a narrow JSON/base64 upload path. Multipart upload is intentionally deferred until the full Asset Library/scanning layer exists.

## Storage Path

Stored files are written under:

- `artifacts/api-server/public/forge-uploads`

Public preview URLs are served through the existing static asset route:

- `/api/assets/forge-uploads/<storedFilename>`

## Validation Rules

Allowed first-pass MIME types:

- `image/png`
- `image/jpeg`
- `image/webp`

Validation includes:

- MIME allowlist
- image magic-byte check
- 8 MB max upload size
- safe filename handling
- unique stored filename per upload
- SHA-256 checksum recording
- blocked protected/avatar/skin/body/face/hair/makeup/internal terms
- blocked unsupported file types including GLB, FBX, ZIP, archives, executable files, scripts, HTML, SVG, and source-code extensions

Repeated identical files are allowed for now because two products may legitimately share the same reference. The checksum is recorded and duplicates are marked in metadata for future deduplication work.

## Asset Intake Integration

Asset Intake records now support:

- `uploadId`
- durable Forge storage source type
- durable preview URL metadata
- upload-linked review status sync

When a SAFE_PRODUCT upload succeeds, Forge creates an Asset Intake record with:

- source type: `forge_upload_storage`
- upload reference type: `uploaded_image`
- reference URL pointing to the durable Forge asset URL
- linked upload id
- linked preview id
- optional linked product id

## Preview Integration

Preview records now support:

- `uploadId`
- durable preview URL
- linked Asset Intake metadata
- linked Product Library metadata
- upload review sync

No ThreeViewer or 3D rendering is used. This remains a lightweight image preview path.

## Product Library Changes

Product Library cards now support:

- `uploadIds`
- uploaded image thumbnail URLs
- upload count display on Forge dashboard product cards
- latest upload id metadata
- durable upload ownership state

When `claimProduct` is true, an upload can create or update a Product Library card and link:

- Upload
- Asset Intake
- Preview
- Product

## Mobile Changes

Updated:

- `artifacts/viper-studio/lib/forgeJobs.ts`
- `artifacts/viper-studio/app/(legacy)/devstudio.tsx`

Mobile now has a safe upload helper:

- `uploadMobileForgeReference`

Dev Lab manual import and camera capture now try durable Forge upload first for SAFE_PRODUCT references, then fall back to the Phase 3G metadata-only path if upload is unavailable.

CreatorHub non-avatar product maps now try durable Forge upload first for:

- vehicle maps
- non-avatar clothing maps
- prop/furniture maps
- environment/building maps

Avatar uploads, skin uploads, body/face/hair/makeup paths, DressingRoom, ViperCreatorShell, Aria, Gaius, MakeHuman, and MPFB are not bridged into public Forge upload storage.

Local compatibility remains:

- Dev Lab AsyncStorage records remain.
- CreatorHub local map state remains.
- Existing metadata-only Asset Intake fallback remains.

Mobile stores returned Forge IDs where available:

- `forgeUploadId`
- `forgeUploadIds`
- `forgeAssetIntakeId`
- `forgeAssetIntakeIds`
- `forgePreviewIds`
- `forgeProductId`

## Website UI Changes

Updated:

- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`

Forge dashboard now shows:

- Upload Storage status panel
- Upload Storage service panel
- uploaded filename
- SAFE_PRODUCT category
- target workspace
- file type
- file size
- linked intake id
- linked preview id
- linked product id
- source/license status
- approve action
- needs revision action
- archive action

Product cards now show upload count alongside generation and intake counts.

## Review Queue Changes

Uploaded SAFE_PRODUCT assets appear in Review Queue through their linked Asset Intake records.

Upload review actions sync to:

- Upload record
- Asset Intake record
- Preview record

Rejected upload state maps to archived preview state because Preview Service does not use a rejected state.

## What Stayed Local

Still local or deferred:

- full multipart upload handling
- virus/malware scanning
- image moderation/scanning hooks
- user-facing file browser
- full Asset Library
- file deduplication UI
- mesh processing
- material baking
- 3D preview rendering
- Export Forge

## What Stayed Untouched

Not touched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- ViperCreatorShell internals
- DressingRoom internals
- protected Aria assets
- protected Gaius assets
- avatar generation
- skin generation
- body/face/hair/makeup upload lanes
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
- Forge upload smoke test

Mobile tests:

- 60 tests passed

Node warning observed:

- Existing module type warning for mobile test files. No new failure.

## Smoke Test Results

Forge upload smoke test passed.

Created:

- Upload record: `upload-f65dba49`
- Asset Intake record: `asset-ea3fa886`
- Preview record: `preview-73134632`
- Product Library card: `product-4761b7db`

Confirmed:

- upload file stored in controlled Forge upload storage
- stored file exists on disk
- public preview URL returns HTTP 200
- upload links to Asset Intake
- upload links to Preview
- upload links to Product Library
- Product Library card stores the upload id
- Review Queue includes the linked Asset Intake item
- protected/avatar upload attempt was blocked
- unsupported ZIP upload attempt was blocked
- upload approval synced to linked Asset Intake and Preview records

## Risks

- JSON/base64 upload is acceptable for the first safe pass but should be replaced with multipart upload before large files.
- There is no malware/scanning layer yet.
- Source/license status remains declared metadata, not verified automatically.
- Duplicate checksum handling records duplicate information but does not yet provide dedupe UI.
- CreatorHub remains a mixed legacy file, so future edits must continue to avoid protected avatar paths.
- Upload Storage is not a full Asset Library yet.

## Recommended Phase 3I Next Step

Build the Asset Review and Safety Scanner foundation:

1. Add upload scanning status fields.
2. Add source rights confirmation workflow.
3. Add image dimension and file metadata extraction.
4. Add duplicate checksum grouping.
5. Add manual review filters for pending, approved, needs revision, rejected, and archived uploads.
6. Keep mobile as requester/reviewer only.

Success condition for Phase 3I:

Forge can review and qualify uploaded SAFE_PRODUCT references before they become reusable Asset Library material.
