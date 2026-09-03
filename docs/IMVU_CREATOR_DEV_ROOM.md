# IMVU Creator Dev Room

Active-scope note, 2026-06-14:

Use this as a dev-room concept for feasible products only: clothing, accessories, props, furniture, rooms, vehicles, ships, weapons, tools, non-skin materials, lighting, effects, and audio. Do not use it to revive public avatar or skin creation.

The IMVU Creator Dev Room is Viper Studio's hands-on creator workspace for avatar, room, furniture, and object product testing.

It should support creators who want direct control as well as creators who want Aria's help.

## Layout

Left side, current milestone:

- Aria-first avatar preview pane.
- Photoreal Aria target visible, using Aria's own UV and texture boards as references.
- No visible noodle, tube, tire, primitive, or cartoon placeholder avatars.
- Rotate, zoom, reset camera, inspect wireframe.
- Preview skins, face textures, hair, eyes, lips, makeup, clothing, accessories, UV frames, rooms, furniture, and object textures.

Left side, later creator-base milestone:

- Calibrated creator bases for IMVU-style product testing.
- Male/female compatibility and body-part target flags.
- Multi-actor preview scenes for clothing, poses, rooms, furniture, and product thumbnails.

Right side:

- Creator controls.
- Manual mode.
- Aria-assisted mode.
- Upload/apply texture tools.
- UV frame tools.
- Asset slot selector.
- Save/export preview tools.
- Multi-actor controls.

## Current Scaffold

Code added:

- `artifacts/viper-studio/lib/imvuCreatorWorkspace.ts`
- `artifacts/viper-studio/app/(tabs)/imvucreator.tsx`

The first version deliberately stays lightweight and Aria-first. It establishes:

- Visible IMVU tab.
- Left preview area using the existing ThreeViewer.
- Photoreal Aria reference presence instead of visible starter bodies.
- Texture and reference presets from Aria's own skin pack, face UV, body UV, and photoreal boards.
- Manual vs Aria-assisted mode toggle.
- Creator tool list for uploads, UV frames, object dev, and future export.
- Future creator-base and multi-actor plan hooks.

## Product Scope

See `docs/IMVU_CREATOR_CAPABILITY_MAP.md` for the current IMVU creation feature map based on official IMVU creator documentation.

Avatar products:

- Skins.
- Hair textures and future hair meshes.
- Eyes.
- Makeup.
- Lips.
- Brows.
- Lashes.
- Clothing textures.
- Accessories.
- UV frames.

Room/object products:

- Bedroom.
- House.
- Table.
- Chair.
- Wall textures.
- Floor textures.
- Furniture.
- Decor items.
- Props.

## Workflow Target

1. Upload or select a base asset.
2. Confirm the product category and derivable/base source.
3. Upload or select texture/image inputs.
4. Apply texture, mesh, or material changes to the selected avatar/object slot.
5. Preview and inspect.
6. Modify manually, in Blender, or ask Aria.
7. Reapply and compare.
8. Save/export the test result.

## Multi-Actor Target

The preview scene should eventually support:

- Add actor.
- Add second actor.
- Add third actor.
- Remove actor.
- Select active actor.
- Pose actors.
- Dress each actor separately.
- Apply skins/hair/eyes/clothes to individual actors.

This matters for clothing, pose, couple, group, room, furniture, and product-preview workflows.

## Design Rules

- IMVU mechanics are required: derivation/source metadata, body-part thinking, material slots, texture overrides, UV frames, skeleton/attachment nodes, and product preview testing.
- Texture building blocks are required: creators should be able to swap one slot at a time, and Aria should be built from the same block system.
- Viper quality is photoreal/premium. IMVU is the mechanics model, not the visual ceiling.
- Aria's own UV boards are source of truth for Aria.
- Do not show low-quality placeholder bodies in the visible product.
- Do not force Aria into every step.
- Manual controls are first-class.
- Aria is available as an assistant, inspector, repair helper, and texture/improvement partner.
- Search for clean permitted assets when useful.
- Make Viper-authored replacements when an asset is missing, weak, or has unclear rights.
- Keep IMVU-aware source notes, product IDs, derivability notes, and export notes with every imported asset.
- Support free Blender/CC0/permissive assets and Viper-authored Blender assets as alternate base sources when they are better than the available IMVU base.

## App And Website Split

Keep this workspace mobile-friendly. The app version should be Forge Lite: Aria, quick preview, simple slot testing, and lightweight creator tools. The website version should become Full Forge: advanced UV editing, room/furniture setup, multi-actor scenes, animation tooling, complex exports, and larger project management.

The long-term split is tracked in `docs/VIPER_APP_WEBSITE_SPLIT.md`.
