# Identity Reconstruction Platform Architecture

**Scope:** Formal elevation of the Identity Reconstruction Engine from a Forge-specific feature into a Core Platform Service.

## 1. Core Platform Service Definition
The Identity Reconstruction Engine is a central, shared service residing directly beneath Helios. It is **NOT owned by Avatar Forge**. It is a platform-wide dependency that any Forge (Avatar, Clothing, Creature, Spacesuit) can call upon to ensure structural and identity consistency.

### Architectural Flow
```
Aria / Gaius (Companion Interaction)
       ↓
Helios (Intent & Provider Routing)
       ↓
Identity Reconstruction Engine (Core Orchestration)
       ↓
Visual Reference Service (Lineage & Metadata Storage)
       ↓
Selected Forge (e.g., Avatar Forge)
       ↓
Native Manufacturing (3D Asset Generation)
       ↓
SentinelQC (Visual/Structural Verification)
```

## 2. Core Responsibilities
The Engine exclusively owns the following processes, lifting them out of the individual Forges:
- **Identity Reconstruction:** Maintaining likeness across multiple transformations.
- **Facial Landmark Analysis:** Extracting topography before generation.
- **Identity Embeddings:** Storing mathematically consistent facial vectors.
- **Multi-view Reconstruction:** Generating orthogonal and 3/4 views from a single reference.
- **Depth & Skull Volume Estimation:** Ensuring 3D geometric stability.
- **Pose Conditioning:** Forcing correct camera angles and body placements.
- **Reference Image Generation:** Producing all 2D reference sheets.
- **Image Editing:** Inpainting/outpainting with identity persistence.
- **Visual Consistency Scoring:** Evaluating divergence from the source.
- **Turnaround & Character Sheet Generation:** Creating production-ready 2D references.
- **Source Lineage & Provenance Tracking:** Ensuring IP and permission inheritance.
- **Provider Orchestration:** Selecting the optimal AI model for the task.

## 3. The Decoupled Forge
Because the Identity Reconstruction Engine now owns reference generation, the Forges themselves act merely as **Consumers**.
A Forge only receives:
- Orthographic front/side/rear
- Expression sheets
- Material sheets
- Identity embedding vectors
Only after receiving these guaranteed-consistent references does the Forge (e.g., Avatar Forge) attempt to manufacture the 3D mesh.
