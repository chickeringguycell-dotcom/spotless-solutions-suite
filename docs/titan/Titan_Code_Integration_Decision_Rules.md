# Titan Code Integration Decision Rules

**Phase 10: Permanent Documentation**

The following formal rules dictate how Viper Studios integrates external 3D and machine-learning code for Project Titan, overriding any previous assumption that all open-source code requires clean-room reimplementation.

### 1. The Code vs. Weights Decoupling Rule
Viper Studios treats an open-source neural network as two legally distinct entities:
* **The Architecture (Source Code):** e.g., The PyTorch definitions for a ResNet encoder or a Tri-Grid volume.
* **The Brain (Pretrained Weights):** The `.pt`, `.pkl`, or `.pth` files resulting from a dataset.

**Rule:** If the Architecture is licensed under a commercially permissive license (MIT, Apache 2.0, BSD), it may be directly integrated into the Viper Studios `local-compute-node` or `Headquarters` pipeline. 

### 2. The Tainted Data Rule
**Rule:** If the Pretrained Weights were generated using a dataset containing non-commercial academic restrictions (e.g., FFHQ, 300W-LP, VGGFace2, MS1M, FLAME), those weights are legally contaminated and MUST NOT be used for commercial production. 
* They may be used in `local-compute-node` strictly for `RESEARCH_ONLY` to verify the architecture works.
* For production, the architecture must be retrained using Viper Studios' proprietary or commercially licensed data.

### 3. The Academic Firewall Rule (Rule 33 Extension)
**Rule:** If a candidate requires manual academic account creation, explicit email approval, or institutional credentials to download its weights or topology files (e.g., the MPI FLAME model used by DECA/MICA), autonomous agents are **PROHIBITED** from attempting to bypass this firewall. The candidate immediately fails autonomous integration and must be logged for manual human review.

### 4. The Dependency Toxicity Rule
**Rule:** An MIT-licensed tool (e.g., PanoHead) that strictly requires a non-commercial third-party tool (e.g., 3DDFA_V2) in its critical path (e.g., data preprocessing and camera alignment) inherits the restrictions of that third-party tool. If the dependency cannot be replaced by a commercial equivalent, the entire pipeline is marked for `CLEAN_ROOM_REIMPLEMENTATION`.
