# VIPER PHASE 4B VEHICLE AND SPACECRAFT REVIEW ACTIONS REPORT

Date: 2026-06-14

Status: implemented and validated.

Copy button note: this report is available as the newest report on the Website/Forge Reports page, where the top `COPY LATEST REPORT` button can copy it directly.

## Mission

Phase 4B upgraded VehicleForge and SpacecraftForge from concept-only submission shells into usable concept-review workspaces.

No full editors were built.
No mesh generation was built.
No texture baking was built.
No Export Forge was built.
No Starfield package export was built.
No Shipyard integration was added.
No heavy mobile previews were added.
No legacy systems or protected assets were removed.

## Workspace Filtering Changes

VehicleForge and SpacecraftForge now scope their workspace surfaces to their own records.

Inside each active shell, the workspace filters:

- Product Library cards
- Generation Requests
- Preview records
- Review Queue items
- Export Readiness checks
- Asset Intake records
- Upload records

The surrounding dashboard panels also scope to VehicleForge or SpacecraftForge when one of those workspaces is active.

Browser check confirmed:

- VehicleForge excludes SpacecraftForge smoke records.
- SpacecraftForge excludes VehicleForge smoke records.
- Both shells show their own workspace products, review items, readiness checks, previews, assets, and uploads.

## Review Actions Added

Each concept workspace now has simple review action buttons for Product Library cards:

- approve concept result
- request revision
- archive concept result
- mark ready for later export
- run readiness check

These actions use existing services:

- Product Library revision actions
- Job Review Service
- Preview review state updates
- Export Readiness checks
- Guide Context recent actions

No duplicate review service was created.

Smoke test results:

| Action | Product | Preview | Job |
|---|---|---|---|
| approve | `approved` | `approved` | `approved` |
| request revision | `needs_revision` | `needs_revision` | `review` / `needs_revision` |
| archive | `archived` | `archived` | `review` / `needs_revision` |
| mark ready later | `approved` | `approved` | `approved`, `readyForExportLater: true` |

Smoke IDs:

- approve product: `product-f3806813`
- request revision product: `product-5905febb`
- archive product: `product-d66b2ce6`
- mark ready later product: `product-306af795`

## Reference Intake Changes

VehicleForge and SpacecraftForge now include a SAFE_PRODUCT reference intake entry point.

The intake form captures:

- reference title
- reference type
- product link
- reference URL
- reference notes

Reference intake uses existing services:

- Upload Storage
- Asset Intake
- Preview Service
- Product Library
- Review Queue

SpacecraftForge was added to the existing SAFE_PRODUCT workspace allow-list for Upload Storage and Asset Intake.

Allowed VehicleForge reference types:

- vehicle references
- wheel/tread references
- cockpit/cabin references
- cargo/tool/mount references
- material references

Allowed SpacecraftForge reference types:

- spacecraft references
- hull references
- cockpit references
- engine references
- landing gear references
- weapon mount references
- docking/module/room references
- material references

Still blocked by existing scanners:

- avatar uploads
- skin uploads
- body uploads
- face uploads
- hair uploads
- makeup uploads
- protected Aria/Gaius assets
- MakeHuman
- MPFB

Reference smoke result:

- upload: `upload-01c2fa00`
- asset intake: `asset-a88c1427`
- preview: `preview-6f0787cf`
- linked product: `product-306af795`
- scan status: `passed`
- source rights: `user_confirmed`

## Aria/Gaius Summary Changes

Each active concept workspace now includes lightweight guide summaries.

Aria workspace summary shows:

- creative intent
- selected class and role
- recent generation direction
- style/material direction
- next creative suggestion

Gaius workspace summary shows:

- readiness status
- missing metadata
- readiness blockers
- source/license warnings
- scan/upload issues
- next practical action

These summaries read existing Guide Context, Product, Preview, Upload, Review, and Export Readiness records. They do not load protected guide assets.

## Readiness Action Changes

Each workspace shell now includes a direct readiness action for products.

The action calls the existing Export Readiness service.

It does not create export files.

Smoke readiness results:

- VehicleForge readiness: `export-check-db45b15e`, status `ready_for_export`
- SpacecraftForge readiness: `export-check-fdd3d135`, status `ready_for_export`

These are readiness/checklist statuses only. Export Forge still does not exist.

## Product Structure Display

VehicleForge now displays:

- class
- role
- mobility type
- propulsion type
- passenger count
- cargo notes
- mount notes
- material notes
- scale summary

SpacecraftForge now displays:

- class
- role
- hull notes
- cockpit notes
- engine notes
- landing gear notes
- weapon mount notes
- docking notes
- room/module notes
- material notes
- scale summary

No heavy editing was added.

## Mobile Impact

Mobile remains lightweight.

No mobile vehicle editor was added.
No mobile spacecraft editor was added.
No ThreeViewer was added to Home.
No three-scripts startup import was added.
No AriaZoneChat startup import was added.
No Shipyard import was added to the mobile Home path.
No heavy preview system was added.

Mobile may continue consuming lightweight Forge summaries, product status, preview status, review status, and readiness warnings.

## What Stayed Untouched

Untouched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- DevStudio
- protected Aria assets
- protected Gaius assets
- MakeHuman
- MPFB
- public avatar generation
- public skin generation
- legacy routes
- existing API routes

## Validation

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- API build
- Existing mobile tests: 60 passed
- Forge HTTP smoke test
- Website browser check
- Mobile startup import check

Known warning:

- Existing Node module-type warning appears during mobile tests. It did not cause failures.

## Risks

- Reference intake currently stores a lightweight uploaded reference marker plus metadata; richer upload UI should remain Website-only and should continue through Upload Storage.
- Ready-for-export is still only readiness language. It must not be presented as actual Export Forge support.
- Archive action uses existing Product/Preview states and records a Job Review revision state because there is no separate archived job state.
- VehicleForge and SpacecraftForge can become too broad if Phase 4C attempts real editors before review and reference flows stabilize.

## Recommended Phase 4C Next Step

Build workspace-specific concept refinement loops.

Recommended Phase 4C scope:

1. Add a revision request form that creates a new Generation Request from the selected product and preview.
2. Let Aria turn revision notes into a cleaner generation prompt.
3. Let Gaius attach readiness blockers to the revision request.
4. Keep all outputs flowing through Generation Service, Preview Service, Product Library, Review Queue, and Export Readiness.
5. Keep mobile as requester/reviewer only.

Do not begin mesh generation, texture baking, Shipyard integration, heavy viewers, or Export Forge in Phase 4C.

## Success Condition

VehicleForge and SpacecraftForge are now usable concept-review workspaces.

They can submit, filter, review, revise, archive, attach references, and run readiness checks without becoming heavy editors.
