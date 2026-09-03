# FaceNet Identity Metric Assessment

**Phase 2: Correct Capability Classification**

Based on the `facenet_calibration.json` output computed against the `GB001` test subjects, the InceptionResnetV1 model is classified strictly as follows:

| Capability | Classification | Raw Score | Note |
| :--- | :--- | :--- | :--- |
| **Same-image comparison** | `CALIBRATED` | `1.000` | Perfect control baseline. |
| **Recompressed-image comparison** | `CALIBRATED` | `0.958 - 0.989` | Handled crop, brightness, scaling perfectly. |
| **Front-to-profile comparison** | `CALIBRATED` | `0.806` | Correctly identified Gemini profile as the same person. |
| **Front-to-UV-reference comparison** | `UNSUITABLE_FOR_THIS_OUTPUT` | `null` | MTCNN failed to detect a face in the flattened UV texture. |
| **Same-person cross-view separation** | `CALIBRATED` | `0.806` | Similarity remains high across yaw angles. |
| **Different-person separation** | `CALIBRATED` | `0.152, 0.077, -0.165` | Successfully rejected all three negative controls (Wikipedia images). |
| **Stylized or topology-image comparison** | `UNSUITABLE_FOR_THIS_OUTPUT` | `null` | MTCNN cannot detect faces on wireframes. |
| **SentinelQC suitability** | `PARTIALLY_CALIBRATED` | N/A | Excellent for real photos/renders, but fails on raw texture/topology assets. |

**Threshold Established:**
* **Same Identity:** `> 0.75` Cosine Similarity
* **Different Identity:** `< 0.30` Cosine Similarity

**Summary:** FaceNet is a proven, calibrated mathematical metric for determining if a synthesized profile render matches the frontal source portrait. However, it cannot evaluate intermediate manufacturing assets like UV maps or wireframes because its prerequisite MTCNN face detector fails on non-photorealistic topologies.
