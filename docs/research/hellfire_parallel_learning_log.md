# Hellfire Parallel Learning Log

## ENTRY 001: GAUSSIAN-TO-MESH RESEARCH

**ACTIVE BACKGROUND TASK:** 
Dataset Recovery Daemon (`autonomous_dataset_recovery.py`) is attempting resilient resumable downloads of external benchmarks.

**PARALLEL WORK COMPLETED:**
Research into 3DGS-to-Mesh extraction methods.

**NEW LESSON:**
Extracting meshes from 3D Gaussian Splatting (3DGS) requires translating an unstructured point-cloud-like representation of continuous density into discrete polygon surfaces. We analyzed TSDF Fusion, Poisson Surface Reconstruction, Marching Cubes, and SuGaR.

**IMPACT ON HELLFIRE:**
Hellfire must not treat 3DGS output as a drop-in game-ready mesh. For Viper Studios' Universal Asset Contract (UAC), we will likely need a hybrid pipeline: 3DGS for appearance/novel view, followed by depth-map extraction and TSDF/Poisson for the base proxy mesh, and then procedural retopology.

**FOLLOW-UP EXPERIMENT:**
Once a real dataset is verified (e.g., OmniObject3D), train a standard 3DGS model, extract depth from holdout cameras, and run TSDF Fusion. Compare the result to the ground-truth mesh.

**CONFIDENCE:**
HIGH.

---

## ENTRY 002: SENTINEL IMPROVEMENTS FOR ROUND 2

**ACTIVE BACKGROUND TASK:** 
Dataset Recovery Daemon (`autonomous_dataset_recovery.py`) is attempting resilient resumable downloads of external benchmarks.

**PARALLEL WORK COMPLETED:**
Research into advanced physical evaluation metrics for 3D generation.

**NEW LESSON:**
PSNR and SSIM are insufficient because they only measure 2D novel-view synthesis quality. A model can achieve high PSNR while having terrible internal geometry (floaters, cameras embedded in walls).
We must implement:
1. **Silhouette IoU:** Project the Gaussians to a 2D mask from a holdout view and compare intersection-over-union with the ground truth mask. This penalizes background floaters.
2. **Depth Comparison:** Render depth from the trained model and compare it pixel-by-pixel with the ground truth depth map. This ensures the Gaussians are physically located at the surface, not creating a fake "painted" backdrop.
3. **Runaway Densification Detection:** Track the number of Gaussians per unit volume over training steps. If density explodes without a corresponding increase in PSNR/SSIM gradient, Sentinel must flag a collapse.

**IMPACT ON HELLFIRE:**
Round 2 Sentinel will require ground-truth masks and depth maps, not just RGB images. We must configure the dataset adapters to withhold these modalities from the student model so Sentinel can use them as the hidden answer key.

**FOLLOW-UP EXPERIMENT:**
Draft the `DatasetAdapter` interface to explicitly separate `student_inputs` from `sentinel_keys`. 

**CONFIDENCE:**
HIGH.
