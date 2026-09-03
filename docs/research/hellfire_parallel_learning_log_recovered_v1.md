# RECOVERED FRAGMENTS FROM TRANSCRIPT

### 4. Sentinel Theory Improvement
- **Detecting Floaters/Ghost Gaussians**: Floaters are low-opacity or small Gaussians floating in empty space, usually created to satisfy complex view-dependent specular highlights that SH cannot represent. To detect them programmatically:
  - Metric 1: **Volume Sparsity Ratio**: Calculate the bounding box of the top 95% of opaque Gaussians. Count the number of low-opacity (`< 0.15`) Gaussians scattered outside the core density cluster.
  - Metric 2: **Holdout Alpha Deviation**: Render the alpha mask of the object from a novel view. Compare against the ground truth silhouette mask using IoU. Floaters will lower the IoU significantly.
- **Detecting Blurry Thin Geometry**:
  - Metric: **High-Frequency Energy Loss**: Use a Laplacian variance filter or FFT on the rendered holdout images vs ground truth. A significant drop in high-frequency energy indicates that `gsplat` failed to densify sufficiently around thin structures and fell back to large, blurry "blob" Gaussians.

### 5. Level 8 Prep: Universal 3D Asset Contract
- **Curriculum Requirement**: Level 8 requires using Gaussian evidence to manufacture a clean polygon part that passes Universal Asset Contract checks.
- **Contract Definition (Rule 37)**: The contract mandates:
  1. Real-world dimensions (scale accuracy).
  2. Silhouette accuracy (matching reference).
  3. Topological quality (0 non-manifold edges, 0 duplicate vertices, correct normals).
  4. UV layout overlap (0% overlap).
  5. PBR completeness.
  6. Collision and export validity.
- **SentinelQC Execution**: Sentinel evaluates these via `validationMetrics` (seen in `helios_benchmark_library.json`). To pass Level 8, Helios cannot just export a raw Gaussian point cloud or a marching-cubes blob. It must retopologize or fit a clean modular mesh (like the 12-triangle crate) and use the Gaussian model purely as visual/depth ground-truth to project textures and validate silhouettes.

---

## 2026-08-15: Parallel Learning Session 2
**ACTIVE TASK**: `task-19766` (Level 4 Landing Ski Mechanical Training)
**PARALLEL SUBJECT STUDIED**: Camera Coverage Minimum Viability (Level 5 Prep) & Gaussian-to-Mesh Extraction.

### 1. Level 5 Prep: Camera Coverage School
- **Curriculum Requirement**: Systematically vary camera coverage to determine the minimum viable dataset for acceptable 3DGS reconstruction.
- **Experimental Design**: The `viper_3dgs_dataset_generator.py` uses Fibonaccci spherical distribution for views. I will generate synthetic datasets for a chosen canonical asset (e.g., the `landing_ski_raw.glb` or `engine_raw.glb`) at varying view counts: `72`, `36`, `18`, and `9`. 
- **Goal**: Find the exact view count where Holdout PSNR drops below acceptable limits (the "Coverage Cliff"). This will inform the minimum number of multi-view photos the Creator must take for Real Photograph workflows.

### 2. Gaussian-to-Mesh Conversion Theory
- **The Problem**: Raw Gaussians are point clouds. Level 8 requires a solid polygon mesh.
- **Standard Methods**:
  - **TSDF Fusion / Marching Cubes**: Renders depth maps from the trained Gaussians across a dense spherical camera array, then fuses the depth into a Truncated Signed Distance Field (TSDF) voxel grid, and finally extracts a mesh using Marching Cubes. Result: Very high polygon count, often blobby, requires decimation.
  - **SuGaR (Surface-Aligned Gaussian Splatting)**: Adds a regularization term during 3DGS training that forces the Gaussians to align flat against the underlying surface (flattening their Z-scale). This allows direct, high-quality mesh extraction by binding vertices to the flattened Gaussians.
- **Viper Studios Architecture**: As per Rule 44 (Universal Representation Architecture), a Gaussian Model `!=` Polygon Mesh. 3DGS should be used as a *guide*. Instead of relying on messy TSDF extraction, the optimal strategy for Viper Studios is to fit modular procedural primitive meshes (cylinders, cubes) to the bounding/density areas of the trained Gaussians, effectively tracing a clean low-poly mesh over the highly detailed 3DGS reference.
