# VIPER SAM 3D / META 3D OPEN SOURCE INTEGRATION INVESTIGATION

Date: 2026-06-16

Status: research and planning only.

No packages were installed. No code was integrated. No model weights were downloaded. No protected assets were touched.

## Executive Summary

Meta has two official SAM 3D projects that matter for Viper Studios:

- SAM 3D Objects: object and scene reconstruction from single images plus masks.
- SAM 3D Body: single-image 3D human mesh recovery.

There is also SAM 3, which is not a 3D reconstruction model, but it can be useful as a segmentation/mask helper before SAM 3D Objects.

Recommendation:

SAM 3D Objects is worth a cautious Website/Forge-only prototype for SAFE_PRODUCT asset candidates such as props, furniture, non-combat vehicles, non-combat spacecraft concepts, buildings, and some creature/object references.

SAM 3D Body should not be connected to public avatar generation, public skin generation, Aria, Gaius, DressingRoom, or ViperCreatorShell. If Viper ever tests it, it should remain internal-only, protected, and review-gated.

The safest first prototype is:

```text
Owner-approved image upload
  -> Asset Intake
  -> Source Rights Check
  -> SAM 3D Objects Candidate Job
  -> Generated PLY candidate
  -> Preview Record
  -> Review Queue
  -> Product Library candidate
  -> Export Readiness later
```

Do not use SAM 3D for WeaponForge, guns, military/warfare content, tanks, combat vehicles, or weapon mounts until legal review is complete. The SAM License includes prohibited-use language for military/warfare purposes and guns/illegal weapons.

## Official Projects Found

| Project | Official source | Purpose | Status |
|---|---|---|---|
| SAM 3D Objects | https://github.com/facebookresearch/sam-3d-objects | Reconstructs object geometry, texture, pose, and layout from image plus mask. | Candidate for Website/Forge-only prototype. |
| SAM 3D Body | https://github.com/facebookresearch/sam-3d-body | Recovers full-body human mesh from single image, using Momentum Human Rig. | Internal/protected only. Not public Forge. |
| SAM 3 | https://github.com/facebookresearch/sam3 | Segmentation in images/videos using concepts, text, boxes, masks, and points. | Optional mask preprocessor, not a 3D generator. |
| MHR | https://github.com/facebookresearch/MHR | Momentum Human Rig used by SAM 3D Body. | Protected/internal only if ever used. |

## Meta Source Summary

Meta's SAM 3D blog states that SAM 3D includes two models:

- SAM 3D Objects for object and scene reconstruction.
- SAM 3D Body for human body and shape estimation.

Meta also says the release includes model checkpoints, inference code, training/evaluation data, and a parametric human model.

The SAM 3D Objects repository describes the model as reconstructing 3D shape geometry, texture, and layout from a single image, and the quickstart exports a Gaussian splat as PLY.

The SAM 3D Body repository describes a promptable full-body human mesh recovery model. Its Hugging Face model card states that output includes mesh vertices, 3D and 2D keypoints, camera translation, focal length, body pose parameters, hand pose parameters, and shape parameters.

## License Summary

Both SAM 3D Objects and SAM 3D Body use Meta's SAM License.

Important license observations:

- The license grants a limited, non-exclusive, worldwide, non-transferable, royalty-free license to use, reproduce, distribute, copy, create derivative works, and modify the SAM materials.
- The patent language includes rights to make, use, offer to sell, sell, import, and otherwise transfer covered work, subject to the license terms.
- Redistribution must happen under the SAM License.
- Use must comply with trade controls, sanctions, privacy, and data protection law.
- The license prohibits use for ITAR-subject activities or prohibited end uses, including military/warfare purposes, nuclear industries/applications, espionage, and development or use of guns or illegal weapons.
- The materials and outputs are provided as-is.
- Meta may modify the license terms over time.

Commercial-use assessment:

Commercial use appears allowed in principle because the license does not ban commercial use and includes "sell" language in the patent grant. However, the license is not a simple permissive OSS license like MIT or Apache. Viper should treat it as commercially usable only after legal review, especially for anything distributed to users or used in monetized product workflows.

