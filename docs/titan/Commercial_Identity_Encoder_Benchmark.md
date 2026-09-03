# Commercial Identity Encoder Benchmark

## Phase 2 — Isolated Encoder Bake-Off

**Status**: `UNCALIBRATED` (Awaiting execution of isolated environments).

### Evaluation Criteria
The top legally cleared candidates will be installed in isolated test harnesses and evaluated on:
- Same-person similarity across frontal, three-quarter, and profile views.
- Different-person separation (Cosine distance between different identities).
- Robustness to lighting, expression, crops, and occlusion.
- System metrics: Runtime, VRAM usage, CPU fallback capability, ONNX consistency.

### Evaluation Data
- Private `GB001` portraits are **STRICTLY PROHIBITED** during this phase.
- Only public-domain images, explicitly licensed evaluation faces, and synthetic identities will be used.

### Phase 2 Execution Result
**Status**: `NOT EXECUTED / BLOCKED`

According to the Phase 1 License-First Encoder Gate rule: *"Only candidates with verified legally usable code and weights may enter execution."* 

Because AuraFace, GhostFaceNet, and AdaFace all carry `LICENSE_REVIEW_REQUIRED` classifications due to unverified training data provenance (e.g., potential reliance on restricted datasets like MS-Celeb-1M), **there are currently zero verified legally usable face encoders available for the bake-off**.

**Conclusion**: `NEW_ENCODER_TRAINING_REQUIRED`
Viper Studios must either acquire a mathematically verified, commercially clean dataset to train a new encoder from scratch, or purchase commercial rights to an existing proprietary encoder. The bake-off cannot proceed with tainted weights.
- Best overall legal encoder
- Best profile-robust encoder
- Best low-memory encoder
- Best Windows deployment candidate
