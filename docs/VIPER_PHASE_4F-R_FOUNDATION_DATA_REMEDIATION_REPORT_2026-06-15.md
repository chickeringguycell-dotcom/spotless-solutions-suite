# VIPER PHASE 4F-R FOUNDATION DATA REMEDIATION REPORT

Date: 2026-06-15

Status: completed.

Copy-ready note: use the Reports page `COPY LATEST REPORT` button or this report's `COPY` button to copy this whole report.

## Mission

Repair the integrity issues found by the Foundation Integrity layer before resuming Phase 4F Structured Part Planning.

This was a data-remediation phase only.

No heavy editors were built. No mesh generation was added. No texture baking was added. Export Forge was not built. Shipyard integration was not built. Heavy viewers were not added. Legacy systems were not deleted. Protected assets were not moved.

## Source Of Truth

- `VIPER_PHASE_4F-S_FOUNDATION_INTEGRITY_AUDIT_LAYER_REPORT_2026-06-15.md`
- `VIPER_PHASE_REPORT_AUDIT_CHECKLIST_TEMPLATE.md`

## Integrity Issues Found

Initial global integrity status:

| Scope | Status | Issues | Blocked | Errors |
|---|---:|---:|---:|---:|
| Global Forge store | blocked | 6 | 5 | 1 |
| VehicleForge | blocked | 3 | 3 | 0 |
| SpacecraftForge | ok | 0 | 0 | 0 |

Issue inventory:

| Issue | Service | Product | Workspace | Related Upload | Cause |
|---|---|---|---|---|---|
| 1 | Product Library | `product-4761b7db` | VehicleForge | `upload-f65dba49` | Product linked blocked upload with unscanned/unknown-rights state. |
| 2 | Product Library | `product-e064d43d` | VehicleForge | `upload-881ce506` | Product linked blocked upload with unknown source-rights state. |
| 3 | Product Library | `product-ec059e3c` | VehicleForge | `upload-fbaf23b0` | Prototype product still linked a blocked upload lane. |
| 4 | Product Library | `product-7e503d6a` | TextureMaterialForge | `upload-f311559f` | Prototype material candidate still linked a blocked upload lane. |
| 5 | Product Library | `product-0fd06164` | FurnitureForge | `upload-a15852df` | Public-safe product linked an internal-only upload. |
| 6 | Product Library | `product-228a1486` | WeaponForge | `upload-9c705fe3` | Product linked blocked/rejected source-rights upload. |

Grouped findings:

- Product Library issue: six prototype product cards linked unsafe upload ownership chains.
- Upload issue: five uploads were in blocked lanes; one upload was internal-only but linked into a public-safe product card.
- Asset Intake issue: related intake records inherited product ownership links from unsafe upload chains.
- Reusable Asset issue: blocked/internal-only upload lanes were not eligible for active public-safe Product Library ownership.
- Lane violation: `product-0fd06164` linked internal-only `upload-a15852df`.
- Workspace mismatch: none found.
- Missing record reference: none found.

## Records Repaired

The repair used the Forge API. The validator was not weakened.

For each unsafe chain:

- Archived the prototype Product Library card.
- Removed active `previewIds`.
- Removed active `intakeAssetIds`.
- Removed active `uploadIds`.
- Detached the upload from Product Library `productId` ownership.
- Archived the upload review state.
- Detached the Asset Intake record from Product Library `productId` ownership.
- Archived the Asset Intake review state.
- Detached the preview from Product Library `productId` ownership.
- Archived the preview review state.
- Added Phase 4F-R remediation metadata and revision notes.

Repaired chains:

| Product | Upload | Asset Intake | Preview | Action |
|---|---|---|---|---|
| `product-4761b7db` | `upload-f65dba49` | `asset-ea3fa886` | `preview-73134632` | Archived and detached unsafe ownership links. |
| `product-e064d43d` | `upload-881ce506` | `asset-1869f913` | `preview-3f2b2479` | Archived and detached unsafe ownership links. |
| `product-ec059e3c` | `upload-fbaf23b0` | `asset-0c388c98` | `preview-26f075fd` | Archived and detached unsafe ownership links. |
| `product-7e503d6a` | `upload-f311559f` | `asset-c333e147` | `preview-6191c716` | Archived and detached unsafe ownership links. |
| `product-0fd06164` | `upload-a15852df` | `asset-2812706b` | `preview-a9b1d2c4` | Archived and detached internal-only lane violation. |
| `product-228a1486` | `upload-9c705fe3` | `asset-87906ae4` | `preview-7947fc7a` | Archived and detached unsafe ownership links. |

Note: `product-4761b7db` received one preliminary single-record test revision before the final remediation revision. The final Phase 4F-R revision is the active remediation record.

## Product Library Cleanup Results

Product Library now treats the affected records as archived prototype history, not active reusable product ownership.

Cleanup results:

- Affected products no longer actively link blocked uploads.
- Affected products no longer actively link unsafe Asset Intake records.
- Affected products no longer actively link upload-derived previews.
- Preview counts for archived prototype products are now `0`.
- Product revision histories record the remediation.
- The clean VehicleForge smoke product remains active for future validation.
- SpacecraftForge remains clean and has no product records requiring remediation.

## Lane Violations Repaired

The public-safe/internal-only lane violation was repaired:

- `product-0fd06164` was archived.
- `upload-a15852df` remains internal-only but is no longer linked into active Product Library ownership.
- `asset-2812706b` and `preview-a9b1d2c4` were detached from product ownership and archived.

Lane separation remains strict.

## Integrity After Repair

Final integrity status:

| Scope | Status | Issues | Blocked | Errors |
|---|---:|---:|---:|---:|
| Global Forge store | ok | 0 | 0 | 0 |
| VehicleForge | ok | 0 | 0 | 0 |
| SpacecraftForge | ok | 0 | 0 | 0 |

Final API checks:

- `GET /api/forge/integrity`: `ok`, `0` issues.
- `GET /api/forge/integrity?workspaceId=VehicleForge`: `ok`, `0` issues.
- `GET /api/forge/integrity?workspaceId=SpacecraftForge`: `ok`, `0` issues.

## Structured Part Planning Readiness

Phase 4F Structured Part Planning may safely resume.

Readiness checks:

- Product Library: clean integrity result.
- Concept Packages: no active package records currently inherit unsafe links.
- Structured Part Plans: no active part plan records currently inherit unsafe links.
- Reusable asset links: no active blocked/internal-only asset links remain on the repaired products.
- Workspace ownership: VehicleForge and SpacecraftForge both validate cleanly.

Recommended resume condition:

- Resume Phase 4F only on clean active products.
- Do not use archived prototype upload products as part-planning sources.
- Continue requiring Foundation Integrity checks before package assembly, product approval, job approval, reusable asset linking, and structured part plan generation.

## Post-Build Audit

## What Changed

- Modern Forge data was remediated through existing API routes.
- Product Library prototype cards were archived and detached from unsafe upload/intake/preview ownership.
- Upload, Asset Intake, and Preview records in the affected chains were archived and detached from active Product Library ownership.
- Phase 4F-R remediation metadata was added to affected modern Forge records.

## What Stayed Untouched

- Workshop was not removed.
- Shipyard was not removed.
- ThreeViewer was not removed.
- Viewer was not removed.
- IMVU Creator was not removed.
- DevStudio legacy systems were not removed.
- Protected Aria assets were not moved.
- Protected Gaius assets were not moved.
- MakeHuman and MPFB were not reactivated.
- No heavy editors, viewers, export systems, mesh systems, or texture-baking systems were added.

## Validation Results