Viper policy:

- Do not use SAM 3D for WeaponForge or weapon product generation.
- Do not use SAM 3D for tanks, guns, military vehicles, warfare props, or combat-weapon mounts.
- Do not use SAM 3D Body for public avatar, skin, body, face, hair, makeup, or automatic outfit wrapping.
- Keep all SAM 3D model weights outside the Viper mobile app.
- Keep all SAM 3D output behind Asset Intake, Review Queue, Product Library, and Integrity Validator.

## Install Requirements

### SAM 3D Objects

Official requirements:

- Operating system: Linux 64-bit.
- GPU: NVIDIA GPU with at least 32 GB VRAM.
- Python: 3.11 according to the official environment file.
- CUDA target in environment: CUDA 12.1.
- Environment setup: mamba or conda environment from `environments/default.yml`.
- Core install path:
  - `pip install -e '.[dev]'`
  - `pip install -e '.[p3d]'`
  - `pip install -e '.[inference]'`
- Key dependencies include:
  - PyTorch / CUDA
  - PyTorch3D
  - Kaolin
  - gsplat
  - Open3D
  - Blender Python package `bpy`
  - MoGe
  - xatlas
  - Gradio
- Model weights require access approval through Hugging Face:
  - `facebook/sam-3d-objects`

Viper conclusion:

This is not suitable for Windows-local casual setup and absolutely not suitable for mobile. It should run only as a Website/Forge worker on a Linux NVIDIA GPU machine.

### SAM 3D Body

Official requirements:

- Python: 3.11.
- PyTorch installed from official PyTorch instructions.
- Dependencies include:
  - pytorch-lightning
  - pyrender
  - OpenCV
  - yacs
  - scikit-image
  - einops
  - timm
  - hydra
  - Detectron2 from a specific GitHub commit
  - optional MoGe
  - optional SAM3
- Model weights require Hugging Face access approval:
  - `facebook/sam-3d-body-dinov3`
  - `facebook/sam-3d-body-vith`
- It also requires MHR assets:
  - `mhr_model.pt`

GPU/VRAM:

- The official SAM 3D Body install docs do not state a minimum VRAM requirement.
- The code uses CUDA when available and can technically choose CPU if CUDA is unavailable, but CPU use is not a practical Viper production target.
- The released Body model backbones are large: DINOv3-H+ around 840M parameters and ViT-H around 631M parameters.

Viper conclusion:

Treat SAM 3D Body as a high-compute Website/Forge/internal experiment only. Do not put it in mobile, public Forge, public avatar flows, or protected guide asset flows.

### SAM 3

Official requirements:

- Python 3.12 or higher.
- PyTorch 2.7 or higher.
- CUDA-compatible GPU with CUDA 12.6 or higher.
- Optional faster inference dependencies include FlashAttention and related CUDA packages.
- Model checkpoint access requires Hugging Face approval.

Viper conclusion:

SAM 3 is not image-to-3D. It may be useful later for segmentation masks before SAM 3D Objects, but it should not be confused with a 3D generator.

## Output Formats

### SAM 3D Objects

Confirmed official output:

- PLY Gaussian splat / point-cloud style output via `output["gs"].save_ply("splat.ply")`.
- The official notebooks also save PLY and GIF preview renders.

Not confirmed as official direct output:

- GLB
- OBJ
- FBX
- USD
- STL

The repository and Meta descriptions discuss 3D geometry, texture, and layout, but the official quickstart path found in this investigation exports PLY Gaussian splats. Any GLB/OBJ/FBX/USD conversion should be treated as Viper-owned post-processing and must be reviewed separately.

### SAM 3D Body

Confirmed official output fields:

- `pred_vertices`
- `pred_keypoints_3d`
- `pred_keypoints_2d`
- `pred_cam_t`
- `focal_length`
- `body_pose_params`
- `hand_pose_params`
- `shape_params`

