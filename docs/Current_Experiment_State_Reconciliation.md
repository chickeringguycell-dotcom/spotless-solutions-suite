# Current Experiment State Reconciliation

## Overview
This document evaluates the state of Experiments 011, 012, and 013 to determine whether they meet the strict requirements for `EXECUTED_WITH_EVIDENCE`.

### Experiment 011: Conditioning-Range Separation
- **Status**: `EXECUTED_WITH_EVIDENCE`
- **Evidence**:
  - `Experiment_011_Workflow_A.json`
  - `Experiment_011_Workflow_B.json`
  - `Experiment_011_Workflow_C.json`
  - `Experiment_011_Baseline.json`
  - `Experiment_011_Report.md`
  - `Experiment_011_Metric_Comparison.json`
- **Conclusion**: Valid execution artifacts exist. Do not rerun.

### Experiment 012: Spatial IP-Adapter Mask
- **Status**: `EXECUTED_WITH_EVIDENCE`
- **Evidence**:
  - `Experiment_012_Primary_Workflow.json`
  - `Experiment_012_Mask_Effectiveness_Report.md`
  - `Experiment_012_Metric_Comparison.json`
- **Conclusion**: Valid execution artifacts exist. The mask approach was rejected due to latency/boundary issues. Do not rerun.

### Experiment 013: Two-Stage Geometry-First, Identity-Second Refinement
- **Status**: `PARTIAL`
- **Evidence Present**:
  - `Experiment_013_Stage1_Attempt_8_Workflow.json`
  - `Experiment_013_Stage2_Workflow.json`
  - `Experiment_013_Metric_Comparison.json`
- **Evidence Missing**:
  - `Experiment_013_Stage1_Provenance.json`
  - `Experiment_013_Stage1_SentinelQC.json`
  - `Experiment_013_Stage2_Provenance.json`
  - `Experiment_013_Stage2_SentinelQC.json`
- **Conclusion**: While the previous session generated images, it did not satisfy the strict provenance and SentinelQC artifact retention required for a fully verified experiment. It must be rerun with a 10-hour autonomous runner.
