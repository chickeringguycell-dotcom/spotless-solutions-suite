# Viper Mobile To Website Migration Checklist

Date: 2026-06-14

Source of truth: `VIPER_WEBSITE_FIRST_ARCHITECTURE_REVIEW_2026-06-14.md`

Status: planning only.

Do not implement yet. Do not move files yet. Do not delete features yet. Do not rewrite Forge yet.

## Architecture Rule

Website/Forge is the master platform.

Mobile is the lightweight companion for:

- Aria and Gaius guidance.
- Projects and job status.
- Concepts and notes.
- Lightweight thumbnails/previews.
- Review and approval.
- Reference capture.
- Job submission to Forge.

Heavy systems should move to Website/Forge ownership.

## Mobile-Heavy System Checklist

| System | Current file or folder | Why it is heavy | Recommendation | Website/Forge replacement | Loads on mobile startup? | Can disable from startup safely? | Aria needs | Gaius needs | Priority | Risk |
|---|---|---|---|---|---|---|---|---|---|---|
| Workshop startup surface | `artifacts/viper-studio/app/(tabs)/workshop.tsx` | Combines Forge UI, Aria chat, voice, TTS, image picking, build requirements, WebView bridge, pose/body state, and `ThreeViewer`. | Become mobile-lite. | Website Forge shell plus Turntable workspace loader, Job Queue, Product Library, `/api/aria`, `/api/chat`, `/api/build-requirements`. | Yes. `_layout.tsx` uses `initialRouteName="workshop"`. | Yes, after guide chooser and project dashboard exist. | Current project intent, active workspace, chat history, submit-job action, lightweight preview status. | Workspace type, scale/function checklist, export readiness summary. | P0 | High |
| Embedded viewer stack | `artifacts/viper-studio/components/ThreeViewer.tsx` | Large WebView/Three.js scene, GLTF/OBJ/STL/PLY loaders, render loop, bridge commands, avatar/fit/scene logic. | Move to Website/Forge; keep only tiny mobile proxy preview. | Website Preview/Render Service and full 3D Viewer workspace. | Likely yes through `workshop.tsx` import; also loads when `viewer`, `imvucreator`, or `ViperCreatorShell` mount. | Yes, if mobile gets thumbnail/proxy preview and job status instead. | Preview thumbnail, current asset status, safe commands for website job only. | Scale snapshot, collision/export warnings, not full render control. | P0 | High |
| Three.js embedded scripts | `artifacts/viper-studio/lib/three-scripts.ts` | About 773 KB, bundles Three.js and loaders into mobile code path. | Move to Website/Forge. | Website scene runtime and render service. | Likely bundled when `ThreeViewer` is imported. | Yes, once `ThreeViewer` is removed from startup imports. | None directly; Aria only needs preview metadata. | None directly; Gaius only needs measurements/check results. | P0 | High |
| Full viewer/import/export route | `artifacts/viper-studio/app/(tabs)/viewer.tsx` | Full 3D viewer, document picking, file system reads/writes, sharing, body/pose/fit logic, WebView restore loops. | Move to Website/Forge; keep mobile review-only route if needed. | Website Full 3D Viewer, Import Service, Preview Service, Export Forge. | Hidden tab, not default, but present in mobile bundle/routing. | Yes, after lightweight preview and product cards exist. | Read-only preview link, product status, revision notes. | Measurements, scale report, fit/export checklist. | P1 | High |
| Viper creator shell | `artifacts/viper-studio/components/ViperCreatorShell.tsx` | Embeds `ThreeViewer`, avatar/body texture swapping, creator controls, legacy creator flow. | Move to Website/Forge or defer. | Website Creator Workspace Shell and Product Package workspace. | Not direct startup unless imported by active startup path; heavy when mounted. | Yes, if not used as startup shell. | Product intent, workspace link, job card. | Fit/scale/export notes only. | P1 | Medium |
| IMVU creator workspace data | `artifacts/viper-studio/lib/imvuCreatorWorkspace.ts` | Large local workspace definitions, roadmap/capabilities, product stages, legacy avatar-adjacent metadata. | Become shared registry; website owns full version, mobile consumes metadata. | Website Workspace Registry and Product Package Service. | Used by mobile IMVU route, not startup unless route loaded. | Yes, keep small metadata subset on mobile. | Workspace label, allowed product types, next step. | Checklist rules and package readiness criteria. | P1 | Medium |
| IMVU creator route | `artifacts/viper-studio/app/(tabs)/imvucreator.tsx` | Uses `ThreeViewer`, workspace panels, package/product controls, speech viseme/preview concepts. | Become mobile-lite; full workspace moves to Website/Forge. | Website Product Package Builder, Clothing/Furniture/Material workspaces. | Visible tab, not initial route. | Yes, after website package workspace exists. | Product card, submit/revise actions, guidance. | Export readiness, slot/scale/layer checks. | P1 | Medium |
| DevStudio route | `artifacts/viper-studio/app/(tabs)/devstudio.tsx` | Image picker/camera, repeated `/api/imagine` flows, creator slots, local product tooling. | Become mobile-lite or move. | Website Generation Service, Product Library, Reference Upload Service. | Visible tab, not initial route. | Yes, after job submission exists. | Prompt capture, reference upload, generated thumbnail status. | Practical build notes and readiness warnings. | P1 | Medium |
| Wardrobe route | `artifacts/viper-studio/app/(tabs)/wardrobe.tsx` | Image picker, `/api/imagine`, wardrobe/product state, legacy avatar-adjacent concepts. | Defer/protected review only. | Website protected Aria Wardrobe workspace and Product Library. | Hidden tab, not default. | Yes. | Aria outfit/project notes only when protected Aria wardrobe work is active. | Fit/layer/export notes for protected wardrobe only. | P2 | Medium |
| Shipyard route | `artifacts/viper-studio/app/(tabs)/shipyard.tsx` | Large project builder with ship/room planning, subprojects, assembled content, embedded Foundry concepts. | Become mobile-lite; full Shipyard moves to Website/Forge. | Website Spacecraft Forge, Room Forge, Job Queue, `/api/shipyard`. | Visible tab, not initial route. | Yes, after website Shipyard/Spacecraft job flow exists. | Project brief, selected workspace, next build step, submit job. | Scale, structure, module layout, export feasibility. | P2 | High |
| Foundry route | `artifacts/viper-studio/app/(tabs)/foundry.tsx` | Product/parts generator with image picker and `/api/imagine`; duplicates generation UI. | Move to Website/Forge; keep mobile concept card. | Website Furniture/Prop Forge, Weapon/Tool Forge, Generation Service. | Hidden tab, not default. | Yes. | Prompt, category, reference image, generated options. | Practical part/scale/function feedback. | P1 | Medium |
| Worldforge route | `artifacts/viper-studio/app/(tabs)/worldforge.tsx` | World/environment generator with image picker and `/api/imagine`; future world editor risk. | Move to Website/Forge; mobile concept-only. | Website World Forge, Room/Environment Preview Service. | Hidden tab, not default. | Yes. | World brief, biome, reference thumbnail, job status. | Scale/layout/environment logic notes. | P2 | High |
| Storyforge route | `artifacts/viper-studio/app/(tabs)/storyforge.tsx` | Large local narrative/cast/scene tool with speech playback and project memory. | Become mobile-lite; website owns full production planning. | Website Storyforge Service and Project Memory Service. | Visible tab, not initial route. | Yes, after notes/review replacement exists. | Story intent, cast summary, scene notes. | Continuity and production-readiness notes if relevant. | P2 | Medium |
| Chat route | `artifacts/viper-studio/app/(tabs)/chat.tsx` | Voice recognition, TTS fallback, image picker, `/api/imagine`, chat state. | Stay mobile, but slim to guide chat and job entry. | Shared `/api/aria`, `/api/chat`, `/api/tts`, Generation Service. | Hidden tab, not default. Workshop has overlapping chat on startup. | Partly. Keep guide chat, remove duplicated generator weight from startup. | Core chat, project context, intent capture. | Optional inspector chat/checklist. | P0 | Medium |
| Settings route heavy tools | `artifacts/viper-studio/app/(tabs)/settings.tsx` | Includes research-game and image generation calls plus adaptive speech settings. | Keep settings mobile; move generation/research tools to website. | Website Research/Build Requirements services. | Visible tab, not initial route. | Yes for research/generation panels. | Preferences and guide behavior settings. | Inspector strictness/preferences. | P2 | Low |
| Projects route import storage | `artifacts/viper-studio/app/(tabs)/projects.tsx` | Document picker, file system copying, local model storage. | Keep project list; move large file import/storage to website. | Website Asset Upload Service, Product Library, Job Queue. | Visible tab, not initial route. | Do not disable project list; disable heavy imports after web upload exists. | Project summaries and status. | Status/checklist summaries. | P1 | Medium |
| Product library screen | `artifacts/viper-studio/components/CreationLibraryScreen.tsx` | Can grow into local catalog and asset cache. | Mobile-lite browse/review only. | Website Product Library master and Gallery Service. | Only when mounted. | Yes, if project cards remain. | Product cards, thumbnails, source notes. | Readiness labels and warnings. | P0 | Low |
| Dressing room | `artifacts/viper-studio/components/DressingRoom.tsx` | Wardrobe/preview logic, avatar-adjacent flow. | Defer or protected Aria review only. | Website protected Wardrobe/Fit Review Service. | Only when mounted. | Yes. | Protected outfit notes if active. | Fit/layer checks if active. | P2 | Medium |
| Avatar mechanics | `artifacts/viper-studio/lib/avatarMechanics.ts` | Legacy avatar/body/fit mechanics; conflicts with retired public avatar scope. | Defer/internal protected only. | Website protected Fit Reference Service. | Not direct startup unless imported by startup dependencies. | Yes, except tiny fit-reference metadata if needed. | Protected reference labels only. | Fit measurement/check summaries. | P2 | Medium |
| Avatar system registry | `artifacts/viper-studio/lib/avatarSystem.ts` | Legacy avatar asset registry and completion gates. | Defer/internal protected only. | Website Asset Registry with retired/protected status. | Not direct startup unless imported by active screens. | Yes. | Protected Aria/Gaius status only. | Protected reference/inspection status. | P2 | Medium |
| Viewer context | `artifacts/viper-studio/lib/viewerContext.ts` | Global viewer state, measurements, body/fit metadata, WebView-related state. | Move most to website; keep only preview/job metadata. | Website Preview State Service and Fit/Scale Report Service. | Likely through startup viewer imports. | Yes, after startup no longer mounts viewer stack. | Current preview status and last result. | Measurement/check results. | P1 | Medium |
| Intent engine | `artifacts/viper-studio/lib/intentEngine.ts` | Local build intent parsing can grow and duplicate server planning. | Shared light client; website owns full classifier. | Website Intent/Workspace Classification Service. | Likely via AppContext/workshop. | Partly. Keep small mobile router, move full rules server-side. | Intent classification and workspace choice. | Whether inspection is needed. | P0 | Low |
| Game profiles | `artifacts/viper-studio/lib/gameProfiles.ts` | Target rules for games/platforms can grow into export constraints. | Move master rules to website; mobile cache summaries. | Website Target Profile and Build Requirements Service. | If imported by startup path, yes/likely. | Yes, after summary cache exists. | Target label and constraints summary. | Scale/export checklist. | P1 | Medium |
| Materials library | `artifacts/viper-studio/lib/materials.ts` | Material presets can grow into texture libraries and previews. | Mobile-lite swatches; website owns full library. | Website Texture/Material Forge and Asset Library. | Only through screens that import it. | Yes, if mobile keeps small swatch subset. | Material names, prompt constraints, thumbnail. | Practical material/export notes. | P0 | Low |
| Speech correction | `artifacts/viper-studio/lib/speechCorrection.ts`, `lib/correctionEval.ts` | Local correction/eval logic and voice workflow support. | Website preferred service; mobile keeps simple client. | `/api/correctTranscript` and Guide Context Service. | Through chat/workshop voice paths. | Partly. Keep optional voice capture, move correction service. | Clean user intent. | Clean inspection request. | P1 | Low |
| Speech recognition and voice | `artifacts/viper-studio/lib/speechRecognition.ts`, `lib/ariaVoice.ts`, `app/(tabs)/chat.tsx`, `workshop.tsx` | Native permissions, listeners, TTS, fallback voice handling. | Mobile optional; should not be required for startup. | `/api/tts`, guide voice preference service. | Yes through workshop imports/use hooks. | Yes, after text guide chat works first. | Optional spoken input/output. | Optional spoken checklist. | P2 | Medium |
| Image generation duplication | `workshop.tsx`, `chat.tsx`, `devstudio.tsx`, `wardrobe.tsx`, `foundry.tsx`, `worldforge.tsx`, `settings.tsx` | Many screens repeat `/api/imagine`, image picker, prompt/result state. | Move to Website/Forge service with one mobile requester. | Website Generation Service, Gallery, Moderation. | Yes through workshop; others when opened. | Yes, after one job submission flow exists. | Prompt, reference, generated thumbnail/status. | Review notes and feasibility warnings. | P0 | Medium |
| Export sheet | `artifacts/viper-studio/components/ExportSheet.tsx` | Can imply local packaging/sharing; export grows heavy fast. | Mobile status/approval only. | Website Export Forge and Package Service. | Only when mounted. | Yes, if replaced with export status cards. | Export status and user approval. | Checklist failures and readiness. | P1 | Medium |
| File security/import helpers | `artifacts/viper-studio/lib/fileSecurity.ts`, project/viewer import paths | Reads local files and checks headers; can pull large files into mobile storage. | Website upload/import service. | Website Upload Security, Virus Scan, Asset Ingest Service. | Only import flows; project route visible but not startup. | Yes for large imports after website upload exists. | Safe attachment status. | File validity and target compatibility. | P1 | Medium |
| Revenue/paywall spread | `artifacts/viper-studio/lib/revenuecat.tsx`, `PaywallScreen.tsx`, multiple tabs | Entitlement checks across heavy screens can tangle feature loading. | Keep mobile account state; website owns service gating. | Website Entitlement Service and mobile account cache. | Depending on screen. | Partly. Keep account checks, remove heavy screen gates from startup. | Entitlement-aware guidance. | Entitlement-aware export warnings. | P2 | Low |
| ARIA avatar visual | `artifacts/viper-studio/components/ARIAAvatar.tsx`, `lib/ariaLivingAvatar.ts` | Animated guide presentation can become expensive if tied to 3D/avatar systems. | Stay mobile if lightweight; avoid full GLB source assets. | Guide Persona Service and lightweight avatar states. | Likely through startup guide surfaces. | Do not remove; keep lightweight. | Main guide presence. | Not required except handoff between guides. | P0 | Low |
| Protected/large asset libraries | `artifacts/api-server/public/avatars`, `artifacts/avatar-sources`, `artifacts/avatar-references`, mobile prefetch/asset registries | Large GLB/FBX/source files, protected assets, animation clips. | Website Only. | Website Asset Library, Protected Source Store, Preview Proxy Service. | Should not; must never be prefetched on mobile. | Yes, keep out of startup and mobile prefetch. | Asset status and approved thumbnail only. | Scale/inspection result only. | P0 | High |
| Animation/pose systems | `ThreeViewer.tsx`, `viewer.tsx`, `avatarMechanics.ts`, animation test assets under server public | Render loops, clips, mixers, retargeting risk; old fake pose math rejected. | Website Only/deferred. | Website Animation Service using approved real source clips only. | Via viewer/workshop when mounted. | Yes, after no startup viewer. | Clip/job status only. | Motion inspection checklist. | P2 | High |
| Mesh tools and model import | `viewer.tsx`, `ThreeViewer.tsx`, `projects.tsx`, file helpers | GLB/FBX/object import, parsing, preview, sharing, storage. | Website Only for full import/processing; mobile upload only. | Website Mesh Processing and Asset Ingest Service. | Not initial except viewer stack through workshop. | Yes, after upload/job flow exists. | Uploaded reference status. | Geometry/scale/readiness report. | P1 | High |
| Texture tools and baking | `materials.ts`, `devstudio.tsx`, `wardrobe.tsx`, future Texture/Material Forge | Texture libraries and baking are storage/GPU heavy. | Mobile-lite swatches; Website owns processing. | Website Texture/Material Forge. | Some prompt tools via workshop/devstudio; baking not active. | Yes for heavy texture tools. | Material intent, swatch, thumbnail. | Material suitability/export warnings. | P0 | Medium |
| Export/package tools | `ExportSheet.tsx`, `viewer.tsx`, `imvucreator.tsx`, target profile libs | Final packaging, validation, manifests, platform rules. | Website Only; mobile status only. | Website Export Forge, Target Profile Service. | Not initial except any workshop export hooks if present. | Yes. | Export status and user approvals. | Export readiness and failure reasons. | P1 | High |

