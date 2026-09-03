# VIPER STUDIOS FULL ARCHITECTURE, STABILITY, AND ROADMAP AUDIT

Date: 2026-06-15

Status: full architecture, stability, and roadmap audit.

No new feature development was performed. Phase 4H was not started. No legacy systems were deleted. No protected assets were moved. No architecture was modified.

## Executive Summary

Viper Studios has made a real architectural transition.

The project is no longer only a mobile-heavy creator surface. The modern center of gravity is now Website/Forge, with service-backed records for jobs, products, previews, reviews, assets, readiness, concept packages, structured part planning, and proxy preview planning.

The strongest parts of the system are:

- Website/Forge now owns the modern product workflow.
- Product Library, Preview Service, Job Queue, Review Queue, Target Profiles, Export Readiness, Asset Intake, Candidate Review, Concept Packages, Structured Part Plans, and Proxy Preview Plans exist as service-backed systems.
- VehicleForge and SpacecraftForge exist as concept-only workspaces with panels, review flow, structured planning, and proxy planning.
- Mobile startup remains guide-first and review-focused at runtime.
- Integrity validation currently reports global ok status.
- Website Forge route and reports route open in the browser without console errors.
- API build, website build, API typecheck, website typecheck, mobile tests, health checks, browser checks, and integrity checks passed.

The weakest parts of the system are:

- Mobile typecheck currently fails on a typed Expo Router path for `/(legacy)/index`.
- Codex is still running this live thread from a projectless/home-thread context instead of the Viper project attachment.
- Hidden legacy mobile routes are still likely included in the native bundle even though runtime startup is lighter.
- Forge persistence is still JSON-file based, with no migrations, transactions, or locking.
- Gaius is still mostly embedded in readiness text and UI summaries, not a dedicated validation service.
- Visual inspection is not yet image-aware. Proxy Preview Planning exists, but actual visual review, UV review, texture mismatch detection, and protected visual safety are not implemented.
- Upload safety checks are strong locally, but virus scanning is still a stub.
- Protected Aria/Gaius assets live near public-serving paths and need a dedicated serving/access audit before any public workflow expands.
- ForgePage and the Forge API route are large and will become harder to maintain without gradual modularization.

Recommendation:

Do not begin Phase 4H yet. First perform a short stabilization phase to fix mobile typecheck, verify Codex is attached to the Viper project root in a new or corrected thread, and repair the Review Queue identity/projection weakness. After that, Phase 4H can proceed as a lightweight Proxy Image Request and Visual Inspection Prep phase, not as heavy generation or rendering work.

## Architecture Scorecard

| Area | Health | Notes |
|---|---:|---|
| Forge backbone | B+ | Strong service foundation. Needs persistence hardening and API contract tests. |
| Workspace Registry | A- | Clear workspace definitions and mobile/website availability. Good Website-first alignment. |
| Product Library | B+ | Canonical ownership exists. Relationship metadata needs normalization before scale. |
| Job Queue | B | Good state model. Worker linkage still early. |
| Generation Service | B | Service contract exists. Live data currently has zero active generation requests. |
| Preview Service | B | Preview records exist and connect to products/reviews. Heavy visual review is not implemented yet. |
| Review Queue | B- | Central review queue works, but item identity/priority projection needs cleanup. |
| Asset Intake and Upload Storage | B | Good upload gates. Virus scanning remains placeholder. |
| Candidate Review and Asset Readiness | B | Good lane separation model. Internal/public lane risk remains high-impact. |
| Concept Revisions | B- | Model exists, but current live data has no active concept revision records. |
| Concept Packages | B | Vehicle and Spacecraft packages exist. Good bridge from concept to planning. |
| Structured Part Planning | B | Service exists and validates. Still metadata/planning only, correctly no heavy editor. |
| Proxy Preview Planning | B | Service/API/UI exist. Needs actual visual request/inspection phase next. |
| Target Profiles | B+ | Conservative targets exist. Export support is correctly not overclaimed. |
| Export Readiness | B+ | Useful readiness warnings. Must keep separate from actual Export Forge. |
| Aria | B- | Good guide/context/prompt scaffolding. Needs deeper planner/reviewer/image-aware capability. |
| Gaius | C+ | Role is clear, but needs its own service layer and rule ownership. |
| Mobile runtime startup | B+ | Guide-first and light at runtime. |
| Mobile native bundle | C | Hidden legacy routes likely still ship in the Android bundle. |
| Website Forge UI | B | Verified in browser. Large page needs future modularization. |
| Repository boundary | B | Viper has its own Git root. Current thread attachment remains wrong. |
| Codex reliability | C- | Git root is repaired, but live thread still runs from a projectless/root context. |
| Audit framework | A- | Integrity and phase audit discipline now exist. Needs enforcement on every future phase. |

