# Titan Component Decision

## Phase 10 — Architectural Decision
**Classification**: `USEFUL_COMPONENT_SOURCE` / `TRAINING_BLUEPRINT`

**Decision**: **E. Use Pippo only as a research blueprint.**
*Evidence*: 
1. The official release explicitly contains no pretrained weights, meaning it cannot be integrated natively as a working model (rules out A).
2. The source code is licensed under `CC BY-NC 4.0`, forbidding direct reuse in a commercial product like Titan (rules out B).
3. Independent implementation (C) of the Plücker ray camera conditioning and Attention Biasing is the only legally viable path for Titan to achieve multi-view consistency. 
4. Training a custom DiT from scratch (D) is highly unfeasible due to extreme compute/dataset requirements.

## Phase 11 — Update Titan Component Map
**Current Provisional Architecture**:
1. **3DDFA_V2**
   - Role: Geometry, Pose, Dense correspondence, Camera evidence.
   - Status: VERIFIED but blocked pending commercial replacement for BFM.

2. **Pippo**
   - Role: Research blueprint for multi-view generation.
   - Status: CODE_ONLY / NON_COMMERCIAL. Will not be integrated.

3. **Arc2Face**
   - Role: Identity Generator (Photorealistic identity preservation).
   - Status: `LICENSE_BLOCKED`. The reliance on `antelopev2` and WebFace42M strictly prohibits commercial integration without extensive retraining using an alternative like AuraFace.

4. **PhotoMaker V2**
   - Role: Identity Generator (Stacked identity embeddings).
   - Status: `COMMERCIAL_USE_POSSIBLE_WITH_REPLACEMENT_IDENTITY_ENCODER_AND_RETRAINING`. The official stack is blocked by InsightFace.

5. **PuLID**
   - Role: Identity Generator (Contrastive Alignment).
   - Status: `RESEARCH_BLUEPRINT`. The official stack is blocked by InsightFace. Retraining the contrastive adapter on AuraFace is the most promising path forward.

6. **Commercial Identity Encoder**
   - Candidate: **AuraFace** (NOT YET PROVEN)
   - Official code license: REQUIRES VERIFICATION
   - Released-weight license: REQUIRES VERIFICATION
   - Training-data implications: REQUIRES VERIFICATION
   - Embedding quality across profile views: UNVERIFIED
   - Compatibility with Titan diffusion conditioning: UNVERIFIED

**Titan Identity-Engine Decision**:
**NEW_COMMERCIAL_IDENTITY_ENCODER_PATH_PROVISIONAL**

The datasets audited so far did not establish a fully verified commercial training path. The search remains incomplete until each candidate’s official terms are documented.

Titan must evaluate **AuraFace** (or another commercial equivalent) or train an original encoder from scratch. We must build a custom projection adapter (e.g., training our own IP-Adapter or PuLID adapter) to map its embeddings into the diffusion conditioning space. Direct substitution is not expected to work without an adapter because downstream identity-conditioning layers were trained for a different embedding space. Compatibility must be measured.

### Current Status
- Titan encoder architecture: MECHANICAL_TRAINING_PATH_VERIFIED
- Viper Synthetic Identity Dataset V0: SPECIFICATION_ONLY
- Encoder identity learning: NOT VERIFIED
- Encoder Stage B: NOT EXECUTED
- Encoder Stage C: NOT EXECUTED
- Real-photograph generalization: UNVERIFIED
- Identity Adapter training: BLOCKED
- Gemini parity: BLOCKED
- Production-scale requirements: UNKNOWN
- Dataset Generation: HARDWARE BLOCKED (Blender not installed locally)
- Identity improvement: UNVERIFIED
- Production-scale estimates: PROVISIONAL
- GB001 parity: BLOCKED_MISSING_TARGET_IMAGES

**Recommended Next Candidate / Next Titan Command**:
Execute the minimum training feasibility campaign to determine if a commercial embedding can successfully condition the diffusion model.
