# Viper Phase 2B Bundle Boundary Cleanup

Date: 2026-06-14

Scope: safe bundle/startup cleanup. No legacy systems were deleted, no protected assets were moved, and no existing API routes were removed.

## What Changed

- Kept Home as the mobile startup route.
- Kept the guide-first startup flow.
- Renamed the six mobile Turntable category labels to the requested wording:
  - Vehicles and Spacecraft
  - Weapons and Tools
  - Clothing and Armor
  - Furniture and Props
  - Buildings and Structures
  - Materials and Textures
- Moved heavy route files out of `app/(tabs)` and into `app/(legacy)`:
  - Workshop
  - Viewer
  - Shipyard
  - IMVU Creator
  - DevStudio
  - Storyforge
  - Wardrobe
  - Foundry
  - Worldforge
- Added a lightweight `app/(legacy)/index.tsx` Advanced/Legacy chooser.
- Added `app/(legacy)/_layout.tsx` as the explicit legacy stack boundary.
- Added the `(legacy)` stack group to the root app layout.
- Changed the Home footer button from direct Workshop access to the Advanced/Legacy chooser.
- Changed `IntentChipOverlay` so accepted intent returns to Home instead of pushing Workshop.
- Updated remaining explicit Viewer links to use the legacy route group.

## What Stayed Untouched

- Workshop implementation was not deleted or rewritten.
- ThreeViewer was not deleted or rewritten.
- `three-scripts.ts` was not deleted or rewritten.
- Viewer, Shipyard, IMVU Creator, DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge remain intact.
- Protected Aria and Gaius assets were not moved.
- Existing API routes were not changed.
- MakeHuman, MPFB, skin generation, and public avatar generation were not reintroduced.

## Heavy Routes Reachability

Heavy systems are no longer registered as primary tab screens. They remain reachable only through explicit Advanced/Legacy access:

- Home -> Advanced/Legacy -> Workshop
- Home -> Advanced/Legacy -> Viewer
- Home -> Advanced/Legacy -> Shipyard
- Home -> Advanced/Legacy -> IMVU Creator
- Home -> Advanced/Legacy -> DevStudio
- Home -> Advanced/Legacy -> Storyforge
- Home -> Advanced/Legacy -> Wardrobe
- Home -> Advanced/Legacy -> Foundry
- Home -> Advanced/Legacy -> Worldforge

Chat and Projects links that open Viewer now route to `/(legacy)/viewer`.

## Home Startup Cleanliness

Confirmed clean:

- Home does not import `ThreeViewer`.
- Home does not import `three-scripts.ts`.
- Home does not import `AriaZoneChat`.
- Home does not import or call the local `usePrefetch()` hook.
- Workshop is not the initial route.
- Heavy route files are no longer inside `app/(tabs)`.

Remaining startup note:

- Home still statically requires `assets/aria-profile.png` for the Aria guide card. This is not a heavy viewer system, but it remains a startup asset candidate for Phase 2C.

## Bundle Inspection

An Android export with source map was run successfully for inspection, then the temporary export folder was removed.

Result:

- `ThreeViewer` still appears in the exported bundle/source map.
- `lib/three-scripts.ts` still appears in the exported bundle/source map.
- Legacy route modules still appear in the exported bundle/source map.
- Old `app/(tabs)/workshop` and `app/(tabs)/viewer` source paths did not appear in the parsed source map.
- `AriaZoneChat` still appears because it is used by `Projects` and several legacy routes.
- The build/export path still uses an eager bundle style; `scripts/build.js` requests `lazy=false`.

Conclusion:

The route boundary cleanup improved ownership and navigation safety, but it did not yet remove ThreeViewer or `three-scripts.ts` from the exported Android bundle. True bundle reduction needs lazy route/module work in Phase 2C.

## Validation

- Mobile typecheck passed.
- API typecheck passed.
- Mobile tests passed: 60 passed, 0 failed.
- Android export with source map passed.

## What Needs Phase 2C

- Investigate Expo Router async routes or bundle splitting for native exports.
- Change the build/export path away from eager `lazy=false` behavior if compatible with the deployment target.
- Lazy-load `ThreeViewer` from legacy routes before the component module is imported.
- Lazy-load `ViperCreatorShell`, because it statically imports ThreeViewer.
- Lazy-load `AriaZoneChat` from Projects and legacy routes.
- Replace Home's static `aria-profile.png` require with a lighter or deferred guide portrait strategy.
- Regenerate or clear Expo Router generated route types so stale old `(tabs)` heavy route names disappear from `.expo/types`.

## Recommended Next Safe Implementation Step

Phase 2C should be a lazy-loading pass, not a deletion pass:

1. Add lazy boundaries around `ThreeViewer` entry points in Workshop, Viewer, IMVU Creator, and ViperCreatorShell.
2. Add lazy boundaries around `AriaZoneChat` in Projects and legacy routes.
3. Re-run Android export with source map.
4. Confirm `ThreeViewer` and `three-scripts.ts` are absent from the startup bundle or isolated into a lazy chunk.
5. Keep all heavy systems reachable through Advanced/Legacy until Website/Forge replacements are complete.
