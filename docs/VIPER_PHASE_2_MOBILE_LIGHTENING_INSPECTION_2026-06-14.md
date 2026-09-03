# Viper Phase 2 Mobile Lightening Inspection

Date: 2026-06-14

Scope: inspection and cleanup planning only. No major features were added, no legacy routes were deleted, and no protected systems were moved.

## Verification

| # | Check | Result | Notes |
| --- | --- | --- | --- |
| 1 | Mobile startup opens Home, not Workshop | Pass | `(tabs)/_layout.tsx` uses `initialRouteName="index"`. |
| 2 | First visible screen is guide choice | Pass | Home renders `WHO WOULD YOU LIKE TO BUILD WITH?` before the Turntable. |
| 3 | Aria and Gaius appear as separate guide cards | Pass | `GUIDES` defines separate Aria and Gaius cards. |
| 4 | Selecting Aria loads only Aria flow | Pass | `selectedGuide` gates the Turntable and mini-guide panel. |
| 5 | Selecting Gaius loads only Gaius flow | Pass | Same selected-guide gate is used for Gaius. |
| 6 | Unselected guide does not mount hidden chat/avatar systems | Pass | Home does not import `AriaZoneChat`, avatar systems, or `ThreeViewer`. |
| 7 | Six lightweight Turntable categories appear | Partial | All six categories exist and work, but labels are shortened in UI: `Vehicles`, `Weapons`, `Clothing`, `Furniture & Props`, `Buildings & Structures`, `Materials & Textures`. |
| 8 | Each category maps to a Website/Forge workspace ID | Pass | Mobile maps to `VehicleForge`, `WeaponForge`, `ClothingForge`, `FurnitureForge`, `BuildingForge`, and `TextureMaterialForge`. |
| 9 | Mobile can submit a valid Forge job | Pass | Live job created: `forge-job-9778e4f2`, state `submitted`. |
| 10 | Recent job status displays | Pass | Home review panel displays `${job.id} - ${job.state.toUpperCase()}` after submission. |
| 11 | Review, approve, and revision actions work | Pass | Inspection job patched to `approved`, then `review`; history count became 3. |
| 12 | Clothing preview remains lightweight | Pass | Clothing uses `MannequinPair`, built from React Native views. No hidden avatar system or ThreeViewer mount. |
| 13 | Workshop remains accessible through explicit legacy/advanced access | Pass | Home footer has explicit `LEGACY FORGE` action to `/(tabs)/workshop`. |
| 14 | Heavy tabs are hidden from primary navigation | Pass | Heavy routes use `href: null` in the tab layout. |
| 15 | ThreeViewer is not imported or mounted by Home startup | Pass | Home has no ThreeViewer import or mount. |
| 16 | `three-scripts.ts` is not prefetched at startup | Pass | Home does not call `usePrefetch()`. |
| 17 | AriaZoneChat is not mounted at startup | Pass | Home has no `AriaZoneChat` import or mount. |
| 18 | `usePrefetch()` is not used by Home startup | Pass | `usePrefetch` remains in `lib`, but Home does not import or call it. |
| 19 | Protected Aria/Gaius assets are not moved or loaded at startup | Partial | No assets were moved. Home does statically require `assets/aria-profile.png` for the Aria guide card; Gaius is drawn with lightweight views. |
| 20 | Existing tests still pass | Pass | Mobile typecheck passed, API typecheck passed, mobile tests passed: 60 passed, 0 failed. |

## What Is Confirmed Light

- Home is the mobile startup route.
- Workshop is no longer the default startup experience.
- The first user decision is guide selection: Aria or Gaius.
- The Turntable flow only renders after a guide is selected.
- Home does not import or mount ThreeViewer, AriaZoneChat, avatar mechanics, or `usePrefetch`.
- Reference image picker is dynamically imported only when the user taps image attach.
- Clothing preview is a simple male/female mannequin pair, not a hidden avatar editor.
- Mobile job payloads use the Website/Forge job contract.
- Approve and revision actions use the Forge job state endpoint.

## What Is Still Heavy

