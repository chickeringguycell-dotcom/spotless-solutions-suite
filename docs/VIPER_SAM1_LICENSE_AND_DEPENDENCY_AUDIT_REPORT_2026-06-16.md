# VIPER SAM-1 LICENSE AND DEPENDENCY AUDIT REPORT

Date: 2026-06-16

Status: legal, dependency, and deployment readiness audit only.

No SAM 3D packages were installed. No model weights were downloaded. No code was integrated. No workers were created. Phase 4H was not started.

Important note: this is an engineering/legal-readiness audit, not legal advice. Before production or commercial launch, Viper should have the SAM License and Hugging Face access terms reviewed by a qualified human/legal reviewer.

## Mission

Determine whether SAM 3D Objects can legally and technically enter Viper Studios.

Source of truth:

- `VIPER_SAM0_LICENSE_AND_CLOUD_WORKER_DESIGN_REPORT_2026-06-16.md`

Primary answer:

```text
GO WITH RESTRICTIONS
```

SAM 3D Objects is worth integrating into Viper, but only as a Website/Forge cloud-worker lane, with strict category gates and a formal license acceptance record before installation.

## Official Sources Reviewed

- Meta SAM 3D Objects GitHub: https://github.com/facebookresearch/sam-3d-objects
- SAM 3D Objects SAM License: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/LICENSE
- SAM 3D Objects setup: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/doc/setup.md
- SAM 3D Objects Hugging Face model page: https://huggingface.co/facebook/sam-3d-objects
- SAM 3D Objects requirements: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/requirements.txt
- SAM 3D Objects inference requirements: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/requirements.inference.txt
- SAM 3D Objects PyTorch3D requirements: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/requirements.p3d.txt
- SAM 3D Objects default environment: https://raw.githubusercontent.com/facebookresearch/sam-3d-objects/main/environments/default.yml
- PyTorch license: https://raw.githubusercontent.com/pytorch/pytorch/main/LICENSE
- PyTorch3D license: https://raw.githubusercontent.com/facebookresearch/pytorch3d/main/LICENSE
- NVIDIA Kaolin license: https://raw.githubusercontent.com/NVIDIAGameWorks/kaolin/master/LICENSE
- gsplat license: https://raw.githubusercontent.com/nerfstudio-project/gsplat/main/LICENSE
- Open3D license: https://raw.githubusercontent.com/isl-org/Open3D/main/LICENSE
- Blender `bpy` package page: https://pypi.org/project/bpy/4.3.0/
- Blender GPL license text: https://raw.githubusercontent.com/blender/blender/main/doc/license/GPL-license.txt
- NVIDIA CUDA EULA: https://docs.nvidia.com/cuda/eula/index.html
- Python license documentation: https://docs.python.org/3/license.html
- Lambda GPU pricing: https://lambda.ai/pricing
- AWS EC2 G6e instance family: https://aws.amazon.com/ec2/instance-types/g6e/

## Executive Summary

SAM 3D Objects can fit Viper Studios, but not as a casual dependency.

It should enter as:

```text
Image Upload
  -> Upload Storage
  -> Asset Intake
  -> Source Rights Check
  -> SAM3DCandidateJob
  -> Cloud GPU Worker
  -> Generated Mesh Candidate
  -> Preview Record
  -> Review Queue
  -> Product Library Draft
```

SAM 3D Objects should not be installed into:

- mobile
- Website/Forge frontend
- API server process
- Codex process
- local user thread
- protected Aria/Gaius asset pipelines

The license and dependency stack point to one practical conclusion:

```text
SAM belongs in an isolated Linux GPU worker container with strict input/output gates.
```

## License Findings

### SAM License

The SAM 3D Objects repository states that code and model checkpoints are licensed under the SAM License.

The SAM License grants broad use rights for SAM Materials, including use, reproduction, distribution, copying, derivative works, and modifications, subject to the license terms.

Commercial use appears possible because the license does not prohibit commercial activity and includes patent language covering sale/transfer of covered work. However, Viper should not treat this as final legal approval until the accepted Hugging Face terms and Meta SAM License are reviewed and recorded.

