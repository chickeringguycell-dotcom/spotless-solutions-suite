# Proven Missing Component Ledger

## F004 Updates
- **Silhouette ControlNet for SD1.5**: Proved entirely unavailable in the `lllyasviel/ControlNet-v1-1` ecosystem. The ecosystem includes Canny, Depth, NormalBAE, OpenPose, MLSD, Lineart, SoftEdge, Scribble, Seg, Shuffle, Tile, Inpaint, and IP2P. There is no supported strict volumetric silhouette model. Therefore, Phase 4 F004-D was definitively aborted.
- **Micro-Identity Adapter**: IP-Adapter provides general visual similarity (skin tone, eye color, hair tone, general face shape) but it does not mathematically encode facial geometry landmarks like a dedicated FaceID network (e.g. ArcFace-conditioned models). Thus, exact canonical micro-identity parity remains unverified pending human aesthetic review.
