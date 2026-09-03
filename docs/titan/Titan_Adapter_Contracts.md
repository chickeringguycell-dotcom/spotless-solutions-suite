# Titan Adapter Contracts

## Phase 5 — Titan Adapter Contract
To ensure Viper Studios does not depend directly on any single repository's internal format, we have defined normalized schemas under `services/project-titan-3d/contracts/titan_adapters.py`.

### Required Normalized Outputs Supported
- **2D facial landmarks**: `TitanLandmarks.points_2d`
- **Identity embedding**: `np.ndarray` (Fixed dim vector)
- **3D vertices & Faces**: `TitanFaceGeometry`
- **Camera intrinsics & extrinsics**: `CameraExtrinsics`, `CameraIntrinsics`
- **UV coordinates & position map**: Included in `TitanFaceGeometry` and `TitanIdentityPackage`
- **Visibility & Inferred mask**: `visibility_mask`, `inferred_region_mask`

All schemas enforce the presence of `provenance` and `confidence` strings/arrays.

## Phase 6 — Original Viper Integration Code
Original connective tissue routing has been designed around the `TitanIdentityPackage`. The `Cross-view identity coordinator` uses this package to determine the `Observed-versus-inferred classifier` outputs and generates the `Source-protected region manager` maps.
