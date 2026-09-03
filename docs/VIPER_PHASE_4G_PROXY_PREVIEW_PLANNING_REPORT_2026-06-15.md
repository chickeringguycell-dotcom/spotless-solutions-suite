# VIPER PHASE 4G PROXY PREVIEW PLANNING REPORT

Date: 2026-06-15

Status: implemented, runtime-validated, browser-validated, and integrity-clean.

Copy-ready note: open the Reports page and use the top `COPY THIS REPORT` button on this report.

## Mission

Resume Phase 4G from the validated crash-recovery checkpoint and finish runtime validation, smoke testing, browser validation, integrity validation, and final documentation.

No new feature scope was added during the resume pass.

No heavy editors were built.

No mesh generation was built.

No texture baking was built.

No Export Forge, Shipyard integration, ThreeViewer integration, or heavy viewer was added.

No legacy systems were deleted.

No protected assets were moved.

## Source Of Truth

- `VIPER_PHASE_4G_CRASH_RECOVERY_REPORT_2026-06-15.md`
- `VIPER_PHASE_REPORT_AUDIT_CHECKLIST_TEMPLATE.md`

## Summary

Phase 4G adds metadata-only Proxy Preview Planning for VehicleForge and SpacecraftForge.

The new flow is:

```text
Approved Structured Part Plan
  -> Proxy Preview Plan
  -> Proxy Sheet List
  -> Aria Visual Planning Summary
  -> Gaius Visual Warnings
  -> Review Queue Item
  -> Product Library metadata
  -> Foundation Integrity validation
```

Proxy Preview Planning prepares visual review sheets only. It does not create images, meshes, UVs, baked textures, collision, sockets, pivots, exports, Shipyard records, ThreeViewer scenes, or heavy viewer data.

## Proxy Preview Models

Added `ForgeProxyPreviewPlan`.

Fields:

- `id`
- `proxyPreviewId`
- `workspaceId`
- `productId`
- `conceptPackageId`
- `structuredPartPlanId`
- `targetProfileId`
- `previewStatus`
- `proxySheets`
- `ariaVisualSummary`
- `gaiusVisualWarnings`
- `visualInspectionHooks`
- `createdAt`
- `updatedAt`

Statuses:

- `draft`
- `generated`
- `needs_revision`
- `approved`
- `archived`

Added `ForgeProxyPreviewSheet`.

Fields:

- `id`
- `sheetType`
- `label`
- `purpose`
- `plannedElements`
- `sourcePartTypes`
- `visualChecks`

Storage:

- `data/forge/proxy-preview-plans.json`

## Proxy Preview APIs

Added:

- `GET /api/forge/proxy-preview-plans`
- `POST /api/forge/proxy-preview-plans`
- `GET /api/forge/proxy-preview-plans/:proxyPreviewId`
- `POST /api/forge/proxy-preview-plans/:proxyPreviewId/actions`

Supported actions:

- `approve`
- `approve_plan`
- `request_revision`
- `archive`
- `archive_plan`
- `reopen`
- `generate`

Updated:

- `GET /api/forge/summary`
- `GET /api/forge/review-queue`
- `GET /api/forge/integrity`

## Source Guards

Proxy Preview Planning requires:

- VehicleForge or SpacecraftForge workspace
- existing Product Library card
- existing approved concept package
- existing approved structured part plan
- existing target profile
- matching workspace ownership across product, concept package, and structured part plan
- clean Foundation Integrity for product, concept package, and structured part plan

The service rejects:

- unapproved structured part plans
- archived structured part plans
- archived products
- archived concept packages
- missing target profiles
- failed Foundation Integrity sources

## Vehicle Proxy Results

VehicleForge source:

- Product: `product-99369d9d`
- Concept package: `concept-package-390e6a94`
- Structured part plan: `part-plan-e662fef4`
- Structured part plan status: `approved`
- Target profile: `viper_internal`

Generated proxy preview plan:

- Proxy preview plan: `proxy-preview-83fa0e20`
- Initial status: `generated`
- Final smoke-test status: `approved`
- Sheet count: `8`
- Aria visual summary count: `4`
- Gaius visual warning count: `11`

Vehicle proxy sheets:

- Front View
- Rear View
- Left Side View
- Right Side View
- Top View
- Scale Silhouette
- Part Relationship Overlay
- Material Summary Card

Revision/action smoke test:

- `request_revision` action succeeded.
- `approve` action succeeded after revision action.
- Final Review Queue state is `approved`.

## Spacecraft Proxy Results

SpacecraftForge source:

- Product: `product-1d4fe63a`
- Concept package: `concept-package-25097943`
- Structured part plan: `part-plan-b807e7b0`
- Structured part plan status: `needs_revision`
- Target profile: `starfield`

Generation result:

