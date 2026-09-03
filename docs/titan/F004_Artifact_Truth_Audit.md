# F004 Artifact Truth Audit

## Audit of Existing F004 Outputs (Before Rerun)

### 1. Required Prior Initial Outputs
- **F004-A (Canny)**: 18 artifacts
- **F004-B (Depth)**: 18 artifacts
- **F004-C (Normal)**: 18 artifacts
- **F004-D (Silhouette)**: 0 artifacts (MODEL_UNAVAILABLE)

### 2. Required Confirmation Subset
- **Depth seeds 400, 500, 600 across six views**: 18 artifacts

### 3. Extra Exploratory Outputs
- The script generated extra F004-A (Canny) and F004-C (Normal) outputs during confirmation.
- These have been preserved as `EXPLORATORY_EXTRA_OUTPUTS` and are NOT counted as part of the planned best-control confirmation.

### 4. Required Combined Outputs
- **F004-E (Depth + Canny)**: 36 artifacts

## Audit of Rerun Outputs (`GB001_CANONICAL_RERUN`)
- All 108 required rerun images (54 initial, 18 confirmation, 36 combined) have been physically populated.
- 5 high-resolution PNG comparison sheets have been composited and stored in the artifact panel.
