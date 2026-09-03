# GB001 Benchmark Protocol

**Purpose:** Ensure strict, repeatable, unbiased testing of Titan candidate systems using the private GB001 golden benchmark images.

## Phase 10: GB001 Execution Protocol
When the GB001 files are provided, every operational candidate must be tested under identical conditions:
1. **Single Source Rule**: Candidates may only receive `GB001_SOURCE_FRONT.jpg`. If a candidate requires multiple views, it fails the baseline requirement.
2. **Neutral Background Specification**: All generated outputs must utilize a neutral background to prevent composition bias.
3. **Execution Count**: At least three runs per requested view.
4. **Data Preservation**: Preserve best, median, and worst outputs. No manual retouching. Preserve all seeds, prompts, and runtimes.

## Phase 11: Measurement Protocol
Measurement must utilize positive and negative identity controls.
No arbitrary thresholds. Classify results using:
`VERIFIED`, `SUPPORTED`, `PARTIAL`, `FAIL`, `PROVISIONAL`, `UNCALIBRATED`, `SOURCE_EVIDENCE_INSUFFICIENT`.

**Metrics to capture:**
- Requested-view compliance
- Source-to-output identity similarity
- Cross-view identity similarity
- Anatomical plausibility
- Peak VRAM / Runtime

## Phase 14: SentinelQC Design
SentinelQC validates identity parity. ArcFace cosine similarity is insufficient alone.
The SentinelQC validation pipeline must include:
1. **Embedding Similarity**: Dlib / FaceNet cosine similarity.
2. **Geometric Reprojection**: Dense 3D landmark extraction on output, compared to expected rotated source landmarks.
3. **Semantic Consistency**: Skin color, hairline, and ear shape pixel-distribution checks.
4. **Guy's Visual Approval**: The final, overriding gate.
