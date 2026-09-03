# Electrical Drawing Lessons

## Level 15: Electrical Intelligence
Electrical drawings convey logic, connectivity, and power distribution rather than precise physical geometry.

### Key Concepts
- **Schematics**: Show logical connections using standardized symbols for components (resistors, capacitors, switches, power sources). Lines represent wires/connections, not physical length or routing.
- **Wiring Diagrams**: Show the physical layout of wires and components within a device or panel.
- **One-Line Diagrams**: Simplified diagrams showing power distribution paths, typically for facility electrical systems.

### HELIOS/HAL Directives:
- Do not mistake electrical schematic symbols for physical 3D geometry (e.g., a zig-zag line is a resistor, not a physical spring or wall).
- Extract logical connections (netlists) separately from physical 3D routing.
- If physical routing is required, defer to cable harness drawings or 3D routing models, using the schematic only to verify correct point-to-point connectivity.
