# VIPER FOUNDATION ARCHITECTURE AUDIT

Date: 2026-06-15

Status: structural audit complete. New feature development remains paused until the next phase is authorized.

Copy-ready note: this report is intentionally standalone so the Reports page can place the copy button directly above it.

## Mission

Audit the modern Website/Forge foundation before continuing Phase 4F, Phase 4G, or any future heavy workspace work.

This is a structural audit, not a crash audit and not a new implementation phase.

No legacy systems were deleted. Workshop, Shipyard, ThreeViewer, Viewer, IMVU Creator, DevStudio legacy systems, MakeHuman, MPFB, protected Aria assets, and protected Gaius assets were not redesigned, moved, removed, or reactivated.

## Permanent Viper Engineering Rule

From this point forward, any phase that creates or modifies services, APIs, workspace shells, workflows, planning systems, review systems, package systems, asset systems, workspace integrations, or dashboard panels must include a post-build audit before the phase is considered complete.

Minimum audit:

| Required check | Required result |
|---|---|
| API typecheck | Pass or documented failure |
| Website typecheck | Pass or documented failure |
| Mobile typecheck | Pass or documented failure |
| Existing tests | Pass or documented failure |
| Build validation | Pass or documented failure |
| Browser validation | Pass or documented failure |
| Mobile startup validation | Pass or documented failure |
| Protected asset validation | Pass or documented failure |
| Legacy system validation | Pass or documented failure |
| Workspace validation | Pass or documented failure |

A phase is not complete until:

1. The phase report exists.
2. The report includes an audit section.
3. Validation results are recorded.
4. Failures are documented.
5. The recommended next phase is stated.

## Scope

Audited modern Forge architecture:

- Workspace Registry
- Product Library
- Job Queue
- Generation Service
- Preview Service
- Review Queue
- Asset Intake
- Upload Storage
- Asset Review Scanner
- Candidate Review
- Asset Library Readiness
- Concept Revision Requests
- Concept Packages
- VehicleForge
- SpacecraftForge
- Target Profiles
- Export Readiness
- Guide Context Service
- Mobile startup path
- Turntable / Workspace Selection
- Forge Dashboard

Excluded from redesign:

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

These were inspected only for integration and startup risk.

## Current Foundation Snapshot

Live Forge summary at the time of audit:

| Area | Count |
|---|---:|
| Workspaces | 12 |
| Product Library cards | 11 |
| Jobs | 0 |
| Previews | 10 |
| Uploads | 9 |
| Asset Intake records | 10 |
| Generation Requests | 0 |
| Concept Revision Requests | 0 |
| Concept Packages | 0 |
| Structured Part Plans | 0 |
| Review Queue items | 31 |
| Target Profiles | 5 |
| Export Readiness checks | 0 |
| Guide Contexts | 0 |

Review Queue state:

| State | Count |
|---|---:|
| pending | 15 |
| approved | 16 |
| needs_revision | 0 |
| archived | 0 |

Important interpretation:

- The foundation services exist and compile.
- Product, preview, upload, asset intake, and candidate-review records exist.
- Jobs, generation requests, readiness checks, concept revisions, concept packages, structured part plans, and guide contexts are currently empty in persisted data.
- Several advanced service chains are implemented but not represented by active durable records at audit time.

## Strengths

- Website/Forge is correctly becoming the master platform for heavy work.
- Mobile startup is guide-first and does not mount Workshop, ThreeViewer, AriaZoneChat, or usePrefetch from Home.
- Workspace Registry is explicit and contains active VehicleForge and SpacecraftForge entries.
- VehicleForge and SpacecraftForge are concept-only shells and do not build heavy editors, mesh generation, texture baking, Shipyard integration, or Export Forge.
- Product Library is now the canonical product ownership direction for SAFE_PRODUCT outputs.
- Preview Service, Generation Service, Product Library, Review Queue, Target Profiles, and Export Readiness are aligned around a shared service backbone.
- Asset Intake and Upload Storage have strong first-pass safety controls: MIME checks, size limit, blocked extensions, protected-term blocking, source-rights fields, and lane metadata.
- Review Queue aggregates modern Forge service state into one review surface.
- Target Profiles and Export Readiness centralize target/game/export rule logic instead of leaving everything in individual workspaces.
- The build and server validation workflow is stable after the previous toolchain repair.

## Weaknesses

