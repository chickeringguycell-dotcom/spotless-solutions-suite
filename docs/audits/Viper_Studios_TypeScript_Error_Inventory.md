# Viper Studios TypeScript Error Inventory

## `api-server` Typecheck Failures

**Command Executed:** `npx pnpm -r run typecheck`
**Exit Status:** 2

**Exact Errors Logged:**
- `src/lib/forge/assetIntakeService.ts(172,28)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/assetIntakeService.ts(274,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/conceptRevisionService.ts(175,9)`: `error TS2349: This expression is not callable. No constituent of type '"VehicleForge" | "SpacecraftForge"' is callable.`
- `src/lib/forge/exportReadinessService.ts(350,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/generationService.ts(85,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/jobQueue.ts(97,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/previewService.ts(67,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/previewService.ts(67,9)`: `error TS2722: Cannot invoke an object which is possibly 'undefined'.`
- `src/lib/forge/productLibrary.ts(262,9)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`
- `src/lib/forge/uploadStorageService.ts(665,20)`: `error TS2349: This expression is not callable. Type 'String' has no call signatures.`

## Root Cause Analysis
The `api-server` codebase is attempting to execute string properties or undefined methods as functions across nearly every core forge service. This indicates a profound architectural mismatch between defined interfaces and implemented logic, or a failed refactor where method definitions were replaced by static string types.

**Blocking Severity:** HIGH. The `api-server` cannot be reliably started or integrated until these strict compilation errors are resolved.
