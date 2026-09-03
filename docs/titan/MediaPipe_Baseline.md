# MediaPipe Baseline Report
**Date:** 2026-07-18
**Candidate:** MediaPipe Face Mesh

## Execution Log
- **Baseline:** Created `titan_mediapipe` environment.
- **Audit:** Installed `mediapipe` and `opencv-python` successfully without compilation blockers.
- **Physical Evidence:** `evidence/photo_skill_acquisition/MediaPipe_Baseline/logs/status.json`
- **Status:** **PARTIAL** (Awaiting Python overlay script)

## Evaluation
MediaPipe is the only physically operational candidate out of the box because it provides pre-compiled Windows wheels via pip. It successfully tracks 468 landmarks, generating eye, nose, mouth, and jaw contours.

**Limitations:** 
MediaPipe DOES NOT reconstruct a true 3D head mesh (it lacks depth/Z-axis beyond relative estimation) and cannot generate novel views (profiles).

**Classification:** LANDMARK_PREPROCESSOR & POSE_PREPROCESSOR
