# VIPER PHASE 3K ASSET LIBRARY CANDIDATE REVIEW REPORT

Date: 2026-06-14

Scope: Asset Library Candidate Review workflow for Forge-owned SAFE_PRODUCT uploads. This phase does not build the full Asset Library, Export Forge, Spacecraft Forge, Animation Forge, public browsing, or public sharing. No legacy systems or protected assets were deleted or moved.

## Mission

Build the final review gate before a SAFE_PRODUCT upload can become reusable Asset Library material:

SAFE_PRODUCT upload -> scan passed -> source rights acceptable -> upload review approved -> Asset Library candidate -> candidate review -> approved reusable asset material.

## New Fields

Upload records now support:

- `candidateReviewStatus`
- `candidateReviewReason`
- `candidateReviewedAt`
- `candidateReviewedBy`
- `reusableMaterialApproved`
- `reusableMaterialLane`

Candidate review statuses:

- `not_reviewed`
- `approved`
- `needs_revision`
- `rejected`
- `internal_only`

Reusable material lanes:

- `public_safe_product`
- `internal_only`
- `blocked`

## New APIs

Added:

- `GET /api/forge/assets/library-candidates`
- `GET /api/forge/assets/library-candidates/:uploadId`
- `POST /api/forge/assets/library-candidates/:uploadId/review-actions`

Updated:

- `GET /api/forge/uploads`
- `GET /api/forge/review-queue`
- `GET /api/forge/summary`

Candidate review filters support:

- `candidateReviewStatus`
- `reusableMaterialApproved`
- `reusableMaterialLane`
- existing readiness, source-rights, workspace, category, product, and scan filters

## Candidate Review Model

Candidate review is separate from upload review and readiness evaluation.

Readiness says:

- this upload may be considered as an Asset Library candidate

Candidate review says:

- this candidate is approved as reusable material
- this candidate needs revision
- this candidate is rejected
- this candidate is internal-only reusable material
- this candidate review has been reset

## Candidate Actions

Supported actions:

- `approve_candidate`
- `needs_revision`
- `reject_candidate`
- `mark_internal_only`
- `reset_review`

Approval requires:

- `libraryCandidateStatus` is `candidate` or `internal_only`
- `reusableAssetEligible` is `true`
- `scanStatus` is `passed`
- `reviewStatus` is `approved`
- `sourceRightsStatus` is `user_confirmed` or `internal_only`
- no protected/avatar/skin/internal-public-forbidden terms
- linked Product Library card exists

If source rights or readiness are internal-only, the action resolves to the `internal_only` review status and `internal_only` reusable material lane.

Blocked, rejected, protected, avatar, skin, MakeHuman, and MPFB assets cannot be approved as reusable material.

## Product Library Linking

When a candidate is approved or marked internal-only:

- the upload stores candidate review status
- linked intake and preview metadata receive candidate review state
- linked Product Library card metadata records reusable material approval
- linked Product Library card metadata records reusable material lane
- linked Product Library card metadata records candidate review reason, reviewer, date, upload id, preview id, and intake id
- Product Library revision history receives a candidate review entry

No public collections, public browsing, tagging, or full Asset Library records were created.

## Website UI Changes

Added a Website/Forge Candidate Review panel.

The panel shows:

- thumbnail
- file name
- category
- workspace
- product link
- scan status
- source rights status
- readiness status
- candidate review status
- reusable material lane
- reusable material approval state
- blocked reason
- review reason
- reviewer and reviewed date

Actions added:

- approve candidate
- needs revision
- reject candidate
- mark internal only
- reset review

The Forge dashboard status strip now includes a Candidate Review panel count.

## Review Queue Changes

Review Queue Asset Intake items now expose:

- `candidateReviewStatus`
- `reusableMaterialApproved`
- `reusableMaterialLane`

Review Queue reasons now include:

- candidate review status
- reusable material lane
- reusable material approval state
- candidate review reason

Review Queue filtering now supports:

- `candidateReviewStatus`
- `reusableMaterialApproved`
- `reusableMaterialLane`

Candidate review state affects review queue state:

- `not_reviewed` appears as pending
- `approved` appears as approved
- `internal_only` appears as approved
- `needs_revision` appears as needs revision
- `rejected` appears as archived

## Mobile Changes

Mobile remains lightweight.

Updated only the mobile Forge upload status contract so mobile can display:

- candidate review status
- candidate review reason
- reviewed date
- reviewer
- reusable material approval state
- reusable material lane

No mobile Asset Library browser was added.

No heavy asset management was added to mobile.

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
- public browsing
- public sharing

## Validation

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- Existing mobile tests
- API build
- Forge Phase 3K smoke test
- Website/Forge browser verification

Mobile tests:

- 60 tests passed

Node warning observed:

- Existing module type warning for mobile test files. No new failure.

## Smoke Test Results

Forge Phase 3K smoke test passed.

Created:

- Public reusable upload: `upload-4ebfaaf2`
- Public reusable product: `product-d272982c`
- Internal-only upload: `upload-a15852df`
- Internal-only product: `product-0fd06164`
- Blocked/rejected upload: `upload-9c705fe3`

Confirmed:

- SAFE_PRODUCT upload succeeded
- scan status recorded as `passed`
- source rights confirmed
- upload review set to `approved`
- readiness evaluation changed public upload to `candidate`
- public candidate approval changed review status to `approved`
- public candidate lane became `public_safe_product`
- public product metadata recorded `reusableMaterialApproved=true`
- public product metadata recorded `reusableMaterialLane=public_safe_product`
- internal-only readiness stayed `internal_only`
- internal-only candidate review stayed `internal_only`
- internal-only reusable material lane stayed `internal_only`
- blocked/rejected upload readiness became `blocked`
- blocked/rejected upload could not be approved as reusable material
- protected/avatar upload attempt was refused with HTTP 400
- candidate review filters worked
- reusable material lane filters worked
- Review Queue exposed candidate review status and reasons
- Website/Forge Candidate Review panel displayed public, internal-only, and blocked smoke results

## Risks

- Candidate approval is still a workflow gate, not a full Asset Library implementation.
- This is not legal rights verification.
- This is not malware scanning or content moderation.
- Protected-term detection is conservative and may block uploads that need manual review.
- Reusable material approval currently records metadata and Product Library revision history, not full collection/library objects.
- Public-safe material still needs a future Asset Library publishing layer before public browsing or sharing.

## Recommended Phase 4 Next Step

Begin Phase 4: build the first real Asset Library foundation.

Recommended safe start:

1. Create Asset Library records from approved candidate uploads.
2. Keep public-safe and internal-only lanes separate.
3. Add immutable source, scan, rights, review, and candidate history snapshots.
4. Add Website/Forge-only library browsing for internal review.
5. Keep mobile as lightweight status/review display only.
6. Do not add public sharing until library policy and export gates exist.

## Success Condition

Met.

Only scan-passed, source-qualified, review-approved SAFE_PRODUCT candidates can become reusable asset material. Forge now has a complete safe path from upload to reusable asset candidate approval without building the full public Asset Library.