- The Forge summary endpoint loads all modern Forge records at once. This makes the Website dashboard useful, but it is not a pure Turntable pattern where only the selected slice becomes active.
- ForgePage scopes VehicleForge and SpacecraftForge panels, but most dashboard panels fall back to global summary data when the active workspace is not VehicleForge or SpacecraftForge.
- The guide panel can fall back to global latest job, generation, or readiness records when the active workspace has none. That creates workspace cross-contamination risk.
- Mobile has one category called Vehicles and Spacecraft, but that category currently routes to VehicleForge only. SpacecraftForge is active on Website/Forge, but mobile does not yet provide a simple spacecraft subtype path.
- Mobile Home fetches target profiles on startup before guide and workspace selection. This is lightweight metadata, but it still preloads rule data before a slice is selected.
- The global mobile AppContext still imports and owns old game-profile and viewer-context prompt/rule material. This is not a heavy editor mount, but it conflicts with the Website-owned Target Profile and Export Readiness direction.
- Product Library and related review actions can store linked ids without consistently validating that the referenced preview, job, generation request, upload, or asset exists and belongs to the same workspace.
- Review Queue is derived from service records rather than a persisted workflow/audit log. That is good for the current prototype, but it can become fragile once review decisions need a strict historical trail.
- Asset Intake, Upload Review, Asset Library Readiness, and Candidate Review overlap in the Review Queue. The UI can report them together, but the workflow lanes need clearer separation before larger asset libraries arrive.
- Export Readiness can produce a ready_for_export status even though Export Forge does not exist yet. The wording risks implying a capability that is still future work.
- Worker Dispatcher is a lightweight status layer only. It does not yet have leases, retries, idempotency, or real background processing.

## Risks

### Duplicated Systems

- Legacy /api/imagine paths and the Forge Generation Service both exist. The bridge is acceptable for transition, but future generation must converge on Forge Generation Request records.
- Mobile AppContext still carries target/game profile prompt logic while Forge Target Profiles also exist. This is the biggest rule-ownership drift.
- Review state exists across Product Library, Preview Service, Job Queue, Concept Packages, Asset Intake, Uploads, and Candidate Review. The Review Queue aggregates this, but there is no single persisted review event ledger yet.

### Overlapping Services

- Asset Intake, Upload Storage, Asset Review Scanner, Asset Library Readiness, and Candidate Review are correctly separated by intent, but their UI/review surfaces overlap. The lanes are understandable to the code, but not yet hard enough as policy boundaries.
- Concept Revision Requests, Concept Packages, and Structured Part Plans are separate layers, but they are all currently zero-record services. Their relationship boundaries should be validated with real smoke data before more planning layers are added.

### Unused Or Underused Services

- Jobs, Generation Requests, Export Readiness, Guide Contexts, Concept Revisions, Concept Packages, and Structured Part Plans are implemented but empty in persisted summary data at audit time.
- This does not mean they are broken. It means the foundation should add stronger smoke coverage before future work depends on them.

### Missing Relationships

- Product Library can link previews, jobs, uploads, intake assets, and generation history, but it does not yet enforce referential integrity broadly.
- Readiness checks may reference job/product/preview metadata, but the system needs a shared relationship validator before package assembly and structured part planning become central.
- Mobile guide selection is local until a job is submitted. Guide Context Service does not yet receive every mobile guide-first session.

### Future Scalability Risks

- Forge persistence is still file/JSON-oriented. That is fine for the prototype, but it will become a brick wall for multi-user work, large asset libraries, pagination, transactions, indexing, and background workers.
- The Forge summary endpoint returns broad dashboard data. As records grow, a workspace-scoped summary endpoint will be needed.
- Review Queue can grow quickly because it aggregates products, previews, uploads, intake records, readiness checks, packages, revisions, and plans.

### Future Export Risks

- Export Readiness is useful, but Export Forge does not exist. The UI and status wording must avoid implying final export capability.
- Target-specific readiness, especially Starfield-related planning, must remain labeled as planning/readiness guidance only until a real export path exists.
- Readiness currently expects job linkage. Product-only or intake-only concept records may need a separate readiness mode.

### Product Library Risks

- Product Library is becoming the right canonical owner, but it needs stricter relationship validation.
- Product categories and workspace metadata are still flexible strings. That is useful early, but it can drift without normalized taxonomies.
- Existing product data is mostly prototype/smoke data. Real end-to-end product histories are still thin.

### Review Queue Risks

- The Review Queue shows the state well, but it is not yet a durable decision log.
- Candidate review, upload review, and intake review can blur together.
- Review Queue needs pagination, filters, archive behavior, and event history before heavy production use.

