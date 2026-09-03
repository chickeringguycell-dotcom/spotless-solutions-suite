# VIPER VEHICLE AND SPACECRAFT FORGE MASTER PLAN

Date: 2026-06-14

Status: planning/design only.

No implementation was performed. No systems were deleted. No protected assets were moved. No existing Forge services were rewritten.

## Mission

Design the master blueprint for Vehicle Forge and Spacecraft Forge as major Website/Forge workspaces.

This plan assumes the current Forge backbone exists:

- Product Library
- Job Queue
- Workspace Registry
- Preview Service
- Generation Service
- Guide Context Service
- Review Queue
- Asset Intake
- Upload Storage
- Asset Library Candidate Review
- Target Profiles
- Export Readiness

Vehicle Forge and Spacecraft Forge should use these services instead of creating isolated, one-off pipelines.

## Core Decision

Vehicle Forge and Spacecraft Forge should be separate workspaces with a shared engineering backbone.

Shared backbone:

- concept generation
- reference intake
- product cards
- reusable asset candidates
- preview records
- review queue
- target profiles
- export readiness checks

Separated workspace logic:

- Vehicle Forge owns ground, hover, utility, and machinery design.
- Spacecraft Forge owns hulls, ship modules, ship systems, cockpit/engine/landing gear logic, station modules, and room concepts.

## High-Level Architecture

```text
Mobile
  |
  | guide selection, category choice, idea text, references, review actions
  v
Forge Job Queue
  |
  | workspaceId = VehicleForge or SpacecraftForge
  v
Workspace Registry
  |
  +--> Vehicle Forge Workspace
  |      |
  |      +--> Generation Service
  |      +--> Asset Intake / Upload Storage
  |      +--> Product Library
  |      +--> Preview Service
  |      +--> Review Queue
  |      +--> Target Profiles / Export Readiness
  |
  +--> Spacecraft Forge Workspace
         |
         +--> Generation Service
         +--> Asset Intake / Upload Storage
         +--> Product Library
         +--> Preview Service
         +--> Review Queue
         +--> Target Profiles / Export Readiness
```

## Service Ownership Diagram

```text
User intent
  -> Job Queue
  -> Generation Request
  -> Preview Record
  -> Product Library Card
  -> Asset Intake / Candidate Review
  -> Review Queue
  -> Export Readiness
  -> Future Export Forge
```

Vehicle Forge and Spacecraft Forge do not own persistence directly. They create and consume service records.

## What Is Vehicle Forge?

Vehicle Forge is the Website/Forge workspace for designing non-space vehicles and mobility products.

It supports:

- cars
- trucks
- motorcycles
- tanks
- construction equipment
- hover vehicles
- utility vehicles

Vehicle Forge is not just a concept image generator. It should become a structured product workspace that can progress from idea to product card to preview to readiness checklist.

Vehicle Forge should answer:

- What kind of vehicle is it?
- What role does it serve?
- What scale is it?
- How does it move?
- How many passengers or operators does it support?
- What surfaces, materials, and modular parts does it use?
- Does it need wheels, treads, hover pads, cargo beds, armor, tools, or mounts?
- What target profile is it being prepared for?

## What Is Spacecraft Forge?

Spacecraft Forge is the Website/Forge workspace for designing space vehicles, spacecraft parts, ship modules, and station modules.

It supports:

- starfighters
- shuttles
- transports
- freighters
- capital ships
- station modules
- hull concepts
- cockpit concepts
- engines
- landing gear
- weapon mounts
- modules
- room concepts

Spacecraft Forge should use Starfield scale assumptions where useful, but it must not claim final Starfield export support until Export Forge and target-specific packaging exist.

Spacecraft Forge should answer:

- What class of ship is it?
- What is the role: fighter, shuttle, cargo, transport, capital, station?
- What is the scale envelope?
- What modules does it need?
- Does it have internal rooms?
- Where are cockpit, engines, landing gear, weapon mounts, cargo, crew, and docking points?
- Which parts can become reusable Asset Library candidates?
- What readiness blockers exist before export?

## Key Differences

