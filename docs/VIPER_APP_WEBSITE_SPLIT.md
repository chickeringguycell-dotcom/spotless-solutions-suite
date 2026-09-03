# Viper App And Website Responsibilities

This is a design direction record, not a refactor order.

The Forge stays in the mobile app, but the mobile app should become Forge Lite: fast, personal, Aria-centered, and good for quick creation. The website should become the full creator studio for heavier tools.

## Product Split

### Mobile App: Forge Lite

The app should prioritize work that feels natural on a phone:

- Aria interaction.
- Chat and voice interaction.
- Lightweight Forge actions.
- Protected guide presence or thumbnails.
- Simple clothing/accessory job submission.
- Simple non-skin material or product preview.
- Starship and asset concept creation.
- Inventory and library browsing.
- Social features.
- Project status and notifications.
- Quick approve/reject flows for assets Aria prepares.

The phone should feel alive and useful without trying to become Blender, IMVU Studio, Unity, and a render farm at once.

### Website: Full Forge

The website should carry heavier studio tools:

- Full world building.
- Advanced Forge workspace.
- Large scene creation.
- Heavy asset editing.
- Play/scene production.
- Animation timelines and pose tools.
- Complex rendering.
- Large project management.
- Advanced creator toolkit workflows.
- Multi-actor and room/furniture scene setup.
- Batch export and validation.
- Full IMVU-style creator package assembly.
- Clothing, accessories, props, furniture, rooms, vehicles, ships, weapons, tools, non-skin materials, lighting, effects, and audio product workflows.

The website should not promise public avatar or skin generation unless that scope is explicitly reopened later.

## Shared Backend

Both app and website should share:

- Aria identity and memory.
- Project library.
- Asset storage.
- Protected guide manifests.
- Product/material manifests.
- Creator product packages.
- Export jobs.
- Permission/source metadata.
- User account and entitlement state.

Heavy jobs should run on the website or backend and send lightweight results back to the app.

## Features That Can Make Mobile Too Heavy

Track these carefully:

- Large GLB/VRM models with many materials.
- High-resolution texture preview stacks.
- Multi-actor scenes.
- Avatar creation and skin creation.
- Room and furniture editing.
- Blender-style scene tools.
- Advanced UV editing.
- Animation timelines.
- Complex export validation.
- Large project trees.
- Local rendering and lighting experiments.
- Too many panels inside the phone creator view.

These are allowed on mobile only as lightweight preview, simplified controls, or remote job status.

## Mobile Guardrails

- Load mobile LOD assets by default.
- Keep one main live preview active at a time.
- Use compressed texture previews.
- Prefer quick slot tests over full editor workflows.
- Push advanced editing to website when the task needs precision.
- Let Aria prepare heavy work in the background and show progress on the phone.
- Keep creator controls short, tappable, and focused.

## Website Guardrails

- Treat the website as the advanced creator studio.
- Support large screens, panels, timelines, grids, and inspectors.
- Provide richer UV, texture, mesh, room, animation, and export tooling.
- Keep the same creator package format as the app.
- Let users start on phone and continue on website without losing context.

## Aria Across Both

Aria should feel like the same person everywhere:

- In the app, Aria is the close companion and quick Forge assistant.
- On the website, Aria is the full studio architect.
- The same project state, memories, texture blocks, and creator packages should follow her.

The split is not app versus website. It is Aria on phone for quick work, and Aria in the full studio for heavy work.
