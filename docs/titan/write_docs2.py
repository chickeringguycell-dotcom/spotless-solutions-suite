import os

docs_dir = r'C:\Users\U\Documents\antigravity\dazzling-noether\docs\titan'

docs = {}

docs['F001_Training_Data_Rights_Audit.md'] = '''# F001 Training Data Rights Audit

## Sources
1. **Unreal Engine MetaHuman**
   - **Classification:** REJECT / LICENSE_AMBIGUOUS
   - **Details:** Epic Games EULA restricts using MetaHumans to train ML models that generate human assets outside the UE ecosystem. Custom licensing required for commercial weight distribution.

2. **MakeHuman**
   - **Classification:** TRAINING_AND_COMMERCIALIZATION_CONFIRMED
   - **Details:** CC0 output license.

3. **MB-Lab**
   - **Classification:** TRAINING_AND_COMMERCIALIZATION_CONFIRMED
   - **Details:** Blender addon (AGPL), but generated character topology and renders can be used.

4. **Commercially Licensed Scan Datasets (e.g., Triplegangers, Renderpeople)**
   - **Classification:** TRAINING_ALLOWED_WEIGHTS_RESTRICTED (Usually)
   - **Details:** Standard commercial licenses often forbid using the scans to train generative AI that competes with their marketplace. Custom enterprise licensing required.

5. **Public-Domain Human Scans**
   - **Classification:** TRAINING_AND_COMMERCIALIZATION_CONFIRMED

6. **Internally Created Viper Characters**
   - **Classification:** TRAINING_AND_COMMERCIALIZATION_CONFIRMED
'''

docs['F001_Architecture_Decision_Matrix.md'] = '''# F001 Architecture Decision Matrix

## A. Camera-Conditioned ControlNet
- **Identity Preservation:** High (via IP-Adapter)
- **Camera Control:** High (Explicit conditioning)
- **Cross-View Consistency:** Low-Medium (Unless attention mechanisms are altered)
- **Rear-head Generation:** Low (Stable Diffusion 1.5 struggles heavily with rear human heads without massive fine-tuning)
- **Commercial Licensing:** Excellent
- **Expected Quality:** High for front/profiles, poor for rear.

## B. Camera-Token Adapter or LoRA
- **Identity Preservation:** High
- **Camera Control:** Medium
- **Commercial Licensing:** Excellent
- **Risk:** Tokens easily ignored by the base model.

## C. Multi-View Diffusion (e.g., SyncDreamer/MVDream approach)
- **Identity Preservation:** High
- **Cross-View Consistency:** Very High (Outputs are intrinsically linked in attention layers)
- **Compute:** Extremely High
- **Commercial Licensing:** Feasible if built on SD1.5.

## D. 3D-Aware Generator (Triplane/GAN)
- **Identity Preservation:** Very High (if inverted perfectly)
- **Cross-View Consistency:** Perfect (It renders a 3D proxy)
- **Rear-head Generation:** Excellent
- **Commercial Licensing:** Hard (Requires massive dataset for training a foundation Triplane GAN).

## E. Hybrid Titan Pipeline (MediaPipe + IP-Adapter + SentinelQC)
- **Identity Preservation:** High
- **Camera Control:** High (Via MediaPipe ControlNet)
- **Rear-head Generation:** FAIL (MediaPipe cannot provide rear head)
- **Risk:** Lowest, but fails F001 requirement for full head.

**Conclusion:** A Camera-Conditioned ControlNet or Multi-View Diffusion on SD1.5 are the most feasible, but rear-head completion is the primary bottleneck.
'''

docs['F002_No_Training_Baseline.md'] = '''# F002 No-Training Baseline

**Setup:**
- Base: SD 1.5 + IP-Adapter (Standard preset).
- Geometry Control: MediaPipe Left/Right Profile, 3/4, and Rear View Wireframes.
- Conditioning: Source Portrait (GB001).

**Results:**
- **View Compliance:** Left/Right Profile and 3/4 are PARTIAL to SUPPORTED. Rear view is FAIL (Model hallucinates a face on the back of the head or ignores the control entirely).
- **Identity Consistency:** Profiles maintain some identity, but degrade significantly at 3/4 and rear views.
- **Cross-View Consistency:** FAIL (Different hair, clothing details, and facial structures across views).
- **Conclusion:** F002 establishes that without training, SD1.5 + IP-Adapter cannot perform full-head (especially rear-head) generation even when forced by MediaPipe geometry.
'''

docs['F001_Titan_Owned_Training_Program.md'] = '''# F001 Titan-Owned Training Program

## Plan Summary
- **Decision:** TITAN-OWNED TRAINING REQUIRED.
- **Selected Architecture:** Camera-Conditioned ControlNet on SD1.5 + IP-Adapter.
- **Justification:** Zero commercially viable models exist for full-head reconstruction. SD1.5 is legally reusable. We must train a ControlNet specifically on human heads spanning 360 degrees to force the base model to output rear/side views correctly while maintaining the IP-Adapter identity.
- **Dataset Source:** MakeHuman + Custom procedural variations rendered in Blender (CC0/Fully owned).
- **Required Identity Count:** 10,000 synthetic identities.
- **Views per identity:** 24 (Every 15 degrees).
- **GPU Requirement:** 1x A100 (Local Smoke Training), 8x A100 (Cloud).
- **Estimated Cost:** ,000 - ,000 for cloud compute.

*(Note: No training is authorized yet.)*
'''

for k, v in docs.items():
    with open(os.path.join(docs_dir, k), 'w') as f:
        f.write(v)

print("Created all Phase docs.")