## Scope Audited

Modern systems audited:

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
- Structured Part Planning
- Proxy Preview Planning
- Target Profiles
- Export Readiness
- Guide Context Service
- VehicleForge
- SpacecraftForge
- Forge Dashboard
- Reports page
- Mobile startup path
- Mobile Turntable/workspace selection
- Integrity validator
- Audit framework
- Repository layout
- Git structure
- Codex integration points

Legacy systems were inspected for risk only:

- Workshop
- Shipyard
- ThreeViewer
- Viewer
- IMVU Creator
- DevStudio

They were not redesigned.

## Forge Assessment

Forge is now the right architectural center for Viper Studios.

The Website/Forge service backbone supports the intended flow:

```text
User intent
  -> Job Queue
  -> Generation Request
  -> Preview Record
  -> Product Library Card
  -> Review Queue
  -> Readiness Check
  -> Future Export Forge
```

Current service files under `artifacts/api-server/src/lib/forge` show a broad but coherent backbone:

- `workspaceRegistry.ts`
- `jobQueue.ts`
- `generationService.ts`
- `previewService.ts`
- `productLibrary.ts`
- `reviewQueueService.ts`
- `targetProfileService.ts`
- `exportReadinessService.ts`
- `assetIntakeService.ts`
- `uploadStorageService.ts`
- `conceptRevisionService.ts`
- `conceptPackageService.ts`
- `structuredPartPlanService.ts`
- `proxyPreviewPlanService.ts`
- `workspaceAssetService.ts`
- `integrityService.ts`
- `workerDispatcherService.ts`
- `guideContextService.ts`
- `productOwnershipService.ts`
- `persistence.ts`

Strengths:

- Service ownership is clearer than earlier mobile-heavy behavior.
- VehicleForge and SpacecraftForge now consume existing services instead of inventing private storage.
- Review Queue acts as a central collection point for products, previews, packages, part plans, proxy preview plans, readiness checks, and asset intake.
- Integrity validation provides a useful foundation-wide health check.
- Target Profile and Export Readiness services keep export rules separate from actual export generation.

Weaknesses:

- `persistence.ts` still uses JSON files under `data/forge`. That is acceptable for a prototype, but it is not ready for multi-user editing, concurrent workers, large asset libraries, or long-lived production data.
- `forgeStore.ts` and `/api/forge` are useful central facades, but both are becoming large coordination surfaces.
- The Forge API has many routes but limited schema validation and contract testing.
- The service graph is increasingly broad. Future phases need to avoid adding one-off storage and instead strengthen the common contracts.

Recommended fix:

Keep the service backbone. Do not rewrite it. Add schema validation, contract tests, and a future migration path away from JSON persistence before heavy worker or multi-user use.

## Product Library Assessment

Current Product Library state from the Forge summary:

- Products: 13
- VehicleForge products: 5
- SpacecraftForge products: 1
- TextureMaterialForge products: 2
- FurnitureForge products: 1

Strengths:

- Product Library has become the canonical owner for SAFE_PRODUCT outputs.
- Products link to previews, generation history, concept packages, structured plans, and review records.
- VehicleForge product records now support workspace-specific product evolution.
- Product cards are visible through Website/Forge.

Weaknesses:

- Product relationships are still mostly record-field based rather than normalized relationship records.
- Some relationship metadata, especially reusable asset relationships, is complex enough that it will become hard to query safely later.
- Product status, review status, readiness status, and package/plan status now overlap in meaning. The current system works, but a future product lifecycle model is needed.

Risk:

If Product Library becomes the canonical owner for all workspaces without lifecycle tightening, products may drift into inconsistent states such as approved product, pending preview, blocked asset, and ready-for-export readiness at the same time.

Recommended fix:

Add a product lifecycle policy layer after Phase 4H, not before it. This should define allowed transitions and derive product status from linked review/readiness records where possible.

## Job Queue Assessment

Strengths:

- Job states exist and align with the Forge workflow.
- Mobile can submit Forge-shaped jobs.
- Jobs can link to products, previews, target profiles, and workspaces.

Weaknesses:

- Worker Dispatcher currently has no tracked live dispatch records in the summary.
- There is not yet a real background worker lifecycle.
- Jobs and generation requests can exist as passive records unless a future worker actively advances them.

Risk:

As generation, proxy image requests, and future export readiness grow, jobs may become status labels without a reliable processing engine.

Recommended fix:

Keep worker dispatcher lightweight, but make it the only path for future automated transitions. Do not let each workspace invent custom processing loops.

## Generation And Preview Assessment

Current summary:

- Generation requests: 0
- Previews: 12
- Proxy preview plans: 1
- Concept packages: 2
- Structured part plans: 2

Strengths:

- The generation-to-preview-to-product path exists.
- Preview records support review and product ownership.
- Proxy Preview Planning creates a bridge toward visual inspection without loading heavy viewers.

Weaknesses:

- Live data has previews but no active generation request records, which suggests old generation state may have been completed, archived, or not retained in the summary.
- Generation output metadata needs stronger retention and traceability before real image requests begin.
- Preview records are not yet image-aware review objects. They are still mostly metadata/thumbnail records.

Recommended fix:

Before actual image generation expands, require every generated visual output to preserve:

- source generation request id
- source prompt
- workspace id
- product id
- preview id
- review queue id
- source rights and asset lane state when reference assets are involved

## Review Queue Assessment

Current summary:

- Total review items: 42
- Pending: 8
- Approved: 17
- Needs revision: 2
- Archived: 15

Review types present:

- preview
- product
- readiness
- asset_intake
- concept_package
- structured_part_plan
- proxy_preview_plan

Strengths:

- Review Queue now gathers modern Forge work into one workflow.
- It includes asset intake, products, previews, readiness, concept packages, part plans, and proxy preview plans.
- VehicleForge and SpacecraftForge both feed it.

Weaknesses:

- Some pending review queue API output shows null item id or priority fields in projected responses.
- Review state exists in multiple places: review queue items, products, previews, concept packages, readiness checks.
- There is not yet a strong reviewer decision audit trail across all object types.

Recommended fix:

Repair review queue identity/projection before adding Phase 4H visual review records. Every review item should expose a stable review id, item id, workspace id, priority, object type, status, and linked target.

## Asset Pipeline Assessment

The modern asset pipeline includes:

- Asset Intake
- Upload Storage
- Upload safety checks
- Asset Review
- Candidate Review
- Asset Library Readiness
- Workspace Asset recommendations

Strengths:

- Public-safe and internal-only lanes exist.
- Upload scanning checks extensions, MIME, magic bytes, suspicious payload patterns, SSRF-like strings, GLB JSON internals, size, and filenames.
- Integrity currently reports no blocked or error-level asset issues.
- Candidate assets can be consumed by VehicleForge and SpacecraftForge without making them public by default.

Weaknesses:

- Virus scanning is still a stub.
- Public-safe and internal-only relationships are high-impact and must remain strict.
- At least one blocked/rejected prototype upload remains in the data but appears isolated and does not currently break integrity.
- Protected assets live near public-serving folders, which needs a route/access audit before any public image or asset browsing expands.

Risk:

The biggest asset risk is not current integrity failure. The biggest risk is accidental lane leakage when visual inspection, reusable asset browsing, or image request workflows begin.

Recommended fix:

Before heavy asset browsing or visual generation:

1. Add a protected asset serving audit.
2. Replace stub virus scanning with a real scanner or explicit offline-quarantine policy.
3. Keep internal-only assets out of public-safe Product Library flows by validator rule.
4. Add tests for public product plus internal asset violations.

## VehicleForge Assessment

Current state:

- VehicleForge is active.
- Website availability: concept-only workspace.
- Mobile availability: concept-only submission/review.
- Products: 5.
- Jobs: 1.
- Concept packages: 1.
- Structured part plans: 1.
- Proxy preview plans: 1.
- Review queue items: 18.
- Integrity: ok with one informational readiness note.

Browser validation confirmed:

- VehicleForge opens in Website/Forge.
- Vehicle panels are visible.
- Proxy Preview Plan panel is visible.
- Proxy Sheets panel is visible.
- Concept Package panel is visible.
- Structured Part Plan panel is visible.
- Revision History, Candidate Assets, Asset Recommendations, Linked Assets, Aria summary, and Gaius summary are visible.
- No browser console errors were observed.

Strengths:

- VehicleForge follows the Website-first direction.
- It uses the existing service backbone.
- It does not introduce heavy editors.
- It supports concept, review, package, structured part planning, proxy planning, and asset recommendation surfaces.

Weaknesses:

- It is still concept/planning only.
- The review and package states need stronger lifecycle rules before real construction begins.
- Gaius validation is present as warnings/summaries, not as a dedicated service.

Recommendation:

