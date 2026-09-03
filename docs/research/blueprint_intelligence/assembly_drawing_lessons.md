# Assembly Drawing Lessons

## Level 7: Assembly Drawings
Assembly drawings describe how multiple individual manufactured parts fit together to form a complete product.

### Key Components
- **Bill of Materials (BOM) / Parts List**: A table listing the Item Number, Part Number, Description, and Quantity for every component.
- **Balloons/Callouts**: Numbered circles pointing to specific parts in the drawing, correlating them to the BOM.
- **Exploded Views**: Shows parts separated along their axis of assembly to clearly illustrate the sequence and mating relationships.

### HELIOS/HAL Directives:
- If a blueprint calls for `N` identical fasteners, DO NOT manufacture `N` independent meshes. Build ONE canonical part and create `N` instances.
- Extract parent/child relationships and assembly sequence.
- Establish mating surfaces, sockets, and interfaces between parts.
- Link this directly to Viper Studios' `AssetAssemblyManifest` and `AssetPartManifest`.
