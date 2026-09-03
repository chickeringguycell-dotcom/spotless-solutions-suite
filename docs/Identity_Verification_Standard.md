# Identity Verification Standard

## Mission
SentinelQC is not merely inspecting appearance. SentinelQC is proving whether the manufactured result remains the **same person** represented by the approved Identity Specification Package.

## The Tri-Agent Review System
- **Aria** performs visual and perceptual identity review. (Does this *feel* like the person?)
- **Gaius** performs structural and proportional review. (Does this *look* structurally accurate?)
- **SentinelQC** performs machine-measured verification. (Does the math explicitly match?)

All three must read the exact same `Identity_Specification_Package.json`. They may not invent or use different identity facts.

## Status Handling
SentinelQC strictly enforces verification based on the origin of the data:
- `MEASURED`: Verified using strict evidence-based tolerance.
- `ESTIMATED`: Verified using wider provisional tolerance and labeled as estimated.
- `INFERRED`: Verified for coherence, but does not claim source accuracy.
- `USER_PROVIDED`: Treated as authoritative unless contradicted by calibrated evidence.
- `MISSING`: Ignored. SentinelQC will not invent a target measurement.
- `OCCLUDED`: Requires additional source evidence or classified as unresolved.
- `NOT_APPLICABLE`: Skipped with documented reason.
- `REJECTED`: Rejected source measurements cannot be used.

## Tolerance Types & Calibration
We do not invent millimeter tolerances for uncalibrated photographs. Absolute millimeters are ONLY checked if the Specification marks `calibrated: true`. All other geometries use:
- `normalized_ratio_tolerance`
- `cielab_delta_e`
- `angular_tolerance`
- `categorical_exact_match`

## Critical Identity Features
A critical feature failure **rejects the candidate** even if the overall average score is high. 
Critical features include: skull silhouette, forehead shape, eyebrow shape, eye position/spacing, nose bridge/width, jaw width, skin undertone, and protected features (scars, moles).

## Protected Feature Verification
Project Titan must preserve misaligned eyes, crooked noses, uneven eyebrows, asymmetric ears, scars, freckles, moles, wrinkles, and birthmarks unless the creator explicitly authorizes modification. **Do not automatically beautify or symmetrize the subject.**

## Closed-Loop Correction
When a rule fails, SentinelQC generates an `Identity_Correction_Package.json` containing:
- Failed rule IDs
- Expected vs Actual values
- Responsible production station
- Regions that MUST remain unchanged
Production must correct only failed regions where practical, leaving approved geometry untouched.

## Final Result Model
Every asset receives an overall classification:
- `VERIFIED IDENTITY MATCH`
- `QUALIFIED IDENTITY MATCH`
- `PARTIAL`
- `REJECTED`
- `BLOCKED`
- `FAILED`
