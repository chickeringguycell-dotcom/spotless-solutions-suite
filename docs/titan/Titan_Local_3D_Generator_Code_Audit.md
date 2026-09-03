# Titan Local 3D Generator Code Audit

## 1. TRELLIS / TripoSR / InstantMesh / Stable Fast 3D
* **Repository:** Various local conda environments.
* **Mechanism:** Single-image to 3D generic object generation (NeRF/Gaussian or Triplane to Mesh).
* **Input:** Generic object image.
* **Output:** Generic 3D Mesh.
* **Potential Titan Value:** Very low for single-shot identity preservation. These systems lack a semantic face-prior, meaning they treat a face like any arbitrary object (e.g., a chair or a mug). They do not extract specific facial features (eyes, nose, jaw) structurally and often hallucinate bizarre geometries for the unseen back of the head.
* **Classification:** DOWNSTREAM_ONLY.

## 2. ComfyUI IP-Adapter FaceID
* **Mechanism:** Injects InsightFace embeddings into Stable Diffusion attention layers.
* **Input:** Source portrait.
* **Output:** 2D identity-conditioned generated image.
* **Potential Titan Value:** High for Phase 7 (Conditional Identity Rendering Ablation). Excellent at preserving identity in 2D space, but completely lacks 3D camera control and spatial consistency across rotations (without ControlNet).
* **Classification:** IDENTITY_COMPONENT.

## 3. Existing Titan Profile Experiments (SD 1.5 UV)
* **Mechanism:** Projecting pixels onto a flat UV map using deterministic OpenCV transformations.
* **Input:** Source portrait.
* **Output:** Flattened pixel projection.
* **Potential Titan Value:** Retracted. Deterministic projection cannot hallucinate missing identity features on the side/rear of the head.
* **Classification:** NO_RELEVANT_VALUE for hidden-region completion.