The demo writes rendered visualization images, not a direct asset file.

Not confirmed as official direct output:

- GLB
- OBJ
- FBX
- USD
- STL

MHR includes rig assets and FBX files, but those are MHR assets, not direct SAM 3D Body export packages from the demo. Viper should not treat SAM 3D Body as a ready-to-export avatar generator.

## Viper Workflow Fit

| Viper workflow | SAM 3D Objects fit | SAM 3D Body fit | Recommendation |
|---|---:|---:|---|
| Props | High | None | Recommended first prototype target. |
| Furniture | High | None | Strong candidate. |
| Vehicles | Medium | None | Only non-combat/non-military vehicles. |
| Spacecraft | Medium | None | Only non-combat concept/reference candidates. |
| Buildings | Medium | None | Useful for exterior/interior reference meshes, not final assets. |
| Creatures like Fluff | Low to medium | None | Possible object/creature reference candidate only, not rigged creature generation. |
| Human bodies | None | High technically, high risk | Internal/protected only. Do not publicize. |
| Clothing | Low | Medium but risky | Do not use for automatic mannequin/avatar wrapping. |
| Aria/Gaius protected assets | Do not use | Do not use | Strictly prohibited without separate protected internal approval. |
| Weapons | Not recommended | None | Exclude because of license risk. |
| Tanks/combat vehicles | Not recommended | None | Exclude because of military/warfare risk. |

## Category-Specific Findings

### Props

Recommended.

Props are the safest SAM 3D Objects target. They are bounded, object-like, and fit Asset Intake plus Product Library review well.

### Furniture

Recommended.

Furniture is explicitly aligned with Meta's example product use case around view-in-room style object visualization. Viper should use owner-approved or permissively licensed images only.

### Vehicles

Conditionally recommended.

Use only for non-combat vehicles such as cars, trucks, motorcycles, hover vehicles, and utility vehicles. Exclude tanks, military equipment, guns, weapon mounts, and anything framed as warfare.

### Spacecraft

Conditionally recommended.

Use only for non-combat spacecraft concept candidates, such as shuttles, freighters, civilian transports, station modules, or room/module references. Exclude fighters, weapon mounts, combat craft, and military targets until legal review.

### Buildings

Conditionally recommended.

SAM 3D Objects can help with rough massing/reference candidates from images. It should not be treated as final architectural geometry.

### Creatures Like Fluff

Possible but limited.

SAM 3D Objects may create a rough creature/object reference from an owner-approved image, especially if Fluff is treated like a toy, creature maquette, or concept object. It will not produce a rigged creature, animation-ready topology, fur system, or game-ready creature asset.

### Human Bodies

Technically supported by SAM 3D Body, but Viper should not integrate it into public flows.

SAM 3D Body should remain:

- internal-only
- protected
- not connected to public avatar generation
- not connected to public skin generation
- not connected to automatic clothing wrapping
- not connected to Aria/Gaius protected assets

## Safety Boundaries

Hard rules:

1. Do not connect SAM 3D Body to Aria.
2. Do not connect SAM 3D Body to Gaius.
3. Do not use SAM 3D Body for public avatar generation.
4. Do not use SAM 3D Body for public skin generation.
5. Do not use SAM 3D Body for automatic texture wrapping.
6. Do not bypass Asset Intake.
7. Do not bypass source rights checks.
8. Do not bypass Review Queue.
9. Do not bypass Product Library.
10. Do not bypass Integrity Validator.
11. Do not use SAM 3D Objects for guns, illegal weapons, warfare, military use, tanks, or weapon mounts.
12. Do not put any SAM 3D runtime, model weights, or heavy dependencies in the mobile app.

## Recommended Viper Architecture

SAM 3D should be a Website/Forge worker lane, not a workspace editor.

Recommended flow:

```text
Image Upload
  -> Upload Storage
  -> Asset Intake
  -> Source Rights Check
  -> Asset Review Scanner
  -> Candidate Review
  -> SAM 3D Candidate Job
  -> Worker Dispatcher
  -> Generated Mesh/Splat Candidate
  -> Preview Record
  -> Review Queue
  -> Product Library Candidate
  -> Export Readiness later
```

