# Titan Unresolved Failures

## Current Active Failures (Awaiting Recovery Loop)

1. **Experiment 001**: Failed Identity Constraints (Eye-spacing failure on Left Profile).
   - **Blocker**: Awaiting ComfyUI infrastructure repair to generate a new baseline with View-Aware rules.
2. **Experiment 002**: Failed Face Detection.
   - **Blocker**: Awaiting ComfyUI infrastructure repair to test the new `CANNY_PROFILE` ControlNet format.
3. **Experiment 003**: Failed Face Detection (Dual-Conditioning collision).
   - **Blocker**: Awaiting ComfyUI infrastructure repair to test `CANNY_PROFILE` + IP-Adapter simultaneously.
4. **Experiment 005**: Infrastructure Boot Failure.
   - **Blocker**: Windows Application Control blocking scipy DLL. Requires user action.
