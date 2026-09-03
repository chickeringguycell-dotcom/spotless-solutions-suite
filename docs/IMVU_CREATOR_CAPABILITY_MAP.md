# IMVU Creator Capability Map

This document records what IMVU's creator ecosystem supports so Viper Studio can grow toward the same creator usefulness without copying proprietary IMVU assets. The operating rule is IMVU creator mechanics with Viper photoreal quality.

## Official Sources Checked

- IMVU Classic avatar body parts intro: `https://create.imvu.com/articles/classic/avatar-body-parts-intro/`
- IMVU Studio avatar body parts: `https://create.imvu.com/articles/studio/imvu-studio-avatar-body-parts/`
- IMVU product types: `https://create.imvu.com/articles/studio/imvu-product-types/`
- IMVU Studio material components: `https://create.imvu.com/articles/studio/imvu-studio-material-components/`
- IMVU Studio Toolkit for Blender: `https://create.imvu.com/articles/studio/imvu-studio-toolkit-for-blender/`
- IMVU Studio Toolkit quick start: `https://create.imvu.com/articles/studio/toolkit-quick-start/`
- IMVU skeletons for Blender: `https://create.imvu.com/articles/classic/skeletons-blender/`
- IMVU furniture nodes and seat naming: `https://create.imvu.com/articles/classic/furniture-rooms-nodes/`
- IMVU actions and particles landing page: `https://create.imvu.com/articles/classic/actions-particles/`

## What IMVU Creation Covers

### Product Types

IMVU's creator platform covers avatar products and scene products. Viper's Dev Room should support both:

- Avatar body and body part replacements.
- Skin.
- Hair.
- Eyes.
- Clothing.
- Accessories.
- Avatar actions and poses.
- Rooms.
- Furniture.
- Room/furniture nodes and seats.
- Material/texture edits.

### Derivation Model

IMVU creators often derive from an existing base product, then replace or edit parts. Viper needs:

- Source product metadata.
- Derivation/permission notes.
- Changed material-slot tracking.
- Reset-to-base.
- Save/export test result.

### Body Parts and Conflicts

IMVU has body part IDs and replacement concepts. Clothing/hair/accessories may replace or hide specific body parts.

Viper needs:

- Body-part target selector.
- Conflict warning when a product overrides the same target as another product.
- Male/female compatibility flag.
- Slot naming familiar to IMVU creators.
- Texture block package tracking so one product can replace only skin, eyes, lips, hair, clothing, or an accessory slot.

### Materials and Texture Maps

IMVU Studio material components cover texture/material editing. Viper should support:

- Color/diffuse.
- Opacity/alpha.
- Normal or bump-style detail.
- Specular/shine style values.
- Emissive/glow style values where applicable.
- UV-frame previews.
- Compare before/after.

Aria's current skin pack already starts this direction with body color, normal, roughness, specular, AO, UV-check, and wireframe references.

### Texture Editing

IMVU Studio includes practical image/material tools such as color and texture combining workflows. Viper should add:

- Upload image/texture.
- Solid-color fill.
- Color tint/filter.
- Combine/overlay textures.
- Crop/align to slot.
- Apply to selected part.
- Apply one texture block at a time.
- Compare texture blocks against the UV frame.
- Save variant.
- Ask Aria to improve, repair, or explain issues.

### Blender / Mesh Pipeline

IMVU's Blender/toolkit workflow covers mesh creation, skeletons, weights, bindings, animation testing, and export.

Viper should eventually support:

- Mesh import.
- Skeleton compatibility checks.
- Weight/attachment checklist.
- Pose/animation test preview.
- Export checklist for Blender/IMVU Studio.
- Bone-count and attachment validation.

### Rooms, Furniture, Nodes, and Seats

IMVU room/furniture products use nodes and special naming concepts for seats, handles, and cooperative interactions.

Viper should support:

- Room/object preview mode.
- Furniture node overlay.
- Seat/pose spot creation.
- Multi-actor testing.
- Couple/group scene setup.
- Wall/floor/furniture texture swapping.

### Actions and Particles

Actions and particles are part of the broader creator platform, but they should come after stable texture, UV, room, and avatar tooling.

Viper should plan for:

- Triggered actions.
- Animation preview.
- Particle preview.
- Export notes.

## Viper Implementation Order

1. Keep the IMVU Dev Room tab visible and lightweight.
2. Add upload/apply texture per selected slot.
3. Add UV-frame overlay and body-part target selector.
4. Add texture-block package tracking.
5. Add room/object texture dev mode.
6. Add save/export preview packages.
7. Add source/derivation metadata.
8. Add mobile/website responsibility split so the app remains Forge Lite and the website carries Full Forge tooling.
9. Add multi-actor scene support.
10. Add Blender/toolkit export checklist.
11. Add animation/action/particle previews.

## Non-Negotiables

- Manual creator controls must work without Aria.
- Aria-assisted mode should help but never block manual work.
- Do not copy proprietary IMVU assets into Viper.
- Do not show low-quality avatar placeholders in the visible Forge or Creator room.
- Use Aria's own UV/texture references as source of truth for Aria.
- Search for clean permitted assets when useful.
- Make Viper-authored replacements when assets are missing, weak, or unclear.
