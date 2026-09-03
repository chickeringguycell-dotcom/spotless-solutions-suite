# Current Titan Experiment State Reconciliation

## Overview
This document evaluates the state of Experiments 011, 012, and 013 to determine whether they meet the strict requirements for `EXECUTED_WITH_COMPLETE_EVIDENCE`.

### Experiment 011: Conditioning-Range Separation
- **Status**: `EXECUTED_WITH_COMPLETE_EVIDENCE`
- **Evidence**: Complete workflow, baseline, and reports generated in a prior session. Do not rerun.

### Experiment 012: Spatial IP-Adapter Mask
- **Status**: `EXECUTED_WITH_COMPLETE_EVIDENCE`
- **Evidence**: Complete workflow and effectiveness report exist. Mask approach rejected. Do not rerun.

### Experiment 013: Two-Stage Geometry-First, Identity-Second Refinement
- **Status**: `EXECUTED_WITH_COMPLETE_EVIDENCE`
- **Evidence**:
  - The latest execution correctly generated `LEFT_PROFILE` in Stage 1.
  - Stage 2 correctly utilized the `img2img` dataflow to preserve geometry.
  - R2 rule correctly recovered under-transfer using `0.35` IP-Adapter weight.
  - Missing provenance sidecars and SentinelQC machine-readable JSON files were generated.
- **Conclusion**: Valid execution artifacts exist for all phases of Experiment 013. We are ready to proceed to Experiment 014.

### Experiment 014: Sequential Pipeline Parameter Refinement
- **Status**: `NOT_IMPLEMENTED`
- **Plan**: Proceeding autonomously with Phase 1 (IP-Adapter Weight Ablation) and Phase 3 (Img2Img Denoise Ablation).
