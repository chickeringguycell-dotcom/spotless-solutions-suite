# VIPER CODEX CRASH AUDIT PHASE 4F STABILITY REPORT

Date: 2026-06-15

Status: stability audit complete. Phase 4F feature work remains paused.

Copy-ready note: this report is intentionally written as a single standalone document so the Reports page can place its copy button directly above it.

## Mission

Stop new feature work and investigate the repeated Codex/session crashes during Phase 4F Structured Part Planning.

No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, DevStudio, and protected assets were not removed or moved.

## Short Answer

The project does not currently show a TypeScript failure in the API, Website, or Mobile projects. The API build also passes.

The validation stopped at the Website build because `pnpm` is not available in the current shell environment. That is a tooling/environment failure, not a Viper code failure.

The repeated Codex crash pattern is most likely caused by unsafe process-management commands used while restarting/checking servers. A previous server-kill command could match its own PowerShell command line and terminate the active tool process, which fits the observed `Exit code: -1` crash behavior.

Phase 4F can probably continue after the build tooling and server restart workflow are stabilized, but it should not continue until the Website build, API health check, and browser check can complete cleanly.

## Current Worktree State

Git status could not provide a normal changed-file diff for this project because the whole Viper project folder is currently untracked under the Git root:

```text
Git root: C:/Users/U
Status: ?? "Documents/Codex/Projects/Viper Studio/project/"
```

Because of that, this audit used direct file inspection instead of relying on Git diff.

## Phase 4F Partial Files Found

These Phase 4F files or partially touched files exist:

| File | State |
|---|---|
| `artifacts/api-server/src/lib/forge/structuredPartPlanService.ts` | Exists. Structured Part Planning service file is present. |
| `artifacts/api-server/src/lib/forge/types.ts` | Exists. Structured part plan types/statuses appear to be added. |
| `artifacts/api-server/src/lib/forgeStore.ts` | Exists. Forge summary/export wiring appears partially updated. |
| `artifacts/api-server/src/routes/forge.ts` | Exists. Structured part plan API routes appear wired. |
| `artifacts/api-server/src/lib/forge/reviewQueueService.ts` | Exists. Review Queue integration appears partially updated. |
| `artifacts/landing-page/src/lib/forgeApi.ts` | Exists. Website API client types/functions appear partially updated. |
| `artifacts/landing-page/src/pages/ForgePage.tsx` | Exists. Forge page has Structured Part Plan panel wiring. |
| `docs/VIPER_PHASE_4F_STRUCTURED_PART_PLANNING_REPORT_2026-06-15.md` | Not found. Phase 4F implementation report was not created. |

## ForgePage Partial Wiring

`ForgePage.tsx` contains Phase 4F UI wiring for:

- `Structured Part Plan`
- `Part Relationships`
- `Planned Parts`
- `Planning Readiness`
- structured part plan generate/action handlers
- parent state for `generatingPartPlanPackageId`
- parent state for `actingPartPlanId`

This confirms Phase 4F was partly implemented before the crash audit pause.

## Validation Results

Validation was run in the requested order and stopped at the first failure.

