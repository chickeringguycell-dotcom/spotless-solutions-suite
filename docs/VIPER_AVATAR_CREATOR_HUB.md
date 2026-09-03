# Viper Creator Hub

Superseded active-scope note, 2026-06-14:

Public avatar creation and skin creation are retired from active Viper scope. Keep avatar-specific parts of this file as historical context only. Current creator work should focus on clothing, accessories, props, rooms, furniture, vehicles, ships, weapons, tools, non-skin materials, and export/package workflows.

Viper Studios is not only an avatar viewer. It is a Forge where anyone who wants to build game content can come make to their heart's content while Aria helps them move from idea to working asset.

## Product Direction

The Forge should support a universal creator workflow:

- Avatars, skins, heads, hair, eyes, clothes, accessories, and avatar animation.
- Game mods, ships, weapons, furniture, rooms, props, environments, story assets, and export packages.
- A visible working floor where the user can watch Aria build, test, adjust, and explain the pipeline.
- Target-aware checks for platforms such as IMVU, VRChat, Starfield, Blender, Unity, Unreal, Roblox, and others.

## Avatar Creator Direction

The avatar side of the Forge should support an IMVU-aware creator workflow. Current visible milestone is Aria-first; calibrated creator bases return later after Aria clears the quality bar.

- Future calibrated creator bases for fit testing.
- Male avatar pipeline with two separated lanes: a protected or semi-protected Male Companion character lane and a public Male Creator Base workbench lane.
- Body texture atlases for skin and body detail work.
- Face/head texture cutting from Aria-style portrait references.
- Eye, brow, lash, lip, hair, clothing, accessory, and body-detail slots.
- Rigged avatar bodies with idle, blink, gaze, breathing, expression, and future lip-sync support.
- A visible workspace where Aria can apply, compare, and explain creator changes in front of the user.

The first IMVU Creator workspace scaffold lives in `docs/IMVU_CREATOR_DEV_ROOM.md` and `artifacts/viper-studio/app/(tabs)/imvucreator.tsx`.

Related design records:

- `docs/VIPER_ASSET_DROP_INTAKE.md`: simple front-door staging folder for downloaded source assets.
- `docs/VIPER_MALE_AVATAR_DUAL_ROLE_POLICY.md`: locked separation between Male Companion and Male Creator Base.
- `docs/VIPER_TEXTURE_BLOCK_STANDARD.md`: texture building blocks for Aria and creator products.
- `docs/VIPER_DERIVABLE_CREATOR_CATEGORY_SYSTEM.md`: category-first creator products, derivable/base asset workflow, and wearable attachment slots.
- `docs/VIPER_APP_WEBSITE_SPLIT.md`: mobile app as Forge Lite and website as Full Forge.

## IMVU Creator Mental Model

IMVU creators think in body patterns, body parts, skeletons, materials, textures, and replaceable products. Viper should meet them there.

Useful compatibility targets:

- IMVU classic female body pattern: product 80.
- IMVU classic male body pattern: product 191.
- Ten base body part IDs: head, hair, upper body, lower body, hands, feet, and related body part replacements.
- Clothing often replaces body parts rather than merely covering an underlying body.
- Avatar attachments use attachment nodes/bones.
- The avatar skeleton must be treated as fixed for IMVU-specific products.

Official references:

- https://create.imvu.com/articles/classic/avatar-body-parts-intro/
- https://create.imvu.com/articles/studio/imvu-studio-avatar-body-parts/
- https://create.imvu.com/articles/classic/skeletons-blender/

## Viper Implementation Rule

Viper can support IMVU sizing, testing, body-part thinking, and creator workflows without copying proprietary IMVU meshes or textures into the product. Aria's visible body must remain photoreal and Viper-owned; later creator bases should also be Viper-owned or properly licensed, with measurement rigs, UV-test views, and slot vocabulary that make sense to IMVU creators.

## Texture Pipeline

Viper texture work should use building blocks, not one flattened texture. The same block system should let creators test IMVU-style products and let Viper build Aria from the accepted base.

The body textures currently used as the male and female base skin atlases are:

- `artifacts/api-server/public/textures/base_female_skin.jpg`
- `artifacts/api-server/public/textures/base_male_skin.jpg`

The Aria face source/atlas is:

- `artifacts/api-server/public/textures/aria_face.png`

Next texture tools to build:

- Texture block standard: body, face, eyes, brows, lashes, lips, hair, clothing, accessories, and UV frames.
- Face cutter: crop eyes, lips, brows, lashes, sclera, iris, blush, and base face from Aria references.
- Head UV preview: show how a face sheet wraps onto the selected avatar head.
- Body atlas preview: show front/back torso, arms, legs, hands, feet, and seams.
- Slot tester: apply one texture part at a time without rebuilding the whole avatar.
- Creator export checklist: naming, dimensions, body part target, slot target, and preview screenshots.

The standard lives in `docs/VIPER_TEXTURE_BLOCK_STANDARD.md`.

## IMVU Product Development Lane

Viper should support creators who download IMVU free, starter, or derivable assets and want to develop products from them.

Important distinction:

- Viper-owned or CC0 assets can ship directly inside Viper.
- IMVU free/starter/derivable assets can be imported for creator workflow, testing, derivation, and IMVU product development.
- Free Blender/CC0/permissive assets can also be used as base products when they are cleaner or easier to adapt.
- If a good base does not exist, Viper should make the asset in Blender and keep that Blender file as the editable product source.
- If an IMVU asset is only licensed for IMVU Creator usage, Viper should not redistribute it as a built-in Viper asset.
- Every imported IMVU product should keep source metadata: creator/source, product ID if any, derivation status, license/permission note, original file name, and target export.

Furniture workflow targets:

- Kitchen pieces, bed, table, chairs, room shells, wall/floor textures, decor, and avatar/furniture spots.
- Scale testing against Viper's calibrated male/female avatar bases.
- Seat/standing spot previews.
- Texture replacement and material-slot testing.
- Package checklist for IMVU Studio/Create Mode.

Official references:

- Deriving products: https://create.imvu.com/articles/classic/what-is-deriving/
- Zero-change derives and derivable permission context: https://support.imvu.com/support/solutions/articles/154000196628-all-you-need-to-know-about-zero-change-derives
- Furniture starter workflow for Blender: https://create.imvu.com/articles/classic/quickstart-furniture-blender/
- Furniture introduction/start file: https://create.imvu.com/articles/classic/furniture-introduction-blender/
- Creator responsibilities and IP rules: https://create.imvu.com/articles/classic/imvu-terms-of-service/

## Aria's Role

Aria is the guide and builder inside this space. She should be able to say what she is doing, show it on the avatar, and keep the pipeline visible:

1. Import reference.
2. Cut texture pieces.
3. Apply to avatar slots.
4. Test fit and seams.
5. Preview expressions and movement.
6. Package for the target platform.
