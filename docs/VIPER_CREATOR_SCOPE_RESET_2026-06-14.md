# Viper Creator Scope Reset

Status: active direction as of 2026-06-14.

## Decision

Viper Studios should not try to be an avatar generator or skin generator.

That path is too large, too quality-sensitive, and too easy to sink the project into body topology, face likeness, UV seams, skin shaders, blendshapes, hair systems, licensing, moderation, and marketplace edge cases before the core product works.

## Retired From Active Scope

- MakeHuman / MPFB as a Viper production lane.
- Viper Female Base V1 as an active creator foundation.
- Public male/female avatar base creation.
- Skin generation, face skins, makeup skins, eye packs, brows, lashes, lips, nails, and full avatar appearance packages.
- Promising that Aria is built by morphing a public creator base.
- Mobile loading of creator-base avatars or avatar/skin factory paths.

## Still Allowed

- Aria remains a protected CC5 flagship assistant.
- Gaius remains a protected assistant/guide lane.
- Camilla and other compatible CC5 assets may be used as internal motion or fit references when properly sourced.
- Clothing and accessories may use fixed reference bodies or fit rigs, but those rigs are not public avatar products.
- Aria-specific wardrobe may be built only through approved protected Aria wardrobe systems.

## Feasible IMVU-Style Product Scope

Viper should focus on creator products that do not require Viper to solve public avatar generation:

- Clothing and wearable mesh products.
- Accessories and jewelry.
- Props and objects.
- Furniture.
- Rooms.
- Buildings.
- Vehicles and ships.
- Weapons and tools.
- Interior assets.
- Decals, materials, and texture sets for non-skin surfaces.
- Lighting, effects, and audio products.
- Product cards, derivation metadata, source notes, package checks, thumbnails, and export checklists.

## Architecture Rule

Website/Forge is the master factory for heavy product creation.

Mobile is a companion/control surface:

- choose Aria or Gaius
- chat
- browse projects/products
- approve/reject jobs
- view thumbnails or lightweight previews
- submit small build requests

Mobile should not run avatar creation, skin creation, MakeHuman import, heavy GLB startup, rigging, retargeting, UV editing, baking, or full product export.

## MakeHuman Purge Rule

MakeHuman assets may remain only as quarantined historical artifacts until the user approves permanent deletion.

They must not appear in:

- active app startup
- active mobile prefetch
- Aria's system prompt
- product roadmap promises
- current creator-base registries
- visible Forge guidance
- new implementation plans

If a future task needs a body for clothing fit, use a fixed licensed/protected fit reference and name it as a fit reference, not as a creator avatar base.
