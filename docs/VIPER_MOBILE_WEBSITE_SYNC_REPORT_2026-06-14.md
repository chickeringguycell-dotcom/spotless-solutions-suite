# Viper Studios Mobile / Website Sync Report

Date: 2026-06-14

Status: report-first planning document. Do not implement from this report until the next step is explicitly approved.

## Scope Corrections

This report follows the older "Mobile / Website Sync and App Lightening Plan" handoff, but it also applies the newer direction from the current thread:

- Fluff is paused and must not be resumed unless explicitly requested.
- OpenClaw did not actually work and remains unresolved. Treat it as a support track needing real verification.
- MakeHuman and MPFB are retired from active Viper Studios scope.
- Public avatar creation and skin creation are retired from active Viper Studios scope.
- Aria V5 remains protected and must not be overwritten or treated as a public creator base.
- Gaius remains a protected guide, not a public creator base.
- Active Viper creator scope is everything feasible around IMVU-style products except public avatars and skins: clothing, accessories, props, furniture, rooms, buildings, vehicles, ships, weapons, tools, non-skin materials, lighting, effects, audio, metadata, product cards, package checks, thumbnails, and export workflows.

## 1. What Exists On Mobile

### Mobile Routes And Screens

The mobile app lives under `artifacts/viper-studio`.

Visible tabs:

- `workshop.tsx` - primary Forge / build surface and current startup tab.
- `projects.tsx` - project dashboard.
- `shipyard.tsx` - large project builder for ships, rooms, subprojects, and assembly planning.
- `devstudio.tsx` - creator/dev studio with image generation and product tooling.
- `imvucreator.tsx` - IMVU creator workspace shell and package/product surface.
- `storyforge.tsx` - narrative/cast/scene production surface.
- `settings.tsx` - account, config, research/game tools, and related controls.
- `index.tsx` - home/start surface.

Hidden tabs still present in the app:

- `chat.tsx` - separate chat surface.
- `viewer.tsx` - full viewer/import/export surface.
- `wardrobe.tsx` - wardrobe/product surface with legacy avatar-adjacent pieces.
- `foundry.tsx` - product/parts generator.
- `worldforge.tsx` - world/environment generator.

The tab layout currently starts at `workshop`, not at the lighter guide-choice experience the newer direction wants.

### Largest Mobile Screen Files

- `workshop.tsx` - about 194 KB.
- `viewer.tsx` - about 180 KB.
- `chat.tsx` - about 91 KB.
- `storyforge.tsx` - about 86 KB.
- `settings.tsx` - about 82 KB.
- `devstudio.tsx` - about 76 KB.
- `wardrobe.tsx` - about 74 KB.
- `imvucreator.tsx` - about 59 KB.
- `shipyard.tsx` - about 51 KB.
- `projects.tsx` - about 31 KB.
- `foundry.tsx` - about 29 KB.
- `worldforge.tsx` - about 27 KB.

### Major Mobile Components

- `ThreeViewer.tsx` - about 354 KB. This is the largest mobile component and is the center of the mobile 3D/viewer weight.
- `CreationLibraryScreen.tsx` - library browsing and saved creator items.
- `DressingRoom.tsx` - wardrobe/preview logic.
- `ViperCreatorShell.tsx` - legacy creator shell.
- `ARIAAvatar.tsx` - guide/avatar presentation.
- `AriaZoneChat.tsx` - Aria chat panel.
- `ChatBubble.tsx` - chat message rendering.
- `PaywallScreen.tsx` - mobile subscription gate.
- `ExportSheet.tsx` - export/share actions.

### Major Mobile Libraries

- `three-scripts.ts` - about 773 KB. This is the biggest single mobile support file.
- `imvuCreatorWorkspace.ts` - creator workspace metadata and product workflow definitions.
- `viperCreation.ts` - creation/project model helpers.
- `intentEngine.ts` - build intent parsing.
- `gameProfiles.ts` - game/target profile definitions.
- `viewerContext.ts` - viewer state/context.
- `avatarMechanics.ts` - legacy avatar mechanics and fit/reference logic.
- `speechCorrection.ts` - voice transcript correction.
- `avatarSystem.ts` - avatar/asset registry logic, now mostly legacy/fit reference after the scope reset.

### Mobile Capabilities Present Today

- Aria chat and guide interaction.
- Voice input, transcript correction, and speech playback.
- Image picking and prompt-to-image calls.
- Local project storage through AsyncStorage.
- Product and creator workspace data stored locally.
- Mobile paywall/subscription surfaces.
- Full mobile 3D viewer and preview logic.
- Import/export/share hooks in the viewer.
- Ship/room planning through Shipyard.
- Product/parts generation through Foundry.
- World/environment generation through Worldforge.
- Narrative/cast/scene generation through Storyforge.
- IMVU-style creator workspace shell.
- Legacy avatar, body, pose, fit, and wardrobe-adjacent surfaces.

