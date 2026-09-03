# TS2349 Root Cause Table

| Error Location | Broken Symbol | Actual Type | Expected Type | Root Cause | Corrective Change | Downstream Errors Resolved |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `assetIntakeService.ts(172,28)` | `forgeId("asset")` | `string` | `(prefix: string) => string` | Local string variable `forgeId` shadows the imported ID-generator function `forgeId` from `utils.ts`. | Rename local variable `forgeId` to `targetWorkspaceId` or `workspaceForgeId`. | N/A |
| `assetIntakeService.ts(274,9)` | `forgeId("asset")` | `string` | `(prefix: string) => string` | Same as above. | Rename local variable `forgeId` to `targetWorkspaceId`. | N/A |
| `conceptRevisionService.ts(175,9)` | `forgeId("revision")` | `string` | `(prefix: string) => string` | Local string variable `forgeId` shadows the imported ID-generator function `forgeId`. | Rename local variable `forgeId` to `targetWorkspaceId`. | N/A |
| `exportReadinessService.ts(350,9)` | `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | N/A |
| `generationService.ts(85,9)` | `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | N/A |
| `jobQueue.ts(97,9)` | `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | N/A |
| `previewService.ts(67,9)` | `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | `TS2722` possibly 'undefined' in `previewService` |
| `productLibrary.ts(262,9)` | `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | N/A |
| `uploadStorageService.ts(665,20)`| `forgeId(...)` | `string` | `(prefix: string) => string` | Same shadowing issue. | Rename local variable. | N/A |

## Audit Summary
In all failing files under `src/lib/forge/`, the utility function `import { forgeId } from "./utils"` was shadowed by a local `const forgeId = coerceText(...)` representing the string ID of the workspace (e.g., "VehicleForge"). When the code subsequently attempted to generate a unique ID using `forgeId("prefix")`, the TypeScript compiler threw `TS2349: This expression is not callable. Type 'String' has no call signatures.`
