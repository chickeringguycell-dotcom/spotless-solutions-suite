# Aria Identity Texture Pipeline

Superseded active-scope note, 2026-06-14:

Aria identity textures are protected historical/reference material, not public skin products. MakeHuman / MPFB and public skin/avatar creation are retired from active Viper scope. Current creator work should follow `docs/VIPER_CREATOR_SCOPE_RESET_2026-06-14.md`.

Aria's visual identity source is now the photoreal reference set:

- `artifacts/api-server/public/avatar-concepts/aria-photoreal-forge-stand-v1.png`
- `artifacts/api-server/public/avatar-concepts/aria-photoreal-presence-target-v1.png`
- `artifacts/api-server/public/avatar-concepts/aria-character-base-reference-v1.png`
- `artifacts/api-server/public/avatar-concepts/aria-face-uv-reference-v1.png`
- `artifacts/api-server/public/avatar-concepts/aria-body-texture-uv-reference-v1.png`

The older `aria-imvu-style-target-v1.png` remains as a historical social-avatar reference, but it is no longer the visual quality bar.

## Current Rule

Do not paste the whole board onto an avatar head unless the UV layout matches. Use Aria's own UV boards as the source for cutting slot textures.

Aria's visible target is photoreal Viper quality with IMVU-style mechanics underneath. Rose, Michelle, and other starter rigs are private rig/expression experiments only; they are not acceptable as visible Forge or Creator-room stand-ins.

No noodle bodies, tire/tube bodies, primitive test figures, cartoon bases, or low-detail mannequin-style avatars should appear in the visible Viper experience.

Aria is a protected flagship character, not a public creator base. Public clothing, hair, skin, accessory, and creator-product testing must happen on the Male Creator Base and Female Creator Base. Aria-specific wardrobe work is allowed only through approved internal Aria wardrobe systems.

## Missing Asset Rule

Search first for clean permitted assets or references when that saves time. If the asset does not exist, is low quality, or has unclear usage rights, make a Viper-authored replacement.

See `docs/AVATAR_ASSET_SOURCE_CANDIDATES.md` for the active source lanes.

Promising search lanes:

- Character Creator / CC4 or newer: preferred Aria production lane once installed. Use it for Aria's face likeness, body proportions, rig, skin, eyes, hair, expression support, clothing fit, and Blender/FBX handoff.
- Character Creator 5 Aria export: current primary flagship lane when available. Treat `Aria_V4_walk.fbx` and newer CC5 exports as protected Aria candidates, not creator base assets.
- MakeHuman/MPFB core assets: free/open-source fallback and testing lane only. Do not treat MakeHuman as the Aria visual target if Character Creator is available.
- VRoid Studio: useful stylized avatar and VRM workflow reference lane; verify the current guidelines and do not imply pixiv/VRoid endorsement.
- Ready Player Me: useful avatar-platform reference lane; use only through its developer terms if integrated.

## First Visible Pass

The Forge now shows Aria through the photoreal reference presence layer while the real rig catches up:

- Photoreal standing Aria target on the Forge floor.
- Subtle idle movement from the presence layer.
- No visible starter rig, cartoon body, tube body, or primitive placeholder.
- Face, body, and UV boards stored as Aria identity metadata.
- Female creator-safe foundation garment reference stays dark with violet trim.
- `aria_signature_skin_v1` is registered at `artifacts/api-server/public/skins/aria/skin-pack.json`.
- Older starter body maps remain reference-only unless their rights and UV use are validated.

## Production Slot Cuts

The first Aria cut now exists as separate preview texture products:

- `face_base`
- `base_face_reference`
- `makeup_overlay`
- `blush_overlay`
- `lips`
- `eye_makeup`
- `brows`
- `iris_violet`
- `sclera`
- `lashes`
- `body_base`
- `body_base_v1`
- `body_normal`
- `body_roughness`
- `body_specular`
- `body_ao`
- `body_base_uv_check`
- `body_map_reference`
- `body_wireframe_reference`
- `external_body_uv_reference`
- `base_garment_mask_reference`
- `base_garment_mask_preview`
- `preview_sheet`

Additional products still to make or source with clear usage rights:

- `nails`
- `tattoos`
- `hair_alpha_or_cards`
- `outfit_materials`
- `female_base_garment`
- `necklace_accessory`
- face material maps
- eye material maps
- lip material maps

## Completion Path

1. Treat `aria-photoreal-forge-stand-v1.png` as the visible Forge Aria target.
2. Treat Aria's own face/body UV boards as source-of-truth references for Aria.
3. Use `aria_signature_skin_v1` as the first Aria slot pack.
4. Build a head-UV preview that shows exactly where each cut lands.
5. Replace safe marker tints with real slot textures only after the UV preview is clean.
6. Prefer Character Creator / CC4 or newer to create Aria's serious human base, then use Blender for cleanup, Viper slot mapping, and runtime export.
7. Use `Aria_V4_walk.fbx` as the current protected Aria candidate until a newer approved CC5 export replaces it.
8. Use MakeHuman/MPFB only as a historical fallback or creator-base testing lane if Character Creator is unavailable.
9. Move from candidate export to a protected flagship Aria body with documented source, license, UVs, rig, material slots, permanent modesty layer, and approved wardrobe slots.