## 2. What Exists On Website / Forge

The website/API lives mainly under `artifacts/api-server`.

### Website Pages

- Landing page with public Viper Studios positioning and navigation.
- Studio page with owner-facing chat/image generation.
- ARIA report page.
- Release notes page.
- Community page.
- Static diagnostic/report pages in `public`.

The website has the API and asset hosting backbone, but it does not yet have the full desktop Forge workspace that should replace the heavy mobile authoring surfaces.

### API Routes

Current API surfaces include:

- Health/status.
- Promo validation.
- General chat.
- Aria chat.
- Image generation.
- Shipyard planning.
- Game/research support.
- Build requirements.
- Text-to-speech.
- Image decomposition.
- Learning extraction.
- Gallery.
- Moderation.
- Critique.
- Transcript correction.
- Library.
- Issues.

### Website / Server Assets

The server hosts the largest protected and public assets, including:

- Protected Aria V5 source and generated GLB/FBX assets.
- Aria V4/V5 preview and animation files.
- Motion/animation test assets.
- Retired MakeHuman/Viper Female Base artifacts.
- Legacy texture and creator library data.
- Reports, screenshots, diagnostics, and static manifests.
- `catalog.json` and related library metadata.

Largest asset examples include Aria V4/V5 GLBs in the 175 MB to 190 MB range, animation tests around 148 MB, protected FBX sources around 79 MB to 94 MB, and multiple preview/rejected files around 70 MB to 76 MB.

## 3. Features, Assets, And Tools Only On Mobile

- Full Forge startup screen.
- Full `ThreeViewer` mobile experience.
- Hidden but present full `viewer` route.
- Push-to-talk style voice workflow.
- Mobile transcript correction flow.
- Mobile project dashboard.
- Mobile Shipyard interface.
- Mobile Foundry interface.
- Mobile Worldforge interface.
- Mobile Storyforge interface.
- Mobile DevStudio interface.
- Mobile IMVU Creator interface.
- Mobile Wardrobe interface.
- Camera/image-picker-driven product prompts.
- Local saved project/product state through AsyncStorage.
- RevenueCat/paywall user experience.
- Mobile import/export/share sheet behavior.
- Legacy avatar/body/pose controls and fit-reference controls.

## 4. Features, Assets, And Tools Only On Website / Server

- Public landing site.
- Owner-gated web Studio page.
- API service layer for chat, Aria chat, image generation, TTS, library, gallery, moderation, issues, and build requirements.
- Static hosting for large Aria assets.
- Static hosting for protected/reference source assets.
- Static diagnostic and research reports.
- Server-side asset/library catalogs.
- Gallery and moderation backend concepts.
- Issue tracking endpoint.
- Build requirements endpoint.
- Server-side shipyard route.

## 5. Duplicated Systems

- Aria chat exists in mobile workshop/chat/AriaZoneChat and server routes.
- General chat exists in mobile surfaces and the web Studio page.
- Image generation appears in multiple mobile screens and in the web Studio page.
- Product/library concepts exist in mobile creator screens and server library/catalog files.
- Ship/project planning exists in mobile Shipyard and server Shipyard/build routes.
- Aria identity and creator rules exist in AppContext, server prompts, web prompts, manifests, and docs.
- Viewer/3D logic exists heavily on mobile while the website only has asset hosting and diagnostics, not the desktop Forge replacement.
- Legacy avatar and skin references still exist in older docs/data even though active scope now excludes public avatars and skins.

## 6. Largest Mobile Files

The biggest mobile files are:

- `lib/three-scripts.ts` - about 773 KB.
- `components/ThreeViewer.tsx` - about 354 KB.
- `app/(tabs)/workshop.tsx` - about 194 KB.
- `app/(tabs)/viewer.tsx` - about 180 KB.
- `app/(tabs)/chat.tsx` - about 91 KB.
- `app/(tabs)/storyforge.tsx` - about 86 KB.
- `app/(tabs)/settings.tsx` - about 82 KB.
- `app/(tabs)/devstudio.tsx` - about 76 KB.
- `app/(tabs)/wardrobe.tsx` - about 74 KB.
- `app/(tabs)/imvucreator.tsx` - about 59 KB.
- `lib/imvuCreatorWorkspace.ts` - about 54 KB.
- `app/(tabs)/shipyard.tsx` - about 51 KB.

## 7. Heaviest Mobile Systems

The heaviest mobile systems are:

- Mobile 3D viewer stack: `ThreeViewer.tsx` plus `three-scripts.ts`.
- Workshop startup surface, which mixes chat, voice, image picking, subscriptions, Aria memory, speech correction, build parsing, viewer state, and API calls.
- Full viewer/import/export route.
- Multiple local generator studios: Foundry, Worldforge, DevStudio, Wardrobe, Storyforge, and Shipyard.
- Repeated image-generation UI and API wiring across screens.
- Scattered AsyncStorage persistence across many independent features.
- Voice and speech correction pipeline.
- Legacy avatar/body/pose/skin/wardrobe mechanics that no longer match active scope.
- Paywall/subscription checks spread through multiple screens.

## 8. What Should Be Copied To Website / Forge First

The website should receive the actual desktop Forge first. Copy concepts, not the mobile file structure.

Priority order:

1. Desktop Forge shell: a real owner workspace with tabs/modules instead of only the public landing and basic Studio page.
2. Product Library: saved cards, sources, thumbnails, metadata, package status, and review notes.
3. Foundry: non-avatar product generation for props, accessories, weapons, tools, furniture, mechanical parts, and materials.
4. Shipyard: large project planner for ships, rooms, interiors, subprojects, and assembled product sets.
5. Worldforge: rooms, environments, buildings, staging spaces, lighting, and world assets.
6. Storyforge: narrative/cast/scene planning as production metadata, not as a heavy mobile authoring surface.
7. IMVU Product Package Builder: clothing/accessories/props/furniture/rooms/vehicles/ships/weapons/materials, with public avatars and skins excluded.
8. Aria/Gaius guide chat in the desktop workspace.
9. Job queue/status model so mobile can submit, watch, approve, and lightly edit while the website does heavy work.

## 9. What Should Be Removed From Mobile Later

Remove only after the equivalent website/Forge module exists and is tested.

- Forge as the startup destination.
- Full mobile `ThreeViewer` as a default or central experience.
- Hidden full `viewer` route as a general authoring tool.
- Full mobile Foundry/Worldforge/Shipyard/Storyforge authoring surfaces.
- Repeated image generation panels across many tabs.
- Giant prompt/protocol blocks embedded in mobile UI code.
- Legacy public avatar creation controls.
- Legacy skin creation controls.
- MakeHuman/Viper Female Base active references.
- High-poly GLB/FBX asset paths and protected source asset references from mobile runtime flows.
- Heavy desktop-style import/export/package work from mobile.

## 10. What Should Be Archived For Later

Archive means preserve safely outside active product flow. It does not mean permanently delete unless the user explicitly approves deletion.

- MakeHuman / MPFB / Viper Female Base artifacts.
- Legacy public avatar creation plans.
- Legacy skin/hair/makeup creator plans.
- Rejected pose-math Aria files and preview experiments.
- Fluff prototype materials.
- Old generic avatar candidates.
- Static diagnostic HTML pages that are no longer part of the active owner workflow.
- Old texture/wardrobe experiments that may remain useful as protected references but are not public skin/avatar products.
- OpenClaw notes until it receives a focused verification pass.

## 11. What Must Stay On Mobile

The mobile app should become a light companion/control center.

Keep:

- Startup guide choice: "Who would you like to build with today?" with Aria or Gaius.
- Chat with the selected guide.
- Project list and project status.
- Job submission and job status.
- Approve/reject/needs-revision controls.
- Product cards and lightweight thumbnails.
- Camera/photo upload for references.
- Lightweight prompt capture.
- Lightweight preview/proxy display.
- Notifications and reminders.
- Account/settings.
- Optional voice capture.
- Offline/light local drafts where useful.

## 12. What Should Never Run On Mobile

- Full CC5, Blender, or rigging automation.
- Full GLB/FBX high-poly protected assets.
- Retargeting, motion editing, or animation authoring.
- Full Three.js factory scene on startup.
- Texture baking, UV editing, or final package building.
- Full room/world/ship desktop editors.
- Public avatar creation.
- Public skin creation.
- MakeHuman import or MakeHuman-derived active creator flows.
- Protected Aria/Gaius source asset handling.
- Starfield/Skyrim packaging or mod export work.
- Fluff production pipeline.

## 13. Exact Recommended Next Implementation Step

Build the desktop website Forge shell first.

Recommended next implementation:

1. Add a website Forge workspace route under the existing API/server web app.
2. Give it desktop modules for Dashboard, Product Library, Foundry, Shipyard, Worldforge, Storyforge, and Product Packages.
3. Use static/mock data first, drawn from the current mobile concepts and server manifests, with no heavy GLB/FBX loading by default.
4. Route Aria/Gaius chat through the existing server chat layer.
5. Keep public avatars, skins, MakeHuman, and Fluff out of the active workspace.
6. After this desktop shell exists, change mobile startup to the Aria/Gaius guide chooser and move the heavy mobile Forge behind explicit project actions.

This keeps Viper moving forward without cutting away the current mobile tools before the website has somewhere to receive them.

