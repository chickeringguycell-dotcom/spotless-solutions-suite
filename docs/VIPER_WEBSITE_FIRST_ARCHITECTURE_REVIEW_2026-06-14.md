# Viper Studios Website-First Architecture Review

Date: 2026-06-14

Status: planning only.

Do not implement changes yet. Do not move files yet. Do not delete systems yet.

## Executive Decision

Website/Forge is the master Viper Studios platform.

Mobile is the companion/control center.

Website/Forge performs heavy lifting:

- Large asset libraries.
- Full workspace tools.
- Heavy previews.
- Mesh processing.
- Texture processing and baking.
- Rigging.
- Animation.
- Export/package building.
- Project compilation.
- AI generation workloads.
- Background services.

Mobile provides access:

- Aria and Gaius guidance.
- Project list and status.
- Concepts and notes.
- Lightweight thumbnails/previews.
- Review and approval.
- Small reference uploads.
- Job submission to Forge.

## Scope Guardrails

This review includes all major systems named in current Viper planning, but applies the active scope reset:

- Fluff remains paused.
- OpenClaw remains unresolved until verified.
- MakeHuman/MPFB are retired from active Viper scope.
- Public avatar generation is retired from active scope unless explicitly reopened.
- Public skin generation is retired from active scope.
- Avatar Forge can exist only as Website Only, internal/protected, or deferred planning for Aria/Gaius maintenance.
- Texture/Material Forge is active for object materials, fabric, metal, paint, dirt, wear, glow, decals, trims, and non-skin surfaces.
- Clothing Forge may use protected fit references, but those references are not public avatar bases.

## Evidence From Current Project

Mobile has the weight of the old all-in-one design:

- `artifacts/viper-studio/lib/three-scripts.ts` is about 773 KB.
- `artifacts/viper-studio/components/ThreeViewer.tsx` is about 354 KB.
- `artifacts/viper-studio/app/(tabs)/workshop.tsx` is about 194 KB.
- `artifacts/viper-studio/app/(tabs)/viewer.tsx` is about 180 KB.
- `artifacts/viper-studio/app/(tabs)/chat.tsx` is about 91 KB.
- `artifacts/viper-studio/app/(tabs)/storyforge.tsx` is about 86 KB.
- `artifacts/viper-studio/app/(tabs)/settings.tsx` is about 82 KB.
- `artifacts/viper-studio/app/(tabs)/devstudio.tsx` is about 76 KB.
- `artifacts/viper-studio/app/(tabs)/wardrobe.tsx` is about 74 KB.

Website/API already has useful service pieces:

- `/api/chat`
- `/api/aria`
- `/api/imagine`
- `/api/tts`
- `/api/library`
- `/api/gallery`
- `/api/moderation`
- `/api/issues`
- `/api/shipyard`
- `/api/build-requirements`
- `/api/correctTranscript`
- `/api/decompose-image`
- `/api/extract-learnings`
- `/api/critique`

Server/public assets already include very large protected/reference files:

- Aria GLB/FBX assets around 70 MB to 190 MB.
- Animation test assets around 148 MB.
- Protected source FBX files around 79 MB to 94 MB.
- A source zip around 66 MB.

Conclusion: the project already proves the website/server side is the correct home for heavy assets and heavy workflows.

## Classification Legend

- Mobile Essential: must remain in the mobile app.
- Mobile Optional: may exist on mobile if lightweight and on demand.
- Website Preferred: best owned by Website/Forge, with mobile acting as requester/reviewer.
- Website Only: should not run on mobile.

## System Classification