VehicleForge is ready for Phase 4H after stability fixes, but only for lightweight proxy image request records and visual inspection preparation.

## SpacecraftForge Assessment

Current state:

- SpacecraftForge is active.
- Website availability: concept-only workspace.
- Mobile availability: concept-only submission/review.
- Products: 1.
- Jobs: 1.
- Concept packages: 1.
- Structured part plans: 1.
- Proxy preview plans: 0 in summary at audit time.
- Review queue items: 5.
- Integrity: ok with one informational readiness note.

Browser validation confirmed:

- SpacecraftForge opens in Website/Forge.
- Spacecraft panels are visible.
- Proxy Preview Plan panel is visible.
- Concept Package panel is visible.
- Structured Part Plan panel is visible.
- Candidate Asset, Asset Recommendation, Aria, and Gaius surfaces are visible.
- No browser console errors were observed.

Strengths:

- SpacecraftForge is correctly kept separate from Shipyard.
- It does not claim Starfield export support.
- It uses target/readiness guidance without building Export Forge.
- It has the right panels for hull, room/module, systems, readiness, and review.

Weaknesses:

- It has less live proxy preview data than VehicleForge.
- Starfield assumptions must stay explicitly labeled as readiness guidance, not export support.
- Spacecraft scope can easily drift into Shipyard, WorldForge, RoomForge, or Export Forge if phase boundaries are not enforced.

Recommendation:

Proceed carefully. SpacecraftForge should stay concept/planning only until visual inspection, Gaius validation, and product lifecycle rules are stronger.

## Lazy Susan Compliance

Viper's core rule is:

```text
Only the active workspace slice should become active.
```

Website/Forge compliance:

- Workspace registry lists all workspaces, but active workspace panels switch by selected workspace.
- Browser validation showed VehicleForge and SpacecraftForge panels open only when selected.
- The Forge dashboard still fetches broad summary data. This is acceptable for dashboard counts, but it should not evolve into mounting every workspace editor.
- ForgePage is large, so accidental inactive workspace rendering remains a future risk.

Mobile compliance:

- Mobile starts guide-first.
- Home does not import ThreeViewer, `three-scripts.ts`, AriaZoneChat, or `usePrefetch`.
- The primary mobile categories remain lightweight:
  - Vehicles and Spacecraft
  - Weapons and Tools
  - Clothing and Armor
  - Furniture and Props
  - Buildings and Structures
  - Materials and Textures
- Workshop is not the initial route.
- Heavy routes remain hidden from primary navigation.

Remaining violation risk:

- Expo native build behavior likely still includes hidden legacy route modules in the Android bundle because native bundle splitting is not active and build tooling has used `lazy=false`.
- This is not a runtime startup mount problem, but it is still a package-weight and memory-risk problem.

Recommendation:

Keep runtime Lazy Susan discipline. Treat native bundle cleanup as a separate production-build strategy:

- Keep legacy routes advanced-only for now.
- Finish Website/Forge replacements.
- Later exclude or remove legacy mobile-heavy tools from production mobile builds when safe.

## Aria Assessment

Current Aria capabilities:

- Guide selection exists on mobile and Website/Forge.
- Aria can act as the creative guide in workspace panels.
- Aria has directive parsing and lightweight behavior systems.
- Aria memory exists as a file-backed local memory surface.
- Aria can contribute prompt refinement and creative summaries in Forge workflows.

Long-term Aria vision:

- planner
- builder
- reviewer
- visual reviewer
- image-aware assistant
- code-aware assistant
- project-aware assistant

Gap analysis:

| Aria role | Current state | Gap |
|---|---|---|
| Planner | Early context and summaries exist | Needs task graph, dependency reasoning, and workspace planning memory |
| Builder | Can guide jobs, not execute work | Needs safe worker action contracts |
| Reviewer | Can summarize and suggest | Needs review decisions linked to evidence |
| Visual reviewer | Not yet implemented | Needs image inspection records and visual comparison |
| Image-aware assistant | Not yet integrated | Needs image input, asset safety, and protected visual filtering |
| Code-aware assistant | Not Viper-native yet | Needs reliable project-attached Codex context and bounded code access |
| Project-aware assistant | Product/job context exists | Needs durable project memory and cross-service retrieval |

Strengths:

- Aria has a clear creative role.
- Aria is not overloaded with Gaius-style technical validation.
- Aria can fit naturally into VehicleForge and SpacecraftForge concept flows.

Risks:

- If Aria becomes builder, reviewer, and validator without clear contracts, she can become a catch-all instead of a reliable guide.
- Protected Aria assets must never leak into public Forge product flows.