Recommended service owner:

- Asset Intake owns the original image.
- Upload Storage owns file storage.
- Worker Dispatcher owns job execution state.
- Preview Service owns generated preview thumbnails/turntables.
- Review Queue owns approval/revision.
- Product Library owns approved SAFE_PRODUCT candidates.
- Export Readiness owns future readiness checks.
- Integrity Validator enforces lane separation and blocked categories.

## Proposed New Record Types

Do not implement yet. Proposed only.

### SAM3DCandidateJob

Fields:

- job id
- source upload id
- asset intake id
- workspace id
- product id, optional
- model family: `sam_3d_objects` or `sam_3d_body`
- mode: `object_candidate`, `scene_candidate`, `body_internal_candidate`
- source rights status
- allowed lane
- blocked reason
- status: draft, submitted, queued, processing, completed, failed, rejected
- output asset ids
- preview ids
- review queue id
- created date
- updated date

### GeneratedMeshCandidate

Fields:

- candidate id
- source SAM 3D job id
- source upload id
- workspace id
- output type: ply, vertices, parameters, preview_only
- local storage path
- thumbnail path
- source rights status
- review status
- product id, optional
- notes

## Safest First Prototype

Prototype name:

```text
Forge SAM 3D Objects Candidate Worker
```

Prototype target:

- Furniture and Props only.

Allowed inputs:

- User-owned images.
- Public-domain images.
- Licensed references with recorded source rights.
- Internal test images created specifically for Viper.

Blocked inputs:

- Aria protected assets.
- Gaius protected assets.
- Human faces/bodies.
- Skin/body/face/hair/makeup references.
- Weapons.
- Guns.
- Tanks.
- Military or warfare content.
- Copyrighted product images without rights.

Prototype output:

- PLY candidate.
- Rendered preview image.
- Review Queue item.
- Product Library draft candidate.

No export:

- No GLB export.
- No OBJ export.
- No FBX export.
- No game export.
- No IMVU export.
- No Starfield export.

## Website/Forge Only Assessment

SAM 3D must be Website/Forge only.

Reasons:

- SAM 3D Objects requires Linux 64-bit and at least 32 GB VRAM.
- SAM 3D Objects has large CUDA/PyTorch/PyTorch3D/Kaolin/gsplat dependencies.
- SAM 3D Body uses large backbones and human mesh recovery dependencies.
- Model checkpoint access requires Hugging Face authentication and license acceptance.
- Generated outputs require review and source-rights tracking.
- Mobile must remain guide-first, lightweight, and review-focused.

Mobile may only:

- upload references
- select a SAM 3D candidate job option later
- view generated thumbnails
- request revision
- approve/reject

Mobile must not:

- run SAM 3D
- store model weights
- process meshes
- render heavy splats
- export models

## Risks

### License Risk

SAM License is not a standard permissive OSS license. Commercial use appears possible, but legal review is required before monetized or distributed use.

### Weapon And Military Risk

The license prohibits certain military/warfare/gun/illegal weapon uses. Viper must exclude WeaponForge, tanks, combat vehicles, combat spacecraft, and weapon mounts from SAM 3D workflows unless legal review explicitly approves a narrow scope.

### Source Rights Risk

Single-image reconstruction can reproduce recognizable product geometry. Viper must require source rights metadata before generating candidates.

### Quality Risk

SAM 3D output should be treated as a candidate or reference, not a production-ready asset. The likely first outputs will need cleanup, scale validation, topology review, material review, and export readiness checks.

### Format Risk

Official SAM 3D Objects demo output is PLY Gaussian splat. GLB/OBJ/FBX/USD export is not confirmed in the official quickstart. Viper should not promise game-ready mesh formats until a separate converter/export pipeline is audited.

### Compute Risk

SAM 3D Objects needs at least 32 GB VRAM. This is worker/server compute, not desktop/mobile casual compute.