| Check | Result | Notes |
|---|---|---|
| API typecheck | Pass | `pnpm --filter @workspace/api-server run typecheck`. |
| Website typecheck | Pass | `pnpm --filter @workspace/landing-page run typecheck`. |
| Mobile typecheck | Pass | `pnpm --filter @workspace/viper-studio run typecheck`. |
| Existing tests | Pass | Mobile tests passed: 60 tests, 0 failures. Existing Node module-type warnings remain warnings only. |
| API build | Pass | `pnpm --filter @workspace/api-server run build`. |
| Website build | Pass | `pnpm --filter @workspace/landing-page run build`. |
| API health check | Pass | `http://127.0.0.1:18082/api/healthz` returned `ok`. |
| Website browser check | Pass | Reports page opened at `http://localhost:19006/landing-page/reports` with no browser console errors. Copy buttons are visible. |
| Mobile startup validation | Pass | Home startup files do not import ThreeViewer, three-scripts, AriaZoneChat, LazyThreeViewer, LazyAriaZoneChat, or usePrefetch. |
| Protected asset validation | Pass | No protected asset files were moved or edited. Protected/public-forbidden terms remain blocked by integrity and service guards. |
| Legacy system validation | Pass | Legacy systems were not deleted or rewritten. |
| Workspace validation | Pass | Global, VehicleForge, and SpacecraftForge integrity checks all return `ok`. |
| Integrity API validation | Pass | Full Forge integrity is `ok`, `0` issues. |

Note: `pnpm` is not on the default shell PATH, so validation used the Codex runtime pnpm shim. This did not require a repo or system install.

## Audit Findings

Strengths:

- The Foundation Integrity validator correctly blocked unsafe active ownership chains.
- The validator caught both blocked upload links and public-safe/internal-only lane mixing.
- Existing API update routes were sufficient for remediation.
- The archive-and-detach strategy preserved history without weakening rules.

Weaknesses:

- Prototype upload smoke records can still become active product records if future smoke tests do not explicitly isolate them.
- Upload-derived products need a clearer "prototype/test/quarantine" lane.
- Product metadata on archived prototype records can become noisy after repeated remediation actions.

Technical debt:

- Add a safer smoke-test fixture path that creates archived/quarantined prototype records by default.
- Consider a dedicated remediation helper endpoint for future cleanup tasks.
- Consider a small Product Library filter that hides archived prototype smoke records from normal workspace product pickers.

## Mobile Impact

Mobile remains lightweight.

Mobile remains limited to:

- guide selection
- idea capture
- references
- job submission
- preview/review
- approve/revise actions

No mobile editors, mesh tools, export tools, heavy viewers, or large asset browsers were added.

## Protected Asset Check

- Aria protected assets were not moved.
- Gaius protected assets were not moved.
- Public avatar generation remains out of scope.
- Public skin generation remains out of scope.
- MakeHuman remains retired.
- MPFB remains retired.
- Internal-only upload lanes remain separated from public-safe Product Library ownership.

## Legacy System Check

Legacy systems remain untouched:

- Workshop
- Shipyard
- ThreeViewer
- Viewer
- IMVU Creator
- DevStudio legacy routes

## Workspace Validation

- VehicleForge now validates cleanly.
- SpacecraftForge continues to validate cleanly.
- Concept Package records are empty and do not carry unsafe links.
- Structured Part Plan records are empty and do not carry unsafe links.
- Archived prototype records are not valid sources for new structured part planning.

## Failures

Resolved:

- Initial API typecheck command failed because `pnpm` was not on PATH in this shell. Validation continued with the Codex runtime pnpm shim and passed.

No remaining validation failures were found.

## Remaining Risks

- Future smoke tests could reintroduce active Product Library cards with blocked uploads unless test records are quarantined by default.
- Archived prototype records still exist for history and should not be used as structured planning sources.
- Some upload/intake/preview records still represent blocked or internal-only material; this is acceptable because they are archived and detached from active public-safe product ownership.

## Recommended Next Phase

Recommended next phase:

`VIPER PHASE 4F STRUCTURED PART PLANNING RESUME`

Safe next implementation step:

- Resume Structured Part Planning only for active clean VehicleForge and SpacecraftForge products.
- Keep Foundation Integrity checks mandatory before structured part plan generation.
- Add a small guard that prevents archived products from being selected as structured part planning sources.

## Success Condition

Success condition met.

The current integrity violations were repaired or safely isolated. VehicleForge and SpacecraftForge now have clean data foundations. Structured Part Planning can safely resume without weakening the integrity layer.
