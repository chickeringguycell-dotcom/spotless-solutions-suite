# Aria V1 Recovery Status

## Confirmed State

The Viper Studios project files are present and recoverable.

The latest confirmed visible Aria milestone is:

- `artifacts/viper-studio/components/ThreeViewer.tsx` loading `aria-v4-static-frame30-preview.glb` in the live Forge viewer

That checkpoint confirms:

- The Character Creator 5 Aria V4 asset is the protected flagship Aria lane.
- Viper Female Base V1 remains accepted as the public creator foundation, not Aria's protected body.
- Aria identity references are locked.
- Aria now appears in the Forge as a CC5-derived protected runtime checkpoint.
- The old flat Aria reference panel is hidden after the GLB loads.
- The Forge opens with the orange/purple Viper grid, room assets, and Aria visible.
- Server TTS is reachable; web autoplay can still block the first automatic greeting until the user interacts with the page.

## Current Aria State

Aria currently exists as:

- Protected CC5 source: `artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx`
- Stable visible runtime checkpoint: `artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb`
- Rollback static checkpoint: `artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb`
- Animated candidate needing root-motion cleanup: `artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb`
- Public creator base mesh: `artifacts/api-server/public/avatars/viper-female-base-v1.glb`
- Current build manifest: `artifacts/api-server/public/avatars/aria/aria-v1-current-build.json`
- Skin and identity texture blocks under `artifacts/api-server/public/skins/aria/`
- Official visual references under `artifacts/api-server/public/references/aria/`
- MakeHuman/Blender source handoff under `artifacts/avatar-sources/makehuman/` as historical/reference material only

## Current Active Task

Move from visible protected CC5 checkpoint into a recognizable, animated Aria V1:

1. Clean the animated walk GLB so root motion does not move Aria out of frame.
2. Replace the imported arms-out/static stance with a natural idle stance.
3. Preserve CC5 materials, UVs, protected identity metadata, and Aria-only wardrobe slots.
4. Wire facial/head/gesture controls from the Director Layer into the CC5 rig where bone names are available.
5. Add approved hair, necklace, and wardrobe loadout handling without making Aria a public creator mannequin.

Wardrobe items such as jacket, jeans, sneakers, and pants remain important, but they must not delay Aria's face, skin, eyes, hair, and necklace.

## Blocking Gap

The main blocker is no longer missing project files or missing viewer integration.

The current blocker is asset cleanup: the animated CC5 walk export contains root motion/orientation issues, and the stable visible checkpoint still uses a static imported pose. Aria is visible, but the next pass must make her idle/walk naturally.

## Next Visible Checkpoint

The next checkpoint should be:

`Aria V1 Living Preview`

Minimum acceptance:

- CC5 Aria visible in the Forge on web and mobile.
- Natural idle stance instead of imported arms-out pose.
- Subtle breathing/look-around animation active.
- Aria Director Layer drives at least expression, speaking state, gaze, and gesture messages.
- Voice request succeeds through the API, with user-gesture handling for web autoplay.
- Aria protected identity remains separate from public creator bases and public wardrobe testing.