| Area | Vehicle Forge | Spacecraft Forge |
|---|---|---|
| Primary domain | Ground, hover, utility, machinery | Ships, space vehicles, stations, modules |
| Scale model | road/industrial/crew scale | ship class/module scale |
| Movement | wheels, treads, hover, mechanical systems | thrusters, maneuvering, landing, docking |
| Main parts | chassis, cabin, wheels, treads, cargo, tools | hull, cockpit, engines, landing gear, mounts, rooms |
| Interior needs | optional cabin/cockpit | often important for larger ships |
| Target concerns | size, collision, materials, proxy mesh, gameplay role | module size, hull silhouette, docking, room layout, target profile |
| Readiness emphasis | proportions, grounding, clearance, wheel/tread logic | scale, hardpoints, module alignment, engines, cockpit, landing gear |
| Mobile role | idea, category, references, review | idea, category, references, review |
| Website role | full vehicle design workspace | full ship/module design workspace |

## Shared Services Consumed

Both workspaces consume:

- Workspace Registry: workspace metadata, availability, target support.
- Job Queue: submitted build requests and review state.
- Generation Service: concept, part, material, and layout generation requests.
- Preview Service: thumbnails, concept sheets, proxy images, turntables, readiness previews.
- Product Library: canonical product cards and product history.
- Asset Intake: uploaded references and reusable material sources.
- Upload Storage: durable image/reference upload path.
- Candidate Review: gate for reusable SAFE_PRODUCT reference material.
- Review Queue: centralized review of generation, preview, product, intake, readiness, and candidate state.
- Guide Context Service: Aria/Gaius workspace context.
- Target Profiles: generic GLB, Starfield, future target profiles.
- Export Readiness: checklist logic before any future export.

## Data Created

Both workspaces should create:

- Forge jobs
- generation requests
- preview records
- product cards
- product metadata
- asset intake records
- upload records
- candidate review links
- review queue items
- export readiness checks
- guide context entries

Neither workspace should create private storage formats that bypass Product Library or Preview Service.

## Product Categories

Vehicle Forge categories:

- `vehicle_concept`
- `vehicle_chassis`
- `vehicle_body`
- `vehicle_cabin`
- `vehicle_wheel`
- `vehicle_tread`
- `vehicle_hover_system`
- `vehicle_engine`
- `vehicle_cargo_system`
- `vehicle_tool_mount`
- `vehicle_weapon_mount`
- `vehicle_material_set`
- `vehicle_preview_package`

Spacecraft Forge categories:

- `spacecraft_concept`
- `spacecraft_hull`
- `spacecraft_cockpit`
- `spacecraft_engine`
- `spacecraft_landing_gear`
- `spacecraft_weapon_mount`
- `spacecraft_module`
- `spacecraft_room_concept`
- `spacecraft_station_module`
- `spacecraft_material_set`
- `spacecraft_preview_package`

## Vehicle Product Model

Vehicle product cards should include:

- product id
- product name
- workspace id: `VehicleForge`
- vehicle class
- vehicle role
- target profile id
- scale summary
- mobility type
- propulsion type
- passenger/operator count
- cargo notes
- weapon/tool mount notes
- material set ids
- preview ids
- intake asset ids
- upload ids
- reusable asset candidate ids
- readiness check ids
- source/reference notes
- review status
- revision history

Recommended vehicle classes:

- car
- truck
- motorcycle
- tank
- construction_equipment
- hover_vehicle
- utility_vehicle

Recommended mobility types:

- wheeled
- tracked
- hover
- hybrid
- static_prop

## Spacecraft Product Model

Spacecraft product cards should include:

- product id
- product name
- workspace id: `SpacecraftForge`
- spacecraft class
- spacecraft role
- target profile id
- scale summary
- module grid notes
- hull shape notes
- cockpit placement
- engine placement
- landing gear placement
- weapon mount placement
- docking/entry notes
- room concept ids
- material set ids
- preview ids
- intake asset ids
- upload ids
- reusable asset candidate ids
- readiness check ids
- source/reference notes
- review status
- revision history

Recommended spacecraft classes:

- starfighter
- shuttle
- transport
- freighter
- capital_ship
- station_module

