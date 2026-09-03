# Avatar Export Profile Architecture

## Philosophy
The Viper-native avatar is the canonical master. All exports are mathematically derived descendants.
**Never destructively modify the canonical Viper avatar during export.**

## Target Platforms
Support target-specific export profiles for:
- Unreal Engine
- Unity
- Starfield
- Skyrim
- VRChat
- VRM
- IMVU
- Future platforms

## Profile Capabilities
During the automated export pipeline, each platform-specific profile may selectively perform the following operations:

1. **Rigging**: Retarget the skeleton, Rename bones, Convert facial controls.
2. **Geometry**: Merge meshes, Preserve modular meshes, Generate LODs, Enforce polygon limits, Create required attachment points.
3. **Materials**: Bake textures, Reduce materials, Apply platform-specific shaders.
4. **Physics**: Generate collision.
5. **Packaging**: Package metadata, Convert file formats (e.g., `.fbx`, `.vrm`, `.nif`, `.gltf`).

## Execution Example
* **Skyrim Profile**: Preserves modularity, maps body slots to Bethesda slot IDs (e.g., 32 for Body, 30 for Head), enforces specific `.nif` formats.
* **VRChat Profile**: Merges all body and clothing pieces into a single unified mesh, bakes the textures into a single atlas to reduce draw calls, and generates a `.vrm` or Unity package.
