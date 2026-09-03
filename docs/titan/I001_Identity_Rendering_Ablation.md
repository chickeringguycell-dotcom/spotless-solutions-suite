# Experiment I001: Identity Rendering Ablation
**Status:** COMPLETE
**Date:** July 18, 2026

## Objective
To determine whether PRNet geometry (specifically the 3D rendered left profile) improves Titan's ability to generate the Gemini-style identity-preserving profile compared to a baseline SD1.5 + IP-Adapter setup.

## Procedure
1. **BASELINE:** Generated 3 images (seeds 100, 200, 300) using SD 1.5, IP-Adapter, and the text prompt for a left-facing profile portrait, conditioned on the source portrait.
2. **CORRECTION:** Generated 3 images (same seeds) using the same pipeline, but added ControlNet (Canny edge detector) conditioned on the PRNet_Left_profile.png geometry.

## Results
- **BASELINE:** Failed to generate a consistent left-facing profile. The IP-Adapter forced the face to look forward, resulting in severe anatomical distortion, double faces, or melted features when conflicting with the text prompt.
- **CORRECTION:** Successfully forced the geometry into a perfect left-facing profile using the PRNet geometry constraints via ControlNet. The IP-Adapter was then able to map the identity onto this constrained geometry, preserving the source subject's identity much more effectively than the baseline.

## Conclusion
PRNet geometry provides a measurable and critical improvement to the rendering pipeline. It acts as the foundational structural anchor that prevents IP-Adapter from collapsing the geometry into a front-facing perspective, successfully achieving the Gemini-style profile.
