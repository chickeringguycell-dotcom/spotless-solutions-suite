# F004 Evaluation

## Profile Identity
- **Status**: UNCALIBRATED / HUMAN REVIEW REQUIRED.
- **Findings**: The workflow extracts visual semantics (via IP-Adapter) and locks global structure (via Depth/Canny constraints). While the resulting generation possesses identical scale, general coloring, and lighting, exact micro-identity of the source facial features requires subjective, visual verification. IP-Adapter provides strong visual resemblance but is not a dedicated facial identity model.

## Structural Control
- **Status**: VERIFIED (for camera and silhouette compliance only)
- **Findings**: Absolute geometric limits provided by Depth maps successfully constrain the diffusion bounds. F002’s hallucination of a frontal face on the rear view was caused by a malformed control map consisting of rotated frontal landmarks, not a structural incapacity of the SD1.5 model itself.

## Rear-Head Completion
- **Status**: STRUCTURALLY SUPPORTED / AESTHETIC AND IDENTITY ACCEPTANCE PENDING
- **Findings**: Supplying a solid Depth boundary with a neutral prompt correctly forces the network to draw the back of a head. Face-detector analysis over rear angles indicates no facial landmarks are drawn inside the bounded volume, achieving geometric compliance. However, aesthetic plausibility is pending human acceptance.