### Mobile Weight Risks

- Home remains light, but AppContext still imports old target/game profile logic and viewer-context material globally.
- Native bundle splitting is still limited by the single eager Android bundle behavior found in Phase 2D.
- Projects and legacy routes remain available, which is intentional, but they must stay out of Home startup and primary flow.

### Workspace Isolation Risks

- VehicleForge and SpacecraftForge are well scoped inside their concept shell.
- The dashboard around them still loads and displays global service data in some contexts.
- GuidePanel fallback behavior should be tightened so an inactive workspace never inherits another workspace's latest job or readiness state.

### Asset Lane Separation Risks

- Public-safe, internal-only, and blocked lane metadata exists.
- Protected terms are blocked during upload, which is good.
- ClothingForge is allowed as a safe upload target for clothing concepts, but it needs stronger non-avatar policy before any clothing expansion.
- The scanner is a foundation scanner, not a full visual/content safety scanner.

### Readiness Model Weaknesses

- Readiness checks are strong for metadata completeness, but they can over-block product-only workflows that do not yet have a job.
- ready_for_export wording can overpromise before Export Forge exists.
- Workspace-specific readiness schemas should become more formal before heavy workspace implementation.

## Turntable Compliance

Core rule:

> Only the selected workspace slice should become active.

### Mobile

Status: mostly compliant.

Confirmed:

- App starts on Home.
- Guide-first startup is preserved.
- Aria and Gaius cards are lightweight UI.
- Only the selected guide continues into the mobile flow.
- Home does not import ThreeViewer.
- Home does not import three-scripts.
- Home does not import AriaZoneChat.
- Home does not use usePrefetch.
- Heavy legacy systems remain behind explicit Advanced/Legacy access.

Issues:

- Target profiles are fetched on Home startup before workspace selection.
- Vehicles and Spacecraft currently maps to VehicleForge only.
- AppContext still carries global rule/prompt systems that should continue migrating to Website/Forge services.

### Website/Forge

Status: partially compliant.

Confirmed:

- Turntable workspace selection exists.
- VehicleForge and SpacecraftForge shells activate based on selected workspace.
- VehicleForge and SpacecraftForge service panels use scoped data for products, jobs, previews, assets, generation requests, revisions, packages, part plans, worker dispatch, review queue, and readiness checks.

Issues:

- Forge summary loads all service records.
- Global dashboard status panels load all counts.
- Non Vehicle/Spacecraft workspaces fall back to global Product Library, Job Queue, Review Queue, Asset, Preview, Guide, and Readiness panels.
- GuidePanel can show global fallback records.

Verdict:

The architecture is acceptable for a control-room dashboard, but it is not yet strict Turntable isolation. Before heavy workspace work, add workspace-scoped summaries or stricter scoping helpers.

## Mobile Compliance

Status: pass with watch items.

Mobile remains:

- guide selection
- idea capture
- lightweight reference attachment
- job submission
- thumbnail/preview review
- approve/revise behavior

Mobile is not currently drifting into:

- heavy editors
- mesh tools
- export tools
- Shipyard behavior
- large asset library browsing
- heavy viewers on Home startup

Watch items:

- Move remaining target/game profile prompt ownership out of AppContext.
- Keep Projects, chat, and legacy routes out of Home startup.
- Add a simple vehicle vs spacecraft subtype selector so mobile can route to SpacecraftForge without adding a heavy editor.

## Workspace Compliance

### VehicleForge

Status: compliant.

- Active registry entry exists.
- Concept-only shell exists.
- Uses Forge service backbone.
- No heavy editor was added.
- No mesh generation was added.
- No texture baking was added.
- No Export Forge was added.
- No Shipyard integration was added.

### SpacecraftForge

Status: compliant.

- Active registry entry exists.
- Concept-only shell exists.
- Uses Forge service backbone.
- Starfield is treated as readiness/profile planning, not final export.
- No Shipyard integration was added.
- No heavy editor was added.
- No export package support was claimed.

### Placeholder Workspaces

Status: needs capability guard.

WeaponForge, ClothingForge, RoomForge, and ExportForge are placeholders or metadata-only workspaces but still appear in the registry. That is acceptable, but Job Queue should eventually enforce capability-level rules instead of only rejecting retired or disabled workspaces.

## Asset Pipeline Review

Strengths:

- Upload Storage has a real intake boundary.
- Image MIME types are limited.
- Large file size is capped.
- Dangerous extensions are blocked.
- Protected terms are blocked in filenames, titles, descriptions, and metadata.
- Source-rights fields exist.
- Asset Intake records are created.
- Preview records can be created.
- Candidate Review supports approved, internal-only, rejected, and blocked style outcomes.
- Public-safe and internal-only lane metadata exists.

Weak points:

- Scanner is metadata and magic-byte based, not a real visual safety scanner.
- Candidate Review and Asset Intake review need clearer separation in Review Queue.
- Internal-only lane enforcement needs stronger UI and readiness gates before public/export flows exist.
- Duplicate upload detection exists, but duplicate handling is not yet a full workflow.

Recommendation:

Keep the asset pipeline lightweight, but add a shared asset relationship validator and a lane policy check before package or export readiness workflows consume reusable assets.

## Product Library Review

Strengths:

- Product Library is the right canonical owner for generated SAFE_PRODUCT outputs.
- Product cards carry status, category, workspace, thumbnails, metadata, preview links, job links, upload links, intake links, generation history, and revision history.
- Product actions support approve, request revision, archive, and duplicate for revision.

Weak points:

- Linked ids are not always validated against live records.
- Workspace consistency is not enforced everywhere.
- Category and metadata keys are still flexible.
- Existing current data has no jobs or generation requests, so product ownership is not currently backed by an active end-to-end generation chain.

Recommendation:

Before continuing structured planning, add a Product Relationship Integrity helper that verifies:

- preview ids exist
- job ids exist
- generation request ids exist
- upload ids exist
- intake asset ids exist
- linked records belong to the same workspace or to an explicitly compatible shared workspace
- blocked/internal-only assets are not used in public-safe product lanes

## Readiness Review

Strengths:

- Target Profiles are centralized.
- Export Readiness checks are service-owned instead of mobile-owned.
- VehicleForge and SpacecraftForge have workspace-specific metadata checks.
- Missing metadata, missing preview, missing product, source/license, scale, material, and target-profile issues are reported as warnings or blockers.

Weak points:

- ready_for_export can sound like Export Forge exists.
- Product-only concept records may be penalized for missing job links.
- Deferred targets are blocked, which is safe, but the UI should explain that this means "not exportable yet," not "bad product."
- Readiness checks need formal workspace schemas before heavy workspace implementation.

Recommendation:

Rename or present readiness outcomes more conservatively:

- not_ready
- needs_review
- ready_later
- ready_for_export_when_export_forge_exists
- blocked

The internal service may keep existing enum names for compatibility, but the UI/reporting language should avoid overpromising.

## Foundation Validation Results

Validation was rerun during this audit.

| Check | Command / Method | Result | Notes |
|---|---|---|---|
| API typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\api-server\tsconfig.json --noEmit` | PASS | No errors. |
| Website typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\landing-page\tsconfig.json --noEmit` | PASS | No errors. |
| Mobile typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\viper-studio\tsconfig.json --noEmit` | PASS | No errors. |
| Existing mobile tests | Node test runner for ariaCmdParser, avatarMechanics, and jumpsuit seam tests | PASS | 60 tests passed. Existing module-format warnings only. |
| API build | `node artifacts\api-server\build.mjs` | PASS | Build completed. |
| Website build | `corepack pnpm --filter @workspace/landing-page run build` | PASS | Vite build completed. |
| API health check | `http://127.0.0.1:18082/api/healthz` | PASS | Returned 200. |
| Website health check | `http://127.0.0.1:19006/landing-page/` | PASS | Returned 200. |
| Website browser validation | In-app browser at `http://127.0.0.1:19006/landing-page/forge` | PASS | Forge shell opened. VehicleForge, SpacecraftForge, Product Library, and Review Queue were visible. No browser console errors. |
| Mobile startup validation | Static startup/import inspection | PASS WITH WATCH ITEMS | Home stays guide-first and does not import ThreeViewer, three-scripts, AriaZoneChat, or usePrefetch. AppContext still carries old global rule material. |
| Protected asset validation | Static protected path/lane inspection | PASS | No protected Aria/Gaius assets were moved or loaded by Home startup. Upload scanner blocks protected terms. |
| Legacy system validation | Static route/access inspection | PASS | Legacy systems remain reachable by explicit Advanced/Legacy access and were not deleted. |
| Workspace validation | Registry/API/dashboard inspection | PASS WITH WATCH ITEMS | VehicleForge and SpacecraftForge are active and visible. Mobile category mapping for SpacecraftForge needs a lightweight routing fix. |