Recommended fix:

Add Aria capabilities through service contracts:

1. Creative brief summarization.
2. Prompt refinement.
3. Review explanation.
4. Visual inspection commentary.
5. Project memory retrieval.

Do not give Aria direct heavy-editor ownership.

## Gaius Assessment

Current Gaius capabilities:

- Gaius appears in guide selection and Forge panels.
- Gaius provides readiness warnings and practical next-action summaries.
- Gaius is represented in target/readiness/proxy/structured planning fields.

Current weakness:

Gaius does not yet have a dedicated service layer. His role is conceptually strong but technically embedded across records and panels.

Intended Gaius role:

- validation coverage
- readiness coverage
- review coverage
- planning coverage
- scale checks
- source-rights checks
- lane separation checks
- missing metadata checks
- export-not-ready warnings

Gap analysis:

| Gaius role | Current state | Gap |
|---|---|---|
| Readiness validation | Export Readiness exists | Needs Gaius-owned summary and decision records |
| Scale validation | Notes and warnings exist | Needs workspace-specific rule packs |
| Source/reference validation | Asset intake exists | Needs source-rights evidence summaries |
| Review coverage | Review Queue exists | Needs practical review recommendations |
| Planning coverage | Structured/proxy planning warnings exist | Needs rules over part/preview plan completeness |

Recommended fix:

Create a Gaius Validation Service after Phase 4H prep. It should consume Product Library, Target Profiles, Readiness Checks, Review Queue, Asset Intake, Structured Part Plans, and Proxy Preview Plans, then produce stable Gaius findings.

## Visual Inspection Readiness Assessment

Current state:

- Proxy Preview Planning exists.
- Proxy preview sheets and visual warnings can be planned.
- VehicleForge and SpacecraftForge UI panels show proxy preview planning surfaces.
- Review Queue accepts proxy preview plan items.
- Integrity remains ok after Proxy Preview Planning.

Missing pieces:

- Actual proxy image request records.
- Actual generated image records.
- Visual inspection result records.
- UV review.
- Texture validation.
- Visual mismatch detection.
- Protected asset visual safety checks.
- Image-aware Aria review.
- Gaius visual defect classification.

Recommendation:

Phase 4H should not build heavy visual generation. It should only add the lightweight request and inspection preparation layer:

```text
Proxy Preview Plan
  -> Proxy Image Request
  -> Future Image Output
  -> Visual Inspection Record
  -> Review Queue
  -> Aria visual summary
  -> Gaius visual warnings
```

Do not add heavy viewers, mesh processing, UV tools, or export tooling in Phase 4H.

## Mobile Assessment

Mobile remains mostly aligned with the Website-first rule.

Confirmed mobile startup design:

- First screen is guide-first.
- Aria and Gaius are separate guide cards.
- Only the selected guide continues into the flow.
- Mobile category selection is simple.
- Vehicles and Spacecraft can route to VehicleForge or SpacecraftForge.
- Home startup does not directly import ThreeViewer, `three-scripts.ts`, AriaZoneChat, or `usePrefetch`.
- Workshop is no longer the primary startup surface.

Mobile still owns or carries risk in:

- Heavy legacy route files under Expo Router.
- Native bundle inclusion of hidden routes.
- Settings/profile logic that still carries game/target profile text.
- Advanced legacy access routes.
- RevenueCat/root app initialization that can affect startup/offline behavior.

Current validation issue:

Mobile typecheck fails:

```text
app/(tabs)/index.tsx(772,46): error TS2322:
Type '"/(legacy)/index"' is not assignable to the typed route union.
```

Assessment:

This appears to be a typed Expo Router route issue, not evidence that mobile startup is heavy. It should be fixed before Phase 4H begins.

Recommendation:

Fix the typed legacy route link in Home or route through a typed-safe advanced/legacy helper. Then rerun mobile typecheck before starting any new feature work.

## Website Assessment

Browser validation confirmed:

- `/landing-page/#forge` opens as the landing-page Forge section.
- `/landing-page/reports` opens the reports page.
- `/landing-page/reports` contains top report copy controls and many report copy buttons.
- `/landing-page/forge` opens the actual Forge workspace shell.
- VehicleForge opens.
- SpacecraftForge opens.
- Browser console showed no errors during these checks.

Website build:

- `@workspace/landing-page` typecheck passed.
- `@workspace/landing-page` build passed.
- Vite built successfully.
- Main JavaScript bundle was about 433.94 kB before gzip and 124.09 kB after gzip.

Strengths:

- Website/Forge is usable and visible.
- Reports page is working.
- Copy buttons exist on the reports page.
- Forge shell shows the modern service-backed panels.

Weaknesses:

- `ForgePage.tsx` is very large and is now a maintenance risk.
- Dashboard and workspace panels may become too broad if every future service adds direct UI into one page.
- Website does not yet have deep visual inspection tooling.

Recommended fix:

Do not redesign now. After Phase 4H, gradually split ForgePage into workspace panels and shared service panels.

## Stability Assessment

Validation results:

| Check | Result | Notes |
|---|---:|---|
| API typecheck | Pass | `@workspace/api-server` typecheck passed. |
| Website typecheck | Pass | `@workspace/landing-page` typecheck passed. |
| Mobile typecheck | Fail | Typed route failure for `"/(legacy)/index"` in mobile Home. |
| Existing mobile tests | Pass | 14 suites, 60 tests passed. |
| API build | Pass | API build completed. |
| Website build | Pass | Vite build completed. |
| API health check | Pass | API returned 200. |
| Website health check | Pass | Website returned 200. |
| Browser validation | Pass | Reports, Forge route, VehicleForge, and SpacecraftForge opened without console errors. |
| Integrity validation | Pass | Global, VehicleForge, and SpacecraftForge status ok. |
| Workspace validation | Pass | 12 registry workspaces, 5 active, VehicleForge and SpacecraftForge present. |

First failing validation:

Mobile typecheck.

Likely cause:

Typed Expo Router route mismatch for advanced/legacy link from Home.

Impact:

- Blocks a fully clean validation gate.
- Does not appear to break runtime browser validation.
- Must be fixed before Phase 4H.

## Codex Reliability Assessment

Repository boundary status:

- Viper has its own Git root at:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

- The home repository at `C:\Users\U\.git` was left untouched.
- Running Git from the Viper project no longer needs to treat the entire Windows user profile as the project.

Remaining Codex issue:

- The current live Codex thread is still attached to a projectless/home-thread workspace:

