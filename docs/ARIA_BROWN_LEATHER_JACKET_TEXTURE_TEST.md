# Aria Brown Leather Jacket Texture Test

Date: 2026-06-01

## Goal

Create `aria_brown_leather_jacket_v1` as an IMVU-style texture clothing test for Aria.

This is a wardrobe test item, not final production clothing. It should stay separate from the skin texture and should be replaceable by a future fitted jacket mesh.

## Correct Viper Female Base V1 Template

Use this file as the current paint template:

`C:\Users\U\Documents\Codex\Projects\Viper Studio\project\artifacts\api-server\public\creator-templates\viper-female-base-v1\viper_female_base_v1_full_body_paint_template.png`

Live working copy:

`C:\Users\U\Documents\Codex\2026-05-30\files-mentioned-by-the-user-viper\work\viper-studio-full\artifacts\api-server\public\creator-templates\viper-female-base-v1\viper_female_base_v1_full_body_paint_template.png`

Original MakeHuman export:

`C:\Users\U\Documents\makehuman\v1py3\exports\textures\young_lightskinned_female_diffuse3.png`

## Paint Instructions

Paint the jacket on a separate transparent layer using the same canvas size as the template.

Areas to target:

- torso front
- torso back
- shoulders
- upper arms
- lower arms, if this jacket has sleeves
- neckline and collar shape
- front opening / zipper / lapel area
- cuff and hem details

Do not flatten it into the skin texture.

## Files Needed For First Test

Preferred folder:

`C:\Users\U\Documents\Viper_Asset_Drop\aria_brown_leather_jacket_v1\`

Preferred files:

- `aria_brown_leather_jacket_v1_albedo.png`
- `aria_brown_leather_jacket_v1_opacity.png`
- `aria_brown_leather_jacket_v1_roughness.png`
- `aria_brown_leather_jacket_v1_normal.png`
- `aria_brown_leather_jacket_v1_reference.png`
- `source_note.txt`

Minimum files:

- `aria_brown_leather_jacket_v1_albedo.png`
- `aria_brown_leather_jacket_v1_opacity.png`

## Opacity / Clothing Mask

Use white for visible jacket pixels and black for hidden/empty pixels.

The opacity mask is required if the jacket has:

- an open front
- neckline cutout
- sleeveless areas
- straps
- torn edges
- lace, mesh, holes, or transparent panels

## Freebie 1 Notes

`C:\Users\U\Documents\Viper_Asset_Drop\Freebie 1\` includes strong garment references:

- front/back preview renders
- front/back UV maps
- normal maps
- multiple texture passes

However, those UVs belong to that dress mesh, not Viper Female Base V1. Use them to study the workflow and material structure, not as the direct Viper jacket UV.

## Decision

First test mode:

`texture_overlay_clothing`

Later production mode:

`hybrid_or_mesh_clothing`

The first target is to prove that Viper can apply an IMVU-style jacket texture layer to the accepted Viper Female Base V1 without damaging the base skin texture or creator-compatible foundation.