### Protected Asset Risk

SAM 3D Body and MHR are human-body systems. They must not touch protected Aria/Gaius assets or public avatar systems.

### Dependency Risk

The dependency stack is large and CUDA-specific. It should be isolated in a worker container or dedicated compute environment, not mixed into the API server or mobile app.

## Integration Recommendation

Recommended with restrictions:

- Yes for SAM 3D Objects as a Website/Forge-only experimental candidate worker.
- No for mobile runtime.
- No for public avatar/skin/body flows.
- No for WeaponForge or military/warfare categories.
- No for direct export.
- No for protected Aria/Gaius assets.

Recommended first Viper workspace:

- Furniture and Props.

Recommended second possible workspace:

- Building and Structures reference candidates.

Recommended later possible workspace:

- Non-combat VehicleForge and non-combat SpacecraftForge concept candidates.

Not recommended yet:

- Clothing and Armor.
- Creature Forge production assets.
- Avatar Forge.
- Skin Forge.
- Weapon Forge.
- Export Forge.

## Implementation Plan For Later

Do not implement until approved.

### Phase SAM-0: Legal And License Gate

- Review SAM License.
- Review Hugging Face access terms.
- Review dependency licenses.
- Define blocked categories.
- Add Viper policy: no SAM 3D weapons/military/guns.

### Phase SAM-1: Worker Environment Test

- Create isolated Linux GPU worker environment.
- Do not add dependencies to Viper mobile or API server.
- Download weights only after license approval.
- Run one private test image.
- Record runtime, VRAM, output size, and failure modes.

### Phase SAM-2: Forge Candidate Records

- Add `SAM3DCandidateJob`.
- Add `GeneratedMeshCandidate`.
- Link records to Asset Intake, Review Queue, Preview Service, Product Library, and Integrity Validator.

### Phase SAM-3: Furniture/Prop Prototype

- Allow only Furniture and Props.
- Require source rights before job submission.
- Produce PLY candidate and preview image.
- Review Queue must approve before Product Library ownership.

### Phase SAM-4: Readiness And Conversion Review

- Evaluate whether PLY candidates can become GLB/OBJ through a separate converter.
- Add scale/material/topology checks.
- Do not build Export Forge in this phase.

## Final Decision

SAM 3D Objects is useful for Viper, but only as a reviewed Website/Forge candidate pipeline.

SAM 3D Body is technically interesting, but too risky for public Viper workflows. It should remain internal-only unless a separate protected human-body audit is approved.

Viper should proceed only with a narrow, safe first prototype:

```text
Furniture/Props image upload
  -> Asset Intake
  -> Source Rights Check
  -> SAM 3D Objects Candidate Job
  -> PLY Candidate
  -> Preview Record
  -> Review Queue
  -> Product Library Draft
```

No mobile integration. No protected assets. No weapons. No body/avatar/skin generation. No automatic exports.

## Sources Consulted

- Meta SAM 3D blog: https://ai.meta.com/blog/sam-3d/
- SAM 3D Objects GitHub: https://github.com/facebookresearch/sam-3d-objects
- SAM 3D Objects setup: https://github.com/facebookresearch/sam-3d-objects/blob/main/doc/setup.md
- SAM 3D Objects Hugging Face model card: https://huggingface.co/facebook/sam-3d-objects
- SAM 3D Objects license: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/LICENSE
- SAM 3D Body GitHub: https://github.com/facebookresearch/sam-3d-body
- SAM 3D Body install guide: https://raw.githubusercontent.com/facebookresearch/sam-3d-body/main/INSTALL.md
- SAM 3D Body Hugging Face model card: https://huggingface.co/facebook/sam-3d-body-dinov3
- SAM 3D Body license: https://raw.githubusercontent.com/facebookresearch/sam-3d-body/main/LICENSE
- SAM 3 GitHub: https://github.com/facebookresearch/sam3
- MHR GitHub: https://github.com/facebookresearch/MHR

