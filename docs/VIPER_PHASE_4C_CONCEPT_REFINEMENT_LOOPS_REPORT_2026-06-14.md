# VIPER PHASE 4C CONCEPT REFINEMENT LOOPS REPORT

Date: 2026-06-14

Status: implemented and validated.

Reports page note: this report is intended to appear with the existing top `COPY LATEST REPORT` button on the Website/Forge reports page.

## Mission

Upgrade VehicleForge and SpacecraftForge from one-pass concept generators into iterative concept refinement workspaces.

No heavy editors were built.
No mesh generation was built.
No texture baking was built.
No Export Forge was built.
No Shipyard integration was built.
No heavy viewers were added.
No legacy systems were deleted.
No protected assets were moved.

## Summary

VehicleForge and SpacecraftForge now support this loop:

```text
Generate Concept
  -> Review
  -> Revision Request
  -> Aria prompt refinement
  -> Gaius readiness suggestions
  -> New Generation Request
  -> New Preview
  -> Product Library generation history
  -> Review Queue
  -> Review Again
```

The loop uses the existing Forge service backbone instead of creating a separate editor or custom storage path.

## New Data Structures

Added `ForgeConceptRevisionRequest`.

Fields:

- `id`
- `sourceProductId`
- `sourcePreviewId`
- `sourceGenerationRequestId`
- `workspaceId`
- `jobId`
- `targetProfileId`
- `revisionNumber`
- `revisionNotes`
- `ariaPromptRefinement`
- `gaiusReadinessSuggestion`
- `refinedPrompt`
- `createdBy`
- `status`
- `newGenerationRequestId`
- `newPreviewId`
- `createdAt`
- `updatedAt`
- `history`

Statuses:

- `pending`
- `submitted`
- `processing`
- `completed`
- `archived`

Storage:

- `data/forge/concept-revision-requests.json`

## New APIs

Added:

- `GET /api/forge/concept-revisions`
- `POST /api/forge/concept-revisions`
- `GET /api/forge/concept-revisions/:revisionRequestId`
- `PATCH /api/forge/concept-revisions/:revisionRequestId`
- `POST /api/forge/concept-revisions/:revisionRequestId/regenerate`

Website client helpers were added for:

- creating revision requests
- updating revision requests
- regenerating a concept from a revision request
- reading revision requests from the Forge summary

## Revision Workflow

When a revision request is created:

1. Product Library receives a `request_revision` history entry.
2. The source preview is marked `needs_revision`.
3. The linked job receives a review action.
4. The revision request appears in Review Queue.
5. Aria and Gaius assist text is stored on the revision request.

When a revision request is regenerated:

1. Revision status moves through `submitted` and `processing`.
2. A new Generation Request is created.
3. A new Preview record is created.
4. Product Library receives a new generation history entry.
5. The linked job receives the new preview.
6. Export Readiness creates a fresh checklist.
7. Revision status becomes `completed`.
8. Review Queue shows the revised concept chain.

## Aria Refinement Behavior

Aria preserves the original product intent and improves the user's revision note into a cleaner generation prompt.

Example behavior:

- User note: make it look more armored.
- Aria refinement: preserve the source vehicle purpose, keep the existing material and scale direction, and generate the next lightweight concept version with a stronger armored silhouette.

Aria does not replace the user's idea. It improves and structures it.

## Gaius Readiness Behavior

Gaius adds practical refinement suggestions from:

- latest readiness blockers
- target profile warnings
- missing metadata
- scale concerns
- source/reference concerns

Gaius does not rewrite creative intent.

## Product Revision History

Product cards now receive concept-chain metadata:

- `latestConceptVersion`
- `latestRevisionRequestId`
- `latestRevisionNotes`
- `latestAriaPromptRefinement`
- `latestGaiusReadinessSuggestion`

Product generation history now represents concept versions:

- Concept 1
- Concept 2
- Concept 3

Product revision history still records all review and update actions separately.

## Review Queue Changes

Added Review Queue item type:

- `concept_revision`

Revision queue items show:

- revision status
- source product
- source preview
- new preview when available
- Aria prompt summary
- Gaius readiness summary
- revision reason

## Website UI Changes

VehicleForge and SpacecraftForge now show:

- Revision Notes panel
- Revision History panel
- Request Revision action
- Regenerate Concept action for pending revision requests
- Aria revision assist
- Gaius readiness assist
- concept generation history preview

The UI remains lightweight metadata and preview review only.

## Mobile Changes

No mobile app feature code was changed.

Mobile remains responsible for:

- viewing revision history later
- submitting revision notes later
- approving or requesting more revisions later

Mobile still does not receive:

- editors
- heavy previews
- mesh tools
- texture baking
- export tools

Validation note:

- A stale generated Expo router type cache was cleared because it was malformed and broke typecheck.
- No mobile route, screen, legacy system, or protected asset was removed.

## What Stayed Untouched

Untouched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- protected Aria assets
- protected Gaius assets
- MakeHuman
- MPFB
- public avatar generation
- public skin generation
- heavy viewers
- mesh generation
- texture baking
- Export Forge
- Shipyard integration

## Smoke Test

Smoke test proved:

1. Create concept.
2. Approve initial review.
3. Submit revision request.
4. Aria generates refined prompt.
5. Gaius readiness suggestions appear.
6. New generation request is created.
7. New preview is created.
8. Product revision history is updated.
9. Review Queue shows revision chain.
10. Mobile remains lightweight.

Corrected smoke result:

- Job: `forge-job-c482b162`
- Product: `product-7580063c`
- Initial generation: `generation-c85c2292`
- Initial preview: `preview-3e6c9d1b`
- Revision request: `revision-e356996a`
- Revision status: `completed`
- Revision number: `2`
- New generation: `generation-796c40a7`
- New preview: `preview-75f1144f`
- Readiness check: `export-check-6281ce57`
- Product latest concept version: `Concept 2`
- Product generation history count: `2`
- Aria prompt present: yes
- Gaius suggestion present: yes

## Test Results

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- API build
- Existing mobile tests: 60 passed
- API Forge smoke test
- Website browser check

Browser check confirmed:

- VehicleForge opens.
- SpacecraftForge opens.
- Revision Notes panel appears.
- Revision History panel appears.
- Concept 2 appears in VehicleForge.
- Aria revision assist appears.
- Gaius readiness assist appears.
- Browser console errors: 0

## Risks

- Product revision count records every product update and review action, while concept version count records generation history. They are intentionally separate, but the UI should keep labeling clear.
- The current regeneration worker is lightweight and immediate. Future real workers should preserve the same contract but may run asynchronously.
- Review Queue can grow quickly as concepts iterate; Phase 4D should consider filters before adding more asset panels.
- Gaius suggestions depend on available metadata and readiness checks. Weak metadata still creates weaker practical guidance.

## Recommended Phase 4D Next Step

Begin Workspace Asset Integration:

- Candidate Asset panel
- Asset Recommendation panel
- approved candidate assets
- reusable materials
- reusable references
- workspace asset filters
- public-safe lane support
- internal-only lane support

Keep Phase 4D lightweight.

Do not build:

- mesh generation
- Export Forge
- Shipyard integration
- heavy viewers

## Success Condition

VehicleForge and SpacecraftForge are now iterative concept workspaces.

Ideas can evolve through review and refinement while staying inside the Forge service backbone and without requiring heavy editors.
