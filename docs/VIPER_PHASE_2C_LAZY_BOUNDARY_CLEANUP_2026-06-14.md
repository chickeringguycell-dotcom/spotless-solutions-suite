# Viper Phase 2C Lazy Boundary Cleanup

Date: 2026-06-14

Scope: safe lazy-boundary cleanup after the Phase 2 inspection and Phase 2B route boundary work. No legacy systems were deleted, no protected assets were moved, and no API routes were removed.

## What Changed

- Added `components/LazyThreeViewer.tsx`.
- Added `components/LazyAriaZoneChat.tsx`.
- Replaced direct ThreeViewer runtime imports with `LazyThreeViewer` in:
  - `app/(legacy)/workshop.tsx`
  - `app/(legacy)/viewer.tsx`
  - `app/(legacy)/imvucreator.tsx`
  - `components/ViperCreatorShell.tsx`
- Replaced direct AriaZoneChat runtime imports with `LazyAriaZoneChat` in:
  - `app/(tabs)/projects.tsx`
  - `app/(legacy)/devstudio.tsx`
  - `app/(legacy)/shipyard.tsx`
  - `app/(legacy)/foundry.tsx`
- Removed Home's static `assets/aria-profile.png` require.
- Replaced the Home Aria guide card image with a lightweight React Native drawn guide mark.

## What Stayed Untouched

- ThreeViewer internals were not rewritten.
- `three-scripts.ts` was not rewritten.
- Workshop, Viewer, Shipyard, IMVU Creator, DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge remain available through Advanced/Legacy.
- Protected Aria and Gaius asset files were not moved.
- Existing API routes were not changed.

## Home Startup Status

Confirmed:

- Home does not import ThreeViewer.
- Home does not import `three-scripts.ts`.
- Home does not import AriaZoneChat.
- Home does not import or call local `usePrefetch()`.
- Home no longer requires `assets/aria-profile.png`.
- Home still uses guide-first startup and the lightweight Turntable.

## Export / Bundle Result

An Android export with source map was run successfully, then the temporary export folder was removed.

Result:

- `components/ThreeViewer.tsx` still appears in the exported Android source map.
- `lib/three-scripts.ts` still appears in the exported Android source map.
- `components/AriaZoneChat.tsx` still appears in the exported Android source map.
- The lazy wrapper files also appear, which confirms the source changes are present.
- Old `app/(tabs)/workshop.tsx` and `app/(tabs)/viewer.tsx` paths do not appear.
- `ARIA_PORTRAIT` no longer appears.
- `assets/aria-profile.png` still appears because other non-Home surfaces, such as `ARIAAvatar`, still reference it.

Conclusion:

React lazy boundaries cleaned up the source-level ownership, but the current Expo Android export still creates a single eager bundle. Lazy wrappers alone are not enough to remove ThreeViewer or `three-scripts.ts` from this export.

## Validation

- Mobile typecheck passed.
- API typecheck passed.
- Mobile tests passed: 60 passed, 0 failed.
- Android export with source map passed.

## What Needs Next

- Investigate Expo Router native async routes or Metro split-bundle support for this deployment target.
- Investigate whether the custom build path can stop forcing eager bundle behavior.
- Keep the lazy wrappers in place as the code-level boundary for the future build split.
- Audit `ARIAAvatar` and onboarding-style surfaces separately if the remaining Aria profile asset must leave the startup/export asset list.
- Re-run source-map checks after build-level splitting changes.
