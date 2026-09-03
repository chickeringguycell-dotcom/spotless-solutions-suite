# Visual Reference Service Architecture

**Scope:** Managing generated images not as disposable files, but as permanent, tracked manufacturing specifications.

## 1. The Paradigm Shift
In traditional systems, generated concept art is disposable. In Viper Studios, every generated image produced by the Identity Reconstruction Engine is treated as a binding **Manufacturing Document**.

## 2. Shared Service Location
The Visual Reference Service operates alongside the Identity Engine and acts as its permanent memory bank.

## 3. Core Data Structure
When the Identity Engine generates a reference (e.g., a side profile), the Visual Reference Service stores it in the Project Memory database with the following strict metadata schema:

```json
{
  "referenceId": "UUID",
  "sourceImageId": "UUID_OF_ORIGINAL_UPLOAD",
  "creatorId": "UUID",
  "projectId": "UUID",
  "providerUsed": "AuraFaceAdapter_v2",
  "modelUsed": "Hunyuan3D_v2",
  "prompt": "Side profile, highly detailed...",
  "seed": 123456789,
  "identityEmbeddingReference": "UUID_OF_VECTOR",
  "viewType": "ORTHOGRAPHIC_LEFT",
  "assetType": "INFERRED_ESTIMATE",
  "approvalHistory": [
    { "timestamp": "...", "status": "APPROVED", "by": "CREATOR" }
  ],
  "lineage": {
    "parentAssets": ["sourceImageId"],
    "childManufacturedAssets": ["UUID_OF_FINAL_3D_MESH"]
  }
}
```

## 4. Lineage and Provenance
Because the Visual Reference Service tracks Lineage, any future licensing change to the original `sourceImageId` will automatically cascade down to the `childManufacturedAssets`. This ensures complete IP protection and satisfies the Viper Studios sovereignty mandate.

## 5. Pipeline Pre-Requisites
Project Titan is strictly **blocked** from manufacturing the final 3D asset until the Visual Reference Service has confirmed the existence and Creator Approval of:
- Orthographic front
- Orthographic side
- Expression sheet (optional but recommended)
- Identity embedding vector
