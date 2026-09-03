# F002 Control Validity Audit

## F002 MediaPipe Controls
- **MediaPipe_Left_Profile_Wireframe.png**: SYNTHETIC_PROFILE_PROXY
- **MediaPipe_Right_Profile_Wireframe.png**: SYNTHETIC_PROFILE_PROXY
- **MediaPipe_Left_34_Wireframe.png**: SYNTHETIC_PROFILE_PROXY
- **MediaPipe_Right_34_Wireframe.png**: SYNTHETIC_PROFILE_PROXY
- **MediaPipe_Rear_View_Wireframe.png**: INVALID_CONTROL

**Reasoning:**
MediaPipe contains frontal facial landmarks and relative depth, but no rear skull, scalp, back-of-hair, neck, or rear silhouette. Rotating frontal landmarks 180 degrees creates a reversed frontal graph, not a valid rear-head control. It cannot be used to judge a renderer's ability to create rear views.
