# Titan Composite Architecture Decision

**Decision:** PROVISIONAL COMPOSITE SOLUTION (Category B)

Based on forensic audits of the available open-source landscape, no single existing project provides a complete, commercially licensed solution for generating GB001 outputs.

**Provisional Component Architecture:**
1. **Face Detection:** MediaPipe Face Mesh
2. **Metric 3D Extraction:** MICA / Deep3DFaceRecon
3. **Commercially Clean Identity Encoder:** Facenet-PyTorch / OpenFace
4. **Novel View Synthesis:** SyncDreamer / SV3D
5. **UV Extraction:** Deep3DFaceRecon / DECA
6. **Validation:** SentinelQC (Scikit-Image SSIM + Face-Alignment 3D Reprojection)

*This architecture remains provisional until each component is successfully executed against GB001 in an isolated test environment.*
