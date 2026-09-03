# Viper Studios P0.0 TypeScript Baseline

## Workspace Packages Audited
| Package Name | Path | Build Command | Typecheck Command | Status |
| :--- | :--- | :--- | :--- | :--- |
| **@workspace/scripts** | `scripts` | `tsc -p tsconfig.json` | `tsc -p tsconfig.json --noEmit` | Active |
| **@workspace/mockup-sandbox**| `artifacts/mockup-sandbox` | `tsc -p tsconfig.json` | `tsc -p tsconfig.json --noEmit` | Active |
| **@workspace/api-server** | `artifacts/api-server` | `tsc -p tsconfig.json` | `tsc -p tsconfig.json --noEmit` | Active |
| **@workspace/landing-page** | `artifacts/landing-page` | `tsc -p tsconfig.json` | `tsc -p tsconfig.json --noEmit` | Active |
| **@workspace/viper-studio** | `artifacts/viper-studio` | `tsc -p tsconfig.json` | `tsc -p tsconfig.json --noEmit` | Active |

## Command Executed
`npx pnpm -r run typecheck`

## Result Summary
- **Exit Code**: 2
- **Total Errors**: 10
- **Total Warnings**: 0
- **Failing Package**: `artifacts/api-server`

## Detailed Error Inventory (`artifacts/api-server`)
1. `src/lib/forge/assetIntakeService.ts(172,28)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
2. `src/lib/forge/assetIntakeService.ts(274,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
3. `src/lib/forge/conceptRevisionService.ts(175,9)`: `TS2349: This expression is not callable. No constituent of type '"VehicleForge" | "SpacecraftForge"' is callable.` (Primary)
4. `src/lib/forge/exportReadinessService.ts(350,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
5. `src/lib/forge/generationService.ts(85,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
6. `src/lib/forge/jobQueue.ts(97,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
7. `src/lib/forge/previewService.ts(67,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
8. `src/lib/forge/previewService.ts(67,9)`: `TS2722: Cannot invoke an object which is possibly 'undefined'.` (Cascading)
9. `src/lib/forge/productLibrary.ts(262,9)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
10. `src/lib/forge/uploadStorageService.ts(665,20)`: `TS2349: This expression is not callable. Type 'String' has no call signatures.` (Primary)
