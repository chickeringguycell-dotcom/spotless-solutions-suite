# VIPER SAM-0 LICENSE AND CLOUD WORKER DESIGN REPORT

Date: 2026-06-16

Status: architecture, policy, and worker design only.

No SAM 3D packages were installed. No model weights were downloaded. No cloud worker was implemented. No Phase 4H replacement work was started. No protected assets were moved.

## Mission

Define how Meta SAM 3D should fit into Viper Studios before installation or code integration begins.

Target architecture:

```text
Mobile
  -> Viper Cloud
  -> Forge Workers
  -> SAM Workers
  -> Review Queue
  -> Product Library
  -> Mobile Review
```

## Executive Decision

SAM 3D should enter Viper as a Website/Forge cloud worker lane.

It should not become:

- a mobile feature
- a direct editor
- a replacement for Forge services
- an automatic export pipeline
- an avatar/skin generator
- a protected Aria/Gaius asset tool

The correct first role is:

```text
SAM 3D Objects Worker = image-to-3D candidate generator for reviewed SAFE_PRODUCT assets.
```

The first prototype should be limited to:

- Furniture
- Props

Everything it creates must be treated as a candidate, not a finished product.

## SAM Role In Viper

SAM 3D solves one specific problem for Viper:

```text
Turn an approved 2D reference image into a rough 3D candidate that Forge can review, organize, and later prepare for export.
```

SAM 3D does not solve:

- final topology
- game-ready mesh cleanup
- UV validation
- texture baking
- rigging
- animation
- legal/source-rights review
- Product Library ownership
- export packaging
- mobile preview performance

SAM becomes powerful only when it is wrapped by Viper's existing safety and review system.

## Cloud Architecture

Long-term Viper architecture:

```text
Phone
  |
  | upload, idea, category, review decisions
  v
Viper Cloud
  |
  +--> Upload Storage
  +--> Asset Intake
  +--> Source Rights Check
  +--> Aria creative context
  +--> Gaius practical validation
  +--> Forge Workers
  |      |
  |      +--> Product Library
  |      +--> Preview Service
  |      +--> Review Queue
  |      +--> Export Readiness
  |
  +--> SAM Workers
         |
         +--> SAM 3D Objects Worker
         +--> future internal SAM 3D Body Worker, protected only
```

No home-PC dependency:

- The phone should not require a local desktop to run reconstruction.
- The mobile app should not store model weights.
- The mobile app should not process meshes.
- The mobile app should not run Python, PyTorch, CUDA, SAM, Kaolin, PyTorch3D, or gsplat.
- Cloud workers should own GPU-heavy reconstruction.

## Worker Design

### SAM 3D Objects Worker

Responsibilities:

- Receive approved image intake records.
- Receive or generate object masks.
- Run candidate reconstruction.
- Save generated candidate output.
- Generate lightweight preview media.
- Create Preview Service records.
- Submit generated candidates to Review Queue.
- Link reviewed candidates to Product Library drafts.
- Report failure states back to Worker Dispatcher.

Non-responsibilities:

- It does not approve source rights.
- It does not create final products automatically.
- It does not export GLB/OBJ/FBX/USD.
- It does not publish assets.
- It does not touch protected guide assets.
- It does not bypass Review Queue.
- It does not bypass Integrity Validator.

### SAM 3D Body Worker

Status:

```text
Not approved for public Viper use.
```

If ever tested, it must be:

- internal-only
- protected
- disconnected from public avatars
- disconnected from public skins
- disconnected from Aria/Gaius protected assets
- disconnected from automatic clothing/body wrapping

SAM 3D Body is not part of the first prototype.

## Safe Categories

Allowed first prototype:

- Furniture
- Props

Future candidates after review:

- Buildings
- Structures
- Non-combat Vehicles
- Non-combat Spacecraft
- Environment objects
- Creature maquettes or object-like creature references

Important note:

Future support does not mean automatic approval. Each category must pass source-rights, license, safety, and readiness checks.

## Blocked Categories

Blocked for SAM 3D integration:

- Weapons
- Guns
- Tanks
- Military vehicles
- Combat spacecraft
- Weapon mounts
- Military/warfare props
- Aria
- Gaius
- Public avatars
- Public skins
- Human-body generation
- Face generation
- Hair generation
- Makeup generation
- Automatic avatar texture wrapping
- DressingRoom systems
- ViperCreatorShell systems
- MakeHuman
- MPFB