Recommended spacecraft roles:

- combat
- cargo
- passenger
- exploration
- industrial
- station_support
- cinematic_prop

## Asset Relationships

```text
Product Card
  |
  +--> Concept previews
  +--> Part products
  +--> Material set products
  +--> Asset intake references
  +--> Approved reusable material candidates
  +--> Readiness checks
  +--> Future export package records
```

Vehicle example:

```text
Armored Utility Truck
  +--> chassis product
  +--> cabin product
  +--> wheel/tire product
  +--> cargo bed product
  +--> armor material set
  +--> 3 concept previews
  +--> readiness check for generic_glb
```

Spacecraft example:

```text
Frontier Cargo Shuttle
  +--> hull product
  +--> cockpit product
  +--> engine cluster product
  +--> landing gear product
  +--> cargo room concept
  +--> worn metal material set
  +--> readiness check for starfield
```

## Reusable Asset Use

Approved reusable assets should be used as source material only after passing:

- upload scan
- source rights check
- upload review
- library readiness
- candidate review

Vehicle Forge can reuse:

- tire textures
- tread references
- dashboard concepts
- armor panel references
- warning labels
- headlight concepts
- material wear references

Spacecraft Forge can reuse:

- hull plating references
- cockpit panel references
- engine glow concepts
- landing gear references
- module trim styles
- decals
- ship material sets

Internal-only reusable material must stay in the internal-only lane and must not be exposed to public-safe product flows.

## Generation Flow

```text
User or mobile submits idea
  -> Job Queue creates job
  -> Workspace Registry resolves VehicleForge or SpacecraftForge
  -> Generation Service creates request
  -> Worker/future generator produces concept metadata or preview
  -> Preview Service stores preview records
  -> Product Library creates/updates product card
  -> Review Queue collects result
  -> Aria summarizes creative direction
  -> Gaius checks readiness blockers
```

Vehicle generation request types:

- vehicle concept sheet
- front/side/top orthographic sheet
- chassis exploration
- mobility system exploration
- cabin/interior concept
- material/wear pass
- weapon/tool mount concept
- scale/readiness proxy

Spacecraft generation request types:

- ship silhouette sheet
- hull concept sheet
- cockpit concept
- engine cluster concept
- landing gear concept
- weapon mount concept
- module layout concept
- room concept
- station module concept
- scale/readiness proxy

## Preview Model

Vehicle previews should include:

- thumbnail
- concept image
- front/side/top sheet
- 3/4 hero view
- material swatch panel
- scale silhouette
- mobility system close-up
- optional proxy turntable
- readiness checklist card

Spacecraft previews should include:

- thumbnail
- silhouette sheet
- 3/4 hero view
- top/side/front orthographic sheet
- module layout diagram
- engine/cockpit/landing gear detail sheets
- room concept card
- scale comparison
- optional proxy hangar turntable
- readiness checklist card

Preview records should stay lightweight at first. Heavy 3D or mesh previews belong in later Website/Forge phases.

## Review Workflow

```text
Generation result
  -> Preview pending
  -> Product card review
  -> Asset intake review
  -> Candidate review for reusable references
  -> Export readiness check
  -> Ready for future workspace implementation or export path
```

Review statuses should map to existing Forge review states:

- pending
- approved
- needs_revision
- rejected or archived

Vehicle review questions:

- Does the silhouette match the intended vehicle class?
- Is scale believable?
- Does the mobility system make sense?
- Are cockpit/cabin/cargo areas clear?
- Are weapon/tool mounts appropriate?
- Are material choices coherent?
- Are references source-qualified?
- Is the product ready for future mesh or export work?

Spacecraft review questions:

- Does the hull match the ship class?
- Is the ship scale believable?
- Are cockpit, engines, landing gear, and mounts placed logically?
- Are modules and room concepts coherent?
- Are Starfield-style assumptions clearly marked as target-profile guidance, not export support?
- Are references source-qualified?
- Is the product ready for future mesh or export work?

## Readiness Model

Vehicle readiness should check:

- product linked
- preview linked
- source/license metadata present
- target profile selected
- scale notes present
- mobility type present
- material set present
- collision/proxy notes present
- category/class present
- review state approved or ready for later export

Spacecraft readiness should check:

- product linked
- preview linked
- source/license metadata present
- target profile selected
- scale notes present
- ship class present
- hull/cockpit/engine notes present
- landing gear or docking notes present when needed
- weapon mount notes if combat role
- module/room notes for larger ships
- material set present
- review state approved or ready for later export

## Target Profile Integration

### generic_glb

Use for:

- general preview readiness
- neutral product card checks
- future GLB-style export planning

Conservative checks:

- product linked
- preview exists
- source metadata exists
- scale summary exists
- material metadata exists
- no claim of final export package

### starfield

Use for:

- Spacecraft Forge planning
- ship/module scale warnings
- target-specific readiness checklist
- future Export Forge preparation

Conservative checks:

- target is planning/readiness only
- no claim of final Starfield export package
- ship class and role required
- scale and module notes required
- cockpit/engine/landing gear/mount notes required as applicable
- room concepts required for larger ships or modules

### future targets

Future targets may include:

- Unreal
- Unity
- Blender package
- game-specific mod formats
- Viper internal package

These should be added through Target Profile Service before workspace-specific code depends on them.

## Aria Responsibilities

Aria should own creative guidance:

- help user name the vehicle or ship
- ask design-shaping questions
- refine style, mood, silhouette, role, and materials
- translate user intent into generation prompts
- summarize project direction
- propose concept variants
- help choose references
- keep the experience inviting and imaginative

Aria should not claim export readiness or technical validity.

Aria prompt context should include:

- selected guide
- workspace id
- vehicle/ship class
- creative intent
- style direction
- reference summaries
- target profile summary
- recent previews and review decisions

## Gaius Responsibilities

Gaius should own practical validation:

- scale warnings
- structure warnings
- missing metadata
- missing product/preview links
- source-rights warnings
- reusable asset lane warnings
- readiness check summaries
- target profile constraints
- practical next actions

Gaius should not override creative direction unless it creates a readiness or feasibility problem.

Gaius prompt context should include:

- target profile
- workspace id
- product metadata
- scale metadata
- class/role metadata
- linked previews
- linked references
- readiness checks
- candidate review status
- export blocked state

## Mobile Responsibilities

Mobile should support:

- choose Aria or Gaius
- choose category: Vehicles and Spacecraft
- choose simple type: vehicle or spacecraft
- describe idea
- upload lightweight references
- select target profile summary
- submit job
- view product cards
- view thumbnails and lightweight previews
- view candidate/review/readiness status
- approve or request revision

Mobile should not support:

- full vehicle editor
- full spacecraft editor
- mesh generation
- mesh processing
- UV editing
- texture baking
- rigging
- animation
- heavy 3D hangar scenes
- large asset library browsing
- export package creation
- Starfield package building

## Website/Forge Responsibilities

Website/Forge should support:

- full Vehicle Forge workspace
- full Spacecraft Forge workspace
- structured product creation
- generation request management
- reference and upload management
- reusable candidate review
- product relationship management
- preview panels
- future proxy turntables
- target profile checks
- export readiness checks
- Aria/Gaius context panels
- review queue integration

Future Website/Forge phases may add:

- modular part assembly
- proxy 3D turntables
- mesh generation or mesh import
- material assignment
- scale validation views
- module grid views
- room layout preview
- export package preparation

## Vehicle Forge Workspace Layout

```text
Vehicle Forge
  |
  +--> Intent / Brief Panel
  +--> Class + Role Panel
  +--> References Panel
  +--> Concept Generation Panel
  +--> Product Structure Panel
  |      +--> chassis
  |      +--> body
  |      +--> cabin
  |      +--> mobility system
  |      +--> cargo/tools/mounts
  |
  +--> Preview Panel
  +--> Materials Panel
  +--> Candidate Assets Panel
  +--> Review Queue Panel
  +--> Readiness Panel
  +--> Aria / Gaius Panel
```

## Spacecraft Forge Workspace Layout

