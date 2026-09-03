# Viper Product Library And Loadout System

## Requirement

Completed products must become product entries, not loose files.

Creators should not need to browse raw filenames to dress Aria or test assets. Finished products should appear as cards in a product library.

## Product Library / Wardrobe

The product library contains all completed products available to Aria, users, NPCs, and future creator avatars.

Each product card should include:

- Thumbnail
- Product name
- Category
- Status
- Equip button

Example:

- Thumbnail
- Aria Leather Jacket V1
- Category: Jacket
- Status: Complete
- Equip

## Equipped Items / Current Outfit

The equipped item list contains only what is currently active on the avatar.

Example:

- Hair: Aria Hair V1
- Eyes: Aria Violet Eyes V1
- Necklace: Aria Triangle Necklace V1
- Jacket: Aria Leather Jacket V1
- Pants: Aria Jeans V1
- Shoes: Aria Sneakers V1

Changing outfits must not require rebuilding Aria.

## Current Project State

Viper already has partial pieces:

- `artifacts/viper-studio/app/(tabs)/wardrobe.tsx` stores wardrobe items and shows visual cards.
- `artifacts/viper-studio/lib/avatarMechanics.ts` has product manifests, equipped product IDs, slot mechanics, and equip logic.
- `artifacts/viper-studio/lib/imvuCreatorWorkspace.ts` defines creator product packages and categories.

The missing piece is the full bridge between these systems:

- Product cards backed by product manifests.
- Category-filtered creator inventory.
- Equip/unequip UI connected to the avatar loadout.
- Saved outfits/loadouts as named looks.
- Finished product status separate from draft/reference status.

## Design Rule

Aria identity products are not the same as wardrobe products.

Identity products:

- Face
- Skin
- Eyes
- Hair
- Brows
- Lips
- Necklace

Wardrobe products:

- Jacket
- Shirt
- Pants
- Shoes
- Seasonal outfits
- Creator showcase outfits

The system should allow Aria to change clothes while keeping her identity intact.