| Order | Check | Command | Result | First Error / Notes |
|---|---|---|---|---|
| 1 | API typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\api-server\tsconfig.json --noEmit` | PASS | No errors. |
| 2 | Website typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\landing-page\tsconfig.json --noEmit` | PASS | No errors. |
| 3 | Mobile typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\viper-studio\tsconfig.json --noEmit` | PASS | No errors. |
| 4 | Existing mobile tests | `node --experimental-strip-types --test lib\__tests__\ariaCmdParser.test.ts lib\__tests__\avatarMechanics.test.ts __tests__\jumpsuit-seam.test.ts` | PASS | 60 tests passed. Package format warnings only. |
| 5 | API build | `node artifacts\api-server\build.mjs` | PASS | Build completed. |
| 6 | Website build | `pnpm --filter @workspace/landing-page run build` | FAIL | `pnpm` is not recognized in this shell. |
| 7 | API server health check | Not run | SKIPPED | Stopped at first failure as requested. |
| 8 | Website browser check | Not run | SKIPPED | Stopped at first failure as requested. |

## First Failing Command

```text
pnpm --filter @workspace/landing-page run build
```

First error:

```text
pnpm : The term 'pnpm' is not recognized as the name of a cmdlet, function, script file, or operable program.
```

Likely cause:

The current shell environment does not have `pnpm` on PATH. The root project scripts depend on `pnpm`, and the landing-page package build script depends on Vite through the workspace package setup.

This does not indicate a Website code failure by itself.

## Crash Source Inspection

### TypeScript Failure

Not observed.

API, Website, and Mobile typechecks all passed.

### Build Failure

API build passed.

Website build did not reach Viper code because `pnpm` was unavailable.

### Browser Or Render Loop

Not proven.

Static inspection of `ForgePage.tsx` found normal state effects:

- one target-profile sync effect
- one workspace reset effect keyed to `workspace.id`
- one initial summary load effect

No obvious infinite render loop was found during static inspection. Runtime browser validation was not run because validation stopped at the Website build failure.

### API Route Error

Not observed in typecheck or API build.

Runtime API health check was not run because validation stopped at the Website build failure.

### Circular Import Risk

No obvious circular import was found in the Phase 4F service chain.

Observed import direction:

```text
routes/forge.ts -> forgeStore
forgeStore -> structuredPartPlanService
forgeStore -> reviewQueueService
reviewQueueService -> structuredPartPlanService
structuredPartPlanService -> conceptPackageService
```

`structuredPartPlanService.ts` does not appear to import `forgeStore` or `reviewQueueService`, which reduces the immediate circular-import risk.

### Malformed Cache

No clear malformed cache issue was found.

Observed cache/build folders:

| Path | State |
|---|---|
| `artifacts/viper-studio/.expo` | Exists, last modified 2026-05-30. |
| `artifacts/landing-page/.vite` | Not present. |
| `artifacts/landing-page/dist` | Exists, last modified 2026-06-14. |
| `artifacts/api-server/dist` | Exists, refreshed by the passing API build. |

No cache cleanup was performed.

### Memory Issue

No direct evidence of a Viper memory issue was found during this audit.

### Codex / Session Instability

Likely contributor.

The most suspicious crash source is a prior PowerShell process-kill pattern used while trying to restart/check the API server. A command that searches all process command lines for the API server path can also match its own currently running PowerShell command line, then terminate the active tool process.

That matches the repeated `Exit code: -1` behavior seen around server restart attempts.

Safer future rule:

- do not kill processes by broad command-line substring alone
- filter to `node.exe` first
- exclude the current PowerShell process id
- avoid matching the literal text of the currently running command
- prefer starting a new server on a known port only after checking existing listeners safely

## Fixes Applied

No code fixes were applied during this audit.

Reason:

The user requested stabilization and investigation first. The first actual validation failure is environment/tooling related, not a code defect requiring a small patch.

## Remaining Risks

- Phase 4F is partially implemented and should be treated as unfinished.
- Website build has not been proven because `pnpm` is unavailable in the current shell.
- API server runtime health was not checked after the audit because validation stopped at the first failure.
- Website browser behavior was not checked after the audit because validation stopped at the first failure.
- The Viper project being untracked under the Git root makes change review and rollback much harder.
- Two landing-page Node processes were observed during inspection, so stale dev servers may confuse browser checks unless handled carefully.

## Can Phase 4F Safely Continue?

Not yet.

The code looks stable through:

- API typecheck
- Website typecheck
- Mobile typecheck
- existing mobile tests
- API build

But Phase 4F should not continue until:

1. `pnpm` or the equivalent workspace build command is available in the shell.
2. Website build passes.
3. API server health check passes.
4. Website browser check passes.
5. Server restart commands are changed to avoid killing the active Codex/tool process.

## Recommended Next Action

First stabilize the build and server-check workflow:

1. Restore or expose `pnpm` in the shell environment, or use a documented equivalent workspace build path.
2. Re-run validation starting at Website build.
3. Use a safer server health-check flow that does not broadly terminate matching process command lines.
4. Confirm the Website Forge page opens without render loops.
5. Only then resume Phase 4F implementation or create the Phase 4F implementation report.

## Audit Conclusion

The repeated crashes are most likely not caused by a TypeScript failure in Viper.

The strongest current explanation is a combination of:

- Codex/session tool instability triggered by unsafe process-kill commands
- missing `pnpm` in the current shell, blocking the Website build validation
- unfinished Phase 4F edits that should remain paused until full validation can complete

Viper is partially stable, but not fully cleared for Phase 4F continuation yet.
