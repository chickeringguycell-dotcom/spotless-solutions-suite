# Hi3D / Hi3DGen Architectural Lessons

## Hi3D: Pursuing High-Resolution Image-to-3D Generation with Video Diffusion Models

### 1. Camera-Pose Conditioning
*   **SOURCE IDEA:** Hi3D conditions the Video Diffusion Model (SVD) with explicit camera poses to drive generation rather than relying on unguided stochastic video.
*   **WHY IT WORKS:** It grounds the temporal consistency of video generation into spatial (geometric) consistency.
*   **WHAT PROBLEM IT SOLVES:** Prevents the "Janus problem" (multiple faces) and severe geometric shifting common in pure image-to-3D diffusion.
*   **HOW VIPER STUDIOS CAN USE IT:** When generating or assembling novel views for a specific spacecraft component (e.g., a weapon pod), we must constrain any generative model tightly with exact camera intrinsics/extrinsics matching the ground-truth view bundles.
*   **WHAT WE SHOULD NOT COPY:** The massive monolithic video generation across an entire complex vehicle, which introduces occlusion errors. We apply this constraint *per component*.
*   **DEPENDENCY REQUIREMENTS:** None. We adopt the mathematical constraint strategy, not the ML model.
*   **CONFIDENCE:** 95% (Proven effective in 3D-aware video generation).

### 2. Orbital/Sequential Multi-View Generation & Cross-View Consistency
*   **SOURCE IDEA:** Treat multi-view generation as a continuous orbital video sequence.
*   **WHY IT WORKS:** Video diffusion inherently forces adjacent frames to remain consistent to prevent flicker; leveraging this forces geometric surfaces to remain consistent across viewpoints.
*   **WHAT PROBLEM IT SOLVES:** Independent 2D generations hallucinating contradictory details on different sides of an object.
*   **HOW VIPER STUDIOS CAN USE IT:** If we lack reference for the back of an engine module, any inferred views must be derived sequentially from the known front/side views rather than generated in isolation.
*   **WHAT WE SHOULD NOT COPY:** Blindly trusting the sequential output over ground-truth photography.
*   **DEPENDENCY REQUIREMENTS:** None. Conceptual application.
*   **CONFIDENCE:** 90%

### 3. Novel-View Augmentation via Gaussian Splatting (3DGS)
*   **SOURCE IDEA:** Convert high-resolution orbital images into a 3D Gaussian Splat before extracting the mesh.
*   **WHY IT WORKS:** 3DGS is inherently capable of fusing multi-view pixel data into a coherent volumetric point cloud very rapidly, implicitly resolving minor view inconsistencies.
*   **WHAT PROBLEM IT SOLVES:** Direct meshing from depth maps often leads to tearing. 3DGS creates a continuous, optimizable volume first.
*   **HOW VIPER STUDIOS CAN USE IT:** When a single part has complex topology, converting reference bundle masks/depths to a dense point cloud (or splat) before meshing provides a superior intermediate bridging step.
*   **WHAT WE SHOULD NOT COPY:** Extracting final hard-surface topology directly from 3DGS (it often yields lumpy geometry without heavy retopology).
*   **DEPENDENCY REQUIREMENTS:** None directly for the concept; local point-cloud manipulation if implemented.
*   **CONFIDENCE:** 85%

---

## Hi3DGen: High-fidelity 3D Geometry Generation from Images via Normal Bridging

### 4. Normal Maps as Geometry Evidence
*   **SOURCE IDEA:** Extract or estimate surface normals from the RGB image first, and use those normal maps to bridge the gap to 3D geometry.
*   **WHY IT WORKS:** RGB contains high-frequency shading data that humans interpret as shape, but standard depth/silhouette carving misses entirely. Normals translate shading into mathematical surface direction.
*   **WHAT PROBLEM IT SOLVES:** "Blobby" reconstructions where silhouettes match but interior surface details (panel lines, intake curvature) are completely flat.
*   **HOW VIPER STUDIOS CAN USE IT:** For components like the `intake_bezel` or `canopy`, we can use derivative normals to define curvature and bevels that cannot be seen from the pure orthographic silhouette.
*   **WHAT WE SHOULD NOT COPY:** Treating estimated normals as ground-truth geometry. They are *Derived Geometry Guidance* only.
*   **DEPENDENCY REQUIREMENTS:** Minimal (Sobel/Scharr operators, or lightweight single-image normal estimation pipelines).
*   **CONFIDENCE:** 98% (Industry standard for surface detailing).

### 5. Separating Low-Frequency Form from High-Frequency Detail
*   **SOURCE IDEA:** Construct the base topology (low-frequency form) first, then displace or refine the surface using normal-guided details (high-frequency).
*   **WHY IT WORKS:** It prevents detailed noise from destroying the fundamental structural integrity of the mesh during initial generation.
*   **WHAT PROBLEM IT SOLVES:** Over-constrained optimization where the algorithm destroys a perfect cylindrical shape to satisfy a tiny spec of noise in the reference image.
*   **HOW VIPER STUDIOS CAN USE IT:** Perfectly aligns with the `VIPER STUDIOS WORKFLOW`. We build clean parametric structural modules *first*, then apply normal-guided displacements or refinements as a completely separate step (Phase 4: Hard-Surface Detail).
*   **WHAT WE SHOULD NOT COPY:** N/A. This is a perfect match for our architecture.
*   **DEPENDENCY REQUIREMENTS:** None.
*   **CONFIDENCE:** 100%
