# PRNet Component Assessment

**Phase 2: Correct Capability Classification**

Based on the verified output from the `GB001` test execution (where rendering failed due to an array-indexing bug, but geometry and position maps succeeded), the PRNet component is classified strictly as follows:

| Capability | Classification | Evidence / Note |
| :--- | :--- | :--- |
| **Frontal face reconstruction** | `VERIFIED` | Produced `GB001_mesh.obj` representing the front of the face. |
| **Profile geometry** | `PARTIAL` | The mesh curves around the side but truncates abruptly before the ears. |
| **Ear geometry** | `FAILED` | Completely absent from the generated OBJ. |
| **Rear skull** | `FAILED` | Absent. |
| **Scalp** | `FAILED` | Absent. |
| **Hair** | `FAILED` | Absent. Texture samples hair falling on face, but no volume exists. |
| **Neck** | `FAILED` | Absent. |
| **Shoulders** | `FAILED` | Absent. |
| **Full head** | `FAILED` | Reconstructs a facial mask only. |
| **Full body** | `NOT_SUPPORTED` | Component is face-only. |
| **UV position mapping** | `VERIFIED` | Produced `GB001_uv_position_map.jpg` containing dense correspondence. |
| **Texture sampling** | `VERIFIED` | Produced `GB001_texture.jpg` containing the unwarped facial texture. |
| **Novel-view synthesis** | `FAILED` | The internal `render_texture` function crashed with indexing errors. Renders were not produced. |
| **Identity preservation** | `PARTIAL` | The mesh shape preserves facial structure, but lack of head volume destroys holistic identity. |

**Summary:** PRNet is extremely effective at extracting a mathematical UV Position Map and unwarped facial texture. However, it fails completely at full-head reconstruction and rendering. It is NOT "the exact intelligence required" to finish Titan; it is merely one isolated piece (the Face Geometry/UV mapper).