### Redistribution Requirements

If Viper distributes SAM Materials or derivative works of SAM Materials to a third party, distribution must happen under the SAM License and include a copy of the agreement.

Practical Viper rule:

```text
Do not redistribute SAM code, model weights, or worker images inside Viper apps.
```

Keep SAM inside a private cloud worker environment. Mobile and Website/Forge should call Viper services, not ship SAM.

### Commercial-Use Assessment

| Question | Assessment | Viper Rule |
|---|---|---|
| Can Viper use SAM 3D Objects commercially? | Likely yes, with restrictions and legal signoff. | Require SAM License acceptance record before install. |
| Can Viper store outputs? | Likely yes, but Viper owns the responsibility for source rights, privacy, and use risk. | Store only reviewed SAFE_PRODUCT candidates. |
| Can Viper modify outputs? | Likely yes for generated outputs and Viper-side processing, but license/source rights still matter. | Keep edits behind Product Library and Review Queue. |
| Can Viper sell products created from reviewed outputs? | Likely yes for allowed categories after source-rights and review gates. | Only after human/legal-safe review; never for blocked categories. |
| Can Viper redistribute SAM weights/code? | Only under the SAM License terms. | Do not redistribute weights/code in Viper products. |

### Derivative-Work Findings

The SAM License says licensees own their modifications and derivative works of SAM Materials as between the licensee and Meta, subject to Meta's ownership of SAM Materials and Meta-created derivatives.

Viper interpretation:

- Viper can modify generated candidate outputs after review.
- Viper can store Viper-side metadata, previews, mesh cleanup notes, product cards, and readiness records.
- Viper should not modify SAM itself in the first integration.
- If SAM code is modified later, those modifications must be tracked in a license registry.

### Hugging Face Access Findings

The Hugging Face model page is gated.

Observed requirements:

- User must log in or sign up.
- User must agree to share contact information.
- Access asks for full legal name, date of birth, and full organization name with corporate identifiers.
- Access is not available in comprehensively sanctioned jurisdictions.

Unknown until login/acceptance:

- Any extra access conditions shown after authentication.
- Whether Meta requires additional organization-level approval.
- Whether Viper must keep a particular notice or usage record beyond the SAM License.

Viper rule:

```text
No model weights may be downloaded until the accepted Hugging Face access terms are captured in a Viper license registry.
```

### Remaining SAM License Restrictions

Viper must comply with:

- trade controls and sanctions rules
- privacy and data protection laws
- no reverse engineering of underlying SAM components
- no ITAR-related use
- no military or warfare purposes
- no nuclear-industry use
- no espionage use
- no development or use of guns or illegal weapons
- no patent litigation trigger behavior
- no expectation of Meta support or warranty

Viper should be stricter than the minimum license language.

## Dependency Findings

### Official Environment Shape

The official setup requires:

- Linux 64-bit
- NVIDIA GPU with at least 32 GB VRAM
- Python 3.11
- CUDA 12.1-style dependency stack
- Hugging Face authenticated checkpoint access
- Mamba or Conda-style environment creation

The default environment pins:

- `python=3.11.0`
- CUDA 12.1 packages

The requirements include:

- `bpy==4.3.0`
- `cuda-python==12.1.0`
- `open3d==0.18.0`
- `torchaudio==2.5.1+cu121`
- `spconv-cu121==2.3.8`
- `xformers==0.0.28.post3`
- `MoGe` from GitHub
- many additional Python, visualization, rendering, and ML packages

Inference extras include:

- `kaolin==0.17.0`
- `gsplat` from a pinned GitHub commit
- `gradio==5.49.0`
- `seaborn==0.13.2`

PyTorch3D extras include:

- `pytorch3d` from a pinned GitHub commit
- `flash_attn==2.8.3`

### Dependency License Table

