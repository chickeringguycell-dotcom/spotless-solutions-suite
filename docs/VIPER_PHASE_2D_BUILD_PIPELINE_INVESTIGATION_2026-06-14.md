# Viper Phase 2D Build Pipeline Investigation

Date: 2026-06-14

Scope: Investigate whether Viper's Expo Android build can truly split heavy legacy code out of the main native bundle. No legacy systems were deleted, no protected assets were moved, and `scripts/build.js` was inspected but not changed.

## Executive Finding

Viper's current Expo Android production export cannot be relied on to split Workshop, ThreeViewer, `three-scripts.ts`, AriaZoneChat, ViperCreatorShell, or legacy route code out of the main native bundle.

Phase 2C successfully created source-level lazy boundaries and kept Home startup clean, but the current Android export path still emits one eager Hermes entry bundle. The practical path is:

1. Keep runtime startup clean.
2. Keep heavy tools behind explicit Advanced/Legacy access.
3. Finish Website/Forge replacements.
4. Use a later production-exclusion or separate Advanced build strategy to remove heavy mobile code from production bundles when replacement coverage is ready.

## Current Expo / Router / Metro Setup

- Mobile app: `artifacts/viper-studio`
- Entry point: `expo-router/entry`
- Expo SDK package: `expo@~54.0.35`
- Expo CLI package: `@expo/cli@54.0.23`
- Expo Router package: `expo-router@~6.0.24`
- React Native: `0.81.5`
- Metro config: default `getDefaultConfig(__dirname)` from `expo/metro-config`
- `app.json` has the `expo-router` plugin enabled with an `origin`, but no `asyncRoutes` setting.
- `app.json` experiments currently include `typedRoutes: true` and `reactCompiler: false`.

## Current Build Behavior

The normal Expo Android export was run with:

```text
expo export --platform android --output-dir .phase2d-export-check --source-maps --clear
```

Result:

- Android export passed.
- Metro reported one Android entry bundle with 1,587 bundled modules.
- Entry bundle: `entry-49f0327ba6a173b021a94af343aba982.hbc`
- Entry bundle size: 5,846,280 bytes, about 5.85 MB.
- Source map: `entry-49f0327ba6a173b021a94af343aba982.hbc.map`
- Source map size: 13,458,679 bytes, about 13.5 MB.
- Parsed source-map source count: 1,558 sources.

Source-map findings:

| Pattern | Present in Android source map |
| --- | --- |
| `components/ThreeViewer.tsx` | Yes |
| `lib/three-scripts.ts` | Yes |
| `components/AriaZoneChat.tsx` | Yes |
| `components/ViperCreatorShell.tsx` | Yes |
| `components/LazyThreeViewer.tsx` | Yes |
| `components/LazyAriaZoneChat.tsx` | Yes |
| `components/LazyViperCreatorShell.tsx` | Yes |
| `app/(legacy)/workshop.tsx` | Yes |
| `app/(legacy)/viewer.tsx` | Yes |
| `app/(legacy)/devstudio.tsx` | Yes |
| `app/(tabs)/workshop.tsx` | No |
| `app/(tabs)/viewer.tsx` | No |
| `assets/aria-profile.png` | Yes |
| `ARIA_PORTRAIT` | No |

Interpretation:

- The heavy tab routes are no longer in `app/(tabs)`.
- Legacy route modules still enter the Android native bundle because Expo Router discovers the route files that remain under `app/(legacy)`.
- Lazy wrappers exist in the bundle, but the modules behind those wrappers are still bundled into the same native entry artifact.
- Home startup remains clean at the source level, but bundle size is still affected by reachable legacy route files.

## scripts/build.js Findings

The mobile build script is `artifacts/viper-studio/scripts/build.js`.

It:

- Starts Metro with `expo start --no-dev --minify --localhost`.
- Downloads one `expo-router/entry.bundle` for iOS.
- Downloads one `expo-router/entry.bundle` for Android.
- Forces `lazy=false` on the bundle request.
- Writes one `bundle.js` per platform into `static-build`.
- Extracts assets by scanning the downloaded bundle text.
- Rewrites manifest launch assets to point at the single platform bundle.

The `lazy=false` setting is consistent with the rest of the script: the script assumes a complete, deterministic, single bundle per platform. Changing this to `lazy=true` would not be a safe one-line fix because the downloader, asset extraction, and manifest rewrite logic do not currently know how to discover, copy, host, and load async chunks.

## Why Phase 2C Lazy Wrappers Did Not Reduce the Native Bundle

Phase 2C changed source-level ownership:

- Home does not import ThreeViewer.
- Home does not import `three-scripts.ts`.
- Home does not import AriaZoneChat.
- Home does not call local `usePrefetch()`.
- Heavy tools are behind Advanced/Legacy and lazy wrappers.

That protects runtime startup work, but it does not guarantee production native bundle splitting. React lazy imports are only useful for bundle size when the bundler and runtime emit and load separate chunks. In Viper's current Android export, Expo/Metro still creates one native entry bundle, so the lazy boundary is folded into that single artifact.

## Native Async Routes Support

Official Expo documentation says Expo Router async routes can split route bundles, but the caveats currently state that async routes do not support native production apps yet:

- https://docs.expo.dev/router/web/async-routes/

Expo's Metro documentation also describes automatic bundle splitting as web-only:

- https://docs.expo.dev/guides/customizing-metro/#bundle-splitting
- https://docs.expo.dev/versions/latest/config/metro/#bundle-splitting

Conclusion:

- Native production async route splitting is not a supported solution for this project today.
- Setting `asyncRoutes.android = true` is not recommended as a production strategy.
- `expo export --help` in this project exposes no native split-bundle, async-route, or lazy-chunk export flag.

## Is lazy=true Safe?

Not for the current production/static mobile build path.

Reasons:

- `scripts/build.js` explicitly downloads one bundle per platform.
- Asset discovery scans that one bundle.
- Manifest output points to that one bundle.
- Expo docs do not support native production async routes yet.
- A runtime feature that works during development would not prove production Android bundle reduction.

Recommendation:

- Do not change `scripts/build.js` from `lazy=false` in Phase 2D.
- Do not enable native async routes for Android production in this build until Expo documents native production support and Viper has a chunk-aware downloader/manifest pipeline.

## Can Metro Create Split Native Bundles For Android?

Not through Viper's current managed Expo export path.

The documented automatic split-bundle path is for web. Android export still produces one Hermes bytecode entry bundle. Metro may support advanced custom bundling in other React Native setups, but that would be a custom native build architecture, not a safe Phase 2 mobile-lightening step for this project.

## Can Legacy Routes Be Production-Excluded?

Yes, but only through build-time exclusion, not a normal runtime feature flag.

A runtime flag that hides Advanced/Legacy screens will not remove their files from the Expo Router route graph or Metro bundle if the route files and static imports remain reachable.

Production exclusion would need one of these later strategies:

1. Separate production and Advanced/Legacy build profiles.
2. Move heavy legacy route implementations outside the production Expo Router `app` tree and provide production route stubs.
3. Use a build-time file selection or generation step so production mobile sees only lightweight routes.
4. Use a carefully tested Metro resolver alias to replace heavy legacy modules with lightweight stubs in production.
5. Keep a development/Advanced build that still includes full Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge.

Expo supports build variants for development/preview/production apps, which fits the recommended Advanced build direction:

- https://docs.expo.dev/build-reference/variants/

## Recommended Strategy

Recommended path for Viper:

1. Accept that current Android production export is one eager native bundle.
2. Keep the Phase 2C lazy wrappers because they protect runtime startup and clarify ownership.
3. Keep Home as the guide-first startup route.
4. Keep Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge reachable only through Advanced/Legacy.
5. Do not chase unsupported native async-route splitting in this build.
6. Make Website/Forge the heavy-work destination.
7. Plan a Phase 2E production-exclusion architecture:
   - Production mobile build: lightweight guide-first app plus Website/Forge handoff.
   - Advanced/Legacy development build: includes full legacy creator tools.
   - Website/Forge: owns heavy rendering, mesh tools, texture processing, animation systems, exports, libraries, and full creator workspaces.

## Risks

- Changing `scripts/build.js` to `lazy=true` could break static bundle download, asset extraction, and manifest generation.
- Enabling Android async routes could create confusing development behavior without reducing production native bundle size.
- A runtime feature flag will hide legacy routes from users but will not remove them from the bundle.
- Metro resolver aliases could hide code in production, but mistakes could break Advanced/Legacy route resolution.
- Generated Expo Router route types are currently noisy and can include stale paths after route moves. Source-map inspection is a more reliable bundle signal than the generated `.expo/types/router.d.ts` cache.
- Keeping heavy legacy tools in the production route tree means the Android bundle remains larger until production exclusion or real removal happens later.

## Rollback Notes

No build-script change was made.

Current safe rollback posture:

- Leave `scripts/build.js` with `lazy=false`.
- Keep Phase 2C lazy wrappers.
- Keep legacy tools under explicit Advanced/Legacy access.
- If generated route types become stale, clear `.expo` cache and regenerate from the current route tree.
- Remove temporary export folders after inspection.

## Validation Results

- API typecheck: passed.
- Mobile typecheck: passed.
- Mobile tests: passed, 60 passed and 0 failed.
- Android export with source map: passed.
- Android source-map inspection: heavy legacy modules still present in the single native entry bundle.

## Recommended Phase 2E Action

Phase 2E should be a production-exclusion design pass, not deletion.

Suggested Phase 2E mission:

1. Design separate `production-mobile` and `advanced-legacy` build profiles.
2. Decide whether production mobile should use route stubs, build-time file selection, or a separate lightweight app entry.
3. Keep Advanced/Legacy builds available for Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, DevStudio, Storyforge, Wardrobe, Foundry, and Worldforge.
4. Keep production mobile focused on guide selection, light Turntable categories, project review, thumbnails/previews, approvals, revision requests, and Forge job submission.
5. Re-run Android export/source-map inspection after the production-exclusion prototype.

Success condition for Phase 2E:

- Production mobile bundle no longer includes heavy legacy tool implementations, while an Advanced/Legacy build still preserves those tools until Website/Forge replacements are complete.
