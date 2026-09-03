# Viper Texture Block Standard

Superseded active-scope note, 2026-06-14:

Skin, face, eye, makeup, lip, brow, lash, nail, hair, and avatar appearance blocks are retired from public creator scope. Keep protected Aria identity material internal. New active texture work should target clothing, accessories, props, furniture, rooms, vehicles, ships, weapons, decals, and non-skin materials.

Viper's avatar creator system should work the way IMVU creators already think: stable base avatar, body-part targets, material slots, UV frames, texture overrides, preview testing, and export notes.

The important Viper difference is quality. IMVU is the mechanics model, not the visual ceiling.

## Core Rule

Do not build Aria or creator products as one flattened texture.

Build them as reusable texture blocks that can be applied, replaced, compared, and exported independently.

The same tools that let IMVU-style creators test products should also be the tools Viper uses to build Aria.

## Stable Base

`Viper Female Base V1` is the accepted creator base.

Keep these stable unless we deliberately create a new base version:

- Skeleton and rest pose.
- Scale.
- UV layout.
- Body-part targets.
- Material slot names.
- Attachment points.
- Creator metadata format.

Aria is a variant built on top of this base, not a separate incompatible avatar system.

## Texture Blocks

### Body Blocks

- `body_base_albedo`: main body color and broad skin tone.
- `body_detail_albedo`: knees, elbows, hands, feet, collarbone, back, and other detail zones.
- `body_normal`: pores and subtle sculpted detail.
- `body_roughness`: shine control.
- `body_ao`: soft crease/shadow support.
- `body_tone_mask`: tint and tone selection.
- `body_uv_frame`: creator guide overlay for testing seams and placement.

### Face Blocks

- `face_base_albedo`: Aria's face identity and skin tone.
- `face_detail_albedo`: freckles, pores, cheek/nose/chin detail.
- `face_normal`: eyelids, nose, lips, cheeks, pores.
- `face_roughness`: forehead, cheeks, nose, and lip shine control.
- `makeup_overlay`: eyeliner, shadow, blush, highlight, optional creator layers.
- `face_uv_frame`: creator guide overlay for fitting face products.

### Eye Blocks

- `iris_albedo`: iris color and radial detail.
- `iris_normal`: iris depth detail.
- `sclera_albedo`: eye white color and subtle veins.
- `cornea_material`: transparent shine/wetness material.
- `catchlight_mask`: controlled reflection/catchlight support.

### Brow, Lash, And Lip Blocks

- `brow_albedo`: brow shape and color.
- `lash_alpha`: transparent eyelash card texture.
- `lash_albedo`: lash color.
- `lip_albedo`: lip color and shape.
- `lip_normal`: lip creases and volume support.
- `lip_roughness`: gloss control.

### Hair Blocks

- `hair_albedo`: dark Aria hair color and strand color.
- `hair_alpha`: card/groom opacity.
- `hair_normal`: strand depth.
- `hair_roughness`: shine control.
- `hair_highlight_mask`: controlled highlight placement.

### Clothing And Accessory Blocks

- `garment_albedo`: clothing color and pattern.
- `garment_alpha`: opacity or coverage mask.
- `garment_normal`: fabric detail.
- `garment_roughness`: fabric shine.
- `accessory_albedo`: jewelry, metal, gem, or prop color.
- `accessory_material_maps`: metalness, roughness, normal, glow, or tint.

## IMVU-Style Product Package

Every Viper creator product should eventually carry:

- Product type: skin, hair, eyes, makeup, lips, clothing, accessory, room, furniture, or object.
- Product category: jacket, shirt, pants, shoes, necklace, hat, furniture, room, vehicle part, effect, audio, or another creator-facing category.
- Derivable/base asset source.
- Target body part IDs.
- Target material slots.
- Texture block IDs.
- UV frame used.
- Source asset metadata.
- Permission/license note.
- Changed-slot list.
- Preview screenshots.
- Export target notes.

This lets creators swap one piece without rebuilding the avatar.

## Aria Conversion Stack

Aria should be assembled in this order:

1. Viper Female Base V1.
2. Aria head/face morph.
3. Aria body proportion morph, if needed.
4. Aria face texture blocks.
5. Aria eyes.
6. Aria brows, lashes, and lips.
7. Aria body skin blocks.
8. Aria hair blocks.
9. Aria clothing/accessory blocks.
10. Aria expressions, blink, gaze, and future speech controls.

## Tooling Order

Build creator tools in this order:

1. Slot picker.
2. Texture upload.
3. UV-frame overlay.
4. Apply one texture block to one slot.
5. Before/after compare.
6. Seam and placement checklist.
7. Save preview package.
8. Export package manifest.
9. Aria-assisted repair, cleanup, and improvement.

Manual controls come first. Aria-assisted mode helps, but creators must be able to work directly.

## Legal And Source Rule

Keep IMVU as compatibility and workflow language unless explicit permission is confirmed.

Viper-owned, CC0, permissive, or properly licensed assets can ship as built-in assets. IMVU-specific assets can be imported for creator workflow only when their permission allows that usage, and their source metadata must stay attached.