## Mobile Keep List

Keep these as real mobile capabilities:

- Aria guide chat.
- Gaius optional inspector chat.
- Guide choice at startup.
- Project dashboard.
- Job status and queue view.
- Product cards.
- Approval, revise, archive, and submit actions.
- Lightweight thumbnails.
- Small preview images or proxy previews.
- Prompt capture.
- Notes and offline drafts.
- Reference photo upload.
- Account and entitlement status.
- Basic settings.

## Mobile Lite List

Keep only lightweight versions of these:

- Turntable workspace cards.
- Texture/Material Forge concepts and swatches.
- Furniture/Prop Forge concepts.
- Clothing concepts with protected fit-reference thumbnails only.
- Weapon/Tool concepts.
- Room/Building/World concepts.
- Vehicle/Spacecraft concepts.
- Storyforge notes and review.
- Product Library browsing.
- Gallery browsing.
- Export checklist status.
- Voice input/TTS as optional features.
- Local intent routing with server confirmation.

## Website/Forge Move List

Move full authoring and heavy work here:

- Full Workshop/Forge authoring.
- Full `ThreeViewer` scene viewer.
- Full viewer/import/export route.
- Product Library master.
- Job Queue master.
- Texture/Material Forge full editor.
- Furniture/Prop Forge.
- Clothing Forge full workflow.
- Weapon/Tool Forge.
- Room Forge.
- Building Forge.
- Vehicle Forge.
- Spacecraft Forge/Shipyard.
- World Forge.
- Storyforge full production planning.
- AI generation workflows.
- Build requirements and target profiles.
- Gallery storage and moderation.

