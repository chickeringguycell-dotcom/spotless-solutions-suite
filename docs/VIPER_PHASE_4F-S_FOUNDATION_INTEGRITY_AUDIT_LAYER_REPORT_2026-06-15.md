# VIPER PHASE 4F-S FOUNDATION INTEGRITY AND AUDIT LAYER REPORT

Date: 2026-06-15

Status: implementation complete, validation complete, feature work still paused.

Copy-ready note: this report is intentionally standalone so the Reports page can place the copy button directly above it.

## Mission

Run the Foundation Integrity fix recommended by the Viper Foundation Architecture Audit before continuing Phase 4F Structured Part Planning.

No Structured Part Planning feature work was continued. No heavy editors, mesh generation, texture baking, Export Forge, Shipyard integration, or heavy viewers were added.

No legacy systems were deleted. No protected assets were moved.

## Source Of Truth

- `VIPER_FOUNDATION_ARCHITECTURE_AUDIT_2026-06-15.md`
- `VIPER_BUILD_TOOLCHAIN_AND_SERVER_STABILITY_REPORT_2026-06-15.md`

## What Changed

This phase added a foundation integrity layer and tightened the modern Forge architecture around it.

Changed areas:

- Forge relationship integrity validator
- Forge integrity API
- workspace-scoped summary support
- high-risk service validation hooks
- GuidePanel fallback behavior
- placeholder/deferred/internal workspace job guards
- mobile Vehicles vs Spacecraft routing
- readiness wording safety
- reusable phase-report audit checklist template

## Relationship Validator Changes

Added:

- `artifacts/api-server/src/lib/forge/integrityService.ts`

The validator checks links between:

- Product Library cards
- previews
- jobs
- generation requests
- uploads
- asset intake records
- candidate/reusable asset lane state
- concept revision requests
- concept packages
- structured part plans
- export readiness checks
- guide contexts
- target profiles

It verifies:

- referenced ids exist
- linked records stay in the same workspace when required
- shared assets are explicitly compatible
- blocked uploads do not enter products
- public-safe products do not use internal-only assets
- internal-only assets remain internal-only
- protected/avatar/skin/MakeHuman/MPFB references do not enter SAFE_PRODUCT flows
- package/product/preview/workspace relationships remain consistent

The validator returns:

- overall status
- issue count
- warnings
- errors
- blocked issues
- affected service
- affected id
- related service
- related id
- workspace id
- suggested fix
- severity

Severity values:

- info
- warning
- error
- blocked

Status values:

- ok
- warning
- error
- blocked

Duplicate issue reporting was deduped so the same underlying bad link does not appear twice through direct product links and reusable-asset relationship metadata.

## Integrity API Changes

Added API endpoints:

- `GET /api/forge/integrity`
- `POST /api/forge/integrity/check`

Supported filters:

- `workspaceId`
- `service`
- `id`

Live validation result at audit time:

| Scope | Status | Issues | Warnings | Errors | Blocked |
|---|---:|---:|---:|---:|---:|
| Global Forge store | blocked | 6 | 0 | 1 | 5 |
| VehicleForge | blocked | 3 | 0 | 0 | 3 |
| SpacecraftForge | ok | 0 | 0 | 0 | 0 |

The blocked/error issues are existing stored-data issues, not new compile failures:

- several current Product Library records link blocked upload records
- one public-safe product links an internal-only upload

The validator now correctly prevents those records from being approved, packaged, or advanced into structured planning until the links are cleaned or replaced.

## High-Risk Flow Hooks

The validator is now used in high-risk paths:

| Flow | Behavior |
|---|---|
| Concept package assembly | Blocks if product/package foundation links have error or blocked issues. Adds integrity warnings to Gaius package notes. |
| Structured part planning | Blocks if concept package foundation links have error or blocked issues. Adds integrity warnings to Gaius planning notes. |
| Reusable asset linking | Blocks if existing product integrity has error or blocked issues before adding another reusable asset. |
| Export readiness checks | Runs in warning/report mode and blocks future-export readiness when integrity errors/blockers exist. |
| Product approval action | Blocks approval when product integrity has error or blocked issues. |
| Job approval / ready-later action | Blocks approval when job integrity has error or blocked issues. |

Deferred enforcement:

- ordinary product metadata updates remain permissive
- preview updates remain permissive
- upload review actions remain permissive

Reason:

Those paths may be needed to repair bad data. Enforcement is strongest only where the workflow would bless or advance a record.

## Workspace Scoping Changes

Added workspace-scoped summary support:

- `GET /api/forge/summary?workspaceId=VehicleForge`
- `GET /api/forge/summary?workspaceId=SpacecraftForge`

Scoped summary returns the same summary shape with:

- filtered jobs
- filtered products
- filtered previews
- filtered uploads
- filtered asset intake
- filtered generation requests
- filtered concept revisions
- filtered concept packages
- filtered structured part plans
- filtered worker dispatch items
- filtered review queue
- filtered export readiness checks
- `workspaceScope` metadata