| System | Purpose | Mobile value | Website value | Impact | Recommended location | Migration priority |
|---|---|---|---|---|---|---|
| Aria Guide | Main creative guide and project assistant. | Essential conversation, continuity, next-step help. | Shared guide intelligence across all workspaces. | Memory low/medium, storage low, performance low/medium depending on avatar/voice. | Mobile Essential plus Website Preferred shared service. | P0 |
| Gaius Guide | Practical inspector for scale, function, export readiness. | Optional review voice and checklist help. | Strong value inside full Forge workspaces. | Memory low, storage low, performance low. | Mobile Optional plus Website Preferred. | P1 |
| Turntable Workspace Loader | Chooses the active workspace and loads only what is needed. | Essential as lightweight category/job selector. | Essential as full workspace loader. | Memory low if metadata-only, performance improves everything. | Mobile Essential plus Website Preferred. | P0 |
| Project Dashboard | Shows projects, statuses, approvals, and recent work. | Essential. | Essential for full management and production history. | Memory low, storage low/medium if cached, performance low. | Mobile Essential plus Website Preferred. | P0 |
| Job Queue / Forge Handoff | Sends jobs from mobile to Website/Forge and tracks results. | Essential. | Essential service for heavy workflows. | Memory low on mobile, storage medium on server, performance low/medium. | Mobile Essential client plus Website Preferred service. | P0 |
| Product Library / Catalog | Stores assets, cards, metadata, sources, thumbnails, packages. | Browse, search, approve, and submit edits. | Master source of product truth. | Memory low on mobile, storage high on server, performance medium. | Website Preferred with mobile cache. | P0 |
| Lightweight Preview | Shows thumbnails, small images, or simple proxies. | Essential for review without loading full Forge. | Useful for previews and generated thumbnails. | Memory low/medium, storage low, performance low/medium. | Mobile Essential as thumbnail/proxy only. | P0 |
| Full 3D Viewer | Loads and inspects GLB/FBX and interactive scenes. | Useful only on demand, risky as default. | Core full Forge capability. | Memory high, storage high, performance high/GPU. | Website Preferred; Mobile Optional only for tiny proxies. | P1 |
| ThreeViewer / Embedded Three Stack | Mobile 3D rendering and preview system. | Some value for simple preview, too heavy as startup. | Better as website scene viewer. | Memory high, storage high, performance high. | Website Preferred; remove from active mobile loading. | P1 |
| Workshop Startup Surface | Current all-in-one Forge surface. | Too broad for lightweight mobile startup. | Concepts should feed desktop Forge modules. | Memory high, storage medium, performance high due mixed concerns. | Split: Mobile Essential guide/job subset; Website Preferred full tools. | P0 |
| Chat | General assistant conversation. | Essential if kept focused. | Useful in website Studio/Forge. | Memory low/medium, storage low/medium, performance low. | Mobile Essential plus Website Preferred. | P0 |
| Voice Input | Capture ideas quickly. | Good optional mobile value. | Useful but not required for desktop. | Memory medium, storage low, performance medium/background. | Mobile Optional. | P2 |
| TTS / Speech Playback | Makes Aria/Gaius feel present. | Optional. | Useful for Studio experience. | Memory low/medium, storage low, performance medium/network. | Mobile Optional plus Website Preferred service. | P2 |
| Transcript Correction | Cleans voice input. | Useful for mobile voice. | Better as service. | Memory low on mobile, performance medium if local. | Website Preferred service with mobile client. | P1 |
| Reference Upload / Camera | Upload images or notes as build references. | Essential for mobile capture. | Website stores and processes references. | Memory low, storage medium/high server, performance low. | Mobile Essential client plus Website Preferred service. | P0 |
| AI Image Generation | Generates concepts, textures, thumbnails, references. | Mobile should request only. | Website/API should own generation, moderation, storage. | Memory low mobile, storage medium/high server, performance/network high. | Website Preferred service. | P0 |
| AI Chat / Build Planning | Converts intent into project plans and workspace jobs. | Essential conversation and request entry. | Full planning, decomposition, memory, and job setup. | Memory medium, storage medium, performance medium. | Website Preferred service with mobile client. | P0 |
| Build Requirements | Explains target needs, constraints, and checklist. | Lightweight checklist display. | Master rule engine and target profiles. | Memory low mobile, storage medium server, performance low. | Website Preferred service. | P1 |
| Texture/Material Forge | Creates object materials, fabric, metal, wear, glow, decals, trims. | Concept cards, swatches, prompts, small previews. | Full material editor, UV preview, texture processing. | Memory low mobile, storage high server, performance medium/high website. | Website Preferred; Mobile Optional concept mode. | P0 |
| Texture Baking / UV Work | Baking, maps, UV checks, advanced texture processing. | Not appropriate. | Core full Forge service. | Memory high, storage high, performance high/GPU. | Website Only. | P1 |
| Clothing Forge | Clothing concepts, templates, layers, fit checks, exports. | Concepts, notes, protected fit thumbnail only. | Full fit, material, layer, and export workflow. | Memory medium/high, storage high, performance medium/high. | Website Preferred; Mobile Optional concept mode. | P1 |
| Wardrobe / Aria Wardrobe | Protected Aria outfits and product review. | Review cards and thumbnails. | Full protected wardrobe build/testing. | Memory medium/high if previewed, storage high. | Website Preferred; Mobile Optional review only. | P2 |
| Weapon/Tool Forge | Modular weapons, tools, hand props. | Concepts, cards, reference uploads. | Full mesh assembly, materials, scale, export. | Memory medium, storage medium/high, performance medium/high. | Website Preferred; Mobile Optional concept mode. | P1 |
| Furniture/Prop Forge | Furniture, props, set pieces, room objects. | Strong mobile concept value. | Full object building, dimensions, collision, export. | Memory low/medium mobile, storage medium/high server, performance medium. | Website Preferred; Mobile Optional concept mode. | P0 |
| Building Forge | Structures, walls, roofs, floors, modular buildings. | Concepts and floor-plan notes. | Full modular building editor. | Memory high, storage high, performance high. | Website Preferred; Mobile Optional concept mode. | P2 |
| Room Forge | Rooms, interiors, lighting, placeable room packages. | Concepts, notes, approval, small previews. | Full layout, placement, lighting, export. | Memory medium/high, storage high, performance high. | Website Preferred; Mobile Optional concept mode. | P1 |
| World Forge | Worlds, biomes, exterior environments, staging spaces. | Concept-only value. | Full scene/world editor. | Memory high, storage high, performance very high. | Website Preferred; Mobile Optional concept mode. | P2 |
| Vehicle Forge | Ground vehicles, hover vehicles, machinery. | Concepts and inspection notes. | Full construction, parts, preview, export. | Memory high, storage high, performance high. | Website Preferred; Mobile Optional concept mode. | P2 |
| Spacecraft Forge / Shipyard | Ships, fighters, cockpits, engines, mounts, rooms. | Concepts, project cards, approval. | Full hangar builder, modules, scale, export. | Memory very high, storage high, performance very high. | Website Preferred; Mobile Optional concept mode. | P2 |
| Storyforge / Narrative | Cast, scenes, lore, production planning. | Notes, review, prompt capture. | Full story/project memory and production planning. | Memory medium, storage medium, performance low/medium. | Website Preferred; Mobile Optional notes/review. | P2 |
| Export Forge | Package validation, target profiles, manifests, thumbnails. | Status, checklist, approve/reject. | Full packaging, validation, and file generation. | Memory medium mobile if local, storage high server, performance high. | Website Only for package building; Mobile Essential for status. | P1 |
| Mod Forge | Starfield/Skyrim packaging and mod export workflows. | Status only. | Full target-specific export and packaging. | Memory high, storage high, performance high. | Website Only. | P3 |
| Blender Integration | Mesh processing, automation, cleanup, conversion. | Not appropriate. | Core automation service. | Memory high, storage high, performance very high. | Website Only. | P2 |
| CC5 Integration | Protected character source handling, conversion, clips. | Not appropriate. | Protected internal workflow. | Memory high, storage high, performance very high. | Website Only, internal/protected. | P2 |
| Rigging Systems | Skeletons, weights, retargeting, fit rigs. | Not appropriate. | Full Forge/internal asset service. | Memory high, storage high, performance very high. | Website Only. | P2 |
| Animation Systems | Clip loading, mixers, retargeting, motion preview. | Not appropriate beyond video/thumbnail review. | Full website/internal pipeline. | Memory high, storage high, performance very high. | Website Only. | P2 |
| Avatar Forge | Avatar maintenance or future avatar tooling. | No public mobile value under current scope. | Internal/protected Aria/Gaius maintenance only unless scope reopens. | Memory high, storage very high, performance very high. | Website Only, deferred/internal protected. | P3 |
| Creature Forge | Creature planning/building if reopened. | Concept-only if ever approved. | Full creature tools would be website-only. | Memory high, storage high, performance very high. | Website Only, deferred. | P3 |
| Skin Forge | Human skin generation. | No active value. | Retired from active scope. | Memory high, storage high, performance high and quality risk high. | Retired. | Do not migrate |
| MakeHuman / MPFB | Legacy avatar base path. | No active value. | Quarantined historical artifacts only. | Storage medium/high, quality/scope risk high. | Retired/quarantine. | Do not migrate |
| OpenClaw Support | External support/integration lane. | No mobile value until verified. | Verification/support track if reopened. | Unknown. | Website Only, deferred verification. | P3 |
| Gallery | Store/show outputs and thumbnails. | Browse, review, approve. | Master asset/gallery service. | Memory low mobile, storage high server, performance medium. | Website Preferred with mobile client. | P1 |
| Moderation | Review uploads/generations and reject unsafe items. | Status/warnings only. | Server-side service. | Memory low mobile, performance medium server. | Website Only service with mobile display. | P1 |
| Issues / Feedback | Track bugs, tasks, and project notes. | Submit/review issues. | Master issue service. | Memory low, storage medium, performance low. | Website Preferred with mobile client. | P2 |
| Account / Entitlements / Paywall | Access control and plan state. | Essential account state. | Master entitlement service. | Memory low, storage low, performance low. | Mobile Essential client plus Website Preferred service. | P1 |
| Local Offline Drafts | Temporary notes and concepts when offline. | Useful for mobile resilience. | Sync target. | Memory low, storage low/medium, performance low. | Mobile Optional. | P2 |

