# Viper Phase 3E DevStudio Separation Report

Date: 2026-06-14

Scope: DevStudio separation pass. This pass inspected the legacy DevStudio route, classified its major features, and migrated only clearly safe product generation paths toward Forge services. No legacy systems were deleted. Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, protected assets, and existing API routes were not removed or moved.

Source reports used:

- `VIPER_PHASE_3_CORE_SERVICES_REPORT_2026-06-14.md`
- `VIPER_PHASE_3B_SERVICE_WORKER_HANDOFF_REPORT_2026-06-14.md`
- `VIPER_PHASE_3C_APP_TO_FORGE_MIGRATION_REPORT_2026-06-14.md`
- `VIPER_PHASE_3D_TARGET_PROFILE_EXPORT_READINESS_REPORT_2026-06-14.md`

## Executive Result

DevStudio is no longer a mystery box.

It is a mixed legacy route containing:

- Product-safe Dev Lab part generation.
- Product-safe non-avatar CreatorHub map generation.
- Protected/internal avatar maintenance surfaces.
- Protected wardrobe and dressing-room surfaces.
- Retired or dormant avatar/skin generation definitions.
- A lazy Aria chat panel.

Safe product paths were bridged to Forge Generation and Preview services. Protected/internal and retired paths were left untouched.

## Implementation Performed

Updated:

- `artifacts/viper-studio/app/(legacy)/devstudio.tsx`

Safe changes:

- Dev Lab part AI generation now uses `requestForgeGenerationPreview()`.
- Dev Lab generation now creates Forge generation request and preview records.
- Dev Lab routes outputs by category/style:
  - texture style -> `TextureMaterialForge`
  - weapon category -> `WeaponForge`
  - cockpit/hull/engine/landing gear -> `VehicleForge`
  - other ship/prop parts -> `FurnitureForge`
- CreatorHub now starts in `vehicle`, not `avatar`.
- CreatorHub non-avatar texture/map generation now uses `requestForgeGenerationPreview()`.
- CreatorHub routes visible product types:
  - vehicle -> `VehicleForge`
  - clothing -> `ClothingForge`
  - prop -> `FurnitureForge`
  - environment -> `BuildingForge`
- Avatar/skin CreatorHub paths remain unbridged and out of public Forge migration.
- Protected/internal avatar preview commands remain untouched.

Not changed:

- Avatar Studio.
- Dressing Room.
- Wardrobe assets.
- Protected Aria assets.
- Protected Gaius assets.
- ThreeViewer.
- Workshop.
- IMVU Creator.
- MakeHuman/MPFB status.

## Full DevStudio Inventory

