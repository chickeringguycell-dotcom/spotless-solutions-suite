# Aria Photoreal Avatar + IMVU Mechanics Research

Superseded active-scope note, 2026-06-14:

The avatar/skin-generation portions of this research are historical only. Viper should keep Aria as a protected CC5 assistant and focus creator tooling on feasible non-avatar IMVU-style products. Current creator work should follow `docs/VIPER_CREATOR_SCOPE_RESET_2026-06-14.md`.

## Core Direction

Viper's avatar system is not "copy IMVU visuals." It is:

**IMVU creator mechanics + Viper photoreal Aria quality.**

Creators coming from IMVU should recognize the workflow:

- Body patterns and body-part IDs.
- Replaceable products instead of one monolithic avatar.
- Material slots and texture overrides.
- UV maps and UV frame previews.
- Derive/source metadata.
- Skeleton weighting and animation tests.
- Attachment nodes for accessories.
- Room/furniture nodes and seat naming.
- Actions/particles later.

Aria must not be presented through noodle, tube, tire, primitive, or cartoon placeholders. Visible Aria is photoreal reference/presence until a real Viper-owned rig clears the quality gate.

## Current Toolbelt Direction

The preferred free/open-source base-mesh workflow is:

1. MakeHuman or MPFB generates a clean female human base.
2. Blender morphs and sculpts that base toward Aria using the approved front, side, back, 3/4, 360 form, wire, and UV references.
3. Viper preserves separate creator slots for skin, face, eyes, hair, makeup, lips, clothing, and accessories.
4. GLB becomes the runtime format after the head and body resemble Aria closely enough.

Local status on May 31, 2026:

- Blender 5.1 is installed and scriptable.
- MakeHuman Community 1.3.0 is downloaded at `C:\Users\U\Downloads\makehuman-community-1.3.0-windows\makehuman-community_1.3.0.exe`.
- MPFB is not yet detected in Blender's addon registry.
- Do not continue visible Aria work from primitive clay shapes when a MakeHuman/MPFB base mesh can be used instead.

## What IMVU Mechanics Teach Us

IMVU avatars are built as a "Body Pattern": skeleton, meshes, materials, textures, triggered animations, and idle animations. The classic female and male bodies use product IDs 80 and 191, and the avatar is split into 10 body-part IDs: head, hair, upper body, hands, pelvis, legs, and feet.

For Viper this means:

- Every wearable or avatar product needs a target slot and body-part override/conflict model.
- Clothing-like products may replace body geometry rather than only sit over it.
- Viper needs a body-part ID panel and conflict warnings.
- Viper needs per-slot texture/material previews.
- Viper needs imported asset metadata: source, product ID, derivation status, permission notes, and intended export.

Sources:

- IMVU Avatar Body Parts Intro: https://create.imvu.com/articles/classic/avatar-body-parts-intro/
- IMVU Studio Avatar Body Parts: https://create.imvu.com/articles/studio/imvu-studio-avatar-body-parts/
- IMVU Product Types: https://create.imvu.com/articles/studio/imvu-product-types/

## UV and Texture Requirements

Aria came with her own UV/texture references, so Viper should treat those as source of truth for Aria instead of forcing her into older starter maps.

The app now stores:

- `aria-face-uv-reference-v1.png`
- `aria-body-texture-uv-reference-v1.png`
- `aria-character-base-reference-v1.png`
- `aria-photoreal-presence-target-v1.png`
- `aria-photoreal-forge-stand-v1.png`

Needed creator tools:

- View UV map next to texture map.
- Apply texture to selected slot.
- Show UV overlay/frame on top of texture.
- Detect stretching, seam mismatch, wrong orientation, overlap, and bad scale.
- Export UV layout for creators to paint against.
- Keep texture maps separate from mesh ownership/licensing.

Sources:

- Blender UV Unwrapping: https://docs.blender.org/manual/en/3.6/modeling/meshes/uv/unwrapping/introduction.html
- Blender UV Tools: https://docs.blender.org/manual/en/3.6/modeling/meshes/editing/uv.html
- IMVU Diffuse Textures: https://create.imvu.com/articles/studio/imvu-studio-introduction-to-textures/
- IMVU Transparency Options: https://create.imvu.com/articles/studio/transparency-options/

## Mesh, Rig, and Animation Requirements

Aria V1 needs a real humanoid production stack:

- Clean deformation topology around eyes, mouth, jaw, shoulders, elbows, hips, and knees.
- Skeleton and skin weights.
- Eye bones or gaze targets.
- Facial blendshapes/morph targets.
- Visemes for speech.
- Idle animation: breathing, blink, gaze, micro head motion, weight shift.
- Hair system: cards/groom-compatible asset plus motion path later.
- Accessory and clothing slots parented to bones/nodes.

glTF is the right web/mobile runtime shape because it supports PBR materials, skins, morph targets, and animation. VRM is useful as an avatar-specific reference because it layers humanoid bones, expressions, look-at/gaze, and spring bones on top of glTF. Viper can borrow those ideas without committing the whole app to VRM.

Sources:

- Khronos glTF 2.0 Specification: https://registry.khronos.org/glTF/specs/2.0/glTF-2.0.html
- VRM Format: https://vrm.dev/en/vrm/gltf/format/
- VRM Expressions: https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0/expressions.md
- VRM Animation: https://vrm.dev/en/vrma/
- Blender Shape Keys: https://docs.blender.org/manual/en/latest/animation/shape_keys/index.html
- IMVU Studio Toolkit Downloads: https://create.imvu.com/articles/studio/toolkit/

