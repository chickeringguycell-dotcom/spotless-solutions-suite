# Viper Studios Phase 2 Mobile Lightening Plan

Date: 2026-06-14

Status: planning and review document.

Do not start broad mobile deletion. Do not remove Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, existing API routes, or protected assets.

## Phase 1 Review Confirmation

| Check | Result | Evidence |
|---|---|---|
| Forge shell opens | Confirmed | Local website route returned HTTP 200 at `/landing-page/forge`. |
| Turntable/workspace registry exists | Confirmed | `/api/forge/summary` reports workspace registry data. |
| Job Queue accepts jobs | Confirmed | `/api/forge/jobs` accepted review jobs and returned `submitted`. |
| Product Library foundation exists | Confirmed | `/api/forge/products` returned seed product cards. |
| Texture/Material Forge job path works | Confirmed | `TextureMaterialForge` job returned `material_recipe_and_thumbnail`. |
| Mobile-shaped job payload works | Confirmed | `FurnitureForge` mobile-shaped job returned `submitted`. |
| Existing mobile app still passes tests | Confirmed | Mobile tests passed: 60 passed, 0 failed. |
| No protected assets were moved | Confirmed | Protected Aria V5 asset path still exists. |
| No heavy mobile systems were deleted | Confirmed | Workshop, ThreeViewer, Viewer, Shipyard, and IMVU Creator files still exist. |

Current Forge API summary at review time:

- Workspaces: 12.
- Active workspaces: 2.
- Product cards: 3.
- Existing jobs: present in in-memory queue.

## Phase 2 Goal

Phase 2 should make mobile feel like building with a companion, not launching a complex editor.

The target user flow:

1. Choose guide.
2. Choose what to build.
3. Describe it.
4. Add lightweight references.
5. Submit to Website/Forge.
6. Review thumbnails/previews.
7. Approve or request revisions.

Website/Forge remains the factory for heavy construction.

## What Startup Route Should Become

Startup should become the Home route:

- Route: `app/(tabs)/index.tsx`.
- Tab layout default: `initialRouteName="index"`.
- First visible state: guide chooser.
- No Workshop mount on startup.
- No ThreeViewer mount on startup.
- No full creator workspace mount on startup.

Startup should ask:

> WHO WOULD YOU LIKE TO BUILD WITH?

Guide options:

- Aria.
- Gaius.

Only the selected guide should continue into the session.

## What Workshop Becomes

Workshop should become an advanced legacy/full-mobile Forge route while Website/Forge replacement work continues.

Workshop should:

- Remain operational.
- Remain reachable through an explicit legacy/advanced action.
- No longer be the default startup route.
- No longer define the first mobile experience.
- Not be deleted in Phase 2.
- Not be rewritten broadly in Phase 2.

Recommended label:

- `Legacy Forge`
- `Advanced Forge`
- `Open full mobile Forge`

The wording should make clear that this is not the lightweight companion path.

## What Still Stays On Mobile

Mobile should keep:

- Guide selection.
- Selected guide session.
- Project cards.
- Recent jobs.
- Lightweight Turntable categories.
- Idea description.
- Lightweight notes.
- Reference upload or reference notes.
- Thumbnail review.
- Lightweight preview review.
- Approve action.
- Request revision action.
- Submit-to-Forge job action.
- Settings/account.
- Project dashboard.
- Optional access to legacy heavy routes while migration is incomplete.

Mobile should remain useful even when the full Website/Forge workspace is elsewhere.

## What Must Not Auto-Load

These must not auto-load on mobile startup:

- Workshop.
- ThreeViewer.
- `three-scripts.ts`.
- Viewer.
- Shipyard.
- IMVU Creator.
- DevStudio.
- Storyforge.
- Worldforge.
- Foundry.
- Wardrobe.
- Full Aria/Gaius protected assets.
- Large GLB/FBX assets.
- Animation clips.
- Animation mixers.
- Rigging/retargeting systems.
- Mesh processing tools.
- Texture baking tools.
- UV tools.
- Export/package builders.
- MakeHuman/MPFB paths.
- Public avatar creation.
- Skin generation.
- Fluff systems.
- OpenClaw systems before verification.

Aria/Gaius visual presence on mobile should be lightweight. The app should not load full 3D guide bodies or protected source assets at startup.

## How Aria/Gaius Selection Works

Phase 2 guide selection should work as follows:

1. App opens to Home.
2. Home shows guide chooser.
3. User selects Aria or Gaius.
4. Mobile stores selected guide in local screen/session state.
5. Only selected guide copy, portrait, and guidance language appear.
6. The unselected guide stays unloaded and hidden.
7. User can switch guide through a small change-guide action.

Aria mode:

- Creative guidance.
- Continuity.
- Intent shaping.
- Prompt improvement.
- Job submission help.

Gaius mode:

- Practical inspection.
- Scale logic.
- Build feasibility.
- Material practicality.
- Export/readiness warnings.

Do not load both guide panels, chats, or avatars simultaneously.

## How The Light Turntable Works

The mobile Turntable should expose only six simple categories.

