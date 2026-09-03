# Titan Rerun Priority List

According to the new Permanent Test-Failure Recovery Protocol, unresolved failures are prioritized based on specific conditions (no face detected, control not applied, etc.).

## 1. Priority 1: Experiment 003 (Dual-Conditioning)
- **Reason for Priority**: "Tests where no face was detected" (Priority 1) & "Tests where control geometry was not actually applied" (Priority 2).
- **Target Correction**: Use `CANNY_PROFILE` geometry instead of white dots.
- **Status**: Ready for rerun, but currently blocked by AppLocker blocking scipy DLL.

## 2. Priority 2: Experiment 002 (ControlNet Only)
- **Reason for Priority**: "Tests where control geometry was not actually applied" (Priority 2).
- **Target Correction**: Use `CANNY_PROFILE` geometry.
- **Status**: Ready for rerun, but currently blocked by AppLocker blocking scipy DLL.

## 3. Priority 3: Experiment 001 (Text Only)
- **Reason for Priority**: "Tests where SentinelQC used incompatible view measurements" (Priority 4).
- **Target Correction**: Rerun with the new View-Aware SentinelQC to get a valid numerical baseline without the fabricated `-1` error.
- **Status**: Ready for rerun, but currently blocked by AppLocker blocking scipy DLL (even Text-only requires the provider to be online to generate the new baseline image).
