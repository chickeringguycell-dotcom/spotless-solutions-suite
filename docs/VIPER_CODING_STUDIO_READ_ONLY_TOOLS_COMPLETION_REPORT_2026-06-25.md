# Viper Coding Studio Read-Only Tools Completion Report

Date: 2026-06-25

Status: complete.

## Mission

Wire the first safe read-only Coding Studio tools so Aria and Gaius can inspect the Viper Studios codebase through Helios without gaining write, edit, delete, commit, or external generator capabilities.

Phase 5 was not started.

External 3D generators were not integrated.

Protected avatar assets were not modified.

Write/edit/commit tools were not implemented.

## Implemented Tools

- `inspectRepository`
- `searchFiles`
- `readFile`
- `gitStatus`
- `gitDiff`

## Runtime Integration

Existing Helios Coding Studio tool slots now execute the real read-only runtime:

- `inspectRepository`
- `searchFiles`
- `readFile`
- `gitStatus`
- `gitDiff`

Write/edit/commit tool slots remain disabled and return `not_implemented`.

New Forge API endpoints:

- `GET /api/forge/coding-studio/inspect-repository`
- `GET /api/forge/coding-studio/search-files`
- `GET /api/forge/coding-studio/read-file`
- `GET /api/forge/coding-studio/git-status`
- `GET /api/forge/coding-studio/git-diff`
- `GET /api/forge/coding-studio/history`

New service:

- `artifacts/api-server/src/lib/forge/codingStudioService.ts`

New verification tests:

- `artifacts/api-server/tests/codingStudioService.test.ts`

New policy map:

- `docs/CODING_DIRECTORY_MAP.md`

## Safety Behavior

The tools enforce read-only behavior.

The tools deny:

- `.env`
- `.env.*`
- `.secrets/`
- secret, token, key, credential, certificate, and private-key file paths
- protected avatar source assets
- `artifacts/api-server/public/avatars/`
- binary and large asset formats
- generated folders
- dependency folders
- cache folders
- log folders
- paths outside `docs/CODING_DIRECTORY_MAP.md`

Large allowed text files are summarized instead of returned in full.

Denied requests return clear policy errors.

Helios workflow history is logged in memory so read-only tool execution does not create or modify files.

## Mission Control / Self Assessment

Forge summary now exposes Coding Studio as:

- status: partial
- read-only tools: 5
- Helios workflow history count

Mission Control status panel now includes:

- `Coding Studio: Read-only tools partial`

Helios Self Assessment now marks Coding Studio as partial, with the read-only tools operational and write/edit/commit tools still disabled.

## Verification Tests

Passed:

- `searchFiles` can find Helios source files.
- `readFile` can read an allowed TypeScript file.
- `readFile` refuses `.env`.
- `readFile` refuses `.secrets/`.
- `readFile` refuses protected avatar assets.
- `gitStatus` works.
- `gitDiff` works.
- Helios Tool Registry executes the real read-only Coding Studio runtime.
- Read-only Coding Studio tools do not modify files.

## Validation Results

Passed:

- `git status --short --branch`
- `npx pnpm --filter @workspace/api-server run typecheck`
- `npx pnpm --filter @workspace/api-server run test:coding-studio`
- `npx pnpm run typecheck`
- `npx pnpm run build`

Notes:

- Existing unrelated avatar-animation work remains in the worktree and was not modified by this Coding Studio implementation.
- Existing line-ending warnings appeared during Git checks but did not block validation.

## Files Changed For This Phase

- `docs/CODING_DIRECTORY_MAP.md`
- `docs/VIPER_CODING_STUDIO_READ_ONLY_TOOLS_COMPLETION_REPORT_2026-06-25.md`
- `artifacts/api-server/package.json`
- `artifacts/api-server/src/lib/forge/codingStudioService.ts`
- `artifacts/api-server/src/lib/forgeStore.ts`
- `artifacts/api-server/src/lib/helios/capabilityRegistry.ts`
- `artifacts/api-server/src/lib/helios/toolRegistry.ts`
- `artifacts/api-server/src/routes/forge.ts`
- `artifacts/api-server/tests/codingStudioService.test.ts`

## Untouched

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- DevStudio legacy systems
- Protected Aria assets
- Protected Gaius assets
- Protected avatar source assets
- External 3D generator integrations
- Write/edit/commit Coding Studio tools

## Remaining Risks

- Helios history is currently in-memory only. This is intentional for the read-only safety gate, but persistent audit history will need a separate design that does not violate read-only tool guarantees.
- `gitDiff` exposes patches only for allowed, non-secret, non-protected text paths. Denied paths are summarized as blocked.
- The directory policy should be reviewed whenever new Viper source folders are added.

## Recommended Next Step

Continue Coding Studio with a review-only UI pass for Aria and Gaius, still without adding write/edit/commit tools.