## Technical Debt

- Flat-file JSON persistence.
- Broad summary endpoint with no workspace-scoped mode.
- Derived Review Queue with no durable review-event log.
- Flexible metadata strings without a central schema validator.
- Old mobile target/game profile prompt logic still in AppContext.
- Prototype/smoke data mixed with foundation service state.
- No real worker queue or lease model.
- No pagination strategy for large Product Library, Review Queue, Upload Storage, or Asset Library lists.
- No automated enforcement that every future phase report includes an audit section.

## Future Brick Walls

1. Flat JSON persistence will block multi-user Forge, concurrency, indexing, large assets, and real background workers.
2. One broad Forge summary will become too heavy as Product Library, uploads, packages, and part plans grow.
3. Without relationship validation, products, previews, jobs, packages, and readiness checks can drift into dangling references.
4. Without a review event ledger, review history may become hard to trust.
5. Without stronger lane enforcement, public-safe and internal-only assets can become difficult to police later.
6. Without clearer readiness wording, users may think Export Forge exists before it does.
7. Without mobile spacecraft routing, SpacecraftForge remains Website-visible but mobile-submission incomplete.

## Recommended Fixes

### P0 Before Resuming Heavy Workspace Work

1. Add a shared Forge relationship/integrity validator.
2. Use that validator before concept package assembly, structured part planning, export readiness checks, product updates, and review actions.
3. Fix GuidePanel fallback behavior so inactive workspaces never show another workspace's latest job, generation request, or readiness result.
4. Add workspace capability checks for placeholder and metadata-only workspaces.
5. Add a lightweight mobile subtype path for Vehicles vs Spacecraft so spacecraft concepts can route to SpacecraftForge.

### P1 Soon After

1. Move remaining AppContext target/game profile rule ownership toward Forge Target Profile summaries.
2. Add a workspace-scoped Forge summary endpoint or query mode.
3. Separate Review Queue item types for upload review, asset intake review, candidate review, readiness review, package review, and planning review.
4. Adjust readiness UI wording so it does not imply final export support.
5. Add pagination and filters for Review Queue, Product Library, Upload Storage, and Asset Library panels.

### P2 Later

1. Replace flat JSON persistence with a database-backed service layer.
2. Add worker dispatcher leases, retries, idempotency, and durable status history.
3. Add stronger visual/content safety scanning for uploaded references.
4. Add formal workspace metadata schemas for VehicleForge, SpacecraftForge, WeaponForge, ClothingForge, BuildingForge, and Materials.
5. Add automated report/audit generation checks.

## Recommended Roadmap Changes

- Insert a short Foundation Integrity phase before continuing deeper Phase 4F/4G work.
- Treat Phase 4F Structured Part Planning as paused until relationship validation and workspace scoping risks are addressed or explicitly accepted.
- Keep Export Forge blocked until readiness wording and target profile constraints are clarified.
- Keep ClothingForge expansion blocked until non-avatar clothing lane policy is stronger.
- Keep Website/Forge as the factory and mobile as the guide/review/request surface.

## Recommended Next Phase

Recommended next phase:

VIPER PHASE 4F-S FOUNDATION INTEGRITY AND AUDIT LAYER

Mission:

Stabilize the modern Forge foundation before continuing structured part planning or heavier workspace layers.

Scope:

- Add shared relationship/integrity validation.
- Add workspace-scoped summary support or a reusable scoping helper.
- Fix GuidePanel global fallback behavior.
- Add placeholder/metadata-only workspace capability guards.
- Add the phase report audit checklist as a reusable report section.
- Document the lightweight mobile Vehicles vs Spacecraft routing fix.

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

The Viper Forge foundation is healthy enough to continue, but not yet clean enough for more heavy layers without a short integrity pass.

The core direction is right:

- Website/Forge owns heavy work.
- Mobile remains lightweight.
- VehicleForge and SpacecraftForge are concept-only.
- Product Library, Preview Service, Review Queue, Asset Intake, Target Profiles, and Export Readiness are the correct backbone.

The main risk is not a broken build. The main risk is architectural drift:

- broad dashboard loading instead of strict workspace slices
- mobile retaining old target/game rule ownership
- missing relationship validation
- overlapping review lanes
- readiness wording that can overpromise future export support

Proceed with a small Foundation Integrity phase next, then resume Phase 4F with more confidence.