Validation:

VehicleForge scoped summary returned:

- scoped: true
- products: 4
- previews: 4
- review queue items: 12
- cross-workspace records: 0

SpacecraftForge scoped summary returned:

- scoped: true
- products: 0
- previews: 0
- review queue items: 0
- integrity issues: 0

The Website Forge shell now fetches a scoped summary for VehicleForge and SpacecraftForge active slices.

## GuidePanel Fallback Changes

Fixed GuidePanel fallback cross-contamination.

Before:

- active workspace could fall back to the global latest job
- active workspace could fall back to the global latest generation request
- active workspace could fall back to the global latest readiness check

Now:

- active workspace only shows records from that workspace
- if no active workspace records exist, it says:

```text
No active workspace records yet. Create or submit a concept to begin.
```

This prevents inactive workspace slices from inheriting unrelated global state.

## Capability Guard Changes

Job Queue now guards workspace capability state.

Rejected for new jobs:

- retired workspaces
- internal-protected workspaces
- deferred workspaces
- placeholder workspaces
- disabled workspaces
- internal-only workspaces
- metadata-only workspaces

Confirmed behavior:

- `WeaponForge` now rejects a new job because it is still a placeholder.
- `FurnitureForge` now rejects a new job because it is metadata-only right now.
- `VehicleForge` and `SpacecraftForge` remain active concept workspaces.
- `ExportForge` remains not enabled as a real export builder.

This closes the placeholder workspace capability gap without deleting any placeholder routes or registry entries.

## Mobile Routing Changes

Mobile now has a lightweight subtype selector inside:

```text
Vehicles and Spacecraft
```

Options:

- Vehicle
- Spacecraft

Routing:

| Mobile subtype | Workspace |
|---|---|
| Vehicle | VehicleForge |
| Spacecraft | SpacecraftForge |

The subtype selector changes:

- workspace id
- requested output
- includes list
- placeholder prompt
- submitted job constraints
- readiness metadata

It does not add:

- mobile editor
- heavy preview
- Shipyard
- ThreeViewer
- mesh tools
- export tools

Mobile still remains guide, idea, references, job submission, preview, review, approve, and revise only.

## Readiness Wording Changes

The enum remains unchanged for compatibility:

```text
ready_for_export
```

Display wording was changed to avoid implying Export Forge exists:

- Website displays `ready for future export`
- Website panel title is `Future Export Readiness`
- Mobile displays `Future export readiness`
- Review Queue titles say `Future export readiness`
- readiness next action now says no export file or package is generated yet

This keeps readiness as a checklist/status layer, not an export builder.

## Audit Checklist Rule

Added reusable checklist:

- `docs/VIPER_PHASE_REPORT_AUDIT_CHECKLIST_TEMPLATE.md`

Future significant phases must include:

- What changed
- What stayed untouched
- validation results
- audit findings
- mobile impact
- protected asset check
- legacy system check
- workspace validation
- failures
- remaining risks
- recommended next phase

A phase is not complete until:

1. Phase report exists.
2. Audit section exists.
3. Validation results exist.
4. Failures are documented.
5. Recommended next phase exists.

## What Stayed Untouched

Untouched:

- Workshop
- Shipyard
- ThreeViewer
- Viewer
- IMVU Creator
- DevStudio legacy systems
- MakeHuman
- MPFB
- protected Aria assets
- protected Gaius assets
- existing legacy routes
- ThreeViewer internals
- three-scripts internals
- Export Forge implementation
- full Structured Part Planning implementation

## Validation Results

| Check | Result | Notes |
|---|---|---|
| API typecheck | PASS | No errors after moving one guard to the correct review-action path. |
| Website typecheck | PASS | No errors. |
| Mobile typecheck | PASS | No errors. |
| Existing mobile tests | PASS | 60 tests passed. Existing Node module-format warnings only. |
| API build | PASS | `node artifacts\api-server\build.mjs` completed. |
| Website build | PASS | `corepack pnpm --filter @workspace/landing-page run build` completed. |
| API health check | PASS | `http://127.0.0.1:18082/api/healthz` returned 200. |
| Website health check | PASS | `http://127.0.0.1:19006/landing-page/` returned 200. |
| Website browser check | PASS | Forge shell opened. VehicleForge and SpacecraftForge visible. Future Export Readiness visible. No browser console errors. |
| Integrity API check | PASS WITH FINDINGS | Endpoint live. Global store reports 6 existing integrity issues. |
| Workspace-scoped summary check | PASS | VehicleForge and SpacecraftForge scoped summaries return only their own records. |
| Placeholder / metadata-only guard check | PASS | WeaponForge rejects new job with clear placeholder message. FurnitureForge rejects new job with clear metadata-only message. |
| Mobile startup validation | PASS | Home has no heavy imports for ThreeViewer, three-scripts, AriaZoneChat, usePrefetch, MakeHuman, MPFB, ViperCreatorShell, or DressingRoom. |
| Protected asset validation | PASS | No protected Aria/Gaius assets moved. Home startup does not load protected assets. |
| Legacy system validation | PASS | `(legacy)` route remains registered and Advanced/Legacy access remains explicit. |
| Workspace validation | PASS WITH DATA FINDINGS | Workspace scoping works. Current data contains blocked product-upload links that must be cleaned before affected records can advance. |

