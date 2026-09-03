# VIPER BUILD TOOLCHAIN AND SERVER STABILITY REPORT

Date: 2026-06-15

Status: stability/tooling repair complete. Phase 4F feature work remains paused.

Copy-ready note: this report is intentionally standalone so the Reports page can place the copy button directly above it.

## Mission

Repair the build and server validation workflow before any more Phase 4F Structured Part Planning implementation.

No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, DevStudio, and protected assets were not removed or moved.

## Summary

The stability blocker was not Phase 4F TypeScript code.

The actual issues were:

- `pnpm` was not directly available on PATH.
- Corepack could run pnpm, but pnpm 11 tried to verify dependencies before running scripts and triggered the repo's pnpm-only preinstall guard through an internal install check.
- Local server validation did not have a safe reusable Windows workflow, which made broad process-kill commands risky.

Fixes applied:

- Added `verifyDepsBeforeRun: false` to `pnpm-workspace.yaml`.
- Added `scripts/viper-local-server-stability.ps1` for exact-port local server status/start/stop/health checks.

Result:

- API typecheck passed.
- Website typecheck passed.
- Mobile typecheck passed.
- Existing mobile tests passed.
- API build passed.
- Website build passed.
- API health check passed.
- Website browser check passed.

Phase 4F is safe to resume after user authorization, but implementation was not resumed during this task.

## PNPM / Build Toolchain Findings

### Tool Availability

| Tool | Finding |
|---|---|
| `node` | Found at `C:\Program Files\nodejs\node.exe`. |
| `npm` | Found. |
| `npx` | Found. |
| `pnpm` | Not found directly on PATH. |
| `corepack` | Found at `C:\Program Files\nodejs\corepack.cmd`. |
| `corepack pnpm` | Works and reports pnpm `11.5.0`. |

PNPM shims exist on disk, including:

- `C:\Program Files\nodejs\node_modules\corepack\shims\pnpm.cmd`
- Codex runtime Corepack shim paths under `C:\Users\U\AppData\Local\OpenAI\Codex\runtimes\...`

The immediate missing dependency was not pnpm itself. It was the plain `pnpm` command not being exposed on PATH for this shell.

### Workspace Build Expectations

The workspace is pnpm-based:

- root `package.json` uses pnpm for `build` and `typecheck`
- `pnpm-lock.yaml` exists
- `pnpm-workspace.yaml` exists
- `scripts/preinstall-check.cjs` rejects non-pnpm installs

Expected Website build command:

```text
corepack pnpm --filter @workspace/landing-page run build
```

Previous failing command:

```text
pnpm --filter @workspace/landing-page run build
```

Reason it failed:

```text
pnpm : The term 'pnpm' is not recognized
```

### Corepack / PNPM 11 Issue

After switching to Corepack, pnpm reached the workspace but failed because pnpm 11 attempted a dependency status check before running the build. That check tried an internal install and triggered the repo preinstall guard:

```text
Use pnpm instead
```

This was caused by pnpm's `verify-deps-before-run` behavior, not by the Website build itself.

### Build Toolchain Fix

Updated:

```text
pnpm-workspace.yaml
```

Added:

```yaml
verifyDepsBeforeRun: false
```

This keeps the repo's pnpm-only install guard intact while preventing pnpm 11 from attempting an internal install before script execution.

Confirmed pnpm now reads:

```text
"verifyDepsBeforeRun": false
```

Website build now passes with:

```text
corepack pnpm --filter @workspace/landing-page run build
```

### Alternative Build Command

The landing page also has a direct local Vite command available:

```text
artifacts\landing-page\node_modules\.bin\vite.cmd build --config vite.config.ts
```

This should remain a fallback only. The preferred workspace command is Corepack + pnpm.

## Safe Server Restart Findings

### Risk Found

The prior crash audit identified the most likely Codex crash source:

Broad process command-line matching can accidentally match the currently running PowerShell command and terminate the active Codex/tool process.

The repo did not have a safe Windows-specific local API/Website restart helper for validation.

### Existing Server Commands

Observed server-related commands:

- Landing page `dev`: Vite dev server.
- Landing page `serve`: Vite preview server.
- API `start`: Node starts `dist/index.mjs`.
- Mobile Replit dev command uses Unix `fuser` against specific ports for Replit workflow.
- Mobile scripts kill only child Metro processes they spawn.

No protected assets or legacy app systems were touched.

### Server Stability Fix

Added:

```text
scripts/viper-local-server-stability.ps1
```

The helper supports:

- `status`
- `start`
- `stop`
- `health`

Safety rules:

- checks exact port owners only
- filters to Node process owners
- excludes the current shell process
- refuses to stop unexpected process owners
- avoids broad substring-wide process killing
- uses expected command patterns for API and Website stops

Default local validation ports:

- API: `18082`
- Website: `19006`

Local health URLs:

- `http://127.0.0.1:18082/api/healthz`
- `http://127.0.0.1:19006/landing-page/`

## Validation Results

Validation was rerun after the tooling repair.