```text
C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

- Review-summary or thread-level Codex behavior may still target broad user roots unless the thread is opened or created directly on the Viper project.

Assessment:

The Git boundary repair likely solved the Viper repository inheritance problem. It did not fully solve the live-thread attachment problem.

Risk level:

Medium to high for long-running Codex sessions in the current thread. Low to medium for commands explicitly run with the Viper project as working directory.

Recommendation:

Before another long phase, use a Viper project-attached Codex thread. The active workspace should be:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

Do not run 11-hour or overnight Viper phases from a projectless thread.

## Repository And Git Structure

Strengths:

- Viper now resolves as its own repository.
- Project-local Git operations do not scan AppData, Cookies, Local Settings, or the full Windows profile.

Weaknesses:

- The Viper repository is newly initialized and contains many untracked/modified files.
- Codex's current thread context is separate from the Viper repository path.

Recommendation:

Create a stable Viper project thread and keep future audit/phase work attached to the project root. Do not delete `C:\Users\U\.git` unless a separate, explicit backup and removal plan is approved later.

## Integrity Validator Assessment

Current integrity status:

- Global: ok.
- VehicleForge: ok.
- SpacecraftForge: ok.
- Blocked issues: 0.
- Error issues: 0.
- Warning issues: 0.
- Info issues: 2.

Current info issues:

- VehicleForge has a ready-for-export readiness record that means future export readiness, not actual Export Forge support.
- SpacecraftForge has a similar informational readiness note.

Strengths:

- The validator catches relationship and lane risks.
- It reports by workspace.
- It supports the permanent audit rule.

Weaknesses:

- It currently reports known readiness wording issues as info, but the user-facing UI can still misread "ready for export" as actual export support.
- Validator coverage should expand to review queue identity, mobile route safety, and protected asset exposure.

Recommendation:

Keep the validator strict. Add checks instead of weakening existing ones.

## Audit Framework Assessment

The permanent Viper engineering rule is correct:

Any phase that creates or modifies services, APIs, workspace shells, workflows, planning systems, review systems, package systems, asset systems, workspace integrations, or dashboard panels must include a post-build audit.

Minimum audit should continue to include:

- API typecheck
- Website typecheck
- Mobile typecheck
- Existing tests
- Build validation
- Browser validation
- Mobile startup validation
- Protected asset validation
- Legacy system validation
- Workspace validation

Current weakness:

This audit found a mobile typecheck failure. That means the rule is useful and should remain enforced.

Recommendation:

No future phase should be considered complete until its report includes:

- phase report
- audit section
- validation results
- failures documented
- recommended next phase

## Legacy System Risk Assessment

Legacy systems inspected for risk only:

- Workshop
- Shipyard
- ThreeViewer
- Viewer
- IMVU Creator
- DevStudio

Findings:

- Legacy routes remain available and hidden from primary navigation.
- They are large and likely remain in native bundles.
- Lazy wrappers exist for some heavy modules such as ThreeViewer, AriaZoneChat, and ViperCreatorShell.
- Runtime mobile Home remains clean.
- Native bundle weight remains unresolved.

Risks:

- Hidden legacy routes may still increase Android app size.
- Some legacy routes may carry avatar, skin, or protected/internal concepts that must not be reactivated.
- DevStudio remains a risk surface for old generation logic and protected/retired paths.
- ThreeViewer remains risky for startup and memory if accidentally reintroduced.

Recommendation:

Do not delete legacy systems yet. Continue replacing their responsibilities with Website/Forge services. Later, create a production mobile build strategy that excludes legacy-heavy routes when replacements are complete.

## Target Profile And Export Readiness Assessment

Strengths:

- Target Profiles exist.
- Export Readiness exists.
- The system is conservative and does not build Export Forge yet.
- `generic_glb`, `starfield`, `skyrim`, `imvu_product`, and `viper_internal` style profiles are handled as planning/readiness data, not guaranteed export pipelines.

Weaknesses:

- "ready_for_export" wording can be misleading while Export Forge does not exist.
- Mobile still has remnants of target/game profile behavior in local settings/prompt logic.

Recommendation:

Rename or clarify user-facing readiness language to "ready for future export review" where appropriate. Continue moving mobile target profile logic into Website/Forge.

## Aria And Gaius Separation

Correct separation:

- Aria should guide creative direction.
- Gaius should validate practical readiness.

Current risk:

- Aria and Gaius both appear in UI, but only Aria has a more visible personality/service footprint.
- Gaius needs technical ownership so readiness warnings do not become scattered string fields.

Recommendation:

Build Gaius as a real validation service before heavy visual inspection or export planning deepens.

## Visual Safety And Protected Assets

Protected asset rule:

Protected Aria/Gaius assets must remain internal and must not enter public Forge product flows.

Current risk:

- Protected assets exist near API public directories.
- Future visual inspection and proxy image request work will increase the chance that references, outputs, and protected visuals are mixed accidentally.

Recommendation:

Before visual generation expands:

1. Audit public serving routes.
2. Define protected asset access rules.
3. Add integrity checks for protected asset references.
4. Keep image inspection metadata separate from public product references unless explicitly approved.

## Technical Debt

High-priority technical debt:

- Mobile typecheck failure on typed legacy route.
- Current Codex live thread is not attached to the Viper project root.
- Review Queue projected fields can lose item identity/priority.
- JSON persistence lacks migrations, locking, and transactions.
- Virus scanning is a stub.
- Gaius lacks a dedicated service.
- Visual inspection is not image-aware yet.
- Native mobile bundle likely still contains heavy legacy routes.
- Protected asset serving/access needs explicit audit.

Medium-priority technical debt:

- `ForgePage.tsx` is too large.
- `routes/forge.ts` is too large.
- `types.ts` is large and could become hard to maintain.
- Client/server Forge API types are manually mirrored in places.
- Product lifecycle states overlap with review/readiness/package states.
- Worker Dispatcher has no active tracked workload.
- Generation request live data is empty while previews/products exist.

Low-priority technical debt:

- Some package comments contain mojibake characters.
- Mobile tests show module type warnings that can be cleaned up later.

## Future Risks

Major risks:

- Export readiness may be mistaken for real export capability.
- SpacecraftForge may drift into Shipyard or Export Forge scope too early.
- Visual inspection may begin before protected visual safety exists.
- Product Library may become inconsistent without lifecycle rules.
- JSON persistence may break under concurrent workers.
- Review Queue may become unreliable if identity and priority fields are not consistent.
- Mobile may remain runtime-light but bundle-heavy.
- Codex may continue to crash or reload if long phases run from the wrong thread/root.

## Recommended Fixes

Immediate fixes before Phase 4H:

1. Fix the mobile typed route failure in `app/(tabs)/index.tsx`.
2. Rerun mobile typecheck.
3. Confirm future Viper work runs from a Codex thread attached to the Viper project root.
4. Repair Review Queue identity/projection fields so review items always expose stable ids and priority.
5. Add an audit note that Phase 4H must be record-only and visual-inspection-prep only.

Near-term fixes:

1. Add Gaius Validation Service.
2. Add protected asset serving/access audit.
3. Replace virus scan stub or add explicit quarantine policy.
4. Add API contract tests for Forge service routes.
5. Add product lifecycle rules.
6. Split ForgePage into smaller workspace/service panels.
7. Continue moving mobile settings target profile logic to Forge.

Long-term fixes:

1. Move Forge persistence from JSON files to a database or migration-backed store.
2. Add worker processing with durable job state transitions.
3. Create production mobile strategy for excluding legacy heavy routes.
4. Add true image-aware visual inspection.
5. Add future Export Forge only after readiness, visual safety, and product lifecycle are stable.

## Recommended Roadmap Changes

Recommended next phase should not be Phase 4H directly.

Add a short stabilization phase first:

### Phase 4G-S: Pre-Visual Stability Gate

Goals:

- Fix mobile typecheck.
- Confirm project-attached Codex thread.
- Repair Review Queue identity/projection.
- Re-run validation.
- Confirm integrity remains ok.

Then continue:

### Phase 4H: Proxy Image Request And Visual Inspection Prep

Scope:

- Add proxy image request records.
- Add visual inspection placeholder records.
- Link requests to proxy preview plans, products, workspaces, and review queue.
- Keep everything lightweight.

Do not build:

- heavy viewers
- mesh tools
- UV tools
- texture baking
- Export Forge
- Starfield export
- full image generation workers

Recommended later phases:

- Phase 4I: Gaius Visual Validation Service
- Phase 4J: Website-only Visual Review Panel
- Phase 4K: Protected Visual Safety And Asset Lane Hardening
- Phase 4L: Product Lifecycle Policy
- Phase 5A: Worker Dispatcher Upgrade
- Phase 5B: Persistence Migration Planning
- Phase 5C: Production Mobile Legacy Exclusion Strategy

## Recommended Next Phase

Recommended next phase:

```text
VIPER PHASE 4G-S PRE-VISUAL STABILITY GATE
```

Purpose:

Stabilize the validation gate before Phase 4H.

Required work:

- Fix mobile typecheck failure.
- Verify all validations pass.
- Confirm Codex is attached to the Viper project root.
- Repair Review Queue identity/projection if confirmed.
- Confirm no protected assets moved.
- Confirm legacy systems remain untouched.

Only after that should Phase 4H begin.

## Audit Checklist Section

| Required audit item | Result |
|---|---:|
| API typecheck | Pass |
| Website typecheck | Pass |
| Mobile typecheck | Fail |
| Existing tests | Pass |
| API build | Pass |
| Website build | Pass |
| API health check | Pass |
| Website health check | Pass |
| Browser validation | Pass |
| Mobile startup validation | Pass by inspection, with native bundle risk |
| Protected asset validation | Pass by no-move inspection, but serving audit needed |
| Legacy system validation | Pass by untouched/hidden inspection |
| Workspace validation | Pass |
| Integrity validation | Pass |
| Phase report exists | Yes |
| Failures documented | Yes |
| Recommended next phase exists | Yes |

## Validation Details

API typecheck:

```text
Pass
```

Website typecheck:

```text
Pass
```

Mobile typecheck:

```text
Fail
app/(tabs)/index.tsx(772,46): error TS2322:
Type '"/(legacy)/index"' is not assignable to the typed route union.
```

Existing mobile tests:

```text
Pass
14 test suites passed.
60 tests passed.
```

API build:

```text
Pass
```

Website build:

```text
Pass
```

API health check:

```text
Pass
API returned 200.
```

Website health check:

```text
Pass
Website returned 200.
```

Browser validation:

```text
Pass
Reports page, Forge route, VehicleForge, and SpacecraftForge opened without console errors.
```

Integrity validation:

```text
Pass
Global status: ok.
VehicleForge status: ok.
SpacecraftForge status: ok.
Blocked issues: 0.
Error issues: 0.
```

Workspace validation:

```text
Pass
12 workspaces registered.
5 active workspaces.
VehicleForge and SpacecraftForge are present and active.
Six mobile categories are present.
```

## Final Assessment

Viper Studios is structurally healthier than it was before the Website-first migration.

The modern Forge architecture is coherent, service-backed, and moving in the correct direction. VehicleForge and SpacecraftForge are now real concept-only workspaces, not isolated experiments. Mobile remains light at runtime, and the integrity validator is doing useful work.

However, Viper is not ready for deeper visual or heavy workspace work until the current validation break and Codex attachment risk are handled.

Phase 4H should wait.

The correct next move is a short stabilization gate, then a lightweight visual-request preparation phase.