## Audit Findings

Strengths:

- Modern Forge now has a reusable integrity layer.
- High-risk advancement paths are protected.
- VehicleForge and SpacecraftForge slices can request scoped summary data.
- GuidePanel no longer borrows global records.
- Mobile can route spacecraft jobs to SpacecraftForge without becoming heavy.
- Placeholder workspaces no longer silently accept real jobs.
- Readiness wording no longer implies final export support.
- Future phase reports have a reusable audit checklist.

Weaknesses still present:

- The global dashboard still uses global summary counts for its control-room view.
- Existing stored data contains unsafe links.
- Review Queue is still derived rather than a durable review-event ledger.
- Flat JSON persistence remains a future scaling limit.
- Metadata schemas remain flexible.
- Placeholder mobile categories may now show a clear rejection until those workspaces become active.

## Mobile Impact

Mobile impact is intentionally light.

Added:

- Vehicle vs Spacecraft subtype selector
- SpacecraftForge routing for spacecraft jobs
- future-export wording safety

Not added:

- heavy editor
- mesh tools
- export tools
- Shipyard
- ThreeViewer
- large asset browser
- protected avatar loading

Mobile remains compliant with the companion-first design:

```text
Choose your guide.
Choose what you want to build.
Describe it.
Review it.
Approve it.
```

## Protected Asset Check

Passed.

- No protected assets moved.
- No protected Aria/Gaius assets loaded by Home startup.
- No MakeHuman or MPFB reactivation.
- Public avatar generation and public skin generation remain excluded.
- Upload/integrity rules explicitly block protected/avatar/skin/MakeHuman/MPFB records from SAFE_PRODUCT flow.

## Legacy System Check

Passed.

- Workshop remains untouched.
- Shipyard remains untouched.
- ThreeViewer remains untouched.
- Viewer remains untouched.
- IMVU Creator remains untouched.
- DevStudio legacy remains untouched.
- Advanced/Legacy access remains explicit.

## Workspace Validation

Passed with data findings.

Confirmed:

- VehicleForge remains active and concept-only.
- SpacecraftForge remains active and concept-only.
- SpacecraftForge scoped integrity is clean.
- VehicleForge scoped summary has no cross-workspace records.
- Placeholder workspaces now guard new job submissions.

Data findings:

- VehicleForge has 3 blocked product-upload integrity issues in current stored data.
- Global Forge store has 6 total existing integrity issues.
- These records are now blocked from approval/package/planning advancement until repaired.

## Remaining Risks

- Existing unsafe prototype/smoke records need cleanup.
- Product Library should eventually expose a repair workflow for bad links instead of requiring manual data work.
- Review Queue still needs durable event history before production-scale review.
- Workspace-scoped summary is implemented, but global dashboard panels still serve as a control-room view.
- Flat JSON persistence remains a future brick wall.
- Capability guards may require UI messaging so mobile users understand placeholder categories are planned but not active.

## Whether Phase 4F Can Safely Resume

Phase 4F can safely resume at the source-code architecture level.

However, it should not advance affected existing Product Library records into concept packages or structured part plans until current integrity issues are cleaned or fresh clean records are created.

Practical answer:

- Safe to resume Phase 4F implementation after this report.
- Safe to create new clean VehicleForge/SpacecraftForge concepts.
- Not safe to approve/package/plan records that the integrity API marks blocked.
- Best next step is a small integrity data cleanup before continuing deeper Structured Part Planning work.

## Recommended Next Phase

Recommended next phase:

VIPER PHASE 4F-R FOUNDATION DATA REMEDIATION AND STRUCTURED PART RESUME

Goals:

1. Add or run a safe repair path for current blocked product-upload links.
2. Keep repair actions scoped to modern Forge data only.
3. Do not delete legacy systems.
4. Do not move protected assets.
5. Confirm integrity status improves for affected workspaces.
6. Resume Phase 4F Structured Part Planning only on clean products/concept packages.

Do not build:

- heavy editors
- mesh generation
- texture baking
- Export Forge
- Shipyard integration
- public avatar generation
- public skin generation
- MakeHuman
- MPFB

## Final Verdict

Phase 4F-S succeeded.

The modern Forge foundation now has stronger integrity checks, safer workspace scoping, no cross-workspace guide fallback, clearer placeholder workspace behavior, mobile Vehicle vs Spacecraft routing, future-safe readiness wording, and a permanent audit checklist.

The codebase is stable.

The next thing to fix is data cleanliness: current stored prototype records include blocked/internal-only asset links that the new validator correctly refuses to advance.
