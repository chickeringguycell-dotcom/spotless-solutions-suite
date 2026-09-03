# Shared Agent Knowledge Layer (SAKL) Entries
# Category: 3DGS Training & Sentinel Validation

## LESSON A: Dataset Integrity Validation
Dataset integrity must be validated before GPU training. A corrupted or featureless dataset will cause catastrophic reconstruction failure (e.g., PSNR < 15, runaway densification) and waste thousands of GPU iterations. Always enforce a Sanity Gate to check image variance and foreground coverage before training.

## LESSON B: Gaussian Count != Quality
High Gaussian count does not imply high reconstruction quality. An explosion in Gaussians (e.g., > 3 million for a simple asset) without corresponding validation improvement is a symptom of optimization failure, not detail recovery. 

## LESSON C: Adaptive Densification Risk
Adaptive densification can amplify failure when visual evidence is weak. If the 2D projected gradient is artificially high due to ambiguity or featureless regions, the densifier will continually split/clone Gaussians, attempting to resolve an unsolvable ambiguity.

## LESSON D: SfM is Not Required for Known Cameras
Known-camera synthetic 3DGS does not require Structure-from-Motion (SfM). If camera poses (`c2w`/`w2c`) are explicitly provided via the synthetic renderer, triangulation failures are impossible. Any failure is strictly a photometric optimization failure.

## LESSON E: Geometric Shading != Baked Textures
Neutral geometric shading is different from baking lighting into textures. If materials are stripped for a Geometry-Control exam, the renderer must still provide neutral scene illumination to create gradients that expose the form. Lighting remains a rendering condition, not a material albedo property.

## LESSON F: Control Experiments
A control experiment that removes the target challenge cannot pass the target curriculum level. For example, rendering a flat gray portal cannot be used to pass a "Material / Visibility Torture" exam.
