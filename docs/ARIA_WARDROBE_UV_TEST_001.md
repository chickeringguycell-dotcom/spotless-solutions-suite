# Aria Wardrobe UV Test 001

Date: 2026-06-01

## Purpose

First intake review for Aria wardrobe assets using the Viper Female Base V1 creator pipeline.

This test checks whether candidate wardrobe files can be used as direct texture overlays, require matching clothing meshes, or should only be treated as visual references until licensing/permission is confirmed.

## Intake Files Reviewed

- `C:\Users\U\Documents\Viper_Asset_Drop\623-6238782_t-shirt-texture-imvu-hd-png-download.png`
- `C:\Users\U\Documents\Viper_Asset_Drop\5739a6018e6cc6f6ad8b2b8424a7fd37.png`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 3\`

## Corset / Top Candidate

Primary loose file:

`C:\Users\U\Documents\Viper_Asset_Drop\623-6238782_t-shirt-texture-imvu-hd-png-download.png`

Assessment:

- Appears to be an IMVU-style top/corset wearable reference or texture sheet.
- It is not currently aligned to Viper Female Base V1 UVs.
- It does not appear to be a full Viper body UV sheet.
- Best category: `top`, `corset`, or `costume_top`.
- Best implementation path: hybrid clothing.

Recommended handling:

- Do not paint this directly onto Viper Female Base V1 as the final product.
- Use it as a design and material reference for a fitted corset/top clothing mesh.
- Create or import a matching top mesh that fits Viper Female Base V1.
- Apply albedo and opacity maps to that top mesh.
- Keep future slots active for `skin`, `eyes`, `hair`, `makeup`, `top`, `jacket`, `pants`, `shoes`, and `accessory`.

Opacity/mask need:

- Yes. Straps, openings, lace, cut edges, and decorative negative space need an opacity mask if this is tested as a texture layer.
- A black/white mask should be stored separately from the color texture.

## Freebies 2 Package

Important files:

- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\CHKN Files\dRESS.chkn`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\CHKN Files\dRESS.chkn assets\`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\PNG Image\A1.png`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\PNG Image\A2.png`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\Textures\14-txt-3.jpg`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 2\Textures\14-op-3.jpg`

Assessment:

- This is closer to a real creator product package than the loose image file.
- It includes preview renders, texture maps, and opacity maps.
- The readme states the files are original creator work and must use the provided IMVU derivation link.
- The readme also says the files are only for IMVU game use unless further permission exists.

Viper handling:

- Mark as `imvu_compatible_reference_only` until explicit permission is documented.
- Use it to study creator workflow, category structure, material naming, opacity masks, and product packaging.
- Do not move these exact files into the Viper-owned production asset library without permission clearance.

## Black Leather Pants Candidate

Primary loose file:

`C:\Users\U\Documents\Viper_Asset_Drop\5739a6018e6cc6f6ad8b2b8424a7fd37.png`

Assessment:

- This is a visual reference sheet for black leather pants, not a usable UV texture map.
- It shows front/back/angled product styling and material direction.
- It does not include a mesh, UV frame, or texture islands that can be directly wrapped onto Viper Female Base V1.
- Best category: `pants` / `leather_pants`.
- Best implementation path: hybrid clothing.

Recommended handling:

- Use as Aria wardrobe design reference.
- Build or import a fitted pants mesh for Viper Female Base V1.
- Create leather material maps for that mesh:
  - albedo/base color
  - roughness
  - normal/bump
  - optional metallic/specular
  - opacity only if cuts, holes, mesh panels, or transparent detail exist

## Freebies 3 Package

Important files:

- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 3\592.jpg`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 3\Textures\a new mcg2.jpg`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 3\Textures\15-opacity.jpg`
- `C:\Users\U\Documents\Viper_Asset_Drop\Freebies 3\Textures\16-opacity.jpg`

Assessment:

- This appears to be another IMVU creator wearable package with color references and opacity masks.
- The readme says the files must be used on the provided derivation link and only for IMVU game use.

Viper handling:

- Mark as `imvu_compatible_reference_only` until explicit permission is documented.
- Use it to study product mechanics and mask behavior.
- Do not treat it as Viper-owned wardrobe art.

## Next Test Package Format

For each Aria wardrobe item, use one clean folder:

`C:\Users\U\Documents\Viper_Asset_Drop\aria_corset_top_test_001\`

or

`C:\Users\U\Documents\Viper_Asset_Drop\aria_leather_pants_test_001\`

Preferred contents:

- `source_mesh.fbx`, `source_mesh.obj`, `source_mesh.glb`, or `source_mesh.blend`
- `uv_frame.png`
- `albedo.png`
- `opacity.png`
- `normal.png`
- `roughness.png`
- `reference.png`
- `source_note.txt`

Preferred texture size:

- 2048 x 2048 PNG for first serious Viper tests.
- 4096 x 4096 PNG or TIFF for final high-detail Aria work.
- Keep any original IMVU 256 x 512 or 512 x 512 maps unchanged as source references.

## Decision

The first Aria wardrobe test should not be texture-only.

Use a hybrid wearable pipeline:

1. Fit a dedicated clothing mesh to Viper Female Base V1.
2. Attach it to the correct creator category and avatar slots.
3. Apply color texture, opacity mask, and material maps.
4. Preview it in the Forge/Creator viewer.
5. Keep the base avatar unchanged so future creator products remain compatible.

