# VIPER PHASE 3J ASSET LIBRARY READINESS GATE REPORT

Date: 2026-06-14

Scope: Asset Library Readiness Gate for Forge-owned SAFE_PRODUCT uploads. This does not build the full Asset Library, Export Forge, Spacecraft Forge, Animation Forge, or any legacy mobile replacement. No legacy systems or protected assets were deleted or moved.

## Mission

Create a Forge-owned gate that decides whether uploaded SAFE_PRODUCT references are eligible to become reusable Asset Library candidates.

Only uploads that are scan-passed, source-qualified, and review-approved may become candidates.

## New Fields

Upload records now support:

- `libraryCandidateStatus`
- `libraryCandidateReason`
- `reusableAssetEligible`
- `reusableAssetBlockedReason`
- `evaluatedAt`
- `evaluatedBy`

Readiness statuses:

- `not_evaluated`
- `candidate`
- `blocked`
- `needs_review`
- `internal_only`

## Eligibility Rules

An upload may become an Asset Library candidate only when:

- SAFE_PRODUCT category is valid
- target workspace is an approved SAFE_PRODUCT Forge workspace
- `scanStatus` is `passed`
- `sourceRightsStatus` is `user_confirmed` or `internal_only`
- `reviewStatus` is `approved`
- upload is not scanner-blocked
- upload is not rejected or archived
- upload does not contain protected/avatar/skin/internal-public-forbidden terms

If `sourceRightsStatus` is `internal_only`, the upload may become an `internal_only` candidate. It is not treated as a public reusable asset.

Unknown source rights, pending source review, scanner warnings, unscanned uploads, pending upload review, rejected source rights, protected terms, avatar/skin/body/face/hair/makeup terms, MakeHuman, and MPFB are not reusable candidates.

## New APIs

Added:

- `POST /api/forge/assets/library-readiness/evaluate/:uploadId`
- `GET /api/forge/assets/library-readiness/candidates`
- `GET /api/forge/assets/library-readiness/candidates/:uploadId`

Updated:

- `GET /api/forge/uploads`
- `GET /api/forge/review-queue`
- `GET /api/forge/summary`

Candidate filters support:

- `libraryCandidateStatus`
- `candidateStatus`
- `status`
- `category`
- `workspaceId`
- `sourceRightsStatus`
- `reviewStatus`
- `scanStatus`
- `reusableAssetEligible`
- `internalOnly`
- `candidateOnly`

## Website UI Changes

Added a Website/Forge Asset Library Candidates panel.

The panel shows:

- thumbnail
- file name
- category
- workspace
- scan status
- source rights status
- review status
- candidate status
- blocked reason
- internal-only flag
- evaluated date and evaluator

The panel includes an Evaluate readiness action per upload.

The Forge dashboard status strip now includes an Asset Candidates status panel.

The Reports page still keeps the easy copy button at the top for the newest report.

## Review Queue Changes

Asset Intake review queue items now expose:

- `libraryCandidateStatus`
- `reusableAssetEligible`
- `reusableAssetBlockedReason`

Review queue reasons now include the readiness reason, blocked reason, and reusable eligibility state when an upload is linked.

Review queue filtering now supports:

- `libraryCandidateStatus`
- `reusableAssetEligible`

## Mobile Changes

Mobile remains lightweight.

Updated only the mobile Forge upload status contract so mobile can display:

- library candidate status
- library candidate reason
- reusable asset eligibility
- reusable asset blocked reason
- evaluated date
- evaluator

No mobile Asset Library browser was added.

No heavy upload management was added to mobile.

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
- Forge Phase 3J smoke test
- Website/Forge browser verification

Mobile tests:

- 60 tests passed

Node warning observed:

- Existing module type warning for mobile test files. No new failure.

## Smoke Test Results

Forge Phase 3J smoke test passed.

Created:

- Candidate upload: `upload-f311559f`
- Candidate product: `product-7e503d6a`
- Needs-review upload: `upload-1ceb5164`
- Blocked upload: `upload-073ef520`

Confirmed:

- SAFE_PRODUCT upload succeeded
- scan status recorded as `passed`
- source rights set to `user_confirmed`
- upload review set to `approved`
- readiness evaluation changed the upload to `candidate`
- `reusableAssetEligible` became `true`
- unknown source rights evaluated to `needs_review`
- rejected source rights evaluated to `blocked`
- protected/avatar upload attempt was refused with HTTP 400
- candidate list endpoint returned evaluated readiness records
- `candidateOnly=true` returned only candidate/internal-only-ready uploads
- Review Queue exposed readiness status and reasons
- Website/Forge Asset Library Candidates panel displayed the candidate, needs-review, and blocked smoke uploads
- Website/Forge panel displayed blocked reasons and Evaluate readiness actions

## Risks

- This is a readiness gate, not a legal rights verifier.
- This is still not a malware scanner or content moderation system.
- Protected-term detection is conservative and may block uploads that need manual review.
- Duplicate grouping is checksum-based only.
- `internal_only` candidates need future UI and policy separation before any public library flow exists.
- The full Asset Library has not been built yet.

## Recommended Phase 3K Next Step

Build the Asset Library Candidate Review workflow.

Recommended next safe work:

1. Add a candidate approval action separate from upload approval.
2. Keep internal-only candidates in a separate internal lane.
3. Add candidate history entries.
4. Add Product Library links from candidate records.
5. Add simple candidate filters on Website/Forge.
6. Do not build full export, collections, tagging, or public browsing yet.

## Success Condition

Met.

Only reviewed, source-qualified, scan-passed SAFE_PRODUCT uploads can become Asset Library candidates. Forge now has a safe gate before any uploaded asset becomes reusable production material.
