# Viper Mobile Lightening Inspection

Date: 2026-06-14

Scope: inspection only. No new features were added, no legacy routes were deleted, and no protected assets were moved.

## Verification

| Check | Result | Notes |
| --- | --- | --- |
| App starts on Home | Pass | `(tabs)/_layout.tsx` now uses `initialRouteName="index"`. |
| Workshop is no longer initial route | Pass | Workshop remains present but hidden from tabs with `href: null`. |
| ThreeViewer is not imported or mounted by Home startup | Pass | Home has no `ThreeViewer` import or mount. |
| AriaZoneChat is not mounted on startup | Pass | Home has no `AriaZoneChat` import or mount. |
| `usePrefetch()` is not used on Home startup | Pass | Home does not import or call `usePrefetch()`. |
| Only selected guide continues into Turntable flow | Pass | Turntable content is gated behind `selectedGuide`. |
| Aria and Gaius do not both load at startup | Pass with note | Startup shows two lightweight selection cards. Only the selected guide continues into the session panel. |
| Six mobile Turntable categories work | Pass with label note | All six functional categories exist and map to Forge workspaces. UI labels are currently shortened: `Vehicles`, `Weapons`, `Clothing`, `Furniture & Props`, `Buildings & Structures`, `Materials & Textures`. |
| Mobile job payloads submit to `/api/forge/jobs` | Pass | Live inspection job created: `forge-job-b9872eb2`, state `submitted`. |
| Heavy legacy routes remain available but hidden | Pass | `workshop`, `viewer`, `shipyard`, `devstudio`, `imvucreator`, `storyforge`, `wardrobe`, `foundry`, and `worldforge` are hidden from primary tabs. |
| Existing tests still pass | Pass | Mobile typecheck passed, API typecheck passed, and mobile tests passed: 60 passed, 0 failed. |

## What Is Now Light

- Home is the first mobile route.
- Workshop is no longer the default startup surface.
- Home does not import or mount `ThreeViewer`, `AriaZoneChat`, or `usePrefetch()`.
- The first screen is guide selection: Aria or Gaius.
- The Turntable only appears after guide selection.
- Home uses six simple mobile build categories and sends concept jobs to Website/Forge.
- Image picking is imported only when the user chooses to attach a reference image.
- Heavy creator destinations are hidden from primary navigation.

## What Is Still Heavy

- Legacy heavy screens still exist in the mobile app route tree:
  - `workshop.tsx` is about 199 KB.
  - `viewer.tsx` is about 184 KB.
  - `storyforge.tsx`, `settings.tsx`, `devstudio.tsx`, `wardrobe.tsx`, `imvucreator.tsx`, and `shipyard.tsx` are still large route files.
- `components/ThreeViewer.tsx` is about 363 KB.
- `lib/three-scripts.ts` is about 792 KB.
- `AriaZoneChat` is still used by several non-Home routes.
- `IntentChipOverlay` still mounts from the tab layout and can route to Workshop when accepted.

## What Still Leaks Into Startup Or Bundle

- Static startup is clean: Home does not import the viewer stack, AriaZoneChat, or prefetch hook.
- Bundle risk remains: hidden Expo Router routes still live inside `app/(tabs)`, so hiding them with `href: null` does not prove they are excluded from the mobile bundle.
- `ThreeViewer` is still statically imported by `workshop`, `viewer`, `imvucreator`, and `ViperCreatorShell`.
- `ThreeViewer` statically imports `three-scripts`, so any route chunk that includes `ThreeViewer` can pull in the large script payload.
- A bundle analyzer or Expo export/source-map pass is still needed before claiming the heavy stack is fully out of the mobile bundle.

## Recommended Next Safe Step

Do not delete legacy systems yet. The next safe step is a routing/bundle boundary pass:

1. Move heavy legacy screens behind an explicit Advanced/Legacy route boundary or lazy-loaded route group.
2. Keep their URLs available, but keep them out of default tab registration and startup discovery where possible.
3. Convert `ThreeViewer` entry points to lazy imports where Expo/React Native supports it safely.
4. Run a bundle/source-map inspection to confirm whether `ThreeViewer` and `three-scripts` leave the startup bundle.
5. Align mobile category display labels to the requested wording: `Vehicles and Spacecraft`, `Weapons and Tools`, `Clothing and Armor`, `Furniture and Props`, `Buildings and Structures`, `Materials and Textures`.

## Do Not Touch List

- Do not delete Workshop yet.
- Do not delete ThreeViewer yet.
- Do not delete Viewer yet.
- Do not delete Shipyard yet.
- Do not delete IMVU Creator yet.
- Do not delete existing API routes.
- Do not move protected Aria assets.
- Do not move protected Gaius assets.
- Do not reintroduce MakeHuman, MPFB, skin generation, or public avatar generation.
- Do not move large asset libraries until Website/Forge replacements are ready.
