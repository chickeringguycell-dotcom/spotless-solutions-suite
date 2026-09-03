# Blueprint Reading Lessons

## Level 1: Drawing Sheet Literacy
Technical drawing sheets contain metadata that provides critical context before a single geometric feature is modeled.

### Key Components:
1. **Title Block**: Contains Part Name, Part Number, Material, Scale, General Tolerances, and Units.
2. **Revision Block**: Tracks changes. Ensure modeling matches the correct revision.
3. **General Notes**: Global rules applying to the entire sheet (e.g., "ALL FILLETS R0.125 UNLESS OTHERWISE SPECIFIED").
4. **Scale**: Represents the ratio of drawing size to real-world size. However, explicitly stated dimensions always override scaled measurements.
5. **Projection Symbol**: Indicates First-Angle (European/ISO) or Third-Angle (US/ASME) projection, which fundamentally alters how views are arranged relative to the front view.

### HELIOS/HAL Directives:
- Extract units and scale BEFORE interpreting geometry.
- If notes state "UNLESS OTHERWISE SPECIFIED", store this as a default constraint applied to any un-dimensioned feature.
- Verify the projection angle to ensure front/top/side views are mapped correctly to 3D space.
