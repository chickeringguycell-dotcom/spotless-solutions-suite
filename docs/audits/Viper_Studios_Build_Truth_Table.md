# Viper Studios Build Truth Table

| Package | Path | Command | Result | Classification | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **scripts** | `scripts` | `tsc -p tsconfig.json --noEmit` | Passed | BUILDS | Clean compilation. |
| **mockup-sandbox** | `artifacts/mockup-sandbox` | `tsc -p tsconfig.json --noEmit` | Passed | BUILDS | Clean compilation. |
| **landing-page** | `artifacts/landing-page` | `tsc -p tsconfig.json --noEmit` | Passed | BUILDS | Clean compilation. |
| **viper-studio** | `artifacts/viper-studio` | `tsc -p tsconfig.json --noEmit` | Passed | BUILDS | Clean compilation. |
| **api-server** | `artifacts/api-server` | `tsc -p tsconfig.json --noEmit` & `node ./build.mjs` | Passed | VERIFIED COMPLETE | Clean compilation and runtime process starts. |
| **Workspace Build** | `/` | `pnpm -r --if-present run build` | Passed | VERIFIED COMPLETE | All 13 packages typecheck and build cleanly. |

## Summary
All frontend, mock, and API artifacts compile and build cleanly. The central API server (`api-server`) starts and the `/api/healthz` route responds successfully. Database connectivity is currently BLOCKED/UNVERIFIED due to missing local PostgreSQL installation.
