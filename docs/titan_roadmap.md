# Master Roadmap: Project Titan & Viper Studios Architecture

## Phase 1 — Project Titan Identity Survey ⭐ (Completed)
- [x] Implement geometry extraction.
- [x] Implement color sampling.
- [x] Implement feature extraction.
- [x] Generate Confidence maps and Source masks.
- [x] Create `Identity_Specification_Schema.json` contract.

## Phase 2 — Identity Inspection Standard ⭐ (Completed)
- [x] Draft `Identity_Verification_Standard.md`: The rulebook for SentinelQC.
- [x] Create `Identity_Verification_Rules.json`, `Identity_Tolerance_Profiles.json`, `Identity_Critical_Features.json`, `Identity_Failure_Codes.json`, `Identity_Correction_Package_Schema.json`.
- [x] Build `scripts/project_titan_identity_verifier.py` to run the mathematical pass/fail checks (Now **View-Aware** via MediaPipe).
- [x] Build `tests/test_identity_verification.py` to ensure rule adherence and critical feature blocking.

## Phase 3 — Provider Laboratory (Completed)
- [x] **Qwen-Image (7B)**: Extracted Step-Throttling and Multi-Module DiT architecture logic.
- [x] **FLUX.2 Klein (4B)**: Extracted VLM-Driven Semantic Injection logic.
- [x] **Stable Diffusion 3.5 Medium**: Architecture & License Study COMPLETED.

## Phase 4 — Minimum Viable Titan Integration (Completed)
- [x] Station 7A (Conditioning Translation)
- [x] Station 7C (Camera Geometry)
- [x] Station 7D (Provider Execution & Mocks)
- [x] Station 7J (SentinelQC Integration)
- [x] Master Orchestrator E2E Harness
- [x] Phase 1 Post-Implementation Audit

## Phase 5 — Continuous Engineering Improvement (Active)
- [x] Establish `Titan_Engineering_Ideas_Backlog.md`
- [x] Migrate Qwen, FLUX.2, and SD3.5 lessons to Backlog
- [x] Implement Gemini Provider Adapter (Network Layer)
- [x] **BLOCKING ISSUE RESOLVED**: Rewrote `station_7c_camera_geometry.py` to output standard CANNY_PROFILE maps compatible with the installed `control_v11p_sd15_canny.pth`.
- [x] Rerun Dual Conditioning Tuning (Experiment 010)
- [x] Extract Profile Identity into a dedicated Extractor Subsystem.
- [ ] Investigate alternative spatial control for FLUX2 (Canny + IPAdapter latents collide).
- [ ] Research next state-of-the-art Open Source models
- [ ] Accumulate ideas for Phase 2 Milestone Batch

## Phase 6 — Cloud Infrastructure
- [ ] Build Mercury.
- [ ] Build Billing, Projects, and Asset Library.
- [ ] Build Cloud storage, Daily settlement, and Manufacturing ledger.