- No proxy preview plan was generated.
- API returned `400`.
- Exact blocker: `Proxy preview planning requires an approved structured part plan.`

This blocker is correct. The resume pass did not bypass integrity or approve the SpacecraftForge structured part plan automatically.

SpacecraftForge UI correctly shows:

- Proxy Preview Plan panel visible
- Status: not generated
- Source plan: `part-plan-b807e7b0`
- Source plan status: `needs_revision`
- Proxy Sheets panel visible
- No proxy preview plan generated yet

## Aria Visual Planning

Aria now summarizes visual direction for proxy planning.

VehicleForge Aria output includes:

- approved concept intent
- visual direction for the proxy sheets
- material direction
- next creative review step

SpacecraftForge Aria fallback correctly states that an approved structured part plan is needed before visual sheets can be generated.

## Gaius Visual Planning

Gaius now contributes:

- target/profile warnings
- missing reusable asset notes
- visual planning limitations
- no-heavy-system warnings
- scale and practical inspection notes

VehicleForge Gaius warnings were generated and shown in the Proxy Preview panel.

SpacecraftForge Gaius fallback correctly states that proxy plans stay metadata-only and prepare inspection notes without loading a heavy viewer.

## Review Queue Integration

Added Review Queue item type:

- `proxy_preview_plan`

Validated Review Queue result:

- Proxy review item: `review-proxy-preview-plan-proxy-preview-83fa0e20`
- Source: `proxy-preview-83fa0e20`
- Item type: `proxy_preview_plan`
- State: `approved`
- Workspace: `VehicleForge`
- Product: `product-99369d9d`
- Target profile: `viper_internal`

Review Queue proxy counts:

- Pending: `0`
- Approved: `1`
- Needs revision: `0`
- Archived: `0`
- Type count `proxy_preview_plan`: `1`

## Forge Summary Integration

Validated global summary:

- `proxyPreviewPlans`: `1`

Validated VehicleForge-scoped summary:

- `proxyPreviewPlans`: `1`

Validated Review Queue:

- proxy preview plan appears in global Review Queue
- proxy preview plan appears in VehicleForge workspace review list
- proxy preview plan carries status, source plan, sheet count, and Gaius warning reasons

## Browser Validation

Browser URL:

- `http://localhost:19006/landing-page/forge`

VehicleForge browser validation:

- Proxy Preview Plan panel visible
- Proxy Sheets panel visible
- `proxy-preview-83fa0e20` visible
- Aria visual planning visible
- Gaius visual checks visible
- 8 planned sheets visible
- Inspection hooks visible

SpacecraftForge browser validation:

- Proxy Preview Plan panel visible
- Proxy Sheets panel visible
- source plan `part-plan-b807e7b0` visible
- plan status `needs_revision` visible
- no generated proxy plan shown
- no console errors found

## Integrity Validation

Global integrity:

- Status: `ok`
- Issue count: `2`
- Warnings: `0`
- Errors: `0`
- Blocked: `0`

VehicleForge integrity:

- Status: `ok`
- Issue count: `1`
- Warnings: `0`
- Errors: `0`
- Blocked: `0`

SpacecraftForge integrity:

- Status: `ok`
- Issue count: `1`
- Warnings: `0`
- Errors: `0`
- Blocked: `0`

Existing informational notes only:

- VehicleForge readiness `ready_for_export` means ready for a future export path; Export Forge is not built.
- SpacecraftForge readiness `ready_for_export` means ready for a future export path; Export Forge is not built.

Phase 4G introduced no warning, error, or blocked integrity issues.

## Runtime Validation

Safe server helper used:

- `scripts\viper-local-server-stability.ps1`

Safe restart:

- Stopped exact Website listener on port `19006`.
- Stopped exact API listener on port `18082`.
- Restarted API and Website with the safe helper.

Health results:

- API: `http://127.0.0.1:18082/api/healthz` returned `200`
- Website: `http://127.0.0.1:19006/landing-page/` returned `200`

No broad process-kill commands were used.

## Validation Results

| Check | Result | Notes |
|---|---|---|
| API typecheck | Passed | Completed during crash recovery checkpoint. |
| Website typecheck | Passed | Completed during crash recovery checkpoint. |
| Mobile typecheck | Passed | Completed during crash recovery checkpoint. |
| Existing tests | Passed | Mobile tests: 60 passed, 0 failed. Existing module-type warnings only. |
| API build | Passed | `dist/index.mjs` and worker files built successfully. |
| Website build | Passed | Vite build completed; 1743 modules transformed. |
| API health check | Passed | Safe helper health returned 200. |
| Website browser check | Passed | Forge page loaded and panels validated in browser. |
| Mobile startup validation | Passed by source impact | No mobile startup files changed in Phase 4G resume; previous mobile typecheck/tests passed. |
| Protected asset validation | Passed | No protected assets moved or loaded. |
| Legacy system validation | Passed | Workshop, Shipyard, ThreeViewer, Viewer, IMVU Creator, and DevStudio were not modified. |
| Workspace validation | Passed | VehicleForge proxy record scoped to VehicleForge; SpacecraftForge correctly blocked until source plan approval. |
| Proxy Preview validation | Passed | Vehicle proxy plan created, reviewed, approved, summarized, queued, visible, and integrity-clean. |