## Digital-Human Realism Requirements

Photoreal presence depends more on small life signals than raw polygon count:

- Eyes: cornea/gloss, sclera, iris depth, catchlights, eyelids, tearline, blink.
- Face: brows, cheeks, mouth corners, jaw, lips, visemes, asymmetry.
- Skin: albedo, normal, roughness, specular, AO, subsurface warmth, pores/freckles/microdetail.
- Hair: cards/groom, flyaways, anisotropic shine, silhouette control.
- Motion: breathing, listening posture, gaze shifts, tiny smiles, thought pauses.
- Voice sync: viseme curves driven by TTS audio, later emotion-aware audio-to-face.

ARKit-style blendshape names are a practical target vocabulary for early Aria face controls. Ready Player Me and VRM confirm that broad avatar ecosystems lean on morph targets/blendshapes for blinking, visemes, and gaze. NVIDIA ACE/Audio2Face confirms the long-term direction: speech/audio can drive face, lip sync, emotion, and head motion.

Sources:

- Apple ARKit BlendShapes: https://developer.apple.com/documentation/arkit/arfaceanchor/blendshapes
- Ready Player Me Morph Targets: https://docs.readyplayer.me/ready-player-me/api-reference/avatars/morph-targets
- Ready Player Me Facial Animations: https://docs.readyplayer.me/ready-player-me/integration-guides/unity/setup-for-xr-beta/facial-animations
- MetaHuman Documentation: https://dev.epicgames.com/documentation/en-us/metahuman
- NVIDIA ACE Overview: https://docs.nvidia.com/ace/overview/latest/index.html
- NVIDIA Audio2Face Overview: https://docs.omniverse.nvidia.com/audio2face/latest/overview_external.html

## Room, Furniture, and Object Mechanics

Viper should not stop at avatars. IMVU creators also need room, furniture, object, and scene product workflows:

- Upload base object/room/furniture.
- Apply texture/material.
- Preview result.
- Edit or ask Aria to improve.
- Reapply.
- Save/export.
- Validate node names.
- Support seat/standing spots and future multi-actor previews.

Sources:

- IMVU Nodes for Furniture: https://create.imvu.com/articles/classic/nodes-for-furniture/
- IMVU Seat Node Naming: https://create.imvu.com/articles/classic/seat-node-naming/
- IMVU Room Nodes: https://create.imvu.com/articles/classic/room-nodes/
- IMVU Action System: https://create.imvu.com/articles/studio/imvu-studio-actions-system/

## Implementation Rules

1. The visible Forge path uses `aria-photoreal-forge-stand-v1.png` until a real flagship rig is ready.
2. Starter rigs may exist only as hidden experiments.
3. Aria's own UV and texture references are the source of truth.
4. The creator room must preserve IMVU mechanics: body part IDs, derive/source metadata, UV frames, material slots, texture overrides, attachment nodes, room/furniture nodes, and preview testing.
5. Manual creator controls stay first-class.
6. Aria assists, inspects, improves, and explains, but creators can work without her taking over.
7. Future calibrated creator bases return only after Aria's flagship body is worth building around.

## Current App Scaffold

The Aria Creator room now exposes the mechanics directly:

- Creator Product Mechanics: product classes for avatar skins, hair, eyes, makeup, clothing, accessories, UV frames, rooms, furniture, and objects. This keeps Viper useful for IMVU-style creators beyond Aria.
- Aria Body-Part Map: IMVU-style body-part IDs mapped to Aria's photoreal target.
- Aria Material Slots: body skin, face skin, eyes, hair, base garment, and accessories with required maps.
- UV Slot Inspector: selected slot, body-part IDs, UV board, texture product, readiness status, and alignment checks.
- Product Package panel: Aria V1 face skin, body skin, eyes, base garment, and hair packages with product type, slots, body-part IDs, material slots, required assets, export targets, readiness checks, and next step.
- Avatar Mechanics Runtime: a pure, tested mechanics layer for body patterns, equipped products, exclusive body-part replacement, overlays, attachment nodes, required-slot validation, and runtime body-part status.
- Viper Quality Gates: source rights, product manifests, body-part maps, UV alignment, conflict validation, live preview, manual control, material depth, motion/fit checks, export readiness, and creator-grade output. These gates exist specifically to prevent Viper from shipping weak, cartoony, or inferior creator products.
- Rig Readiness Gates: the checklist that blocks placeholder rigs from becoming visible product.
- Expression Channels: blink, gaze, brows, smile, mouth core, cheeks, head motion, breathing, and later hair reaction.
- Speech Visemes: closed, AA, EE, IH, OH, OU, FV, and L/TH target mouth shapes.
- Reference viewer: Aria's photoreal board, character base board, face UV, and body texture/UV sheets.
- Portable blueprint: `artifacts/api-server/public/avatars/aria/aria-v1-blueprint.json`.
- Portable package manifest: `artifacts/api-server/public/avatars/aria/aria-v1-product-packages.json`.
- Portable product class manifest: `artifacts/api-server/public/avatars/aria/viper-creator-product-classes.json`.
- Portable Aria runtime manifest: `artifacts/api-server/public/avatars/aria/aria-v1-avatar-mechanics.json`.
- Portable quality gate manifest: `artifacts/api-server/public/avatars/aria/viper-creator-quality-gates.json`.

This makes the product direction visible to creators and keeps future implementation from drifting back into generic placeholders.
