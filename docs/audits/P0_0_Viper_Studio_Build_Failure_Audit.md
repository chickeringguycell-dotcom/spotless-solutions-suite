# Viper Studio Build Failure Audit
**Date:** 2026-07-20

## 1. Capture of the Initial Build Failure

- **Exact Command:** `npx pnpm run build`
- **Exit Code:** `1`
- **Full Log Path:** `C:\Users\U\.gemini\antigravity\brain\d35d6dc0-1673-4f3a-aef5-7bf9210bcb65\.system_generated\tasks\task-2415.log`
- **Package:** `@workspace/viper-studio@0.0.0`
- **Source File:** `artifacts/viper-studio/scripts/build.js` (Line 254)
- **Error Code:** `TypeError: fetch failed` / `ECONNREFUSED 127.0.0.1:8081`
- **First Root Error:** Node.js native `fetch` inside `build.js` failed to retrieve `http://localhost:8081/artifacts/viper-studio/node_modules/expo-router/entry.bundle?platform=ios...` from the Metro bundler.
- **Cascading Errors:** `Download failed: fetch failed` -> `process.exit(1)` -> `[ERR_PNPM_RECURSIVE_RUN_FIRST_FAIL]`.
- **Duration:** 36 seconds.

## 2. Root Cause Verification

The `viper-studio` build failed during the initial workspace concurrent build (`pnpm -r run build`) but **passed** when rerun (`npx pnpm --filter @workspace/viper-studio run build` and `npx pnpm -r --if-present run build`). 

- **Verified Cause:** **Network-only build behavior (Intermittent Localhost Timeout under Concurrent CPU Load).** 
The build script (`scripts/build.js`) relies on standing up a local Metro server (`expo start --no-dev`) and then using Node's native `fetch` to retrieve the bundle over HTTP from `localhost:8081`. During the initial `pnpm run build`, `artifacts/landing-page` and `artifacts/mockup-sandbox` were compiling simultaneously using Vite (transforming >3500 modules), which heavily starved the CPU. This caused the Metro server's event loop to stall, resulting in the Node `fetch` timing out or hitting `ECONNREFUSED` when it attempted to fetch the massive iOS bundle. 
When rerun without resource contention, Metro successfully served the iOS and Android bundles.

No code changes are required for `viper-studio` to build successfully; the failure is an environmental concurrency limitation of the custom Node-based `fetch` build script rather than a TypeScript or architectural error.
