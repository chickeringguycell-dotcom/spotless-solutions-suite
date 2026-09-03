# Viper Studios New Thread Startup

Use this file to start a fresh Codex thread for Viper Studios.

## Project Root

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project`

## Current Primary Mission

Viper Studios Mobile / Website Sync and App Lightening Plan.

This is a report-first inventory and architecture planning task. Do not implement until the user reviews and approves the report.

## Main Goal

Turn Viper Studios into a clean two-surface platform:

- Website/Forge is the master platform and receives every full capability.
- Mobile app becomes fast, light, responsive, and useful as a control center.
- Nothing important should exist only on mobile.
- If mobile has features, code, tools, panels, assets, or workflows that website/Forge lacks, identify them and recommend copying or rebuilding them on website/Forge before removing or slimming mobile.

## Strict Current Rules

- Do not delete anything.
- Do not remove mobile app features yet.
- Do not rewrite systems yet.
- Do not move files yet.
- Do not touch protected Aria assets.
- MakeHuman / MPFB and Viper Female Base V1 are retired from active Viper production scope.
- Do not revive public avatar generation, skin generation, face skins, eye packs, makeup skins, hair packs, or avatar-base creation.
- Treat Aria and Gaius as protected guide/assistant lanes, not public creator bases.
- Do not resume Aria animation work unless the user explicitly switches back.
- Do not resume Fluff work unless the user explicitly switches back.
- Produce the requested inventory/report first.

## Required Report

Produce a full report with:

1. Full list of what exists on mobile.
2. Full list of what exists on website/Forge.
3. Features/assets/tools that exist only on mobile.
4. Features/assets/tools that exist only on website.
5. Duplicated systems.
6. Largest mobile files.
7. Heaviest mobile systems.
8. What should be copied to website/Forge first.
9. What should be removed from mobile later.
10. What should be archived for later.
11. What must stay on mobile.
12. What should never run on mobile.
13. Exact recommended next implementation step.

The user wants honest engineering judgment, not simple agreement. Challenge the plan if needed. Prioritize performance, responsiveness, simplicity, and user experience over maximum mobile feature count.

## Current Architecture Opinion

What is right:

- Website/Forge as master platform is correct.
- Mobile as control center is correct.
- Loading only one guide, Aria or Gaius, is correct.
- Lightweight turntable/workspace selector is correct if metadata-driven and lazy-loaded.
- Shared backend/manifests are essential.

What is risky:

- Mobile currently carries too many factory screens and large code paths.
- Starting mobile directly in workshop/Forge is risky if it loads 3D and heavy systems immediately.
- Mobile should not embed giant Forge prompts/protocols; intelligence/director logic should move to backend/shared services.
- "Lightweight preview" becomes dangerous if it loads real CC5 GLBs, full textures, animation, and WebView/Three on startup.

Recommended direction:

- Mobile startup should show: "Who would you like to build with today?" with lightweight thumbnails for Aria and Gaius.
- After selection, load only the selected guide presence and chat.
- Do not load the unselected guide, Fluff, full Forge, huge GLBs, or factory panels on startup.
- Mobile turntable should be a lightweight workspace launcher/job submitter, not a full 3D factory scene.
- Website/Forge should receive the full Forge, full Aria/Gaius/Fluff, CC5/Blender integration, animation pipeline, IMVU creator tools, Starfield/Skyrim systems, packaging/export, multi-character scenes, room/world creation, and heavy asset editing.

## Creator Scope Reset

Current user correction:

- Making skins and avatars is not realistic for Viper right now.
- Making the other kinds of IMVU-style products is feasible.

Active scope:

- Clothing and wearable mesh products.
- Accessories and jewelry.
- Props and objects.
- Furniture.
- Rooms and buildings.
- Vehicles and ships.
- Weapons and tools.
- Interior assets.
- Decals, materials, and non-skin texture sets.
- Lighting, effects, audio products, product cards, source notes, derivation metadata, package checks, thumbnails, and export checklists.

Retired from active scope:

- MakeHuman / MPFB production lane.
- Viper Female Base V1 as an active creator foundation.
- Public male/female avatar base creation.
- Skin generation, face skins, makeup skins, eye packs, brows, lashes, lips, nails, and full avatar appearance packages.
- Mobile loading or prefetching of creator-base avatars or skin/avatar factory paths.

Reference doc:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\docs\VIPER_CREATOR_SCOPE_RESET_2026-06-14.md`

