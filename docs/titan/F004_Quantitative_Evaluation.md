# F004 Quantitative Evaluation

## Measurements
- **Requested-view compliance:** Profiles (SUPPORTED), Rear (FAIL - hallucinates faces).
- **Head yaw/pitch compliance:** SUPPORTED (Controls successfully force pose).
- **Source identity similarity:** Profiles (PARTIAL), Rear (FAIL).
- **Cross-seed identity consistency:** FAIL.
- **Cross-view identity consistency:** FAIL.
- **Face hallucination on rear head:** SUPPORTED (Model still hallucinates faces on back of head despite valid rear-head controls).
- **Ear placement / Neck consistency:** SUPPORTED (Follows control).
- **Photorealism:** SUPPORTED.

## Evaluator Metrics
- **Model:** Human Visual Audit
- **Calibration:** UNCALIBRATED (Qualitative verification via comparison sheet).
