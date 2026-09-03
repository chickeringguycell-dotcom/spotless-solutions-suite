# Viper Phase 3D Target Profile And Export Readiness Report

Date: 2026-06-14

Scope: Phase 3D implementation. Built Website/Forge ownership for target profile rules and export-readiness checks. No full Export Forge, Spacecraft Forge, Clothing Forge, World Forge, or Animation Forge was built. No legacy systems were deleted, Workshop/ThreeViewer/Viewer/Shipyard/IMVU Creator were not removed, and protected assets were not moved.

## Executive Result

Website/Forge now owns the canonical target profile and export-readiness rule path.

Mobile no longer needs to carry long target/game prompt blocks as its primary rule source. It now fetches target profile summaries, submits the selected target profile ID with Forge jobs, and displays readiness warnings returned by Forge.

## New Services

### Target Profile Service

New service:

- `artifacts/api-server/src/lib/forge/targetProfileService.ts`

Initial conservative profiles:

- `generic_glb`
- `starfield`
- `skyrim`
- `imvu_product`
- `viper_internal`

The service stores rule/checklist metadata only. It does not claim final export support.

### Export Readiness Service

New service:

- `artifacts/api-server/src/lib/forge/exportReadinessService.ts`

It evaluates:

- job link
- product link
- workspace link
- target profile
- preview records
- product status
- source/license metadata
- scale metadata
- material metadata
- texture/output metadata

It does not generate export files.

## New APIs

Added:

- `GET /api/forge/target-profiles`
- `GET /api/forge/target-profiles/:profileId`
- `GET /api/forge/export-readiness/checks`
- `POST /api/forge/export-readiness/checks`
- `GET /api/forge/export-readiness/checks/:checkId`

Updated Forge summary:

- includes target profiles
- includes export readiness checks
- includes target/readiness status panels

Updated jobs:

- jobs now support optional `targetProfileId`
- new jobs infer a conservative target profile when one is not supplied

## Target Profile Data Model

Each target profile supports:

- profile ID
- label
- target platform
- target game/tool
- supported output types
- scale rules
- material rules
- texture rules
- export constraints
- warning rules
- status

Statuses:

- `active`
- `deferred`
- `internal`
- `retired`

## Export Readiness Model

Each readiness check stores:

- check ID
- job ID
- product ID
- workspace ID
- target profile ID
- available metadata
- preview IDs
- product status
- readiness status
- warnings
- missing requirements
- recommended next actions
- export blocked flag
- created timestamp

Statuses:

- `not_ready`
- `needs_review`
- `ready_later`
- `ready_for_export`
- `blocked`

## Mobile Changes

Updated:

- `artifacts/viper-studio/lib/forgeJobs.ts`
- `artifacts/viper-studio/app/(tabs)/index.tsx`
- `artifacts/viper-studio/contexts/AppContext.tsx`
- `artifacts/viper-studio/lib/gameProfiles.ts`

Mobile now:

- fetches Forge target profile summaries
- lets the user pick a target profile on Home
- submits `targetProfileId` with new Forge jobs
- uses the selected profile's target platform
- creates an export-readiness check after job submission
- displays readiness status, missing requirements, and warnings

Mobile AppContext no longer injects the full long local game profile block into chat prompts. It now injects a small fallback target summary that points canonical target rules and export checks to Website/Forge.

Kept intentionally:

- local `GAME_PROFILES` remains for Settings display and fallback behavior
- existing settings-based target profile behavior remains functional
- no chat/project behavior was broadly removed

## Website UI Changes

Updated:

- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`
- `artifacts/landing-page/src/index.css`

Website/Forge now includes lightweight panels for:

- Target Profiles
- Export Readiness Checks

Texture/Material job submission can select a target profile and sends it with the Forge job payload.

The readiness panel can run a readiness check for a recent job and displays:

- status
- target profile
- blocked/not-blocked state
- missing requirements

## Guide Behavior

Aria path:

- mobile and Website/Forge now surface warnings that export checking belongs to Website/Forge
- mobile prompt context is now a short target summary instead of the full rule block

Gaius path:

- readiness checks report missing scale, material, preview, product, and source/license data
- readiness checks can report `not_ready`, `needs_review`, `ready_later`, `ready_for_export`, or `blocked`

## Test Results

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- Existing mobile tests: 60 passed, 0 failed
- Forge Phase 3D smoke test with temporary storage

Smoke test proved:

1. Listed target profiles.
2. Read `imvu_product`.
3. Created a job with `targetProfileId`.
4. Ran an initial readiness check.
5. Received `not_ready` with missing requirements.
6. Created product and preview metadata.
7. Attached preview/product to the job.
8. Approved product metadata.
9. Marked job ready for export later.
10. Ran readiness again.
11. Confirmed status changed to `ready_for_export`.

Smoke result:

`PHASE3D_TARGET_PROFILE_EXPORT_READINESS_SMOKE_OK`

## Risks

- Export Readiness is a checklist service only; it does not generate packages, files, manifests, meshes, or textures.
- Existing mobile `GAME_PROFILES` still exists for Settings and fallback display. Canonical rule ownership has moved to Website/Forge, but full removal should be gradual.
- Old jobs created before Phase 3D may not have an explicit `targetProfileId`; Forge infers one from `targetPlatform`.
- Readiness checks depend on product metadata quality. Weak metadata will correctly produce warnings or missing requirements.
- `skyrim` is marked deferred because no full Skyrim export path exists yet.
- Runtime startup remains light, but this does not change native bundle splitting behavior from Phase 2D.

## Recommended Phase 3E Next Step

Build a Forge Review Queue / Worker Dispatcher layer:

1. Collect generation requests, preview records, product cards, and readiness checks into one review queue.
2. Let Aria summarize creative intent and target warnings from Forge services.
3. Let Gaius summarize readiness blockers and practical next actions.
4. Add service-backed review notes without building full Export Forge yet.
5. Prepare DevStudio non-avatar product migration next, while keeping avatar/skin paths protected and untouched.

Do not build final exporters until Product Library, Preview Service, Target Profiles, and Readiness checks are stable.
