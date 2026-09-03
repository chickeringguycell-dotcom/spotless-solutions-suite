# Titan Provider Interfaces

**Phase 4: Titan Component Interfaces**

To ensure Project Titan remains independent from specific implementations (e.g., PRNet, FaceNet) until they clear licensing and benchmark gates, the following provider-independent interfaces are defined based on the useful capabilities actually demonstrated during the GB001 audit.

These abstract definitions decouple the Headquarters architecture from any underlying research or commercial engine.

---

## 1. FaceGeometryProvider
Responsible for extracting a 3D polygonal mesh mask from a frontal photograph.

* **Input Schema:** `(image_path: str, bounds_box: tuple) -> Image`
* **Output Schema:** `(vertices: Array[N, 3], triangles: Array[M, 3], metadata: dict) -> MeshObject`
* **Confidence Metric:** Mesh coverage percentage (e.g., excludes ears/hair).
* **Evidence Classification:** `VERIFIED` via PRNet.
* **Failure Modes:** Fails on extreme pitch/yaw, fails on heavy occlusion, fails to reconstruct volume beyond the frontal mask.
* **Provenance Requirements:** Must tag the generated mesh with the provider ID and license status.
* **SentinelQC Use:** Passed to topology-checker to verify non-manifold geometry.
* **Commercial Requirements:** Clean-room implementation of 3DMM regression or a licensed provider API.

## 2. UVPositionMapProvider
Responsible for mapping 2D pixels directly to a dense 3D UV space to generate an unwarped facial texture.

* **Input Schema:** `(image_path: str) -> Image`
* **Output Schema:** `(uv_position_map: Array[256, 256, 3], unwarped_texture: Image) -> TextureArtifact`
* **Confidence Metric:** Pixel-wise mapping error/confidence map.
* **Evidence Classification:** `VERIFIED` via PRNet.
* **Failure Modes:** Texture stretching at the extreme edges (cheeks/jawline); cannot unwarp occluded regions (back of head).
* **Provenance Requirements:** Embedded EXIF tag citing the generating model.
* **SentinelQC Use:** Used to build the foundational skin-texture prior for the UV-style asset.
* **Commercial Requirements:** Clean-room training of a Position Map Regression Network on a commercial 3D dataset.

## 3. IdentityEmbeddingProvider
Responsible for extracting a mathematical vector embedding that uniquely identifies the human subject.

* **Input Schema:** `(image_path: str, face_bounds: tuple) -> Image`
* **Output Schema:** `(embedding_vector: Array[512, Float]) -> IdentityVector`
* **Confidence Metric:** Feature extraction certainty.
* **Evidence Classification:** `CALIBRATED` via FaceNet InceptionResnetV1.
* **Failure Modes:** Fails completely on wireframes, stylized textures, or non-photorealistic topologies.
* **Provenance Requirements:** Must log the model dataset origin (e.g., MS1M, VGGFace2).
* **SentinelQC Use:** Core input for the `CrossViewIdentityValidator`.
* **Commercial Requirements:** Requires a commercial cloud API (e.g., AWS Rekognition) or an embedding model trained strictly on licensed stock datasets.

## 4. CrossViewIdentityValidator
Responsible for mathematically verifying that a synthesized novel-view (e.g., profile) preserves the exact identity of the source portrait.

* **Input Schema:** `(source_vector: IdentityVector, target_vector: IdentityVector)`
* **Output Schema:** `(cosine_similarity: Float, l2_distance: Float, passed_gate: Boolean)`
* **Confidence Metric:** Calibrated similarity threshold (e.g., `>0.75` = PASS).
* **Evidence Classification:** `CALIBRATED` via FaceNet distance metrics.
* **Failure Modes:** False rejections on heavily shadowed profiles; false acceptances on highly generic generated faces.
* **Provenance Requirements:** Audit log of the similarity score attached to the accepted Target asset.
* **SentinelQC Use:** Final automated gate before Human Acceptance in Project Titan.
* **Commercial Requirements:** Identical to the IdentityEmbeddingProvider.
