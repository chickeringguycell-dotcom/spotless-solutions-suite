# Region-Locked Identity Correction Standard

## Purpose
This document establishes the architecture for region-locked image correction within Viper Studios (Project Titan). The standard ensures that when SentinelQC detects an identity failure (e.g., incorrect lip color, shifted eye position), the subsequent correction attempt modifies *only* the failed region, preserving all previously approved regions and identity features.

## Core Principles
1. **Never Destroy Approved Work**: A visually improved image that alters approved identity regions is classified as a FAILURE.
2. **Provider Agnostic**: The architecture must remain usable with any provider (Gemini, OpenAI, Qwen, FLUX, Stable Diffusion, or future Titan-native generators) that supports inpainting or latent-masking.
3. **Explicit Boundary Definition**: Every correction request must be accompanied by explicit masks mapping the allowed edit zone and the protected immutable zones.

## The Identity Correction Package
When a failure is detected, Helios generates an `Identity_Correction_Package.json`. This package is the single source of truth for the correction attempt.

### Required Fields
- `correction_id`: Unique identifier for this correction attempt.
- `candidate_asset_id`: The ID of the image that failed.
- `failed_rule_ids`: The specific SentinelQC rules that failed.
- `required_correction`: Human-readable and model-parseable instruction of what to fix.
- `attempt_number`: Tracking for iterative attempts.

### Region Masking
The correction package references explicit masks:
- `failed_region_masks`: Masks highlighting the exact pixels that failed verification.
- `protected_region_masks`: Masks highlighting areas that must not be altered (e.g., background, approved facial features).

## Workflow Execution
1. **Identify Failure**: SentinelQC flags a specific region (e.g., mouth).
2. **Generate Package**: `build_identity_correction_package.py` constructs the correction request and synthesizes the required masks (Failed Region Mask, Protected Region Mask).
3. **Provider Edit**: The package is dispatched to the chosen provider, demanding that edits be constrained to the `failed_region_masks` (or the inverse of the `protected_region_masks`).
4. **Validate Correction**: `validate_region_locked_edit.py` inspects the new candidate image:
   - Evaluates the pixel drift outside the failed region (must be near zero).
   - Re-runs SentinelQC to verify the failed rule now passes.
   - Re-runs SentinelQC to verify no approved rules have regressed.

## Collateral-Drift Verification
The `validate_region_locked_edit.py` script enforces the region-lock by measuring:
1. Improvement inside the failed region.
2. Changes inside the feather boundary (acceptable blending zone).
3. Changes outside the permitted region (must be ~0%).
4. Changes to protected features (must be ~0%).
5. Changes to identity measurements that previously passed (SentinelQC Regression).