## What Should Remain On Mobile

Mobile should keep:

- Guide choice: Aria or Gaius.
- Chat with selected guide.
- Project dashboard.
- Job queue/status.
- Product cards.
- Approval/rejection/needs-revision actions.
- Lightweight thumbnails and simple preview images.
- Prompt capture.
- Notes and offline drafts.
- Reference photo upload.
- Account/settings.
- Optional voice capture.
- Optional TTS playback.
- Mobile Turntable cards as metadata, not heavy workspaces.

## What Should Move To Website/Forge

Move full authoring and processing to Website/Forge:

- Desktop Forge shell.
- Turntable full workspace host.
- Product Library master.
- Texture/Material Forge.
- Furniture/Prop Forge.
- Clothing Forge full workflow.
- Weapon/Tool Forge.
- Room Forge.
- Building Forge.
- Vehicle Forge.
- Spacecraft Forge / Shipyard.
- World Forge.
- Storyforge full project planning.
- Export Forge.
- AI generation workflows.
- Large asset browsing and storage.
- Full 3D viewer.
- Build requirements and target profiles.

## What Should Become Website Services Only

These should be server-side or Website-only services:

- Blender integrations.
- CC5 integrations.
- Rigging.
- Retargeting.
- Animation authoring and animation mixer work.
- Texture baking.
- UV processing.
- Mesh processing.
- GLB/FBX conversion.
- Export package building.
- Mod packaging.
- Moderation.
- Large gallery storage.
- Large asset library indexing.
- Background generation jobs.
- Protected source asset access.

