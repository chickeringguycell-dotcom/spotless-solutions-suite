# Identity Reconstruction Engineering Bible

## The Identity Mandate
The Identity Reconstruction Engine is a Viper Studios Core Platform Service. It is not an Avatar Forge feature; it is the universal truth engine for human and character identity across all Forges.

## Permanent Architectural Rules

### Rule 1: The Engine Precedes The Forge
No Forge may initiate a 3D manufacturing process until the Identity Reconstruction Engine has provided a geometrically consistent, creator-approved set of 2D visual references (the Manufacturing Documents). 

### Rule 2: Wrap Everything
Viper Studios shall never hardwire an AI provider (such as DALL-E, Hunyuan, or AuraFace) directly into its core logic. Every capability must be accessed through a `ProviderAdapter` that implements the platform's standardized interfaces.

### Rule 3: Visual References are Immutable Blueprints
A generated image in Viper Studios is not a disposable file. It must be logged in the `Visual Reference Service` with its full lineage (Source Image ID, Prompt, Seed, Identity Embedding, Provider, and Approval Status). It becomes a strict manufacturing specification.

### Rule 4: Provider Darwinism
Providers do not possess tenure. The `Provider Quality Scoring System` continuously ranks providers. Helios must always route tasks to the provider that yields the highest accuracy and stability, bounded by the user's commercial licensing constraints.

### Rule 5: Strict Separation of Concerns
- **Helios** owns intent understanding and provider routing.
- **Identity Engine** owns reference generation, embeddings, and consistency.
- **Visual Reference Service** owns storage, lineage, and provenance.
- **Project Titan (Forges)** owns 3D mesh and texture manufacturing based on references.
- **SentinelQC** owns final verification against the source reference.

### Rule 6: Open Source First, Build Last
Always follow the methodology: **FIND → EVALUATE → INTEGRATE → WRAP → BUILD**. 
Only write native, proprietary Viper algorithms when mature open-source solutions fail to meet the platform's Viper Quality Score standards.