## Post-Build Audit

## What Changed

- Added Proxy Preview plan model.
- Added Proxy Preview sheet model.
- Added Proxy Preview service.
- Added Proxy Preview APIs.
- Added Proxy Preview Review Queue integration.
- Added Proxy Preview integrity checks.
- Added Proxy Preview summary counts and status panel.
- Added Website/Forge proxy panels for VehicleForge and SpacecraftForge.
- Added Website client helpers for generate/action proxy preview calls.
- Added report viewer `COPY THIS REPORT` support before final report delivery.

## What Stayed Untouched

- Protected Aria assets were not moved.
- Protected Gaius assets were not moved.
- Workshop was not removed.
- Shipyard was not removed.
- ThreeViewer was not removed.
- Viewer was not removed.
- IMVU Creator was not removed.
- DevStudio legacy systems were not rewritten.
- MakeHuman and MPFB were not reactivated.
- Export Forge was not built.
- Mesh generation was not built.
- Texture baking was not built.
- Heavy viewers were not added.

## Audit Findings

Strengths:

- Proxy Preview Planning correctly depends on approved structured part plans.
- SpacecraftForge correctly refuses proxy generation while its structured part plan is `needs_revision`.
- Review Queue sees proxy preview plans as first-class review items.
- Foundation Integrity now validates proxy preview relationships.
- Browser validation confirms panels are visible without heavy viewer code.

Weaknesses:

- Proxy plans currently have action status but no dedicated revision-history model of their own.
- SpacecraftForge proxy generation remains blocked until its structured part plan is approved or revised.
- Proxy sheets are metadata-only and do not yet produce actual visual image artifacts.

## Mobile Impact

Mobile remains lightweight.

No mobile feature scope was added.

No mobile startup route was changed.

No heavy mobile viewer, mesh tool, texture baker, export tool, Shipyard behavior, or large asset browser was added.

Mobile may later consume proxy status, sheet count, and review status as lightweight metadata only.

## Protected Asset Check

Passed.

No Aria protected assets were moved.

No Gaius protected assets were moved.

No public avatar generation was added.

No public skin generation was added.

No MakeHuman or MPFB path was activated.

Proxy planning remains in SAFE_PRODUCT VehicleForge and SpacecraftForge lanes.

## Legacy System Check

Passed.

The following legacy systems were not deleted, removed, or rewritten:

- Workshop
- Shipyard
- ThreeViewer
- Viewer
- IMVU Creator
- DevStudio legacy systems

## Workspace Validation

Passed.

VehicleForge:

- Active proxy preview plan belongs to VehicleForge.
- Product, concept package, structured part plan, target profile, and proxy preview plan relationships are clean.
- Review Queue contains the VehicleForge proxy preview plan.

SpacecraftForge:

- No proxy preview plan was created because source structured part plan is `needs_revision`.
- Workspace remains visible and stable.
- Integrity remains `ok`.

Turntable compliance:

- Only selected workspace slice becomes active in the browser workflow.
- VehicleForge and SpacecraftForge panels remain scoped to their own records.

## Failures

No final validation failures remain.

Documented expected blocker:

- SpacecraftForge proxy generation returned `400` because the structured part plan is `needs_revision`.
- This is correct behavior and was not bypassed.

## Remaining Risks

- Proxy plans are metadata-only and do not yet create actual proxy images.
- Proxy plan action history is currently stored through Product Library metadata/revision notes, not a dedicated proxy-plan history list.
- SpacecraftForge must complete its structured part plan revision/approval before proxy preview generation can be validated end-to-end there.
- Future visual inspection hooks will need image comparison and mismatch detection services, but those were intentionally not built in Phase 4G.

## Recommended Next Phase

Recommended Phase 4H:

`VIPER PHASE 4H PROXY IMAGE REQUEST AND VISUAL INSPECTION PREP`

Safest next step:

- Add a metadata-only proxy image request contract that can request flat visual artifacts from the existing Generation Service and attach them to Proxy Preview Plans.
- Keep this Website/Forge-only.
- Do not add ThreeViewer, mesh generation, texture baking, Shipyard integration, or Export Forge.
- Require approved proxy preview plans before any future proxy image request can be generated.

## Success Condition

Phase 4G is complete.

Proxy Preview Planning is validated, visible in Forge, present in Review Queue, scoped to VehicleForge, guarded for SpacecraftForge until approval, integrity-clean, and documented.