```text
Spacecraft Forge
  |
  +--> Intent / Brief Panel
  +--> Ship Class + Role Panel
  +--> References Panel
  +--> Hull Concept Panel
  +--> Module / Room Concept Panel
  +--> Systems Panel
  |      +--> cockpit
  |      +--> engines
  |      +--> landing gear
  |      +--> weapon mounts
  |      +--> docking/entry
  |
  +--> Preview Panel
  +--> Materials Panel
  +--> Candidate Assets Panel
  +--> Review Queue Panel
  +--> Starfield/Target Readiness Panel
  +--> Aria / Gaius Panel
```

## Implementation Roadmap

### Phase 1: Workspace Registry And Product Schema

Goal:

- register Vehicle Forge and Spacecraft Forge as active/planned workspaces
- define product metadata keys
- define category lists
- define target profile defaults

Deliverables:

- registry entries
- product metadata contract
- job payload templates
- no heavy editor

### Phase 2: Concept-Only Workspace Shells

Goal:

- add Website/Forge panels for intent, class, references, generation, previews, products, and readiness

Deliverables:

- Vehicle Forge shell
- Spacecraft Forge shell
- concept generation flow using existing Generation Service
- Product Library card creation
- Preview Service integration

### Phase 3: Review And Readiness Integration

Goal:

- make both workspaces feed Review Queue and Export Readiness cleanly

Deliverables:

- workspace-specific readiness checklist inputs
- Gaius readiness summaries
- Aria concept summaries
- Review Queue filters by workspace/category

### Phase 4: Reusable Asset Integration

Goal:

- let approved candidate assets feed material/reference choices

Deliverables:

- reusable asset picker, Website-only
- public-safe vs internal-only lane separation
- product metadata links to reusable assets

### Phase 5: Structured Part Modeling

Goal:

- introduce structured part records without building final mesh tools

Deliverables:

- vehicle part model
- spacecraft part/module model
- part relationship map
- preview dependency graph

### Phase 6: Proxy Turntables

Goal:

- add lightweight Website-only visual review before full editor work

Deliverables:

- proxy turntable previews
- orthographic concept display
- scale silhouette overlays
- no mobile heavy viewer

### Phase 7: Future Heavy Workspace Tools

Goal:

- begin real construction tools only after service contracts are stable

Deliverables may include:

- modular vehicle builder
- modular spacecraft builder
- material assignment
- hull/module layout views
- room concept layout
- mesh import/export preparation

Do not begin this phase until Product Library, Preview Service, Candidate Review, and Export Readiness are stable.

## Risks

- Vehicle Forge and Spacecraft Forge can become too broad if they start as full editors.
- Spacecraft Forge can accidentally become Export Forge; keep export package building separate.
- Starfield target assumptions can be mistaken for supported export; label them as readiness guidance only.
- Internal-only reusable assets must not leak into public-safe material lanes.
- Heavy 3D previews can recreate the mobile startup problem if added too early.
- Product metadata can become inconsistent unless categories and part relationships are standardized first.
- Modular room/ship design can become a World Forge problem if scope is not controlled.

## Do Not Build Yet

Do not build in the first implementation pass:

- full vehicle editor
- full spacecraft editor
- mesh generation
- mesh processing
- texture baking
- rigging
- animation
- Export Forge
- Starfield package export
- full Asset Library browsing
- public sharing
- heavy mobile previews

## Recommended First Implementation Step

Start with concept-only service-backed workspaces:

1. Add or confirm `VehicleForge` and `SpacecraftForge` registry entries.
2. Add workspace-specific product metadata templates.
3. Add simple Website/Forge panels for class, role, references, generation, previews, and readiness.
4. Route all outputs into Product Library, Preview Service, Review Queue, Candidate Review, and Export Readiness.
5. Keep mobile limited to category choice, idea capture, reference upload, job submission, thumbnails, and review.

## Success Condition

This blueprint is ready to guide implementation.

Vehicle Forge and Spacecraft Forge can be built later using the existing Forge service backbone without turning mobile into a heavy editor and without bypassing Product Library, Preview Service, Candidate Review, Target Profiles, or Export Readiness.