| Dependency | Observed License | Commercial Suitability | Deployment Risk |
|---|---:|---|---|
| PyTorch | BSD-style | Generally suitable with notices. | Medium; CUDA wheel compatibility matters. |
| PyTorch3D | BSD-style | Generally suitable with notices. | Medium; built from pinned Git commit. |
| Kaolin | Apache-2.0 | Generally suitable with notices. | Medium; GPU/CUDA compatibility. |
| gsplat | Apache-2.0 | Generally suitable with notices. | Medium; pinned Git commit, compiled GPU code. |
| Open3D | MIT | Generally suitable with notices. | Low/Medium; sizable geometry dependency. |
| Blender `bpy` | GPL-3.0 on PyPI metadata | Usable only with GPL awareness. | High; isolate from proprietary core. |
| CUDA / cuda-python | NVIDIA proprietary terms | Usable for cloud workers under NVIDIA terms. | High; redistribution and platform limits. |
| Python 3.11 | PSF-style permissive | Suitable. | Low. |

### PyTorch

PyTorch uses a BSD-style license. It is compatible with commercial cloud-worker use if notices are preserved.

Viper risk:

- CUDA wheel compatibility.
- Version pinning.
- Worker image size.
- GPU driver/runtime compatibility.

### PyTorch3D

PyTorch3D uses a BSD-style license and is pulled from a pinned GitHub commit in SAM 3D Objects.

Viper risk:

- Build failures on mismatched CUDA/PyTorch.
- Native extension compilation.
- Requires isolated worker build, not API-server dependency pollution.

### Kaolin

Kaolin uses Apache-2.0.

Viper risk:

- NVIDIA ecosystem dependency.
- GPU-specific install behavior.
- Needs license notice in worker SBOM.

### gsplat

gsplat uses Apache-2.0 and is pulled from a pinned GitHub commit.

Viper risk:

- Pinned source dependency.
- GPU compilation.
- Output is Gaussian-splat oriented; not automatically game-ready mesh.

### Open3D

Open3D uses MIT and is listed in the main requirements.

Viper risk:

- Useful for geometry inspection, conversion helpers, or future visual checks.
- Should remain worker-side, not frontend/mobile.

### Blender `bpy`

The SAM 3D Objects requirements include `bpy==4.3.0`.

The PyPI page lists:

- License: GPL-3.0
- Requires: Python 3.11
- Wheel sizes around hundreds of MB depending on platform

Viper rule:

```text
Do not link Blender/bpy into Viper core services or mobile.
Use Blender/bpy only inside isolated worker or conversion containers.
```

If Viper later uses Blender for conversion or rendering, prefer process isolation:

```text
Viper service
  -> job record
  -> isolated Blender worker process/container
  -> output file
  -> Preview/Product records
```

Do not turn Viper API or Website/Forge into a Blender-linked application.

### CUDA

CUDA is governed by NVIDIA's proprietary EULA and CUDA supplement.

Viper rule:

- Use CUDA in cloud worker environments only.
- Do not redistribute CUDA as a standalone product.
- Do not ship CUDA into mobile.
- Keep driver/runtime versions locked per worker image.
- Avoid military/critical-application lanes.

### Full Transitive SBOM Required

SAM 3D Objects has a large dependency tree. SAM-1 reviewed the named critical dependencies, but production readiness requires a generated software bill of materials after the first isolated install.

Required before production:

- full transitive dependency list
- license inventory
- native extension inventory
- model-weight inventory
- container image hash
- vulnerability scan
- export-control review

## Deployment Findings

### Minimum Worker Requirements

Official minimum:

- OS: Linux 64-bit
- GPU: NVIDIA GPU with at least 32 GB VRAM
- Python: 3.11
- CUDA: 12.1-compatible stack
- Checkpoints: gated Hugging Face access

Recommended Viper minimum:

- OS: Linux 64-bit container host
- CPU: 8 vCPU minimum, 16 vCPU preferred
- RAM: 64 GB minimum, 100 GB preferred
- GPU: one 48 GB VRAM GPU preferred
- VRAM: 32 GB minimum, 48 GB safer
- Storage: 250 GB minimum worker disk, 500 GB preferred
- Object storage: separate durable storage for uploads, candidates, previews, logs
- Network: egress to Hugging Face only during approved setup; runtime should use local mounted checkpoints