| Order | Check | Command | Result | Notes |
|---|---|---|---|---|
| 1 | API typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\api-server\tsconfig.json --noEmit` | PASS | No errors. |
| 2 | Website typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\landing-page\tsconfig.json --noEmit` | PASS | No errors. |
| 3 | Mobile typecheck | `.\node_modules\.bin\tsc.cmd -p artifacts\viper-studio\tsconfig.json --noEmit` | PASS | No errors. |
| 4 | Existing mobile tests | `node --experimental-strip-types --test lib\__tests__\ariaCmdParser.test.ts lib\__tests__\avatarMechanics.test.ts __tests__\jumpsuit-seam.test.ts` | PASS | 60 tests passed. Package format warnings only. |
| 5 | API build | `node artifacts\api-server\build.mjs` | PASS | Build completed. |
| 6 | Website build | `corepack pnpm --filter @workspace/landing-page run build` | PASS | Vite built successfully. |
| 7 | API health check | `scripts\viper-local-server-stability.ps1 -Action health` | PASS | API returned 200. Website health also returned 200. |
| 8 | Website browser check | In-app browser at `http://127.0.0.1:19006/landing-page/forge` | PASS | Forge shell loaded. Vehicle Forge and Spacecraft Forge visible. No browser console errors. |

## Server Validation Details

Safe stop result:

```text
Stopped only the exact Vite Node process on port 19006.
API port 18082 was already free.
```

Safe start result:

```text
API listening on port 18082.
Website listening on port 19006.
```

Health result:

```text
API     http://127.0.0.1:18082/api/healthz          200
Website http://127.0.0.1:19006/landing-page/        200
```

Browser result:

```text
URL: http://127.0.0.1:19006/landing-page/forge
Title: Viper Forge - Workspace Shell
Vehicle Forge visible: yes
Spacecraft Forge visible: yes
Forge API unavailable text: no
Browser console errors: none
```

## Phase 4F Safety Check

Inspected partial Phase 4F files:

- `artifacts/api-server/src/lib/forge/structuredPartPlanService.ts`
- `artifacts/api-server/src/lib/forgeStore.ts`
- `artifacts/api-server/src/routes/forge.ts`
- `artifacts/api-server/src/lib/forge/reviewQueueService.ts`
- `artifacts/landing-page/src/lib/forgeApi.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`

### Import Safety

No broken imports were observed. Typechecks passed.

Observed import direction:

```text
routes/forge.ts -> forgeStore
forgeStore -> conceptPackageService
forgeStore -> structuredPartPlanService
forgeStore -> reviewQueueService
reviewQueueService -> conceptPackageService
reviewQueueService -> structuredPartPlanService
structuredPartPlanService -> conceptPackageService
```

No obvious circular dependency was found.

### Route Safety

Structured Part Plan routes are registered:

- `GET /api/forge/structured-part-plans`
- `POST /api/forge/structured-part-plans`
- `GET /api/forge/structured-part-plans/:partPlanId`
- `POST /api/forge/structured-part-plans/:partPlanId/actions`

Runtime route check:

```text
GET http://127.0.0.1:18082/api/forge/structured-part-plans
Status: 200
Response: {"partPlans":[],"statuses":["draft","generated","needs_revision","approved","archived"]}
```

### ForgePage Safety

No missing handler was observed. Typecheck and browser load both passed.

Static effect review found:

- target profile sync effect
- workspace reset effect keyed to `workspace.id`
- initial summary load effect

No obvious render loop was found.

The Structured Part Plan panel exists in code, but no part plans are currently present. That is expected because Phase 4F implementation remains unfinished and paused.

## Fixes Applied

1. Added `verifyDepsBeforeRun: false` to `pnpm-workspace.yaml`.
2. Added `scripts/viper-local-server-stability.ps1`.

No Phase 4F feature implementation was continued.

## Remaining Risks

- Plain `pnpm` is still not on PATH. Use `corepack pnpm` unless PATH is repaired globally.
- The Viper project folder is still untracked under the Git root, so Git cannot provide normal changed-file review for the project.
- Existing mobile tests still emit package format warnings. They are non-fatal but still noisy.
- Phase 4F remains partially implemented and should not be considered complete.
- Local validation servers are currently running on ports `18082` and `19006`.

## Phase 4F Resume Decision

Phase 4F may safely resume after user authorization.

Reason:

- build tooling now works
- safe server validation works
- Codex is no longer relying on broad process-kill commands
- API/Website/Mobile typechecks pass
- mobile tests pass
- API and Website builds pass
- API and Website runtime health checks pass
- Forge shell opens in browser without console errors

Do not continue Phase 4F automatically from this report. Resume only when the user authorizes the next implementation step.

## Recommended Next Action

Resume Phase 4F Structured Part Planning only after confirming this stability report is accepted.

When resuming, start with the smallest remaining Phase 4F work item and keep using:

```text
corepack pnpm --filter @workspace/landing-page run build
scripts\viper-local-server-stability.ps1 -Action health
```

Use the safe server helper for local API/Website validation instead of ad hoc process-kill commands.