## Website Only List

These should never be mobile workloads:

- Blender integrations.
- CC5 integrations.
- Protected Aria/Gaius source handling.
- Rigging.
- Retargeting.
- Animation authoring.
- Animation mixers and clip editing.
- Texture baking.
- UV processing.
- Mesh processing.
- GLB/FBX conversion.
- Export package building.
- Mod packaging.
- Large asset library indexing.
- Large gallery storage.
- Background generation jobs.
- Virus scanning and upload security.

## Deferred List

Keep these out of the first migration:

- Avatar Forge, except internal/protected Aria/Gaius maintenance.
- Creature Forge.
- Animation Forge.
- Mod Forge.
- OpenClaw support until it is freshly verified.
- Full Spacecraft Forge authoring.
- Full World Forge authoring.
- Full Building Forge authoring.
- Protected Aria wardrobe build tools.

## Do Not Touch Yet List

Do not delete, move, or rewrite these until the website destination exists:

- `artifacts/viper-studio/app/(tabs)/workshop.tsx`
- `artifacts/viper-studio/components/ThreeViewer.tsx`
- `artifacts/viper-studio/lib/three-scripts.ts`
- `artifacts/viper-studio/app/(tabs)/viewer.tsx`
- `artifacts/viper-studio/app/(tabs)/imvucreator.tsx`
- `artifacts/viper-studio/app/(tabs)/shipyard.tsx`
- `artifacts/viper-studio/app/(tabs)/devstudio.tsx`
- `artifacts/viper-studio/app/(tabs)/wardrobe.tsx`
- `artifacts/viper-studio/app/(tabs)/foundry.tsx`
- `artifacts/viper-studio/app/(tabs)/worldforge.tsx`
- Protected Aria V5 assets.
- Gaius/protected guide assets.
- Existing API routes.
- Existing docs and reports.
- Quarantined MakeHuman/MPFB artifacts until deletion is explicitly approved.

