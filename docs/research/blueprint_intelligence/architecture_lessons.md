# Architecture Lessons

## Level 13: Architectural Blueprints
Architectural packages describe the construction of buildings and environments, using specialized terminology distinct from mechanical drawings.

### Key Drawing Types
- **Floor Plans**: A top-down view sliced horizontally (typically at ~4 feet above the floor) to show walls, doors, windows, and room layouts.
- **Elevations**: Views of the exterior faces of the building.
- **Sections**: Vertical slices through the building showing floor-to-floor heights, roof structures, and foundations.
- **Reflected Ceiling Plans (RCP)**: A view looking UP at the ceiling from the floor, showing lighting, HVAC registers, and ceiling grids.
- **Schedules**: Tables listing the properties of repetitive elements (e.g., Door Schedule, Window Schedule, Room Finish Schedule).

### HELIOS/HAL Directives:
- Extract structural grids (Grid Lines A, B, C / 1, 2, 3) as global reference datums for the environment.
- Differentiate between structural elements (columns, load-bearing walls) and non-structural elements (partitions, casework).
- Map finishes from Room Schedules directly into Viper Studios Material assignments.
- Reconstruct buildings in 3D using procedural or modular components where applicable, guided by the floor plan layout.
