# Projection Rules

## Level 3: Orthographic Projection
Orthographic projection represents a 3D object using multiple 2D views from different angles.

### Standard Views
- **FRONT**: The primary view, usually showing the most characteristic shape or longest dimension.
- **TOP**: Viewing the object from above the front view.
- **RIGHT/LEFT**: Viewing from the sides.
- **REAR & BOTTOM**: Additional views used if necessary for complex geometry.

### First-Angle vs. Third-Angle Projection
- **First-Angle (ISO)**: The object is placed between the observer and the projection plane. The left view is placed on the right side of the front view.
- **Third-Angle (ASME/US)**: The projection plane is between the observer and the object. The top view is placed above the front view, the right view on the right.

### HELIOS/HAL Directives:
- Multiple views = ONE object.
- Build cross-view correspondence. If a hole exists in the front view, its center axis MUST align with the corresponding hidden lines in the top and side views.
- Never manufacture separate objects for each view; construct a single 3D constraint network that satisfies all views simultaneously.