| Feature | Location | Classification | Migration Candidate | Risk | Recommended Action |
|---|---|---:|---:|---:|---|
| DevStudio route shell and studio tabs | `artifacts/viper-studio/app/(legacy)/devstudio.tsx` | PROTECTED_INTERNAL | No | Medium | Keep as explicit Advanced/Legacy route. Do not make it mobile startup. |
| Archive tab / CreationLibraryScreen | `devstudio.tsx`, `components/CreationLibraryScreen.tsx`, `lib/viperCreation.ts` | PROTECTED_INTERNAL | Partial | Medium | Later split non-avatar creations into Product Library; keep avatar records internal. |
| Dev Lab local part records | `devstudio.tsx`, `STORAGE_KEY = viper_devparts_v1` | SAFE_PRODUCT | Yes | Low | Keep local compatibility now; later mirror non-avatar records into Product Library. |
| Dev Lab add part modal | `devstudio.tsx` | SAFE_PRODUCT | Yes | Low | Future Forge job/product creation source. |
| Dev Lab category presets | `devstudio.tsx`, `CATEGORY_PRESETS` | SAFE_PRODUCT | Yes | Low | Map categories to Forge workspaces; initial mapping added in this pass. |
| Dev Lab style selector | `devstudio.tsx`, `STYLE_OPTIONS` | SAFE_PRODUCT | Yes | Low | Continue using as generation metadata for previews. |
| Dev Lab AI image generation | `devstudio.tsx`, `handleAIGenerate()` | SAFE_PRODUCT | Yes | Low | Migrated to Forge generation-preview bridge. |
| Dev Lab manual photo import | `devstudio.tsx`, `handleManualImport()` | SAFE_PRODUCT | Yes | Medium | Later add asset upload/Preview Service attachment. Do not fake server ownership for local URI files yet. |
| Dev Lab camera capture | `devstudio.tsx`, `handleCamera()` | SAFE_PRODUCT | Yes | Medium | Later add explicit upload/scan flow before Preview/Product Library ownership. |
| Dev Lab image source badges and clear/delete actions | `devstudio.tsx` | SAFE_PRODUCT | Partial | Low | Keep local now; later map clear/archive to Product Library revision actions. |
| CreatorHub visible product selector | `devstudio.tsx`, `CREATOR_PRODUCTS` | SAFE_PRODUCT | Yes | Low | Vehicle, clothing, prop, and environment remain product-safe lanes. |
| CreatorHub non-avatar map slots | `devstudio.tsx`, `CREATOR_MAP_SLOTS.vehicle/clothing/prop/environment` | SAFE_PRODUCT | Yes | Medium | Migrated generation to Forge previews; later attach product cards and metadata. |
| CreatorHub non-avatar AI map generation | `devstudio.tsx`, `aiGenerate()` | SAFE_PRODUCT | Yes | Medium | Migrated to Forge generation-preview bridge when product type is not avatar. |
| CreatorHub manual map upload | `devstudio.tsx`, `pickMap()` | SAFE_PRODUCT | Yes | Medium | Keep local until upload/asset service exists. |
| CreatorHub staging area | `devstudio.tsx`, `StagingArea()` | PROTECTED_INTERNAL | No | High | Internal reference/staging only. Do not migrate to public Forge. |
| CreatorHub preview-on-avatar command | `devstudio.tsx`, `previewOnAvatar()` | PROTECTED_INTERNAL | No | High | Keep internal; it queues avatar texture commands and should not become public product flow. |
| Avatar texture presets | `devstudio.tsx`, `AVATAR_TEXTURE_PRESETS` | RETIRED | No | High | Leave dormant. Do not reactivate public avatar/skin generation. |
| Avatar texture prompt templates | `devstudio.tsx`, `AVATAR_TEXTURE_PROMPTS` | RETIRED | No | High | Leave dormant; do not migrate to Forge. |
| CreatorHub avatar map slots | `devstudio.tsx`, `CREATOR_MAP_SLOTS.avatar` | RETIRED | No | High | Retain only as legacy/internal code. Not visible in product selector after this pass. |
| Avatar Studio tab | `devstudio.tsx`, `LazyViperCreatorShell` | PROTECTED_INTERNAL | No | Very High | Keep as internal legacy route. Do not migrate into public Forge. |
| ViperCreatorShell live avatar editor | `components/ViperCreatorShell.tsx` | PROTECTED_INTERNAL | No | Very High | Uses LazyThreeViewer, body types, skin/makeup/face/eye assets. Leave untouched. |
| ViperCreatorShell skin and makeup swatches | `components/ViperCreatorShell.tsx` | PROTECTED_INTERNAL | No | Very High | Protected/internal avatar maintenance only. |
| Aria signature assets | `components/ViperCreatorShell.tsx`, `components/DressingRoom.tsx` | PROTECTED_INTERNAL | No | Very High | Do not move, expose, or productize. |
| Atelier tab | `devstudio.tsx`, embeds `app/(legacy)/wardrobe.tsx` | SAFE_PRODUCT | Already bridged | Medium | Clothing concept generation already routes to `ClothingForge` from Phase 3C. Keep guardrails. |
| Wardrobe tab / DressingRoom | `devstudio.tsx`, `components/DressingRoom.tsx` | PROTECTED_INTERNAL | No | High | Contains skin/face/Aria locked assets and avatar loadouts. Keep internal. |
| DressingRoom clothing/accessory library items | `components/DressingRoom.tsx` | PROTECTED_INTERNAL | Partial later | High | Split clothing/accessory-only inventory later if needed; do not touch skin/face/Aria assets. |
| Lazy Aria Zone Chat | `devstudio.tsx`, `LazyAriaZoneChat` | PROTECTED_INTERNAL | No | Medium | Keep lazy and legacy-only. Do not mount on Home startup. |
| Paywall/subscription gating | `devstudio.tsx`, `useSubscription()` | SAFE_PRODUCT | No | Low | Keep existing gating around AI generation. |
| MakeHuman | DevStudio scan | RETIRED | No | Low | No active DevStudio import or string found. Do not introduce. |
| MPFB | DevStudio scan | RETIRED | No | Low | No active DevStudio import or string found. Do not introduce. |

## SAFE_PRODUCT List

These can move toward Forge services:

- Dev Lab part records.
- Dev Lab category/style metadata.
- Dev Lab AI part generation.
- Dev Lab manual reference import, after an upload/asset service exists.
- Dev Lab camera reference capture, after an upload/asset service exists.
- CreatorHub vehicle map slots.
- CreatorHub clothing map slots.
- CreatorHub prop map slots.
- CreatorHub environment/building map slots.
- CreatorHub non-avatar AI map generation.
- Atelier clothing concept generation, already bridged in Phase 3C.
- Non-avatar archive records, after they are separated from avatar records.

## PROTECTED_INTERNAL List

These remain internal:

