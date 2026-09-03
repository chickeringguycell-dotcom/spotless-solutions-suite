# Identity Control Calibration Plan

## Phase 6 — Identity Baseline

### Positive Controls
1. **Source Image vs Same-Person Image**: Will compute embedding cosine similarity between the GB001 source portrait and a known alternate photograph of the same subject (e.g., Gemini target). This establishes the "Same-person score range".
2. **Approved Gemini Profile vs Source**: Establishes the expected identity preservation degradation when shifting from frontal to profile view.

### Negative Controls
1. **Source Image vs Different Identities**: Will compute similarity against standard distractor faces to establish the "Different-person score range".

### Evaluation Methodology
- **Metric**: Cosine similarity using a standardized identity encoder (e.g., ArcFace).
- **Threshold**: No arbitrary threshold will be used. Success is defined visually by Guy's acceptance and quantitatively by falling within the calibrated "Same-person score range" without overlapping the "Different-person score range".
- **Disclaimer**: If InsightFace/ArcFace is used for this calibration, it is marked purely as a non-commercial `RESEARCH_REFERENCE` tool.