Preferred GPU classes:

- RTX A6000 48 GB
- NVIDIA L40S 48 GB
- A100 40 GB or 80 GB
- H100 80 GB

Avoid for first prototype:

- 24 GB GPUs such as L4 or A10, because official requirements say at least 32 GB VRAM.
- multi-GPU-only configurations where one job cannot use a single 32+ GB device cleanly.

### Startup Cost Estimate

This estimate is for planning only. Prices change by provider, region, availability, billing model, and tax.

Observed reference:

- Lambda lists RTX A6000 48 GB at about `$1.09/GPU/hour`.
- AWS G6e uses NVIDIA L40S with 48 GB memory per GPU.

Approximate SAM-2 spike budget:

| Activity | Expected Cost Shape |
|---|---:|
| License/access review | No infrastructure cost; human time required. |
| First worker setup, 5-10 GPU hours | About $5.45-$10.90 at $1.09/hr before tax/storage. |
| Deeper install/debug spike, 20-40 GPU hours | About $21.80-$43.60 at $1.09/hr before tax/storage. |
| Always-on single A6000 720 hours/month | About $784.80/month before tax/storage. |

Recommendation:

```text
Use queued, start-on-demand workers first.
Do not run an always-on SAM worker until throughput is measured.
```

### Runtime Cost Estimate

Unknown until measured.

SAM 3D Objects official docs do not provide a guaranteed per-object runtime figure. Viper should measure:

- cold start time
- model load time
- image/mask preprocessing time
- reconstruction time
- preview render time
- output size
- failure rate
- VRAM peak

Planning assumption:

```text
One GPU worker processes one SAM candidate job at a time until SAM-2 proves safe concurrency.
```

### Expected Throughput

Conservative first target:

- one candidate per GPU at a time
- queue-based status updates
- no realtime promise
- user-facing status should say "processing" rather than showing a countdown

SAM-2 should produce measured throughput.

## Viper Policy Validation

SAM remains blocked from:

- Aria protected assets
- Gaius protected assets
- public avatars
- public skins
- weapons
- guns
- tanks
- military content
- military vehicles
- combat spacecraft
- human-body generation
- face generation
- hair generation
- automatic avatar texture wrapping

Allowed first prototype:

- Furniture
- Props

Future candidate categories after new review:

- Buildings
- Structures
- Non-combat vehicles
- Non-combat spacecraft

## Policy Enforcement Points

### 1. Upload Storage

Reject or hold uploads that are:

- protected guide assets
- human body/face references
- weapon/gun references
- military/tank/combat references
- source-rights unknown

### 2. Asset Intake

Require:

- category
- source-rights status
- workspace
- lane
- uploader identity
- intended use

Only `public_safe_product` Furniture/Props should reach SAM in the first prototype.

### 3. SAM3DCandidateJob

Allowed first modes:

- `furniture_candidate`
- `prop_candidate`

Blocked modes:

- `weapon_candidate`
- `combat_vehicle_candidate`
- `combat_spacecraft_candidate`
- `public_avatar_candidate`
- `public_skin_candidate`
- `protected_guide_candidate`
- `human_body_candidate`

### 4. Worker Dispatcher

Worker Dispatcher must reject blocked jobs even if an earlier service accidentally creates one.

### 5. SAM Worker

SAM Worker must:

- accept only pre-approved job IDs
- never read arbitrary storage paths
- never access protected guide asset buckets
- write only candidate output paths
- never create Product Library approved records directly

### 6. Review Queue

All SAM outputs must enter Review Queue as candidates.

Review status must remain:

- pending
- approved
- needs_revision
- rejected
- archived

### 7. Product Library

SAM outputs may create only draft Product Library records until review passes.

### 8. Integrity Validator

Integrity Validator should later enforce:

- no blocked SAM category reaches worker dispatch
- no product links blocked source material
- no public-safe product links internal-only or protected assets
- generated candidate has source upload, intake record, preview record, and review item
- approved product has clean source-rights status

