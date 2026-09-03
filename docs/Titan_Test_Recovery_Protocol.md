# Titan Test Recovery Protocol

## Core Rule
A failed test is not the end of the task. A failed test is the beginning of the audit. Do not move on until the failure is corrected, proven blocked, or proven to represent a real provider limit.

## Recovery Loop Execution
When any test fails, the orchestrator MUST execute the following loop:
1. **FAIL**: Intercept the failed output (whether SentinelQC rejected, or ComfyUI timed out).
2. **AUDIT**: Inspect dimensions, provenance, and hashes. Ensure inputs actually reached the model.
3. **IDENTIFY ROOT CAUSE**: Classify the failure (Generator, Detector, Image Corruption, Format Mismatch, Resolution, Preprocessing, Workflow, or Provider Limit).
4. **CORRECT ONE CAUSE**: Change exactly one variable in the workflow or pipeline.
5. **RERUN**: Execute the identical test payload with the single changed variable. Use `RERUN_0X` suffix.
6. **COMPARE**: Measure the new output against the failed output.
7. **REPEAT**: Continue until PASS, PROVEN LIMIT, or INFRASTRUCTURE BLOCKER.

## Face-Not-Detected Protocol
If SentinelQC returns `FACE_NOT_DETECTED`:
1. Verify the file opens correctly and dimensions are `512x512`.
2. Inspect orientation (rotate if necessary).
3. Do not equate one detector failure with proof that no face exists (human visual inspection or multi-scale pass required).

## Rerun Policy
- Change exactly one variable.
- Preserve all baseline values (seed, prompt, steps, resolution).
- Retain all previous rerun provenance sidecars and images. Do not overwrite prior results.