Reason:

The SAM License is not a simple MIT/Apache-style license and includes prohibited-use language for military/warfare purposes, guns, and illegal weapons. Viper should be stricter than the minimum. The human-body path also conflicts with Viper's protected/internal boundaries.

## Cloud Worker Flow

Preferred flow:

```text
Image Upload
  -> Upload Storage
  -> Asset Intake
  -> Source Rights Check
  -> SAM3DCandidateJob
  -> Worker Dispatcher
  -> SAM Worker
  -> Generated Candidate
  -> Candidate Preview Record
  -> Review Queue
  -> Product Library Draft
```

## Ownership By Step

| Step | Owner | Notes |
|---|---|---|
| Image Upload | Mobile or Website client | User submits image; no reconstruction happens on device. |
| Upload Storage | Upload Storage Service | Stores original image and metadata. |
| Asset Intake | Asset Intake Service | Captures title, source, category, target workspace, and review state. |
| Source Rights Check | Asset Intake / Upload Scanner / Gaius later | Must pass before SAM job submission. |
| SAM3DCandidateJob | New SAM Candidate Service | Records requested reconstruction job. |
| Worker Dispatcher | Worker Dispatcher Service | Queues and tracks worker state. |
| SAM Worker | Cloud GPU worker | Runs SAM 3D Objects in isolated environment. |
| Generated Candidate | New Generated Mesh Candidate record | Stores output paths and derived metadata. |
| Candidate Preview Record | Preview Service | Stores thumbnail, turntable GIF, image preview, or splat preview metadata. |
| Review Queue | Review Queue Service | Requires human/guide review before Product Library ownership. |
| Product Library Draft | Product Library Service | Stores approved or draft product candidate. |
| Mobile Review | Mobile app | Shows thumbnails/status and approve/reject/revision actions only. |

## New Record Types

Design only. Do not implement yet.

### SAM3DCandidateJob

Purpose:

Tracks a reconstruction request from approved source image to worker output.

Fields:

- `id`
- `jobId`
- `workspaceId`
- `projectId`
- `sourceUploadId`
- `assetIntakeId`
- `sourceRightsStatus`
- `safeProductCategory`
- `requestedModel`
- `requestedMode`
- `maskSource`
- `maskUploadId`
- `promptSummary`
- `status`
- `blockedReason`
- `workerDispatchId`
- `generatedCandidateIds`
- `previewIds`
- `reviewQueueItemId`
- `productId`
- `createdAt`
- `updatedAt`

Statuses:

- `draft`
- `submitted`
- `queued`
- `processing`
- `completed`
- `failed`
- `blocked`
- `archived`

Allowed `requestedModel` values:

- `sam_3d_objects`

Reserved but not active:

- `sam_3d_body_internal`

Allowed `requestedMode` values for first prototype:

- `furniture_candidate`
- `prop_candidate`

Future possible modes:

- `building_candidate`
- `structure_candidate`
- `non_combat_vehicle_candidate`
- `non_combat_spacecraft_candidate`

Blocked modes:

- `weapon_candidate`
- `combat_vehicle_candidate`
- `combat_spacecraft_candidate`
- `public_avatar_candidate`
- `public_skin_candidate`
- `protected_guide_candidate`
- `human_body_candidate`

### GeneratedMeshCandidate

Purpose:

Stores the actual generated candidate metadata from a SAM worker.

Fields:

- `id`
- `sam3dCandidateJobId`
- `workspaceId`
- `sourceUploadId`
- `assetIntakeId`
- `outputKind`
- `storagePath`
- `publicPreviewPath`
- `format`
- `fileSizeBytes`
- `vertexCount`
- `pointCount`
- `textureSummary`
- `scaleEstimate`
- `qualityWarnings`
- `sourceRightsStatus`
- `reviewStatus`
- `productId`
- `createdAt`
- `updatedAt`

First prototype allowed format:

- `ply`

Future possible formats after separate audit:

- `glb`
- `obj`
- `usd`

Not approved yet:

- `fbx`
- game-ready packages
- IMVU packages
- Starfield packages

### CandidatePreviewRecord

Purpose:

Stores lightweight visual review material for the generated candidate.

Fields:

- `id`
- `generatedMeshCandidateId`
- `sam3dCandidateJobId`
- `workspaceId`
- `productId`
- `previewType`
- `thumbnailUrl`
- `previewImageUrl`
- `previewVideoUrl`
- `sourceImageUrl`
- `maskPreviewUrl`
- `promptSummary`
- `ariaSummary`
- `gaiusWarnings`
- `reviewStatus`
- `createdAt`
- `updatedAt`

Allowed first preview types:

- `thumbnail`
- `image_turntable`
- `mask_overlay`
- `candidate_summary`

Blocked first preview types:

- heavy real-time splat viewer
- heavy ThreeViewer mount
- mobile mesh viewer
- export preview

## Mobile Role

Mobile must support:

- upload image
- add source notes
- choose allowed category
- monitor SAM candidate job status
- view thumbnails
- view lightweight previews
- approve
- reject
- request revision
- read Aria summary
- read Gaius warnings

Mobile must not:

- run SAM
- store model weights
- process meshes
- perform reconstruction
- perform texture baking
- perform UV editing
- run heavy viewers
- export assets
- bypass source-rights review
- bypass Review Queue
- bypass Product Library

Mobile experience target:

```text
Upload a reference.
Ask Forge to make a candidate.
Review the result.
Approve, reject, or revise.
```

## Website/Forge Role

Website/Forge must support:

- upload and source-rights review
- candidate job creation
- worker dispatch visibility
- candidate preview panels
- Review Queue decisions
- Product Library draft creation
- Export Readiness later
- Aria creative summaries
- Gaius validation warnings

Website/Forge must not:

- treat SAM output as automatically approved
- promise export-ready assets
- bypass Product Library
- expose blocked categories
- expose protected Aria/Gaius assets
- expose SAM 3D Body in public flows

## Aria Role

Aria should:

- help describe the intended product
- help name the candidate
- summarize creative direction
- compare output against user intent
- suggest revision notes

Aria should not:

- approve source rights
- approve license safety
- validate export readiness
- access protected assets for SAM generation
- treat SAM output as final

## Gaius Role

Gaius should:

- flag blocked categories
- flag missing source rights
- flag poor reconstruction quality
- flag scale uncertainty
- flag output format limitations
- flag export-not-ready status
- flag protected asset violations

Gaius should not:

- rewrite creative intent
- authorize blocked categories
- bypass human review

Future recommendation:

Gaius should become the main policy validator for SAM candidate jobs.

## License Gate

SAM-0 does not approve installation.

Before installation:

1. Review Meta SAM License.
2. Review Hugging Face model access terms.
3. Record accepted terms in a Viper license registry.
4. Define blocked categories in Integrity Validator.
5. Confirm whether commercial use is acceptable for Viper's intended use.
6. Confirm whether outputs can be stored, modified, and used in Viper products.
7. Confirm redistribution rules for any model-derived outputs.

Temporary policy:

SAM 3D may be investigated and designed around, but not installed into Viper until license review is accepted.

## Cloud Worker Requirements

SAM 3D Objects worker target:

- Linux 64-bit
- NVIDIA GPU
- At least 32 GB VRAM
- CUDA-compatible environment
- Python 3.11
- Isolated worker environment
- No dependency pollution in API server
- No dependency pollution in mobile app
- No model weights committed to repository
- No model weights copied into app bundles

Worker isolation:

```text
Viper API
  -> queue record
  -> worker dispatcher
  -> cloud worker process/container
  -> storage result
  -> service record update
```

Do not run SAM inside:

- API server process
- landing-page process
- mobile app
- local user thread
- Codex process

## Storage Policy

Store:

- original upload
- mask preview
- generated PLY candidate
- rendered thumbnail
- lightweight preview media
- job logs
- metadata

Do not store:

- model weights in repository
- protected guide assets in SAM candidate storage
- unreviewed human-body outputs in public storage
- unreviewed weapon or military outputs

## Integrity Validator Requirements

Future Integrity Validator checks should include:

- SAM candidate category is allowed.
- Source upload exists.
- Source rights are user_confirmed or approved.
- Asset Intake record exists.
- Worker output exists only after completed status.
- Generated candidate has Review Queue item.
- Product Library link is draft until review approved.
- No public product links internal-only SAM Body output.
- No blocked category reaches worker dispatch.
- No protected Aria/Gaius asset is used as source.
- No weapon/military category is submitted.

## Review Queue Requirements