Reason: these are still useful reference material and may contain working logic that should be copied into Website/Forge deliberately.

## First Safe Migration Candidates

Start with systems that create the website destination without breaking mobile:

1. Website Forge shell.
2. Turntable registry.
3. Job Queue service.
4. Product Library master.
5. Texture/Material Forge prototype.
6. Furniture/Prop Forge metadata.
7. Mobile submit-to-Forge job payload.
8. Mobile project/job status view.
9. Centralized image generation request service.
10. Centralized preview thumbnail service.

Do not start by deleting mobile screens.

## Systems Aria Requires

Aria needs:

- Guide chat.
- Project context.
- Active workspace ID.
- Turntable workspace metadata.
- Job creation and job status.
- Product cards and thumbnails.
- User notes and prompts.
- Reference upload status.
- Build requirements summaries.
- Generated output summaries.
- Export/checklist status.
- Ability to warn when a task is Website/Forge-only.
- Continuity across workspace switching.

Aria does not need:

- Full mobile 3D render loops.
- Protected source assets on mobile.
- Mobile mesh processing.
- Mobile baking.
- Mobile export packaging.

## Systems Gaius Requires

Gaius needs:

- Active workspace ID.
- Scale data.
- Dimensions or rough measurements.
- Function checklist.
- Collision/placement notes.
- Material practicality notes.
- Export readiness checklist.
- Target platform requirements.
- Failure/warning summaries from Website/Forge.