- Avatar Studio tab.
- `LazyViperCreatorShell`.
- `ViperCreatorShell`.
- LazyThreeViewer usage inside Avatar Studio.
- Avatar body type, gender, expression, skin, face, hair, eye, makeup, and texture maintenance.
- CreatorHub staging area.
- CreatorHub `previewOnAvatar()` command path.
- DressingRoom body, face, skin, eyes, hair, tattoo, freckles, and saved look systems.
- Locked Aria signature assets.
- Protected wardrobe/loadout assets.
- Lazy Aria Zone Chat inside DevStudio.
- Any future Gaius protected guide assets, if added.

## RETIRED List

These should stay retired and not migrate:

- MakeHuman.
- MPFB.
- Public avatar generation.
- Public skin generation.
- Dormant avatar texture prompt templates.
- Dormant Avatar CreatorHub map generation.
- Retired avatar pipeline concepts that would generate new public bodies, faces, skins, or base avatars.

## Forge Alignment For SAFE_PRODUCT Features

| SAFE_PRODUCT Feature | Current DevStudio Behavior | Future Forge Destination |
|---|---|---|
| Dev Lab spacecraft part concept | Local part record plus AI image | Generation Service -> Preview Service -> Product Library |
| Dev Lab texture-style part | Local part record plus texture image | TextureMaterialForge -> Generation Service -> Preview Service -> Product Library |
| Dev Lab weapon part | Local part record plus AI image | WeaponForge -> Generation Service -> Preview Service -> Product Library |
| Dev Lab vehicle/ship component | Local part record plus AI image | VehicleForge -> Generation Service -> Preview Service -> Product Library |
| Dev Lab prop/interior component | Local part record plus AI image | FurnitureForge -> Generation Service -> Preview Service -> Product Library |
| CreatorHub vehicle map | Local texture map slot | VehicleForge -> Preview Service -> Product Library metadata |
| CreatorHub clothing map | Local texture map slot | ClothingForge -> Preview Service -> Product Library metadata |
| CreatorHub prop map | Local texture map slot | FurnitureForge -> Preview Service -> Product Library metadata |
| CreatorHub environment map | Local texture map slot | BuildingForge -> Preview Service -> Product Library metadata |
| Atelier clothing concepts | Wardrobe local draft plus generated preview | ClothingForge -> Generation Service -> Preview Service -> Product Library |
| Manual photo references | Local URI only | Asset upload/scan service -> Preview Service -> Product Library source tracking |

## Migration Candidates

First candidates:

1. Create Product Library cards from Dev Lab generated previews.
2. Create Product Library cards from CreatorHub non-avatar generated maps.
3. Attach DevStudio generated preview IDs to Product Library revision history.
4. Add upload/scan support for manual Dev Lab and CreatorHub imports.
5. Split CreationLibraryScreen records by creation type so non-avatar records can migrate without pulling avatar records.

Not candidates yet:

- Avatar Studio.
- DressingRoom.
- Avatar CreatorHub slots.
- Avatar/skin prompt templates.
- Locked Aria assets.
- Any skin/body/face generation.

## Risks

- DevStudio remains a legacy route with many embedded modes.
- Avatar Studio still loads LazyThreeViewer when explicitly opened.
- Native Android production export may still include legacy route code, as Phase 2D already found.
- Dev Lab and CreatorHub still keep local AsyncStorage state for compatibility.
- Manual images remain local URIs until an upload/asset service exists.
- Product Library cards are not automatically created yet for DevStudio outputs.
- CreatorHub still contains dormant avatar slot definitions in the file; they are not migrated and should remain retired/protected.
- DressingRoom contains both clothing/accessory assets and skin/face/protected assets, so it must not be migrated as a whole.

## Recommended First SAFE_PRODUCT Migration

The next safe implementation step is:

Create Product Library cards for Dev Lab generated outputs only.

Recommended shape:

1. After Dev Lab generation returns a Forge preview ID, create or update a Product Library card.
2. Use the part name as product name.
3. Use category/style/project context as metadata.
4. Attach the Forge preview ID.
5. Keep local AsyncStorage record for backward compatibility.
6. Do not create product cards for avatar, skin, face, body, hair, makeup, protected wardrobe, or locked Aria/Gaius assets.

This gives Forge ownership of product records without touching protected avatar systems.

## Test Results

Passed:

- API typecheck.
- Website typecheck.
- Mobile typecheck.
- Existing mobile tests: 60 passed, 0 failed.

Known warning:

- Node test runner still reports module type warnings for TypeScript test files. This existed before this pass and did not fail tests.

## No-Touch Confirmation

Not deleted or removed:

- Workshop.
- ThreeViewer.
- Viewer.
- Shipyard.
- IMVU Creator.
- Protected Aria assets.
- Protected Gaius assets.
- Existing API routes.
- MakeHuman/MPFB retirement status.
- Public avatar/skin retirement status.

## Success Condition

Met.

DevStudio is now separated into product-safe, protected/internal, and retired categories. The first safe product generation paths now flow through Forge Generation and Preview services, while protected/internal avatar systems and retired avatar/skin generation remain untouched.
