# Viper Phase 2C Lazy-Loading Report

Date: 2026-06-14

Scope: Phase 2C lazy-loading cleanup. No legacy systems were deleted, no protected assets were moved, and no existing API routes were removed.

## What Was Lazy-Loaded

- `ThreeViewer` is now behind `components/LazyThreeViewer.tsx`.
- `three-scripts.ts` remains owned by ThreeViewer and is now reached only through the lazy ThreeViewer wrapper at the source level.
- `ViperCreatorShell` is now behind `components/LazyViperCreatorShell.tsx`.
- `AriaZoneChat` is now behind `components/LazyAriaZoneChat.tsx`.
- Legacy ThreeViewer entry points now use `LazyThreeViewer`:
  - `app/(legacy)/workshop.tsx`
  - `app/(legacy)/viewer.tsx`
  - `app/(legacy)/imvucreator.tsx`
  - `components/ViperCreatorShell.tsx`
- Non-startup AriaZoneChat entry points now use `LazyAriaZoneChat`:
  - `app/(tabs)/projects.tsx`
  - `app/(legacy)/devstudio.tsx`
  - `app/(legacy)/shipyard.tsx`
  - `app/(legacy)/foundry.tsx`
- DevStudio now uses `LazyViperCreatorShell` instead of importing `ViperCreatorShell` directly.
- Home's static `aria-profile.png` require was removed and replaced with a lightweight drawn Aria guide mark.
- Stale `.expo/types/router.d.ts` cache was cleared after it continued to list old heavy tab paths.

## What Could Not Be Lazy-Loaded

- `ThreeViewer` internals were not rewritten.
- `three-scripts.ts` was not rewritten or split internally.
- Expo Android export still produced a single eager entry bundle, so dynamic/lazy source boundaries did not create isolated native chunks.
- No local Expo export flag was found for native async route splitting. The local `expo export --help` exposes source-map and minify options, but no async-route or split-bundle option.
- `scripts/build.js` still explicitly sets `lazy` to `false`. It was inspected but not changed because the current deployment target has not been proven to support async native route bundles.
- Remaining `assets/aria-profile.png` export presence comes from other surfaces such as `ARIAAvatar`, not Home.

## What Stayed Untouched

- Workshop remains intact.
- ThreeViewer remains intact.
- Viewer remains intact.
- Shipyard remains intact.
- IMVU Creator remains intact.
- DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge remain intact.
- Protected Aria/Gaius assets were not moved.
- Existing API routes were not changed.
- MakeHuman, MPFB, skin generation, and public avatar generation were not reintroduced.

## Startup Cleanliness

Confirmed:

- Home remains the startup route.
- Home remains guide-first.
- Home does not import ThreeViewer.
- Home does not import `three-scripts.ts`.
- Home does not import AriaZoneChat.
- Home does not import or call local `usePrefetch()`.
- Home no longer statically requires `assets/aria-profile.png`.
- Legacy systems remain reachable through Advanced/Legacy.

## Bundle / Source-Map Findings

Android export with source map passed.

Export result:

- Entry bundle: `entry-49f0327ba6a173b021a94af343aba982.hbc`
- Entry bundle size: about 5.85 MB
- Source map size: about 13.5 MB
- Module count reported by Metro: 1587 modules

Parsed source-map result:

| Pattern | Result |
| --- | --- |
| `components/ThreeViewer.tsx` | Still present |
| `lib/three-scripts.ts` | Still present |
| `components/AriaZoneChat.tsx` | Still present |
| `components/ViperCreatorShell.tsx` | Still present |
| `components/LazyThreeViewer.tsx` | Present |
| `components/LazyAriaZoneChat.tsx` | Present |
| `components/LazyViperCreatorShell.tsx` | Present |
| `app/(legacy)/workshop.tsx` | Still present |
| `app/(legacy)/viewer.tsx` | Still present |
| `app/(legacy)/devstudio.tsx` | Still present |
| `app/(tabs)/workshop.tsx` | Not present |
| `app/(tabs)/viewer.tsx` | Not present |
| `ARIA_PORTRAIT` | Not present |

Conclusion:

The code now has safe lazy boundaries, but the current Expo Android export still folds those lazy modules into the single main bundle. This means ThreeViewer and `three-scripts.ts` are not loaded by Home at the source/import path level, but they still appear in the exported native bundle.

## Test Results

- API typecheck passed.
- Mobile typecheck passed.
- Mobile tests passed: 60 passed, 0 failed.
- Android export with source map passed.

## Recommended Phase 2D Step

Phase 2D should be a build-pipeline investigation, not deletion:

1. Research Expo Router native async route support for the exact Expo SDK/router version in use.
2. Test whether native export can safely support lazy chunks or route splitting.
3. If supported, update the build path deliberately instead of blindly changing `scripts/build.js`.
4. Re-run Android export/source-map inspection and confirm whether ThreeViewer and `three-scripts.ts` leave the main entry bundle.
5. If native splitting is not supported, keep the current source lazy boundaries and prioritize moving heavy construction to Website/Forge services.
