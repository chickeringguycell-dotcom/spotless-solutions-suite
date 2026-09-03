# Titan Failed Test Audit

## Overview
This document audits every failed or blocked Project Titan identity-generation test completed so far, as dictated by the Permanent Test-Failure Recovery Protocol.

## 1. Experiment 001
- **Status**: OPEN
- **Evaluation**: The test was invalid due to incompatible measurement rules. SentinelQC was using a frontal eye-spacing rule on a requested profile image. The provider successfully generated a human face, but the test design forced a failure.
- **Rerun Required**: Yes. Must be rerun with the newly upgraded View-Aware SentinelQC to establish a true baseline.

## 2. Experiment 002
- **Status**: BLOCKED
- **Evaluation**: The test was invalid due to faulty test design. The input `LANDMARK_DEBUG` white-dot image was fundamentally incompatible with `control_v11p_sd15_openpose.pth`. The test was partially diagnosed in Exp 004 and corrected via `CANNY_PROFILE`. 
- **Rerun Required**: Yes. Must be rerun using `CANNY_PROFILE`. Currently blocked by ComfyUI infrastructure missing `comfy_aimdo`.

## 3. Experiment 003
- **Status**: BLOCKED
- **Evaluation**: The test was abandoned too early and partially diagnosed. It was assumed a latent space collision occurred, but Exp 004 proved the ControlNet path was independently broken.
- **Rerun Required**: Yes. Dual-Conditioning must be rerun using `CANNY_PROFILE`. Currently blocked by ComfyUI infrastructure missing `comfy_aimdo`.

## 4. Experiment 004
- **Status**: SUPERSEDED_WITH_EVIDENCE
- **Evaluation**: This was a diagnostic ablation study. It successfully isolated the root cause of Exp 002/003 failures. No rerun required.

## 5. Experiment 005
- **Status**: BLOCKED
- **Evaluation**: The test was blocked by infrastructure. ComfyUI could not be booted due to `ModuleNotFoundError: No module named 'comfy_aimdo'`.
- **Rerun Required**: Yes. Must be rerun once `comfy_aimdo` is restored to the workspace.

## 6. Gemini Provider Attempts
- **Status**: PROVIDER_LIMIT_PROVEN
- **Evaluation**: The API returned 403/429 Quota Exceeded errors. Proven provider limit (billing/tier constraint).
- **Rerun Required**: No, unless the API key quota is upgraded.
