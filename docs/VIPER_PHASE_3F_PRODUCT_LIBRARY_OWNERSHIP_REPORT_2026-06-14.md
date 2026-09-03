# VIPER PHASE 3F PRODUCT LIBRARY OWNERSHIP REPORT

Date: 2026-06-14

Scope: SAFE_PRODUCT Dev Lab outputs only. Protected/internal systems, retired avatar systems, Workshop, ThreeViewer, Viewer, Shipyard, IMVU Creator, existing API routes, and protected assets were not removed.

## Mission

Begin the first fully safe migration identified by the DevStudio Separation Report.

Canonical ownership path:

Generation Request -> Preview Record -> Product Library Card

## What Was Migrated

DevStudio Dev Lab SAFE_PRODUCT image generation now sends product ownership metadata through the shared Forge generation bridge.

Allowed Dev Lab outputs now claim Forge Product Library ownership:

- Vehicle concepts
- Spacecraft parts
- Weapon concepts
- Furniture concepts
- Prop concepts
- Building/environment-style concepts when routed through safe Forge workspaces
- Texture/material concepts

Not migrated:

- Avatar generation
- Skin generation
- Body, face, hair, makeup generation
- DressingRoom systems
- ViperCreatorShell systems
- MakeHuman
- MPFB
- Protected Aria assets
- Protected Gaius assets

## New Product Library Behavior

When a safe Dev Lab generation completes, Forge now:

1. Creates or locates a Product Library card.
2. Links the Generation Request to the Product.
3. Links the generated Preview to the Product.
4. Stores Product Library ownership metadata.
5. Preserves the existing local Dev Lab AsyncStorage record.

The new API ownership service is:

- `claimForgeProductOwnership`
- `POST /api/forge/products/claim-generation`

The `/api/imagine` Forge bridge can now optionally claim product ownership when safe product metadata is provided.

## Product Card Fields

Product cards now include:

- product status
- preview count
- generation history
- revision count
- created date
- updated date

Existing fields remain:

- product name
- category
- workspace
- thumbnail
- metadata
- source tracking
- revision history
- preview ids
- job ids

## Linked Generation / Preview Behavior

The Phase 3F ownership flow links:

- Generation Request `productId`
- Generation Request `previewIds`
- Generation Request `resultPreviewIds`
- Preview `productId`
- Product `previewIds`
- Product `generationHistory`
- Product `jobIds` when a job exists

This means future Forge workspaces can reuse the same ownership path instead of custom one-off result storage.

## Website / Forge Dashboard

The Forge dashboard Product Library cards now show:

- image thumbnails when Product Library uses a preview image
- status
- preview count
- revision count
- generation history count
- updated date

The existing Reports page already includes a simple Copy button for each report and will list this report through `/api/forge/reports`.

## Mobile Changes

Mobile Dev Lab now stores Forge ownership ids beside the local compatibility record:

- `forgeProductId`
- `forgePreviewIds`
- `forgeGenerationRequestIds`

AsyncStorage records were not removed.

Mobile remains a requester/reviewer and does not gain new heavy dependencies.

## What Stayed Untouched

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- CreatorHub protected avatar path
- DressingRoom
- ViperCreatorShell
- Aria protected assets
- Gaius protected assets
- MakeHuman
- MPFB
- Existing API routes

## Validation Results

API typecheck:

- Passed

Website typecheck:

- Passed

Website browser check:

- Passed
- Forge dashboard Product Library loaded
- Product card status, preview count, revision count, generation count, and updated date displayed
- Reports page listed this Phase 3F report
- Reports page showed Copy buttons for all report cards

Mobile typecheck:

- Passed

Existing mobile tests:

- Passed: 60 tests

API build:

- Passed

Forge Product Library ownership smoke test:

- Passed
- Created generation request: `generation-2b5111e9`
- Created preview: `preview-a4fed476`
- Created product: `product-96efabfa`
- Confirmed product preview count: `1`
- Confirmed product generation history count: `1`
- Confirmed product appears in Forge summary/dashboard data

## Risks

- `/api/imagine` still performs real image generation when used normally. The Phase 3F smoke test avoided real generation and tested the service-level handoff.
- Existing Dev Lab local records may not have Forge ownership ids until they generate again.
- Product categorization is conservative and based on existing Dev Lab category/workspace mapping.
- Generated image thumbnails depend on the existing API asset URL being reachable.

## Recommended Phase 3G Next Step

Move safe review actions from Dev Lab and other SAFE_PRODUCT mobile paths into the shared Forge Product Library and Job Review services.

Recommended first target:

- Add a lightweight mobile Product Library review panel that consumes Forge product cards, previews, approve/revise/archive actions, and generation history without loading legacy creator tools.
