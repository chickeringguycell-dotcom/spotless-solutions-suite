# GD&T Lessons

## Level 5: Tolerances & GD&T (Geometric Dimensioning and Tolerancing)
GD&T ensures parts will fit and function correctly by defining allowable variations in form and size.

### Key Concepts
- **Datums**: Theoretical exact planes, axes, or points from which measurements are made (e.g., Datum A, B, C forming a Datum Reference Frame).
- **Feature Control Frames**: Rectangular boxes containing the geometric characteristic symbol, the tolerance value, and datum references.
- **Form Controls**: Straightness, Flatness, Circularity, Cylindricity.
- **Orientation Controls**: Perpendicularity, Parallelism, Angularity.
- **Location Controls**: Position, Concentricity, Symmetry.
- **Runout Controls**: Circular Runout, Total Runout.

### HELIOS/HAL Directives:
- Do not assume perfect geometry. Tolerances define the boundary of acceptable physical realization.
- Build a structured `DatumReferenceFrame`. All positional tolerances must be evaluated relative to their specified datums.
- Use SentinelQC to evaluate manufactured geometry against these tolerance intents rather than demanding mathematically perfect 0.000 error.