## Known Project Paths

Mobile app:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\viper-studio`

Website/landing:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\landing-page`

API/server/asset public area:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\api-server`

Backlog:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\docs\VIPER_BACKLOG.md`

Existing split docs:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\docs\VIPER_APP_WEBSITE_SPLIT.md`

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\docs\VIPER_MOBILE_FORGE_HEALTH_CHECK.md`

## Inspection Findings Already Gathered

Largest mobile tab files:

- `artifacts/viper-studio/app/(tabs)/workshop.tsx` - about 198 KB
- `artifacts/viper-studio/app/(tabs)/viewer.tsx` - about 184 KB
- `artifacts/viper-studio/app/(tabs)/chat.tsx` - about 93 KB
- `artifacts/viper-studio/app/(tabs)/storyforge.tsx` - about 88 KB
- `artifacts/viper-studio/app/(tabs)/settings.tsx` - about 84 KB
- `artifacts/viper-studio/app/(tabs)/devstudio.tsx` - about 78 KB
- `artifacts/viper-studio/app/(tabs)/wardrobe.tsx` - about 75 KB
- `artifacts/viper-studio/app/(tabs)/imvucreator.tsx` - about 61 KB
- `artifacts/viper-studio/app/(tabs)/shipyard.tsx` - about 52 KB
- `artifacts/viper-studio/app/(tabs)/projects.tsx` - about 31 KB
- `artifacts/viper-studio/app/(tabs)/foundry.tsx` - about 29 KB
- `artifacts/viper-studio/app/(tabs)/worldforge.tsx` - about 28 KB
- `artifacts/viper-studio/app/(tabs)/index.tsx` - about 15 KB

Largest mobile component:

- `artifacts/viper-studio/components/ThreeViewer.tsx` - about 363 KB

Other notable mobile components:

- `CreationLibraryScreen.tsx`
- `DressingRoom.tsx`
- `ViperCreatorShell.tsx`
- `ARIAAvatar.tsx`
- `AriaZoneChat.tsx`

Mobile currently starts at Forge:

- `artifacts/viper-studio/app/(tabs)/_layout.tsx`
- `initialRouteName="workshop"`

Visible tabs include:

- HOME
- PROJECTS
- FORGE
- BUILD
- STUDIO
- IMVU
- NARRATIVE
- CONFIG

Hidden routes include:

- viewer
- chat
- wardrobe
- foundry
- worldforge

Mobile `workshop.tsx` is a major bloat risk. It mixes chat, voice, image picking, subscriptions, Aria memory, speech correction, avatar viewer, body shape presets, game research/build intent parsing, local avatar options, and a large Forge prompt/protocol. This is mobile-as-factory, not mobile-as-control-center.

API/public side already contains heavy master assets and diagnostics:

- Aria GLB/FBX assets.
- Aria V5 natural hair GLBs/FBX and textures.
- Camilla motion FBX files.
- Guy motion FBX files.
- Retired Viper Female Base V1 / MakeHuman artifacts that must not be treated as active runtime targets.
- Aria wardrobe library JSON.
- Animation diagnostics and motion forensic reports.
- Public HTML diagnostic/report pages.
- Static library assets, including some retired skin/hair/makeup/avatar references. New active product work should focus on clothing, accessories, objects, rooms, vehicles, ships, weapons, props, and non-skin materials.

Very large API/public assets found:

- `avatars/aria/aria-v4-walk.glb` - about 198 MB
- `avatars/aria/aria-v5-naturalhair-rigged.glb` - about 185 MB
- `avatars/aria/aria-v5-naturalhair-skinned.glb` - about 184 MB
- `avatars/animation-tests/camilla-idle01-cc5-test.glb` - about 155 MB
- `Aria_V4_walk.fbx` - about 98 MB
- `Aria_V5_NaturalHair.fbx` - about 83 MB
- Camilla motion FBXs - about 55 MB each

These should never be mobile startup assets. Mobile needs thumbnails, proxies, or LOD assets only.