## Risk Review

| Risk | Rating | Reason |
|---|---:|---|
| Legal risk | Medium | Commercial use appears possible, but license is custom and output responsibility sits on Viper. |
| License risk | Medium-High | SAM has prohibited-use language and gated HF terms; Blender/bpy GPL adds isolation needs. |
| Compute risk | High | Official minimum is 32 GB VRAM; dependency stack is GPU-heavy. |
| Storage risk | Medium | Checkpoints, candidate PLY files, previews, masks, and logs need durable storage rules. |
| Commercial-use risk | Medium | Allowed categories likely workable; blocked categories must remain hard-blocked. |
| Support burden | High | Meta offers no support obligation; Viper owns debugging, dependency drift, and failures. |
| Dependency risk | High | Many pinned native/GPU dependencies, Git dependencies, CUDA stack, and patching steps. |
| Privacy/source-rights risk | High without gates, Medium with gates | Image-to-3D can reproduce user-uploaded or copyrighted object geometry. |
| Mobile risk | Low if cloud-only | Mobile stays lightweight if SAM never enters mobile bundle. |
| Protected asset risk | Medium | Low only if storage buckets and Integrity Validator enforce hard separation. |

## GO / NO-GO Decision

Recommendation:

```text
GO WITH RESTRICTIONS
```

Reason:

SAM 3D Objects is valuable enough to justify a controlled integration path. It can solve a real Viper problem: turning approved 2D references into 3D candidate material. But it is not safe as a normal app dependency and not safe for broad categories.

Approved:

- SAM 3D Objects only
- Website/Forge cloud worker only
- Furniture/Props first
- source-rights gated
- Review Queue gated
- Product Library draft-only
- worker isolation
- legal/access acceptance record before installation

Not approved:

- SAM 3D Body
- public avatars
- public skins
- Aria protected assets
- Gaius protected assets
- weapons
- guns
- tanks
- military vehicles
- combat spacecraft
- mobile-side SAM
- API-server embedded SAM
- direct-to-export SAM outputs

## Required Conditions Before SAM-2

Before installation or weight download:

1. Human accepts Hugging Face access under the correct legal name and organization.
2. Store accepted SAM License/HF access terms in a Viper license registry.
3. Confirm the organization is not in a sanctioned jurisdiction and the use case does not trigger trade-control restrictions.
4. Approve the blocked-category policy in writing.
5. Create a disposable cloud GPU environment plan.
6. Prepare an SBOM capture plan.
7. Prepare a no-protected-assets test dataset.
8. Prepare one internally generated or owned Furniture/Props test image.

## Recommended SAM-2 Scope

Recommended next phase:

```text
SAM-2 Cloud Worker Environment Spike
```

SAM-2 should:

- remain isolated from Viper production
- install SAM 3D Objects only after license/access acceptance
- use a disposable Linux GPU worker
- use one approved Furniture/Props test image
- download weights only into the isolated worker environment
- capture full dependency SBOM
- record model size, disk size, VRAM peak, runtime, output size, and failure modes
- create no Viper Product Library records
- create no worker dispatcher integration
- touch no protected assets
- use no weapon/combat/avatar/human inputs

SAM-2 success condition:

```text
Viper knows whether SAM 3D Objects can run reliably and affordably in an isolated cloud worker before any Forge integration code is written.
```

## Final Recommendation

Move forward, but keep the gate narrow.

SAM 3D Objects should become a Viper Cloud worker capability after legal/access acceptance, not a mobile feature and not an embedded API dependency.

First approved lane:

```text
Furniture/Props
  -> source-rights approved
  -> SAM candidate job
  -> generated candidate
  -> preview
  -> Review Queue
  -> Product Library draft
```

Decision:

```text
GO WITH RESTRICTIONS
```

## Success Condition

Viper now knows that SAM 3D Objects is promising, commercially plausible, and technically practical only under strict controls.

No installation or integration should begin until the SAM License and Hugging Face access terms are formally accepted and recorded.

