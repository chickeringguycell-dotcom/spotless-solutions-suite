# Avatar Asset Source Candidates

Superseded active-scope note, 2026-06-14:

MakeHuman / MPFB, public avatar bases, and skin/avatar product creation are retired from active Viper scope. Keep this file as historical research only. Current creator work should follow `docs/VIPER_CREATOR_SCOPE_RESET_2026-06-14.md`.

Viper Studio should use the fastest clean path: search for usable assets first, then make Viper-authored replacements for anything missing, weak, or unclear.

## Current Rule

- Prefer Viper-authored assets for Aria's flagship identity.
- Use user-provided references as visual targets and UV guides.
- Use external assets only when source, license, and redistribution rules are clear.
- Keep all third-party source notes with the asset.

## Candidate Lanes

### MakeHuman / MPFB

Official source: `https://static.makehumancommunity.org/about/license.html`

Documentation: `https://static.makehumancommunity.org/makehuman/docs.html`

Use as the preferred free/open-source lane for humanoid base research and Blender pipeline testing. The license page describes MakeHuman and MPFB as split-license projects with a goal of keeping graphics parts as unrestricted as possible, and the MakeHuman community docs describe exported MakeHuman characters as CC0. Still keep a source note with every exported base and verify exact asset/export license before shipping anything public.

Current local status:

- MakeHuman Community 1.3.0 is installed and running locally.
- Blender 5.1 is installed at `C:\Program Files\Blender Foundation\Blender 5.1\blender.exe`.
- MPFB is not currently detected in Blender's addon registry.
- The current Viper Female Base V1 candidate was exported from MakeHuman as `artifacts/avatar-sources/makehuman/exports/viper_female_base_v1.fbx`, handed off through Blender as `artifacts/avatar-sources/makehuman/blender-handoff/viper_female_base_v1_blender_handoff.blend`, normalized as `artifacts/avatar-sources/makehuman/viper_female_base_v1_pipeline_candidate.blend`, and exported to runtime GLB at `artifacts/api-server/public/avatars/viper-female-base-v1.glb`.

Viper use:

1. Generate a clean female base mesh in MakeHuman or MPFB.
2. Export/import to Blender.
3. Morph toward Aria using the approved 360 form, wire/UV, and head references.
4. Retain skin, eyes, brows, lashes, hair, teeth, tongue, makeup, tattoos, clothing, and accessory slots as Viper creator products.
5. Export GLB for the Viper runtime only after orientation, UVs, rig, material slots, and creator locks are verified.

### VRoid Studio

Official source: `https://vroid.com/en/studio/guidelines`

Use as a workflow and stylized-avatar reference lane. VRoid guidelines allow broad use of exported models and preset-derived items when no special clauses apply, but VRoid/pixiv-provided assets are not CC0. Do not build a Viper avatar-generation feature from VRoid meshes/textures without a separate license. Do not imply pixiv or VRoid endorsement.

### Ready Player Me

Official source: `https://docs.readyplayer.me/ready-player-me/support/terms-of-use`

Use as an avatar-platform integration reference lane. Their docs distinguish non-commercial use from commercial app/game integration through a registered developer relationship. Do not mint or represent RPM avatars as Viper-owned assets.

## Immediate Viper Path

1. Keep Aria skin, face, and identity Viper-authored.
2. Use MakeHuman/MPFB before primitive sculpting when a clean human base mesh is needed.
3. Use searched assets only as references, test rigs, or licensed integrations.
4. Build missing hair, garment, eyes, face material maps, and final body mesh as Viper-owned products unless a cleaner permitted asset beats our own work.
