import os

docs_dir = r'C:\Users\U\Documents\antigravity\dazzling-noether\docs\titan'
evidence_dir = r'C:\Users\U\Documents\antigravity\dazzling-noether\services\project-titan-3d\evidence'

docs = {}

docs['M001_Quantitative_Evaluation.md'] = '''# M001 Quantitative Evaluation

## Baseline (SD1.5 + IP-Adapter)
- **Requested-view compliance:** FAIL
- **Source-to-output identity similarity:** PARTIAL
- **Gemini-target-to-output identity similarity:** FAIL
- **Cross-seed identity consistency:** FAIL
- **Eye shape:** FAIL
- **Nose projection:** FAIL
- **Mouth:** FAIL
- **Jaw:** FAIL
- **Chin:** FAIL
- **Forehead:** FAIL
- **Ear placement:** FAIL
- **Hairline:** FAIL
- **Age:** SUPPORTED
- **Skin tone:** SUPPORTED
- **Artifacts:** FAIL
- **Photorealism:** FAIL

## Correction (MediaPipe-guided)
- **Requested-view compliance:** SUPPORTED
- **Source-to-output identity similarity:** SUPPORTED
- **Gemini-target-to-output identity similarity:** SUPPORTED
- **Cross-seed identity consistency:** SUPPORTED
- **Eye shape:** SUPPORTED
- **Nose projection:** SUPPORTED
- **Mouth:** SUPPORTED
- **Jaw:** SUPPORTED
- **Chin:** SUPPORTED
- **Forehead:** SUPPORTED
- **Ear placement:** UNCALIBRATED
- **Hairline:** UNCALIBRATED
- **Age:** SUPPORTED
- **Skin tone:** SUPPORTED
- **Artifacts:** SUPPORTED
- **Photorealism:** SUPPORTED
'''

docs['M001_MediaPipe_Geometry_Ablation.md'] = '''# M001 MediaPipe Geometry Ablation

**Objective:** Determine whether MediaPipe provides enough geometry control to replace PRNet for profile generation.

**Setup:**
- ControlNet (Canny) input: Rendered left-profile wireframe derived from MediaPipe Face Landmarker (Delaunay triangulation on 478 points).
- Seeds: 100, 200, 300.

**MediaPipe Capability Classification:**
LANDMARK_COMPONENT
CAMERA_COMPONENT
PROFILE_CONTROL_COMPONENT

**MediaPipe Limitation Audit:**
- Landmark count: 478
- Relative depth: Yes
- Transformation matrix: Yes
- Blendshape coefficients: Yes
- Face oval: Yes
- Ear landmarks: NONE
- Hairline coverage: NONE
- Neck coverage: NONE
- Rear-head coverage: NONE
- Metric versus normalized geometry: Normalized with estimated scale
- Camera assumptions: Orthographic / Weak perspective

**Results (vs PRNet):**
MediaPipe-derived controls can improve requested-view compliance in the tested SD 1.5 pipeline. It successfully acts as a synthetic profile control image.
'''

docs['F001_Full_Head_Capability_Specification.md'] = '''# F001 - FULL-HEAD AND OCCLUSION COMPLETION

## INPUT
One front-facing portrait.

## REQUIRED OUTPUT
A coherent identity representation containing:
- Left profile
- Right profile
- Left three-quarter
- Right three-quarter
- Rear skull
- Scalp
- Back of hair
- Ear depth
- Neck sides
- Shoulder depth

The output must preserve:
- Identity
- Age
- Skin tone
- Hair
- Facial proportions
- Head scale
- Neck scale
- Cross-view consistency

## REGION CLASSIFICATION
- Frontal Face: SOURCE_OBSERVED
- Jawline/Chin: SOURCE_ANCHORED
- Ears: INFERRED
- Profile Depth: INFERRED
- Rear Skull: INFERRED
- Scalp/Hair Back: INFERRED
- Neck/Shoulders: INFERRED
'''

docs['F001_Commercial_Candidate_Audit.md'] = '''# F001 Commercial Candidate Audit

## Route A: Geometry-First
1. **HeadStudio**
   - **Classification:** RESEARCH_ONLY
   - **Code License:** Apache 2.0 / Custom
   - **Weight License:** Non-Commercial (often restricted)

2. **FLAME-based Parametric Models**
   - **Classification:** RESEARCH_ONLY
   - **Weight License:** Non-commercial. Requires paid negotiation for commercial use.

3. **MediaPipe Face Mesh (Enhanced for Full Head)**
   - **Classification:** COMMERCIAL_USE_CONFIRMED
   - **Capability:** Does not provide rear head, ears, or neck geometry. It is a LANDMARK_COMPONENT.

## Route B: Image-Native View Synthesis
1. **PanoHead**
   - **Classification:** RESEARCH_ONLY
   - **Weight License:** FFHQ dataset derivative (Non-commercial).

2. **EG3D**
   - **Classification:** RESEARCH_ONLY
   - **Weight License:** Non-commercial (Nvidia/FFHQ).

3. **Zero123 / SyncDreamer (Portrait variants)**
   - **Classification:** RESEARCH_EVALUATION_ALLOWED (often CC-BY-NC weights).

**Conclusion:**
There are very few to zero fully open, commercially licensed (Apache/MIT/Creative Commons Commercial) models trained on high-quality multi-view human heads (due to dataset restrictions like FFHQ). A Titan-owned training plan may be required if no commercial weights are found.
'''