Gaius does not need:

- Full mobile render control.
- Full rigging systems.
- Full animation systems.
- Protected source files on mobile.
- Local export packaging.

## Systems That Must Never Auto-Load On Mobile

Never auto-load:

- Full `ThreeViewer` scene.
- `three-scripts.ts` full Three.js stack.
- High-poly GLB/FBX files.
- Protected Aria source assets.
- Protected Gaius source assets.
- Animation clips.
- Animation mixers.
- Rigging and retargeting systems.
- Texture baking tools.
- UV tools.
- Mesh processing tools.
- Blender/CC5 integrations.
- Full Shipyard hangar.
- Full World Forge editor.
- Full Building Forge editor.
- Full Export Forge.
- Starfield/Skyrim mod packaging.
- Public avatar creation.
- Skin generation.
- MakeHuman/MPFB paths.
- Fluff systems.
- OpenClaw systems before verification.

## Startup Disable Checklist

A system can be disabled from mobile startup only when these are true:

- Aria guide chat still works.
- Gaius can still be selected or summoned when needed.
- Project dashboard still opens quickly.
- The user can still submit a job to Website/Forge.
- The user can still view job status.
- The user can still see a thumbnail or lightweight preview.
- The user can still approve or request revision.
- The website replacement exists for any removed heavy behavior.
- No protected source asset becomes required on mobile.

## Recommended First Action After Approval

After this checklist is approved, the first implementation should be:

1. Add the Website Forge shell.
2. Add a workspace registry.
3. Add Product Library and Job Queue placeholders.
4. Add Texture/Material Forge as the first prototype workspace.
5. Add a mobile job submission path that points to the new website services.

Only after those exist should mobile startup be changed away from the heavy Workshop route.