| Mobile category | Includes | Internal Website/Forge workspace mapping |
|---|---|---|
| Vehicles and Spacecraft | spacecraft, fighters, shuttles, cars, trucks, motorcycles, tanks, aircraft, boats | `VehicleForge`, `SpacecraftForge` later |
| Weapons and Tools | guns, rifles, pistols, sci-fi weapons, swords, knives, tools, shields | `WeaponForge` |
| Clothing and Armor | clothing, armor, uniforms, spacesuits, costumes, fashion | `ClothingForge` |
| Furniture and Props | chairs, tables, beds, decorations, props, lights, room objects | `FurnitureForge` |
| Buildings and Structures | houses, rooms, bases, outposts, castles, stations | `BuildingForge`, `RoomForge` later |
| Materials and Textures | paint, metal, fabric, dirt, rust, decals, glow, wear | `TextureMaterialForge` |

Mobile cards should show:

- Category name.
- Short description.
- A few included examples.
- Selected guide hint.
- Submit-to-Forge path.

Mobile cards should not show:

- Dozens of workspaces.
- Heavy workspace controls.
- Full 3D editor controls.
- Export settings beyond target/output intent.

## Clothing And Armor Mobile Rule

Mobile clothing should be concept-only.

Allowed:

- Simple male/female reference mannequin.
- Static or slow-turn lightweight preview.
- Garment description.
- Armor/uniform/costume concept notes.
- Submit-to-Forge job.

Not allowed on mobile startup:

- Heavy runway.
- Heavy avatar systems.
- Animation systems.
- Full fitting.
- Public avatar base tools.
- Skin generation.

Website/Forge owns full fitting and runway experience.

## What Files Are Likely Touched

Likely mobile files:

- `artifacts/viper-studio/app/(tabs)/_layout.tsx`
- `artifacts/viper-studio/app/(tabs)/index.tsx`
- `artifacts/viper-studio/lib/forgeJobs.ts`
- `artifacts/viper-studio/lib/usePrefetch.ts`
- `artifacts/viper-studio/components/AriaZoneChat.tsx` only if startup chat loading needs explicit separation.
- `artifacts/viper-studio/contexts/AppContext.tsx` only if guide context or prompt language needs adjustment.

Likely API/Website files:

- `artifacts/api-server/src/lib/forgeStore.ts`
- `artifacts/api-server/src/routes/forge.ts`
- `artifacts/landing-page/src/pages/ForgePage.tsx`
- `artifacts/landing-page/src/lib/forgeApi.ts`

Docs/memory:

- `docs/VIPER_PHASE_2_MOBILE_LIGHTENING_PLAN_2026-06-14.md`
- `memory/2026-06-14.md`

Files not to delete:

- `artifacts/viper-studio/app/(tabs)/workshop.tsx`
- `artifacts/viper-studio/components/ThreeViewer.tsx`
- `artifacts/viper-studio/app/(tabs)/viewer.tsx`
- `artifacts/viper-studio/app/(tabs)/shipyard.tsx`
- `artifacts/viper-studio/app/(tabs)/imvucreator.tsx`
- Protected Aria/Gaius assets.

## Risk List

- Users may need a clear path to old Workshop while the Website/Forge migration is incomplete.
- Existing screens may assume Workshop is the default route.
- Intent chips or shortcuts may still route directly into Workshop.
- Home may need job persistence beyond the current in-memory API queue.
- Mobile offline behavior needs a local draft queue if Website/Forge is unavailable.
- Gaius currently needs a lightweight portrait/identity treatment that does not depend on large protected assets.
- Clothing mannequin preview must stay simple and avoid becoming a new hidden avatar system.
- Reference uploads must avoid large-file mobile storage.
- API job queue is currently a foundation; durable storage is a future requirement.
- Tests currently cover core logic, not full mobile UI flow.

## Rollback Plan

If Phase 2 causes startup trouble:

1. Restore `_layout.tsx` `initialRouteName` to `workshop`.
2. Restore the previous Home screen file from the prior patch or backup.
3. Keep `/api/forge` in place; it is additive and does not break legacy mobile.
4. Keep Website Forge shell in place; it is additive.
5. Leave hidden legacy routes untouched.
6. Re-run mobile typecheck and mobile tests.
7. Re-open Phase 2 behind a feature flag or settings toggle.

Rollback should not require moving protected assets or deleting new API routes.

## Recommended Phase 2 Implementation Order

1. Confirm Home is the startup route.
2. Add guide chooser.
3. Ensure only selected guide appears.
4. Add six mobile Turntable categories.
5. Map categories to Website/Forge workspace IDs.
6. Add idea description and lightweight references.
7. Add submit-to-Forge payload.
8. Add recent job status and review controls.
9. Hide heavy legacy tabs from primary bottom navigation.
10. Keep explicit access to legacy Workshop.
11. Re-run API, website, and mobile typechecks.
12. Re-run mobile tests.
13. Smoke-test at least one mobile-shaped Forge job.

## Success Criteria

Phase 2 is ready when:

- App startup is Home, not Workshop.
- First screen asks which guide to build with.
- Only selected guide is shown.
- Six-category lightweight Turntable appears after selection.
- Mobile can submit jobs to Website/Forge.
- Workshop remains accessible but is not default startup.
- ThreeViewer does not load at startup.
- Heavy creator systems do not load at startup.
- Existing mobile tests still pass.
- Protected assets remain unmoved.