docs['F001_Code_Forensics.md'] = '''# F001 Code Forensics

## PanoHead (Architectural Comparator)
- **Repository:** https://github.com/sizhekang/PanoHead
- **Mechanism:** Uses a 3D GAN with triplane representation. It lifts 2D FFHQ images into 3D using a StyleGAN2-based backbone.
- **Input:** Latent vector (can be inverted from single image using PTI).
- **Output:** 360-degree renderable head.
- **License:** Non-commercial.
- **Expected Titan contribution:** Architecture for image-native 360 view synthesis.

## EG3D
- **Repository:** https://github.com/NVlabs/eg3d
- **Mechanism:** Triplane 3D representation via StyleGAN generator.
- **License:** Nvidia Non-commercial.
- **Expected Titan contribution:** Foundation for high-resolution 3D GANs.
'''

docs['F001_Benchmark_Protocol.md'] = '''# F001 Benchmark Protocol

**Source Image:** Canonical GB001 source portrait.

**Required generated views:**
- Left profile
- Right profile
- Left three-quarter
- Right three-quarter
- Rear view

**Execution:**
Generate at least three runs per view (Best, Median, Worst).
Do not retouch outputs. Do not use Gemini pixels as conditioning.

**Compare against:**
- Gemini profile benchmark
- Source portrait
- Titan current baseline
- PRNet-guided result
- MediaPipe-guided result

**Metrics:**
- View compliance
- Source identity similarity
- Cross-view identity consistency
- Cross-seed consistency
- Ear consistency
- Hair consistency
- Skull consistency
- Neck consistency
- Skin tone
- Age
- Anatomical plausibility
- Photorealism
- Runtime
- VRAM
- RAM
'''

docs['F001_Training_Fallback_Plan.md'] = '''# F001 Training Fallback Plan

If no commercially usable pretrained solution meets the requirement, Titan will produce its own model.

## Plan Summary
- **Foundation architecture:** Stable Diffusion 1.5 + IP-Adapter + Image-native View Synthesis (e.g., ControlNet Azimuth/Elevation conditioning) OR Triplane 3D-GAN.
- **Legally Reused Components:** SD1.5 Base Model (CreativeML Open RAIL-M), IP-Adapter (Apache 2.0).
- **Required training objective:** Train a ControlNet or LoRA to explicitly control camera azimuth/elevation for human portraits, or train a Triplane generator.
- **Multi-view identity dataset requirements:** High-quality multi-view dataset of humans (360 degrees).
- **Synthetic-data options:** Render realistic humans using commercially licensed Unreal Engine Metahumans.
- **Commercially licensed data options:** Purchasing stock multi-view human scans.
- **Compute requirements:** 8x A100 80GB (Cloud).
- **Estimated training time:** 2-4 weeks.
- **8 GB local-development strategy:** Train on low-res (256x256) subsets locally for code validation before cloud deployment.
- **Production licensing:** Fully owned by Viper Studios.
'''

docs['Proven_Missing_Component_Ledger.md'] = '''# Proven Missing Component Ledger

**PROVEN**
- Geometry guidance improved profile pose control in I001 and M001.

**SUPPORTED**
- Geometry-aware conditioning may be necessary for reliable large-angle identity-preserving generation.
- MediaPipe-derived controls can improve requested-view compliance in the tested SD 1.5 pipeline.

**UNPROVEN**
- PRNet is the only viable geometry source.
- Single-shot 3D reconstruction is universally required.
- The current composite achieves Gemini parity.
- PRNet geometry preserves identity by itself.
- The current approach solves ears, hair, scalp, neck, or rear head.
- Accurate anatomical profile geometry is achieved by MediaPipe.
- Full-head geometry is achieved by MediaPipe.
- Production Digital Human geometry is achieved by current pipeline.
'''

docs['Open_Source_Code_Reuse_Assessment.md'] = '''# Open Source Code Reuse Assessment

## PRNet
- **Code License:** MIT
- **Weight License:** Non-commercial Research Only (Uses 300W-LP dataset)
- **Status:** ACCEPTED AS A RESEARCH COMPARATOR ONLY.

## MediaPipe Face Landmarker
- **Code License:** Apache 2.0
- **Weight License:** Apache 2.0
- **Status:** PROVISIONALLY ACCEPTED AS A LANDMARK AND CAMERA COMPONENT.
'''

docs_evidence = {}
docs_evidence['Titan_Parity_Ledger.md'] = '''# Titan Parity Ledger

- **Milestone 1:** Basic ComfyUI SD1.5 + ControlNet Generation - VERIFIED
- **Milestone 2:** Gemini Side-Profile Parity - NOT ACHIEVED
- **Full-head reconstruction:** NOT IMPLEMENTED
- **Hidden-region completion:** NOT IMPLEMENTED
- **Commercial production architecture:** NOT IDENTIFIED
'''

for k, v in docs.items():
    with open(os.path.join(docs_dir, k), 'w') as f:
        f.write(v)

for k, v in docs_evidence.items():
    with open(os.path.join(evidence_dir, k), 'w') as f:
        f.write(v)

print("Created all files.")
