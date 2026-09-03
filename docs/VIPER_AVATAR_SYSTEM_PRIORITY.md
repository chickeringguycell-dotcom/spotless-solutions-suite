# Viper Avatar System Priority

Superseded active-scope note, 2026-06-14:

MakeHuman / MPFB, Viper Female Base V1, public avatar bases, and skin/avatar product creation are retired from active Viper scope. Keep this file as historical context only. Current creator work should follow `docs/VIPER_CREATOR_SCOPE_RESET_2026-06-14.md`.

Avatar work is now the main development road until the system is complete enough to carry Viper Studios.

## Current Position

The project has enough to begin the real avatar system:

- Photoreal Aria reference set: Forge stand, presence board, character base board, face UV, and body texture/UV board.
- Aria production reference set: 360 form sheet and wire/UV sheet for matching head, body, silhouette, topology, and creator slots.
- MakeHuman Community 1.3.0 package downloaded locally; Blender 5.1 is installed and scriptable; MPFB is not yet connected to Blender.
- MakeHuman female base checkpoint validated: Game Engine rig exported to FBX, handed off through Blender, armature present, 53 bones, UV layers present, material slots named for Viper, and runtime GLB exported upright.
- Viper Female Base V1 accepted as the current creator-base foundation.
- Texture block standard added so Aria and IMVU-style creator products use the same slot-based mechanics.
- Mobile/website responsibility split added: app stays Forge Lite, website carries Full Forge.
- Hidden rig experiments: `Rose.vrm`, `Olivia.vrm`, `Amazonas.vrm`, `Michelle.glb`, and other starter bodies.
- Older body texture sheets: reference-only until rights and UV usage are validated.
- Aria face source: `aria_face.png`.
- Forge support for loading avatars, blinking, gaze, body atlas texture application, and slot tagging.

Visible Aria is not allowed to fall back to those starter bodies. They are private experiments until a matching photoreal flagship rig exists.

## Rule

Do not let avatar work drift into placeholder art. Every avatar change must move toward:

- High-quality humanoid meshes.
- Full-body skeletons.
- Facial rigging or blend shapes.
- Visemes for speech.
- Eye/head tracking.
- Breathing and idle animation.
- Hair, clothing, body-part, and accessory slots.
- IMVU/VRChat-style creator workflows.
- Viper-owned or properly licensed final assets.
- IMVU mechanics underneath: body-part IDs, UV maps, derive metadata, material slots, attachment nodes, texture overrides, and preview testing.

## Asset Tiers

The source of truth is:

`artifacts/viper-studio/lib/avatarSystem.ts`

Use these tiers:

- `starter_rig`: useful for scale, movement, and test rendering only.
- `creator_base`: useful for skin, clothing, furniture spot, and export testing.
- `flagship_candidate`: close enough to test Aria expression, face, and identity work.
- `flagship_ready`: Viper-owned or fully licensed, expressive, shippable, and ready to be Aria's body.

## Immediate Work Order

1. Treat `viper-female-base-v1` as the current MakeHuman/Blender creator-base candidate.
2. Inspect and approve the candidate UV layout, material slots, topology, scale, skeleton names, and attachment-point plan before creator products depend on it.
3. Keep `aria-photoreal-forge-stand-v1.png` as the visible Forge target until the MakeHuman candidate is visually refined enough to replace it.
4. Morph the approved female base toward Aria using the approved front, side, back, 3/4, 360, wire, and UV references.
5. Build the face/head cutting workflow from Aria's face UV board.
6. Build the body texture workflow from Aria's body texture/UV board.
7. Map eyes, lips, brows, lashes, iris, sclera, blush, and base face to avatar slots.
8. Build Aria as texture blocks on Viper Female Base V1: face, body, eyes, brows, lashes, lips, hair, clothing, accessories, and UV frames.
9. Keep the mobile app to Forge Lite responsibilities and push heavier creator tooling toward the website.
10. Add viseme and mouth animation controls once a suitable Aria head rig exists.
11. Keep IMVU as compatibility/reference language only until explicit permission is confirmed.

## Better Asset Policy

If better assets are needed, download them. Acceptable sources:

- User-provided IMVU free/derivable assets.
- MakeHuman/MPFB base meshes and exports with source/license metadata.
- Properly licensed marketplace assets.
- CC0 or permissive humanoid/furniture assets.
- Viper-owned assets we create ourselves.
- Commissioned or licensed Aria flagship assets.

Every imported asset must keep metadata:

- Source URL or product ID.
- Creator/source name when known.
- License or permission note.
- Original file name.
- What Viper changed.
- Target platform/export path.

## Done Means

The avatar system is not complete until Aria can stand in the Forge as a believable digital person:

- She has a flagship-quality body.
- She has Aria's face, hair, eyes, outfit, and accessories.
- She blinks, breathes, looks, smiles, listens, thinks, speaks, and emotes.
- Her mouth moves with voice.
- Creators can test avatar parts, skins, furniture spots, clothing, and exports around her.