## What Should Never Load Automatically On Mobile

Never auto-load these on mobile:

- `ThreeViewer` full heavy scene.
- `three-scripts.ts` full 3D stack.
- High-poly GLB/FBX assets.
- Aria protected source files.
- Animation clips or mixers.
- Rigging/retargeting systems.
- Texture baking/UV tools.
- Blender/CC5 tools.
- Full Shipyard hangar.
- Full World Forge editor.
- Full Building/Room editor.
- Full Export Forge.
- Mod packaging.
- Public avatar creation.
- Skin generation.
- MakeHuman/MPFB paths.
- Fluff systems.

## What Can Be Streamed Or Requested On Demand

Mobile may request these only when needed:

- Small thumbnails.
- Compressed preview images.
- Low-poly/proxy 3D previews.
- Short preview videos.
- Product cards.
- Project summaries.
- Job status.
- Export checklist results.
- Moderation results.
- Aria/Gaius responses.
- Generated concept images.
- Material swatches.
- Small reference attachments.

Mobile should not cache large source files permanently. It should prefer expiring cache, thumbnails, and links back to Website/Forge.

## Ideal Lightweight Mobile Architecture

Recommended mobile structure:

1. Startup: guide chooser.
2. Home: project dashboard and recent jobs.
3. Turntable: category cards only.
4. Chat: Aria/Gaius guidance with project context.
5. Project detail: notes, references, thumbnails, status, approvals.
6. Submit job: sends intent, category, references, and constraints to Website/Forge.
7. Review: shows generated outputs as thumbnails/proxies, then lets the user approve or request revisions.
8. Settings/account: entitlements, sync, preferences.

Mobile data model:

- Local cache of project summaries.
- Local cache of thumbnails.
- Local drafts for offline notes.
- No large asset libraries.
- No protected source assets.
- No full export packages.

Mobile loading rule:

> Load the guide, project metadata, and the active lightweight card. Everything else is requested on demand.

