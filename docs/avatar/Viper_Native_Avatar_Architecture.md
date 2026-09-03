# Viper-Native Avatar Architecture

## Shared Architecture Decision
**Permanent Principle**: "Viper Studios creates avatars using professional game-character architecture. They retain the accessibility and identity of avatars while gaining the modularity, realism, animation, optimization, and runtime behavior required for games."
**Permanent Principle**: "Build once as a rich Viper-native digital human. Derive target-specific game characters and social avatars through export profiles."

## Canonical Internal Character Package
Every Viper Studio generated avatar exists internally as a rich, unified package comprising 6 distinct sub-packages.

### 1. Identity Package
* **Dependency**: Project Titan Identity Specification Package
* Contains source photographs, generated reference views, protected identity regions, inferred regions, and SentinelQC identity evidence. 

### 2. Geometry Package
* Seamless head and body, hands, feet.
* Internal structures: eyes, teeth, tongue, mouth interior.
* Groom structures: hair and scalp geometry.
* Production requirements: Stable production topology, deformation-safe edge loops, organized UV channels, and mathematically strict LOD (Level of Detail) meshes.

### 3. Canonical Viper Rig Package
* Governs the mechanical deformation of the geometry. Detailed in `Canonical_Rig_and_Facial_Contract.md`.

### 4. Facial Control Contract Package
* Governs expression and speech via blendshapes/bones. Detailed in `Canonical_Rig_and_Facial_Contract.md`.

### 5. Material Package
* **Skin**: Albedo, Normal, Roughness, Subsurface scattering, Microdetail, Displacement.
* **Details**: Eye materials (cornea, iris, sclera), Teeth/Gums materials, Hair shaders.
* **Layering**: Support for makeup layers, dirt, sweat, wetness, and damage overlays natively rendered in the Headquarters.

### 6. Behavior Package
* Contains the state-machine logic allowing the avatar to be puppeteered inside the Headquarters. Detailed in `Helios_Character_Behavior_Contract.md`.

## Titan Dependency Statement
**DO NOT begin avatar reconstruction until Titan can manufacture:**
* Identity-preserving front view, profiles, three-quarter views, full-body references, hair references, body proportions, source-versus-inference maps, and UV-supporting evidence.
* **Titan remains the first dependency.** The game-development avatar architecture does not replace Titan. It provides the production body, rig, wardrobe, animation system, and export framework that receives Titan’s identity package.
