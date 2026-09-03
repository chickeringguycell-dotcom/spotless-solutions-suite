# VIPER PHASE 3I ASSET REVIEW SAFETY SCANNER REPORT

Date: 2026-06-14

Scope: Asset Review and Safety Scanner foundation for Forge-owned SAFE_PRODUCT uploads. No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, protected assets, avatar/skin systems, MakeHuman, and MPFB were not moved or reactivated.

## Mission

Add a lightweight quality-control layer before uploaded SAFE_PRODUCT references become reusable production asset material:

Upload -> Safety scan -> Source rights tracking -> Image metadata -> Duplicate grouping -> Asset Intake -> Preview -> Product Library -> Review Queue

## New Fields

Upload records now support:

- `scanStatus`
- `scanNotes`
- `sourceRightsStatus`
- `sourceRightsNotes`
- `duplicateGroupId`
- `duplicateCount`
- `relatedUploadIds`
- `imageMetadata`
- `detectedFileMetadata`
- `scannerWarnings`
- `scannerBlockedReason`

Scan statuses:

- `unscanned`
- `scanning`
- `passed`
- `warning`
- `blocked`
- `failed`

Source rights statuses:

- `unknown`
- `user_confirmed`
- `needs_review`
- `rejected`
- `internal_only`

## Updated APIs

Updated:

- `GET /api/forge/uploads`
- `POST /api/forge/uploads`
- `GET /api/forge/uploads/:uploadId`
- `PATCH /api/forge/uploads/:uploadId`
- `GET /api/forge/review-queue`

Upload list filters now support:

- `reviewStatus`
- `scanStatus`
- `sourceRightsStatus`
- `duplicateGroupId`
- `hasWarnings=true`
- `blocked=true`
- existing workspace/category/product/intake/query filters

Review Queue filters now support:

- `uploadId`
- `scanStatus`
- `sourceRightsStatus`
- `duplicateGroupId`

`GET /api/forge/uploads` also returns upload review, scan, and source-rights status lists for UI controls.

## Scanner Behavior

The scanner is intentionally lightweight.

It performs:

- MIME allowlist check
- magic-byte validation
- checksum recording
- extension recording
- image header dimension extraction
- aspect ratio calculation
- detected metadata recording
- warning capture when dimensions cannot be read

It does not perform:

- malware scanning
- content moderation
- texture baking
- mesh processing
- 3D preview rendering
- export validation

Supported image metadata extraction:

- PNG width/height from IHDR
- JPEG width/height from SOF markers
- WebP width/height from VP8X, VP8L, or VP8 headers

## Source Rights Workflow

Source rights are project-tracking metadata, not legal advice.

Forge can now track:

- unknown source
- user confirmed usable
- needs review
- rejected
- internal only

The Website/Forge Asset Review panel can mark an upload as:

- user confirmed
- needs review

Uploads can still be approved, marked needs revision, rejected, or archived separately from source-rights status.

## Duplicate Grouping Behavior

Uploads with matching checksums are grouped by:

- `duplicateGroupId`
- `duplicateCount`
- `relatedUploadIds`

Duplicates are not deleted.

Duplicates are not automatically merged.

This only provides visibility so a future Asset Library can review or deduplicate safely.

## Website UI Changes

Updated:

- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`
- `artifacts/landing-page/src/index.css`

The Forge dashboard now includes a simple Asset Review panel showing:

- uploaded image thumbnail
- file name
- file size
- image dimensions
- MIME type
- scan status
- source rights status
- duplicate count
- linked intake
- linked preview
- linked product
- review status
- scanner warnings
- scanner blocked reason

Actions added:

- mark source user confirmed
- mark source needs review
- approve
- needs revision
- reject
- archive

The top Forge status strip now includes an Asset Review summary.

## Mobile Changes

Updated:

- `artifacts/viper-studio/lib/forgeJobs.ts`

Mobile remains lightweight.

Added only minimal upload status contract fields and a helper:

- `fetchMobileForgeUploadStatus(uploadId)`

The helper exposes:

- review status
- scan status
- source rights status
- duplicate group id
- duplicate count
- scanner warnings
- scanner blocked reason
- updated date

No mobile asset browser was added.

## Review Queue Changes

Review Queue Asset Intake items now include linked upload scanner context:

- upload id
- scan status
- source rights status
- duplicate group id
- duplicate count
- scanner warnings
- scanner blocked reason

Review Queue reasons now include scanner/source/duplicate details when an upload is linked.

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
- avatar uploads
- skin uploads
- body/face/hair/makeup upload lanes
- MakeHuman
- MPFB
- full Asset Library
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
- Forge Phase 3I smoke test

Mobile tests:

- 60 tests passed

Node warning observed:

- Existing module type warning for mobile test files. No new failure.

## Smoke Test Results

Forge Phase 3I smoke test passed.

Created:

- Upload A: `upload-881ce506`
- Upload B: `upload-fbaf23b0`

Confirmed:

- SAFE_PRODUCT upload succeeded
- image metadata extracted: `1 x 1`
- aspect ratio recorded: `1.000`
- scan status recorded: `passed`
- duplicate checksum grouping detected
- duplicate group id: `dup-4b5c5c92cec3`
- duplicate count: `3`
- source rights changed to `user_confirmed`
- upload review status changed to `approved`
- linked Asset Intake status synced to `approved`
- linked Preview status synced to `approved`
- linked Asset Intake received scan metadata
- linked Preview received scan/source metadata
- Review Queue exposed upload scan/source/duplicate fields
- `scanStatus=passed&sourceRightsStatus=user_confirmed` filter worked
- protected/avatar upload attempt was blocked
- unsupported ZIP upload attempt was blocked

## Risks

- This is not a full malware scanner.
- This is not legal advice or automated rights verification.
- Header-based image metadata can fail on unusual but valid files.
- Duplicate grouping is checksum-only and does not detect visually similar images.
- Rejected uploads remain stored for audit/review until a later retention policy exists.
- JSON/base64 upload remains a first-pass path; multipart upload should come later.

## Recommended Phase 3J Next Step

Build the Asset Library Readiness Gate:

1. Add a reusable-assets eligibility flag.
2. Require passed scan status.
3. Require acceptable source-rights status.
4. Require approved review status.
5. Keep rejected/blocked uploads out of reusable asset lists.
6. Add simple Asset Library candidate view on Website/Forge only.
7. Keep mobile as requester/reviewer, not an asset library browser.

Success condition for Phase 3J:

Only reviewed, source-qualified, scan-passed SAFE_PRODUCT uploads can become Asset Library candidates.
