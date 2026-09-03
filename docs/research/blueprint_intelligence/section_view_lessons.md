# Section View Lessons

## Level 6: Section & Detail Views
Section views expose the internal features of an object that would otherwise be hidden by solid geometry.

### Types of Sections
- **Full Section**: The cutting plane passes entirely through the object.
- **Half Section**: The cutting plane passes halfway through, showing half internal and half external. Useful for symmetrical objects.
- **Offset Section**: The cutting plane is stepped to pass through multiple features that are not in a straight line.
- **Broken-Out Section**: A small portion of the view is removed to show internal details, bordered by a freehand break line.
- **Revolved Section**: A cross-section is rotated 90 degrees and drawn directly on the primary view (e.g., the profile of a spoke).
- **Detail View**: A specific small region is enlarged to show fine detail or complex dimensions clearly.

### HELIOS/HAL Directives:
- Section hatching indicates solid material. The absence of hatching in a section view indicates a void or hole.
- Use section views to infer internal cavities, ducts, engine internals, and machinery housings.
- Align section view features geometrically with the cutting plane line on the parent view.
