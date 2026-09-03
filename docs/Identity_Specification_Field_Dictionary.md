# Identity Specification Field Dictionary

This dictionary defines the canonical JSON fields used in `Identity_Specification_Schema.json`.

## The Status Model
Every geometric measurement, color sample, and protected feature must explicitly declare its mathematical origin using the `status` enum:
- `MEASURED`: Extracted directly from pixel data or source geometry.
- `ESTIMATED`: Algorithmically approximated (e.g., estimating 3D coordinates from a 2D photo).
- `INFERRED`: Best-guess values (e.g., guessing ear shape when hair occludes it).
- `USER_PROVIDED`: Hardcoded truth from the creator.
- `MISSING`: Data cannot be found or guessed.
- `OCCLUDED`: Data exists physically but is blocked (e.g., by hair, glasses, shadow).
- `NOT_APPLICABLE`: Does not apply to this entity.
- `REJECTED`: Fails SentinelQC validation.

## 1. Provenance
- `subject_id`: Unique identifier for the human identity being preserved.
- `protocol_version`: The Viper Studios data protocol (e.g., "1.0.0").
- `missing_data_declarations`: An array of explicit statements indicating what couldn't be extracted.

## 2. Geometric Measurements
- `landmarks`: An array of 468+ MicroDot nodes (MediaPipe format). Includes 2D source coordinates, normalized coordinates (0.0-1.0), and estimated 3D depth maps.
- `inter_landmark_distances`: Measurements (like eye spacing, nose width) wrapped in the measurement object.
- `ratios`: Mathematical relationships (e.g., eye-spacing-to-jaw-width).
- `asymmetry_pairs`: Hardcoded strings for SentinelQC to check (e.g., "Left eyebrow 2mm lower than right").
- **The Measurement Object**:
  - `value`: The numeric value.
  - `unit`: Must be one of: `source_pixels`, `normalized_ratio`, `normalized_coordinates`, `estimated_millimeters`, `calibrated_millimeters`.
  - `calibrated`: Boolean. If true, the millimeter measurement is considered ground-truth reality. If false, millimeters cannot be used.

## 3. Color Samples
- `raw_rgb`: The exact pixel color grabbed from the source coordinate.
- `cielab`: The perceptual color space mapping for accurate skin tone validation.
- `median_color_hex`: The standard display hex for UI rendering (not for final color math).
- `lighting_normalized_status`: Boolean. True if the shadow/highlight bias has been removed.

## 4. Structural Masks
- `file_path` & `hash_sha256`: Points to the generated artifact (e.g., a `.png` of the face silhouette) ensuring it hasn't been altered by another agent.

## 5. Protected Features
- `feature_type`: Scars, freckles, moles, asymmetry.
- `preserve_by_default`: Boolean indicating if this is an intrinsic identity trait (true) or a temporary artifact like a blemish (false).
