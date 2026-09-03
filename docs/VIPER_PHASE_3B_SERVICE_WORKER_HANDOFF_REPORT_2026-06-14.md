# Viper Phase 3B Service-To-Worker Handoff Report

Date: 2026-06-14

Scope: Phase 3B implementation. Connected the Forge service layer to generation, preview, and review workflows. No legacy systems were deleted, Workshop/ThreeViewer/Viewer/Shipyard/IMVU Creator were not removed, protected assets were not moved, and no full major workspace was built.

## Executive Result

Forge now supports a real service loop:

1. Create a job.
2. Create a generation request for that job.
3. Expose a worker contract.
4. Mark generation completed or failed.
5. Create preview metadata.
6. Link preview back to generation/job/product.
7. Review the job.
8. Record product revision actions and history.

This gives future Website/Forge workspaces one shared job-to-generation-to-preview-to-review path instead of each workspace inventing its own.

## New Data Structures

Added:

- `ForgePreviewReviewState`
  - `pending`
  - `approved`
  - `needs_revision`
  - `archived`
- `ForgeProductRevisionAction`
  - `approve`
  - `request_revision`
  - `archive`
  - `duplicate_for_revision`
- `ForgeJobReviewAction`
  - `approve_result`
  - `request_revision`
  - `attach_preview`
  - `attach_product`
  - `mark_ready_for_export_later`
- `ForgeWorkerGenerationContract`

Generation requests now include:

- references
- target output
- result preview IDs
- output metadata
- error message

Preview records now include:

- prompt summary
- source generation request ID
- review status

Jobs now include:

- linked preview IDs
- linked product IDs
- generation request IDs
- review state
- ready-for-export-later flag
- review action history

Products now support expanded revision states:

- `draft`
- `review`
- `approved`
- `needs_revision`
- `archived`

## Worker Contract

Worker contract endpoint:

- `GET /api/forge/generation-requests/:requestId/worker-contract`

Contract fields:

- request ID
- job ID
- product ID
- workspace ID
- request type
- prompt
- references
- target output
- status
- result preview IDs
- error state

This is the handoff shape future workers can consume without knowing the website or mobile UI.

## New APIs

- `POST /api/forge/generation-requests/bridge`
- `GET /api/forge/generation-requests/:requestId/worker-contract`
- `POST /api/forge/generation-requests/:requestId/complete`
- `POST /api/forge/products/:productId/revision-actions`
- `POST /api/forge/jobs/:jobId/review-actions`

## Updated APIs

- `POST /api/forge/generation-requests`
  - now stores references, target output, result preview IDs, output metadata, and optional error state.
- `PATCH /api/forge/generation-requests/:requestId`
  - now updates output metadata, result preview IDs, and error state.
- `POST /api/forge/previews`
  - now supports prompt summary, source generation request ID, and review status.
- `PATCH /api/forge/previews/:previewId`
  - now supports preview review-state updates.
- `PATCH /api/forge/jobs/:jobId`
  - now supports review state and ready-for-export-later metadata.
- `/api/imagine`
  - existing behavior is preserved.
  - optional `forge` metadata can create/update a Forge generation request, create a preview record, and link output metadata back to job/product.

## Preview Flow

When a generation request is completed:

1. Generation request is updated to `completed` or `failed`.
2. Output summary and output metadata are stored.
3. If preview data is supplied, Preview Service creates a record.
4. Preview record is linked to the generation request.
5. Preview ID is added to the generation result list.
6. Preview is attached to the job when a job ID exists.
7. Preview is attached to the product when a product ID exists.

No ThreeViewer or full 3D rendering dependency was added.

## Product Revision Flow

Product revision action endpoint:

- `POST /api/forge/products/:productId/revision-actions`

Supported actions:

- approve
- request revision
- archive
- duplicate for revision

Each action creates a product revision history entry. Duplicate-for-revision creates a new product card with a source-product revision link.

## Job Review Flow

Job review action endpoint:

- `POST /api/forge/jobs/:jobId/review-actions`

Supported actions:

- approve result
- request revision
- attach preview
- attach product
- mark ready for export later

The ready-for-export-later action deliberately does not build Export Forge. It records readiness only.

## UI Changes

Website/Forge shell now includes lightweight panels for:

- generation requests
- previews
- guide context
- product revision history/actions
- job review actions

Texture/Material job submission now also creates a generation request so the dashboard demonstrates the Phase 3B loop.

No full editors were added.

## Mobile Client Support

Mobile helpers were expanded only as service clients:

- fetch generation request status
- fetch preview list
- apply product revision actions
- apply job review actions
- continue consuming guide context

No heavy mobile system was added. No mobile ThreeViewer, `three-scripts.ts`, Workshop, or protected asset loading was introduced.

## Test Results

Passed:

- API typecheck.
- Website typecheck.
- Mobile typecheck.
- Existing mobile tests: 60 passed, 0 failed.
- Forge Phase 3B workflow smoke test.

Smoke test proved:

1. Create job.
2. Create generation request for job.
3. Read worker contract.
4. Mark generation request completed.
5. Create preview record.
6. Link preview to generation request.
7. Link preview to job.
8. Link preview/product to Product Library.
9. Approve job result.
10. Request job revision.
11. Request product revision.
12. Duplicate product for revision.
13. Confirm history/link records exist.

Smoke result:

`PHASE3B_FORGE_WORKFLOW_SMOKE_OK`

## Risks

- JSON persistence is still Phase 3 foundation storage; a database will be needed before multi-user production scale.
- Worker execution is still simulated/contract-based. Real background workers are not built yet.
- `/api/imagine` bridge is optional and safe, but not a full rewrite of generation routing.
- Preview records store metadata and URLs; no renderer or thumbnail worker exists yet.
- Export readiness is only a job flag. Export Forge remains unbuilt.

## Recommended Phase 3C Next Step

Build the real background worker runner:

1. Add a worker dispatcher for queued generation requests.
2. Add generation request status transitions: submitted -> queued -> processing -> completed/failed.
3. Route `/api/imagine` and future Forge generation through the dispatcher when Forge metadata is present.
4. Add preview asset validation and thumbnail URL checks.
5. Add a small Website/Forge review queue filtered by `pending` previews.
6. Keep mobile as review/status/action client only.

Do not build full Spacecraft Forge, Clothing Forge, World Forge, Room Forge, Export Forge, or Animation Forge until the worker runner and review queue are stable.
