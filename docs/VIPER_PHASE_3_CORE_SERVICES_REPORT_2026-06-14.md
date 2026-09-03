# Viper Phase 3 Core Services Report

Date: 2026-06-14

Scope: Phase 3 Website/Forge core service implementation. No legacy mobile systems were deleted, Workshop/ThreeViewer/Viewer/Shipyard/IMVU Creator were not removed, protected assets were not moved, and MakeHuman/MPFB/public avatar generation/skin generation were not reintroduced.

## Executive Result

Website/Forge now has a reusable core service backbone for future workspaces.

The old in-memory Forge foundation was replaced with service modules for:

- Product Library.
- Job Queue.
- Workspace Registry.
- Preview records.
- Generation request records.
- Aria/Gaius guide context.

The services are API-owned and lightweight for mobile consumption. They do not depend on ThreeViewer, `three-scripts.ts`, or any full 3D rendering path.

## Services Completed

### Product Library Service

Completed:

- Persistent product cards.
- Product categories.
- Metadata records.
- Source tracking.
- Revision history.
- Thumbnail fields.
- Search and filter support.
- API list/create/read/update.

This is now the master catalog foundation for Viper Studios.

### Job Queue Service

Completed:

- Persistent jobs.
- Jobs survive server restart through JSON storage.
- Job history.
- Status tracking.
- Status updates.
- Job lookup by ID.
- Filtering by workspace, status, project, and query.

Supported states:

- `draft`
- `submitted`
- `queued`
- `processing`
- `review`
- `approved`
- `exported`
- `failed`

### Workspace Registry Service

Completed:

- One metadata source of truth for Forge workspaces.
- Workspace ID, label, description, category, mobile category mapping, website mapping, status, services, preview type, and export targets.
- Active/usable Phase 3 lanes:
  - `TextureMaterialForge`
  - `FurnitureForge`
  - `VehicleForge`
  - `BuildingForge`

Other workspaces remain placeholders, deferred, internal protected, or retired.

### Preview Service

Completed:

- Thumbnail records.
- Preview image records.
- Proxy preview metadata.
- Product/job/generation preview attachment fields.
- API list/create/read/update.
- No ThreeViewer dependency.
- No full 3D rendering dependency.

### Generation Service

Completed:

- Central generation request ledger.
- Concept requests.
- Image generation request metadata.
- Material/texture concept request metadata.
- Links to jobs, products, and previews.
- API list/create/read/update.

This does not replace `/api/imagine` execution yet; it creates the shared request path future screens should use instead of duplicating generation state.

### Aria/Gaius Context Service

Completed:

- Active project.
- Selected guide.
- Active workspace.
- Active job.
- Project notes.
- Review state.
- Recent actions.
- Website-only warning support.
- API list/create/read/update.

Aria remains the creative guide. Gaius remains the practical inspector.

## Services Partially Completed

- Generation Service: request persistence exists, but actual image/model generation execution is still delegated to existing AI routes until Phase 3B.
- Preview Service: lightweight records exist, but no thumbnail renderer or asset proxy worker exists yet.
- Product Library: persistent cards exist, but large asset storage, package manifests, and moderation integration remain future work.
- Workspace Registry: metadata exists, but full workspace hosts for Spacecraft, Clothing, World, Room, Export, and Animation are intentionally not built yet.

## New Files

- `artifacts/api-server/src/lib/forge/types.ts`
- `artifacts/api-server/src/lib/forge/utils.ts`
- `artifacts/api-server/src/lib/forge/persistence.ts`
- `artifacts/api-server/src/lib/forge/workspaceRegistry.ts`
- `artifacts/api-server/src/lib/forge/productLibrary.ts`
- `artifacts/api-server/src/lib/forge/jobQueue.ts`
- `artifacts/api-server/src/lib/forge/previewService.ts`
- `artifacts/api-server/src/lib/forge/generationService.ts`
- `artifacts/api-server/src/lib/forge/guideContextService.ts`

## Updated Files

- `artifacts/api-server/src/lib/forgeStore.ts`
- `artifacts/api-server/src/routes/forge.ts`
- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/viper-studio/lib/forgeJobs.ts`

## New APIs

Existing compatible endpoints kept:

- `GET /api/forge/summary`
- `GET /api/forge/workspaces`
- `GET /api/forge/workspaces/:workspaceId`
- `GET /api/forge/jobs`
- `POST /api/forge/jobs`
- `PATCH /api/forge/jobs/:jobId/state`
- `GET /api/forge/products`
- `POST /api/forge/products`

New or expanded endpoints:

- `GET /api/forge/workspaces/registry`
- `GET /api/forge/products/:productId`
- `PATCH /api/forge/products/:productId`
- `GET /api/forge/jobs/:jobId`
- `PATCH /api/forge/jobs/:jobId`
- `GET /api/forge/previews`
- `POST /api/forge/previews`
- `GET /api/forge/previews/:previewId`
- `PATCH /api/forge/previews/:previewId`
- `GET /api/forge/generation-requests`
- `POST /api/forge/generation-requests`
- `GET /api/forge/generation-requests/:requestId`
- `PATCH /api/forge/generation-requests/:requestId`
- `GET /api/forge/guide-contexts`
- `POST /api/forge/guide-contexts`
- `GET /api/forge/guide-contexts/:contextId`
- `PATCH /api/forge/guide-contexts/:contextId`

## Data Persistence Method

Forge services use JSON collection files by default under:

`artifacts/api-server/data/forge`

The path can be overridden with:

`FORGE_STORAGE_DIR`

Collections:

- `products.json`
- `jobs.json`
- `previews.json`
- `generation-requests.json`
- `guide-contexts.json`

Writes use a temporary file plus rename for simple atomic replacement. The smoke test used a temporary `FORGE_STORAGE_DIR` and removed it afterward.

## Mobile Impact

Mobile remains light.

Added mobile client helpers only:

- list Forge jobs.
- fetch product cards.
- fetch previews.
- create/update guide context.
- submit jobs.
- update job status.

No heavy mobile systems were added. No mobile ThreeViewer or `three-scripts.ts` imports were added.

## Test Results

Passed:

- API typecheck.
- Website typecheck.
- Mobile typecheck.
- Existing mobile tests: 60 passed, 0 failed.
- Forge API smoke test with temporary storage:
  - product list/create/read/update
  - job create/read/update/status
  - workspace registry summary
  - preview create/list
  - generation request create
  - guide context create/read/update

Smoke result:

`PHASE3_FORGE_SMOKE_OK`

## Risks

- JSON storage is appropriate for Phase 3 foundation work, but a database will be needed before multi-user production scale.
- Generation Service is currently a request ledger, not a worker queue or image execution engine.
- Preview Service stores records, not rendered thumbnails. A renderer/proxy worker should come later.
- Product Library does not yet manage large binary assets or package manifests.
- Runtime hiding still does not remove legacy mobile code from the Android bundle; Phase 2D already confirmed native bundle splitting is not the near-term answer.

## Recommended Phase 3B Next Step

Build the service-to-worker handoff layer:

1. Add a real worker contract for generation requests.
2. Let `/api/imagine` and future Forge generation call paths create `generation-requests` records.
3. Attach generated outputs to Preview Service records.
4. Link previews back to jobs and products.
5. Add Product Library revision actions for approve/request-revision.
6. Add Website/Forge UI panels for previews, generation requests, and guide context.

Do not build full Spacecraft Forge, Clothing Forge, World Forge, Room Forge, Export Forge, or Animation Forge until the service-to-worker path is stable.
