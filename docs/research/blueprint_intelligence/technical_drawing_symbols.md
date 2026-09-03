# Technical Drawing Symbols

## Level 2: Line Language & Symbols
A technical drawing uses a standardized visual language.

### Line Types
- **Visible / Object Lines**: Thick, continuous lines representing visible edges and outlines.
- **Hidden Lines**: Thin, dashed lines representing edges and surfaces not visible from the current viewing angle.
- **Centerlines**: Thin lines with alternating long and short dashes. Used to indicate the axis of symmetry, center of circles, and paths of motion.
- **Dimension & Extension Lines**: Thin lines used to indicate the extent and direction of dimensions.
- **Leaders**: Thin lines ending in an arrow or dot, pointing to a feature to associate a note or dimension.
- **Cutting-Plane Lines**: Thick, dashed lines (often ending in arrows) indicating where a section view is cut.
- **Phantom Lines**: Thin lines with long dashes separated by two short dashes. Used to show alternate positions of moving parts, adjacent positions of related parts, and repeated details.

### HELIOS/HAL Directives:
- Do not treat every line as physical geometry. A centerline or extension line is a constraint marker, not a physical edge.
- Hidden lines in one view MUST correspond to visible lines or cavities in another view.
