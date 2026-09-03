# Dimensioning Rules

## Level 4: Dimension Intelligence
Dimensions translate scale and proportion into precise geometric constraints.

### Types of Dimensions
- **Linear**: Distance between two points, edges, or planes.
- **Angular**: Angle between two intersecting planes or lines.
- **Radial/Diametral**: Size of circular arcs or holes. Look for "R" or "Ø" prefixes.
- **Ordinate**: Dimensions measured from a single 0,0 datum point (often used for complex plates with many holes).
- **Reference**: Dimensions enclosed in parentheses (e.g., `(10)`). These are for reference only and derived from other explicit dimensions.
- **Patterns**: e.g., `4X Ø10` indicates four identical holes of diameter 10.

### HELIOS/HAL Directives:
- Extract dimensions into machine-readable constraints.
- Never invent missing measurements. If a dimension is missing, deduce it geometrically from surrounding constraints, or classify it as UNKNOWN.
- State classification: `MEASURED_FROM_DRAWING`, `EXPLICITLY_DIMENSIONED`, `INFERRED`, or `UNKNOWN`.