- Heavy legacy routes still exist under `app/(tabs)`:
  - `workshop.tsx` is about 199 KB.
  - `viewer.tsx` is about 184 KB.
  - `storyforge.tsx` is about 88 KB.
  - `settings.tsx` is about 84 KB.
  - `devstudio.tsx` is about 78 KB.
  - `wardrobe.tsx` is about 75 KB.
  - `imvucreator.tsx` is about 61 KB.
  - `shipyard.tsx` is about 52 KB.
- `components/ThreeViewer.tsx` is about 363 KB.
- `lib/three-scripts.ts` is about 792 KB.
- `components/AriaZoneChat.tsx` is still imported by non-Home routes.
- Home statically requires `assets/aria-profile.png` for the guide card.
- `IntentChipOverlay` still mounts from the tab layout and can route to Workshop when accepted.

## What May Still Be Bundled

Hiding a route with `href: null` removes it from primary navigation, but does not prove it is absent from the bundle. The current static build script asks Metro for `lazy=false`, so the static build path is likely still an eager bundle.

| System | Hidden From Primary Nav | Startup Mounted By Home | Bundle Risk | Reason |
| --- | --- | --- | --- | --- |
| Workshop | Yes | No | High | Hidden route still lives in `app/(tabs)` and statically imports ThreeViewer. |
| ThreeViewer | N/A | No | High | Statically imported by Workshop, Viewer, IMVU Creator, and ViperCreatorShell. |
| `three-scripts.ts` | N/A | No prefetch | High | Statically imported by ThreeViewer. |
| Viewer | Yes | No | High | Hidden route statically imports ThreeViewer. |
| Shipyard | Yes | No | Medium | Hidden route imports AriaZoneChat and remains a large route. |
| IMVU Creator | Yes | No | High | Hidden route statically imports ThreeViewer. |
| DevStudio | Yes | No | High | Hidden route imports ViperCreatorShell, which imports ThreeViewer, plus AriaZoneChat. |
| Storyforge | Yes | No | Medium | Hidden route remains large and AI-heavy, even without ThreeViewer import. |
| Worldforge | Yes | No | Medium | Hidden route remains in the tab route tree. |
| Foundry | Yes | No | Medium | Hidden route imports AriaZoneChat. |
| Wardrobe | Yes | No | Medium | Hidden route remains large and avatar-adjacent. |

## What Should Be Lazy-Loaded Next

- Move Workshop, Viewer, IMVU Creator, DevStudio, Shipyard, Storyforge, Worldforge, Foundry, and Wardrobe behind an explicit Advanced/Legacy route boundary.
- Convert ThreeViewer entry points to lazy imports so opening Home cannot pull the viewer stack.
- Split `three-scripts.ts` behind ThreeViewer-only loading and verify it is absent from the startup bundle.
- Lazy-load AriaZoneChat on non-Home routes that still need it.
- Replace the Home startup `aria-profile.png` static require with a lightweight guide thumbnail or deferred portrait load if protected guide assets must not bundle at startup.
- Align mobile category labels exactly to: `Vehicles and Spacecraft`, `Weapons and Tools`, `Clothing and Armor`, `Furniture and Props`, `Buildings and Structures`, `Materials and Textures`.
- Run a bundle/source-map inspection after the lazy boundary changes.

## What Should Remain Untouched

- Do not delete Workshop yet.
- Do not delete ThreeViewer yet.
- Do not delete Viewer yet.
- Do not delete Shipyard yet.
- Do not delete IMVU Creator yet.
- Do not delete DevStudio, Storyforge, Worldforge, Foundry, or Wardrobe yet.
- Do not remove existing API routes.
- Do not move protected Aria assets.
- Do not move protected Gaius assets.
- Do not reintroduce MakeHuman, MPFB, skin generation, or public avatar generation.
- Do not migrate large libraries until Website/Forge replacements are ready.

## Recommended Next Safe Implementation Step

Start with a small cleanup pass, not deletion:

1. Rename the six Home category labels to the exact Phase 2 wording.
2. Replace the Home static Aria portrait require with a lightweight/deferred guide-card asset strategy.
3. Add an explicit advanced/legacy route boundary for heavy routes while preserving access.
4. Lazy-load ThreeViewer and AriaZoneChat from those advanced routes.
5. Run a bundle/source-map check to confirm ThreeViewer and `three-scripts.ts` no longer enter startup.

Only after that should Phase 2 proceed to broader mobile-lightening implementation.