## Website/Forge Sync Problem

The website/API side already holds many heavy assets and reports, but the rich interactive creator screens appear more developed in the mobile Expo app than in the current website/landing app.

Core issue:

Mobile became the product prototype.

Website/API became the asset warehouse and report surface.

The master web Forge needs the mobile-born creator workflows copied/rebuilt for desktop web before mobile can be safely slimmed down.

## Green / Yellow / Blue Classification

GREEN - keep on mobile:

- Choose Aria or Gaius.
- Chat with selected guide.
- Project dashboard.
- Project notes and to-do list.
- Job submission and monitoring.
- Notifications.
- Product/asset library cards.
- Current outfit/loadout cards.
- Approve/reject flows.
- Small thumbnails/reference images.

YELLOW - can exist on both if carefully implemented:

- Voice interaction, but not always-on by default.
- Lightweight GLB preview, one asset at a time, LOD/proxy only.
- Lightweight guide avatar presence, not full CC5 asset.
- Asset browser as metadata/cards, not huge file browser.
- Concept builders as template/prompt/job submitters.
- Simple texture/material previews using server-rendered thumbnails or low-res previews.
- Turntable/workspace selector as launcher only.

BLUE - Website/Forge only:

- Full Forge.
- CC5/Blender automation.
- Full avatar/creature creation.
- Rigging.
- Retargeting.
- Motion editing.
- Facial animation editing.
- Full IMVU creator suite and UV/product package assembly.
- High-poly editing.
- Texture baking.
- Heavy rendering.
- Starfield/Skyrim mod assembly and packaging.
- Multi-character scenes.
- Room/world/building editors.
- Full Fluff pipeline.
- Protected Aria full-resolution source assets.

## Backlog Rule

The persistent backlog is:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\docs\VIPER_BACKLOG.md`

Do not start backlog items until the active main objective is complete or blocked.

When the main objective is complete, review the backlog and continue with the next highest priority item.

Backlog themes already established:

- Aria builder-agent vision.
- Hands-free voice system.
- Security audit.
- Product library/wardrobe/loadout system.
- Aria protected identity and wardrobe rules.
- Gaius protected companion role and separate creator-base avatars.
- IMVU-style creator categories and attachment slots.
- Mobile/website split and performance guardrails.
- Starfield AI conversation prototype work.
- Fluff mascot side quest, currently halted and saved.

## Fluff Status

Do not resume unless the user asks.

Fluff was halted and saved here:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\characters\Monster_Fluff_V1_CC5_Handoff`

Zip:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\characters\Monster_Fluff_V1_CC5_Handoff.zip`

Current prototype includes `.blend`, `.fbx`, preview PNG, and report/handoff material.

The user said Fluff is closer but still needs a lot of work, then halted it.

## Aria Protection Status

Do not modify protected Aria assets during the mobile/web sync report.

Important rules:

- Aria is not a public creator base.
- Public creators use separate Male/Female Creator Base avatars.
- Aria face/body/core appearance/voice/identity are protected.
- Permanent modesty layer stays baked/locked.
- Boots, shirt, jacket, and pants are wardrobe assets, not baked base identity.
- No balloon/floating animation.
- No fake pose math.
- Use real CC5 animation clips only.

## Recommended Next Action

Continue the inventory/report.

Inspect these files if needed:

- `artifacts/viper-studio/app/(tabs)/workshop.tsx`
- `artifacts/viper-studio/app/(tabs)/viewer.tsx`
- `artifacts/viper-studio/app/(tabs)/chat.tsx`
- `artifacts/viper-studio/app/(tabs)/devstudio.tsx`
- `artifacts/viper-studio/app/(tabs)/imvucreator.tsx`
- `artifacts/viper-studio/app/(tabs)/storyforge.tsx`
- `artifacts/viper-studio/components/ThreeViewer.tsx`
- `artifacts/landing-page/src/pages/StudioPage.tsx`
- `artifacts/landing-page/src/pages/LandingPage.tsx`
- `artifacts/api-server/public/catalog.json`
- `docs/VIPER_APP_WEBSITE_SPLIT.md`
- `docs/VIPER_MOBILE_FORGE_HEALTH_CHECK.md`

Then produce the requested full report before any changes.