SAM candidate review items should expose:

- stable review id
- source upload id
- candidate job id
- generated candidate id
- workspace id
- category
- source-rights status
- worker status
- preview count
- priority
- blocked reason
- Gaius warnings

Recommended priority:

- `P0`: blocked category, source-rights issue, protected asset issue, failed worker
- `P1`: pending review
- `P2`: approved candidate
- `P3`: archived/rejected candidate

## Product Library Rules

SAM outputs become Product Library records only as drafts.

Draft product fields:

- product name
- workspace id
- category
- source upload id
- asset intake id
- SAM candidate job id
- generated candidate id
- preview ids
- source rights status
- review status
- candidate format
- quality warnings
- created date
- updated date

Approval must happen through Review Queue or Product Library action.

## Safe First Prototype

Prototype:

```text
SAM 3D Objects Furniture/Props Candidate Worker
```

Allowed:

- furniture
- props
- decor
- simple objects
- non-branded user-owned references
- public-domain references
- internally generated test references

Blocked:

- humans
- faces
- bodies
- Aria
- Gaius
- clothing/skin/avatar references
- weapons
- tanks
- military objects
- copyrighted product photos without rights

Prototype success:

```text
Upload approved chair image
  -> source rights pass
  -> SAM3DCandidateJob created
  -> worker completes PLY candidate
  -> preview created
  -> Review Queue item created
  -> Product Library draft created
  -> mobile can approve/reject/revise
```

## Future Phases

### SAM-1 License And Dependency Audit

- Legal/license review.
- Dependency license review.
- Hugging Face access review.
- Blocked-category policy locked.

### SAM-2 Cloud Worker Environment Spike

- Create isolated Linux GPU worker.
- No Viper integration yet.
- Run one private furniture/prop test.
- Record VRAM, runtime, output size, failure modes.

### SAM-3 Forge Record Layer

- Implement `SAM3DCandidateJob`.
- Implement `GeneratedMeshCandidate`.
- Implement `CandidatePreviewRecord`.
- Add Review Queue and Integrity Validator support.

### SAM-4 Furniture/Props Prototype

- Connect Asset Intake to SAM worker.
- Generate candidate preview.
- Create Product Library draft.
- Allow mobile review.

### SAM-5 Buildings/Structures Evaluation

- Test building and structure references.
- Add scale warnings.
- Add Gaius massing checks.

### SAM-6 Non-Combat Vehicle/Spacecraft Evaluation

- Test only non-combat categories.
- Add strict blocked-category filters.
- Do not include weapons, tanks, combat ships, or military vehicles.

### SAM-7 Export Readiness Study

- Evaluate whether generated candidates can become GLB/OBJ/USD later.
- Do not build Export Forge until conversion quality is proven.

## Risks

### License Risk

SAM License is not a simple permissive license. Legal review is required before commercial or distributed use.

### Category Risk

Weapon, military, and combat categories must be blocked because the license includes prohibited-use language.

### Source Rights Risk

Image-to-3D can reproduce recognizable product geometry. Viper must require source-rights approval before reconstruction.

### Compute Risk

SAM 3D Objects requires cloud GPU resources. It cannot be treated like a normal API endpoint.

### Quality Risk

SAM output may be useful but not final. Viper will still need review, cleanup, scale checks, material checks, and future export readiness.

### Format Risk

Official quickstart output is PLY Gaussian splat style output. GLB/OBJ/FBX/USD should not be promised until a separate conversion pipeline is audited.

### Protected Asset Risk

SAM 3D Body and MHR are human-body systems. They must remain out of public Viper flows and away from Aria/Gaius protected assets.

## Final Recommendation

Proceed with SAM integration, but only through a controlled Viper Cloud worker architecture.

Approved direction:

```text
SAM 3D Objects
  -> Website/Forge only
  -> Furniture/Props first
  -> Asset Intake gated
  -> Source Rights gated
  -> Review Queue gated
  -> Product Library draft only
```

Not approved:

```text
SAM on mobile
SAM weights in app bundles
SAM for weapons
SAM for tanks
SAM for combat spacecraft
SAM for public avatars
SAM for public skins
SAM touching Aria/Gaius protected assets
SAM direct export
```

## Success Condition

Viper now has a documented SAM 3D cloud-worker architecture before any installation or code integration begins.

The next safe move is SAM-1: License And Dependency Audit.