## Ideal Full-Power Website/Forge Architecture

Recommended Website/Forge structure:

1. Forge Dashboard.
2. Turntable Workspace Selector.
3. Active Workspace Host.
4. Product Library.
5. Asset Library.
6. Job Queue.
7. Generation Services.
8. Preview/Render Services.
9. Export/Package Services.
10. Moderation/Review Services.
11. Aria/Gaius Guidance Panel.
12. Target Platform Profiles.

Website loading rule:

> Website/Forge may be powerful, but it should still load only the active workspace and required libraries.

Core service ownership:

- Aria/Gaius context service.
- Workspace registry.
- Product library service.
- Asset storage/index service.
- Generation service.
- Preview/render service.
- Export/package service.
- Moderation service.
- Job queue/status service.
- Audit/source metadata service.

## Migration Roadmap

### Phase 0: Freeze The Direction

Goal: stop mobile from gaining more heavy systems.

Actions:

- Treat this document as the ownership map.
- Keep new heavy features out of mobile.
- Keep MakeHuman, public avatars, and skins retired unless explicitly reopened.
- Keep OpenClaw separate until verified.

Priority: P0.

### Phase 1: Build Website Forge Shell

Goal: create the destination before cutting mobile down.

Actions:

- Add a desktop Forge shell.
- Add Turntable workspace selector.
- Add Product Library module.
- Add Job Queue module.
- Add Aria/Gaius guidance panel.
- Add Texture/Material Forge as first prototype.
- Add Furniture/Prop Forge metadata as second workspace.

Priority: P0.

### Phase 2: Create The Job Handoff Contract

Goal: make mobile submit work instead of doing work.

Actions:

- Define job payloads: intent, workspace ID, references, constraints, output target.
- Define job states: draft, submitted, generating, needs review, approved, exported, failed.
- Define mobile review actions: approve, revise, archive, duplicate, send to Forge.

Priority: P0.

### Phase 3: Move Repeated Generation Workflows To Website Services

Goal: stop every mobile screen from carrying its own generator.

Actions:

- Centralize image generation through Website/API.
- Centralize transcript correction through Website/API.
- Centralize build requirements through Website/API.
- Centralize gallery storage.
- Keep mobile as the client.

Priority: P1.

### Phase 4: Deactivate Heavy Mobile Startup Loading

Goal: make mobile fast.

Actions:

- Change startup away from full Workshop.
- Move full Forge access behind explicit actions.
- Keep Turntable cards metadata-only on mobile.
- Load simple previews on demand.
- Keep full `ThreeViewer` out of startup.

Priority: P1.

### Phase 5: Migrate Full Creator Workspaces

Goal: make Website/Forge the real factory.

Actions:

- Move full Foundry/Furniture/Weapon/Material workflows to Website.
- Move full Shipyard/Spacecraft to Website.
- Move Room/Building/World authoring to Website.
- Move Export Forge to Website.
- Leave mobile with cards, notes, thumbnails, and status.

Priority: P1/P2 by workspace.

### Phase 6: Quarantine Or Archive Retired Systems

Goal: remove active confusion without losing history.

Actions:

- Keep MakeHuman/MPFB quarantined until deletion is approved.
- Keep public avatar/skin references out of active UI and prompts.
- Keep rejected pose-math files out of active loading.
- Keep Fluff paused.
- Keep OpenClaw in a verification lane.

Priority: P2.

## First Migration Target

Migrate first:

1. Website Forge shell.
2. Turntable registry.
3. Product Library.
4. Job Queue.
5. Texture/Material Forge prototype.
6. Mobile job submission and review flow.

Reason:

- It creates the destination platform.
- It proves Website-first without breaking mobile.
- It supports every later workspace.
- It avoids the highest-risk systems first.
- It keeps Aria first.

## Final Recommendation

Do not start by deleting mobile systems.

Start by building the Website/Forge destination:

- Desktop Forge shell.
- Turntable loader.
- Product Library.
- Job Queue.
- Texture/Material Forge prototype.

Then mobile can be lightened safely:

- Startup becomes Aria/Gaius guide choice.
- Turntable becomes metadata cards.
- Heavy tools move behind Website/Forge jobs.
- Mobile remains fast, responsive, and useful.

The clean architecture is:

- Mobile thinks, captures, reviews, approves, and submits.
- Website/Forge builds, renders, processes, stores, validates, and exports.

