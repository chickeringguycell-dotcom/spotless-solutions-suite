# VIPER PHASE 4A VEHICLE AND SPACECRAFT CONCEPT SHELLS REPORT

Date: 2026-06-14

Status: implemented and validated.

Copy button note: this report is available as the newest report on the Website/Forge Reports page, where the top `COPY LATEST REPORT` button can copy it directly.

## Mission

Phase 4A began the first real Forge workspace implementation pass for Vehicle Forge and Spacecraft Forge.

The implementation stayed concept-only.

No heavy editors were built.
No mesh generation was built.
No texture baking was built.
No Export Forge was built.
No Starfield package export was built.
No legacy systems were deleted.
No protected assets were moved.

## Registry Changes

`VehicleForge` is now confirmed as an active concept-only Website/Forge workspace.

Registry details added:

- label and description
- active status
- full required Forge service list
- target profile support
- preview type: `vehicle_concept_card`
- export readiness support
- supported classes
- metadata template
- concept panel list

`SpacecraftForge` is now active as a concept-only Website/Forge workspace.

Important boundary:

- `Shipyard` was removed from the SpacecraftForge required service list.
- Shipyard remains untouched as a legacy/protected heavy system.
- SpacecraftForge does not load hangar or heavy ship systems.

## Metadata Templates

Vehicle metadata template:

- `vehicleClass`
- `vehicleRole`
- `mobilityType`
- `propulsionType`
- `passengerCount`
- `cargoNotes`
- `mountNotes`
- `materialNotes`
- `scaleSummary`

Spacecraft metadata template:

- `spacecraftClass`
- `spacecraftRole`
- `hullNotes`
- `cockpitNotes`
- `engineNotes`
- `landingGearNotes`
- `weaponMountNotes`
- `dockingNotes`
- `roomModuleNotes`
- `materialNotes`
- `scaleSummary`

## New Panels

Vehicle Forge now has a concept-only shell with:

- Intent / Brief
- Class + Role
- References
- Concept Generation
- Product Structure
- Preview
- Review Queue
- Target Profile
- Export Readiness
- Aria / Gaius Guide Panel

Supported Vehicle Forge classes:

- car
- truck
- motorcycle
- tank
- construction equipment
- hover vehicle
- utility vehicle

Spacecraft Forge now has a concept-only shell with:

- Intent / Brief
- Ship Class + Role
- References
- Hull Concept
- Module / Room Concept
- Systems
- Preview
- Review Queue
- Target Profile
- Export Readiness
- Aria / Gaius Guide Panel

Supported Spacecraft Forge classes:

- starfighter
- shuttle
- transport
- freighter
- capital ship
- station module

## Service Integrations

The new concept shells use the existing Forge backbone.

When a concept job is submitted, the Website/Forge path creates:

1. Forge Job Queue record
2. Product Library card
3. Generation Service request
4. lightweight Preview Service record
5. Product Library generation history link
6. Job review link to product and preview
7. Export Readiness check
8. Review Queue items through existing aggregation

No separate storage path was created.

## Readiness Integration

Export Readiness now recognizes Phase 4A metadata keys:

- `scaleSummary`
- `materialNotes`

VehicleForge readiness also checks:

- vehicle class
- vehicle role
- mobility type

SpacecraftForge readiness also checks:

- spacecraft class
- spacecraft role
- hull notes
- cockpit, docking, or room/module notes
- engine notes

Readiness remains checklist-only. It does not generate export files.

## Guide Integration

Aria uses the active workspace context for:

- creative intent
- concept direction
- generation status
- workspace direction

Gaius uses the active workspace context for:

- readiness warnings
- missing metadata
- practical next actions
- scale/material checks

The Website/Forge guide panel now prefers records from the active workspace instead of only showing the newest global Forge record.

## Mobile Impact

Mobile remains lightweight.

Mobile can still:

- choose Vehicles and Spacecraft
- submit jobs
- upload references
- view previews
- approve or request revisions

Mobile still cannot:

- edit vehicles
- edit spacecraft
- load heavy viewers
- build exports
- load Shipyard through startup

Mobile contract update:

- `SpacecraftForge` was added as a valid lightweight Forge workspace id.

No mobile editor or heavy dependency was added.

Home startup remains clean from:

- ThreeViewer
- three-scripts
- AriaZoneChat
- usePrefetch

## Smoke Test Results

VehicleForge smoke result:

- job: `forge-job-c6f0102a`
- product: `product-5ab714a7`
- generation request: `generation-0309f617`
- preview: `preview-51413d0c`
- readiness check: `export-check-0f296473`
- readiness status: `needs_review`

SpacecraftForge smoke result:

- job: `forge-job-144fa9cc`
- product: `product-0a6d548b`
- generation request: `generation-12ea14ec`
- preview: `preview-f288aa59`
- readiness check: `export-check-aff8e783`
- readiness status: `needs_review`

`needs_review` is expected because the smoke products are review-stage concept records, not approved export-ready products.

Review Queue result:

- VehicleForge review items: 4
- SpacecraftForge review items: 4

## Browser Check

Website/Forge browser check passed.

Confirmed:

- `/landing-page/forge` opens.
- VehicleForge appears in the Turntable.
- SpacecraftForge appears in the Turntable.
- VehicleForge opens the concept-only shell.
- SpacecraftForge opens the concept-only shell.
- Vehicle class panel appears.
- Ship class panel appears.
- Product Structure appears.
- Hull Concept appears.
- Module / Room Concept appears.
- Submit Concept Job appears.

## Validation

Passed:

- API typecheck
- Website typecheck
- Mobile typecheck
- API build
- Existing mobile tests: 60 passed
- Forge HTTP smoke test
- Website browser check

Known warning:

- Existing Node module-type warning appears during mobile tests. It did not cause failures.

## What Stayed Untouched

Untouched:

- Workshop
- ThreeViewer
- Viewer
- Shipyard
- IMVU Creator
- protected Aria assets
- protected Gaius assets
- MakeHuman
- MPFB
- public avatar generation
- public skin generation
- existing API routes

## Risks

- SpacecraftForge can grow into Shipyard or Export Forge if future phases add heavy tools too early.
- Starfield readiness can be mistaken for Starfield export support; UI/report language must keep saying readiness only.
- Vehicle and spacecraft metadata should stay standardized before any part editor is attempted.
- Product Library can become noisy if concept shells generate too many smoke/test products without cleanup tooling.

## Recommended Phase 4B Next Step

Build concept review actions inside the VehicleForge and SpacecraftForge shells.

Recommended Phase 4B scope:

1. Filter Product Library, Generation Requests, Previews, Review Queue, and Readiness panels by active workspace.
2. Add simple approve / request revision controls inside each concept shell.
3. Add reference intake entry points that use Asset Intake and Upload Storage.
4. Keep everything concept-only.
5. Do not start mesh generation, texture baking, Shipyard integration, or Export Forge yet.

## Success Condition

Vehicle Forge and Spacecraft Forge now exist as real concept-only Forge workspaces.

They use the existing Forge service backbone for jobs, products, generations, previews, review queue, target profiles, readiness checks, and guide context.

They do not introduce heavy editors and do not bypass existing services.
