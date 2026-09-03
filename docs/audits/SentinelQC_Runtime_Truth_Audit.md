# SentinelQC Runtime Truth Audit

## CLAIM
SentinelQC is an executable local script suite designed to mathematically validate 3D assets, but it operates completely disconnected from the main job pipeline.

## EVIDENCE

| Capability | Runtime Truth | Classification |
| :--- | :--- | :--- |
| **GeometryValidator** | `bmesh` scripts exist and can output JSON | VERIFIED WORKING |
| **MetadataValidator** | Reads `VPR_SHELL_*` groups natively in Blender | VERIFIED WORKING |
| **IntersectionValidator** | Present in code but unexecuted in standard passes | FUNCTIONAL BUT INCOMPLETE |
| **TemporalValidator** | Not implemented | ARCHITECTURE ONLY |
| **UVValidator** | Not implemented | ARCHITECTURE ONLY |
| **Pipeline Integration**| No API or webhooks exist to trigger this from the React UI | DISCONNECTED |
| **Evidence Preservation**| JSON outputs remain on local disk (`qc_output.txt`), not uploaded to a database | DISCONNECTED |

## CONCLUSION
**DISCONNECTED**. SentinelQC runs mathematically accurate validation locally via CLI (`sentinel_qc_engine.py`) but cannot be triggered by the user interface, nor does it block any automated job workflows in the API server.
