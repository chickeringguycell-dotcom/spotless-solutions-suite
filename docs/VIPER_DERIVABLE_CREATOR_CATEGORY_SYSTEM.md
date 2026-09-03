# Viper Derivable Creator Category System

Viper should support the creator workflow pattern that IMVU creators already understand:

1. Choose a product category.
2. Choose a derivable or base asset for that category.
3. Dev the product by changing mesh, texture, material, UVs, fit, or attachment settings.
4. Preview it on the correct approved fit reference, room, object, or vehicle.
5. Save/export with source and permission metadata.

This is not copying IMVU assets or code. It is adopting the category-first creator workflow.

## Core Rule

A creator product is not just a loose file.

Every product should know:

- What category it belongs to.
- What base/derivable asset it started from.
- Which fit zone, node, material, or surface it targets.
- Which textures and material blocks it uses.
- Whether it replaces, overlays, or attaches.
- Which platform/export lane it is being prepared for.

## Wearable Categories

Public avatar and skin creation is retired from active Viper scope. Wearable categories should include:

- Jacket.
- Shirt.
- Pants.
- Shoes.
- Necklace.
- Hat.
- Accessory.
- Avatar attachment.

Examples:

- A jacket knows it targets upper body, shoulders, and arms.
- Jeans know they target pelvis and legs.
- Sneakers know they target feet.
- A necklace knows it attaches to the neck node.
Wearable work uses approved fixed fit references. Do not present those references as public avatar products.

## World Categories

World categories should include:

- Furniture.
- Decorations.
- Lighting.
- Visual effects.
- Music/audio assets.
- Environment assets.
- Rooms.
- Wall textures.
- Floor textures.

Examples:

- A chair knows it may need seat nodes.
- A room knows it needs room/furniture node checks.
- A lighting effect knows it targets the scene lighting layer.

## Vehicle Categories

Vehicle categories should include:

- Ships.
- Parts.
- Engines.
- Weapons.
- Interior assets.
- Cockpit props.
- Materials and decals.

Examples:

- An engine knows it attaches to the ship engine slot.
- A weapon knows it attaches to a hardpoint.
- A cockpit prop knows it belongs inside the interior asset lane.

## Derivable/Base Asset Requirement

For IMVU-style dev work, the creator usually needs a derivable/base asset before the product can be developed.

Viper should track this explicitly:

- `requiresDerivableBase: true`
- source platform: IMVU, Viper, CC0, marketplace, user upload, or other
- product ID or source URL when available
- source creator when available
- permission note
- original filename
- target category
- target fit reference or object
- changed slots
- export target

If the asset is from IMVU's free/derivable ecosystem, Viper can use it as a creator-workflow source lane when the user has permission and the source metadata is preserved.

## Asset Sourcing Order

Viper should not force one asset source. The creator should be able to choose the best clean base for the job.

Recommended order:

1. IMVU free/derivable asset when the user has permission and the product metadata is preserved.
2. Free Blender/CC0/permissive asset when it is cleaner or easier to adapt.
3. Viper-authored Blender asset when the needed base does not exist or the available assets are weak.
4. Licensed marketplace or commissioned asset for premium production quality.

For Aria and other flagship assets, Viper should prefer the cleanest result while keeping the source history attached.

IMVU has a large free/derivable asset ecosystem, so Viper should treat it as a major creator source lane. Blender has many free assets too, so Viper should also support Blender-native bases for products that need stronger geometry, cleaner topology, or easier rigging.

## Blender Dev Path

When an asset starts in Blender or is brought into Blender for cleanup:

1. Import the derivable/base asset.
2. Fit it to the approved fixed/protected fit reference for the product.
3. Clean scale, origin, normals, UVs, and materials.
4. Add or transfer weights if the asset must move with the avatar.
5. Add attachment-node metadata if it is an accessory.
6. Export GLB for Viper preview.
7. Preserve the Blender file as the editable creator source.
8. Keep a product manifest beside the asset.

## Wearable Fit Zones

Viper Female Base V1 is retired from active scope. Wearable products should declare fit zones without creating a public avatar base:

- `head`
- `hair`
- `neck`
- `upper_body`
- `shoulders`
- `arms`
- `hands`
- `pelvis`
- `legs`
- `feet`
- `back`

Aria's first wearable targets:

- Leather jacket: upper body, shoulders, arms, back.
- Necklace: neck attachment node.
- Jeans: pelvis and legs.
- Sneakers: left foot and right foot.

These should be product packages, not baked into the base body.

## Mobile And Website Split

Mobile app should support:

- Category picker.
- Quick preview.
- Simple non-skin material/product test.
- Simple fit check.
- Aria explanation and approval.

Website should support:

- Full derivable/base asset import.
- Blender handoff.
- Rig/weight transfer for clothing/accessories when needed.
- UV editing.
- Multi-actor preview.
- Room/object/vehicle assembly.
- Advanced export validation.

The app stays light; the website carries the full creator studio.
