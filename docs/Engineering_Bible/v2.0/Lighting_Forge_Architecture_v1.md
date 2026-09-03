# Lighting Forge Architecture v1

## 1. Forge Executive Summary
**Mission**: To serve as the universal, headless lighting generation and translation engine for Viper Studios, ensuring all environments, assets, and characters are illuminated accurately and consistently.
**Why it exists**: Lighting is engine-specific and highly variable. The Lighting Forge standardizes lighting definitions, HDRIs, and color management (ACES/OCIO) so that scenes exported to Unreal, Unity, or Godot share identical cinematic or realistic qualities.
**Inputs**: Viper Studios scene composition, environment specifications, time-of-day parameters, AI lighting prompts.
**Outputs**: Engine-ready lighting setups (USD Light schemas, Unreal/Unity light prefabs, baked HDRIs).
**Dependencies**: Environment Forge, Material Forge (for PBR accuracy checks).
**Current Status**: Survey / Architecture Phase

## 2. Mission
To automate and standardize lighting design across all Viper Studios outputs. The Lighting Forge will programmatically generate physically accurate environment lighting, cinematic studio setups, and engine-specific illumination profiles, guaranteeing visual consistency regardless of the final rendering platform.

## 3. Scope
The Lighting Forge handles all illumination data for Viper Studios. This encompasses HDRI management, procedural sky/sun/moon generation, global illumination configuration, shadow mapping presets, and strict adherence to color management pipelines (ACES/OCIO).

## 4. Long-Term Vision
An AI-orchestrated cinematic lighting director. Helios will request "golden hour lighting with volumetric fog," and the Lighting Forge will construct the exact HDRI, directional light intensity, color temperature, and post-processing exposure needed, then export it natively to any supported game engine without a human lighter ever touching the scene.

## 5. Design Philosophy
- **Physical Accuracy First:** Lighting is driven by mathematically correct units (Lux, Lumens, Kelvin) rather than arbitrary sliders.
- **Color Managed:** ACES/OCIO is mandatory. We eliminate color space mismatches between editors and engines.
- **Engine Agnostic Translation:** Lighting is stored as a universal schema (e.g., USD Lux) and translated into the specific entity component models of target engines.

---

## 6. Manufacturing Pipeline

### Station 1: Lighting Intent Station
- **Purpose:** Parse the environment requirements and select the foundational lighting approach (HDRI vs. Procedural Sky vs. Studio Setup).
- **Inputs:** Helios scene parameters, time of day, mood requests.
- **Outputs:** Baseline lighting constraints (Lux targets, Kelvin ranges).
- **Dependencies:** ACES configuration library.
- **SentinelQC Checkpoints:** Validates physical plausibility of requested intent.

### Station 2: Source Generation Station
- **Purpose:** Construct or retrieve the primary light sources.
- **Inputs:** Lighting constraints.
- **Outputs:** HDRI textures, Directional Light vectors, Area Light coordinates.
- **Dependencies:** HDRI library (Poly Haven etc.), Procedural Sky algorithms.
- **SentinelQC Checkpoints:** HDRI integrity (no clipped highlights), color temperature accuracy.

### Station 3: Scene Illumination Station
- **Purpose:** Configure Global Illumination, reflections, and shadow parameters.
- **Inputs:** Source lights, target scene scale.
- **Outputs:** Complete lighting schema.
- **Dependencies:** USD Lux schema.
- **SentinelQC Checkpoints:** Validates GI consistency and shadow map resolutions.

### Station 4: Color Management Station
- **Purpose:** Apply exposure controls and strict OCIO/ACES color spaces.
- **Inputs:** Complete lighting schema.
- **Outputs:** Color-managed lighting definition.
- **Dependencies:** OCIO configs.
- **SentinelQC Checkpoints:** White balance neutrality, exposure legality.

### Station 5: Engine Translation Station
- **Purpose:** Convert the universal lighting schema into engine-specific prefabs/data.
- **Inputs:** Color-managed lighting definition.
- **Outputs:** Unreal Lighting Levels, Unity Lighting Profiles, Godot Environment files.
- **Dependencies:** Engine translation modules.
- **SentinelQC Checkpoints:** Engine compatibility and translation fidelity.

---

## 7. Node Graph

The internal architecture of the Lighting Forge operates as a Directed Acyclic Graph (DAG) consisting of the following nodes:

- **Lighting Import:** Ingests external HDRIs or light presets.
- **HDRI Manager:** Catalogs, clamps, and normalizes HDR panoramas.
- **Environment Lighting:** Combines HDRIs with ambient light data.
- **Studio Lighting:** Generates multi-point (key, fill, rim) area lights for portraits/products.
- **Procedural Sky:** Mathematically simulates Rayleigh and Mie scattering for skies.
- **Sun & Moon:** Calculates physically accurate directional vectors based on geolocation and time.
- **Weather Lighting:** Adjusts overcast intensity, lightning flashes, or volumetric fog density.
- **Global Illumination:** Configures indirect light bounces and irradiance settings.
- **Reflection System:** Sets up reflection probes or screen-space reflection constraints.
- **Shadow System:** Configures cascaded shadow maps, soft shadows, and bias.
- **Exposure Control:** Applies physically based camera exposure (ISO, Aperture, Shutter Speed).
- **Color Management (ACES/OCIO):** Enforces scene-referred linear color space processing.
- **Engine Translation:** Maps the graph outputs to target engine specs.
- **Lighting Optimization:** Bakes lighting or reduces light counts for mobile/VR targets.
- **Lighting Export:** Packages the final environment and light configurations.

---

## 8. Technology Mapping

| Node | Decision | Justification |
| :--- | :--- | :--- |
| **Lighting Import** | ADOPT | Standard image/data I/O protocols. |
| **HDRI Manager** | ADOPT | Utilize CC0 HDRI libraries (Poly Haven) via API. |
| **Environment Lighting** | HYBRIDIZE | Combine HDRI with USD Lux standard for ambient definition. |
| **Studio Lighting** | ADAPT | Procedural node logic to auto-place lights around bounding boxes. |
| **Procedural Sky** | ADAPT | Headless execution of open-source atmospheric scattering algorithms (e.g., Hosek-Wilkie or Nishita). |
| **Sun & Moon** | ADOPT | Standard astronomical mathematical models. |
| **Weather Lighting** | REPLACE | Custom procedural adjustment logic tailored to Viper assets. |
| **Global Illumination** | ADAPT | Output settings compatible with Lumen (Unreal) or Enlighten/SDF (Unity/Godot). |
| **Reflection System** | ADAPT | Engine-specific reflection probe generation logic. |
| **Shadow System** | ADAPT | Output cascaded shadow map configurations. |
| **Exposure Control** | ADOPT | Standard EV100 physical camera math. |
| **Color Management (ACES/OCIO)** | ADOPT | Official OpenColorIO standard. |
| **Engine Translation** | ADAPT | Custom Python mapping from USD Lux to engine data formats. |
| **Lighting Optimization** | HYBRIDIZE | Headless Blender for light baking when required for low-end targets. |
| **Lighting Export** | ADOPT | USD/FBX/GLTF standard export packing. |

---

## 9. SentinelQC Integration

SentinelQC acts as the rigorous inspector for the Lighting Forge, validating:

- **HDRI integrity:** Ensures HDRIs have adequate dynamic range (e.g., > 14 stops) and no clipped suns.
- **Exposure:** Validates that the scene EV is mathematically appropriate for the time of day.
- **Color temperature:** Ensures physical lights remain within accurate Kelvin ranges (2000K-10000K).
- **White balance:** Checks for unintended color casts in neutral lighting setups.
- **Shadow quality:** Validates bias and resolution to prevent peter-panning or acne.
- **Reflection quality:** Ensures reflection probe placement covers major reflective surfaces.
- **GI consistency:** Prevents light leaking in procedural interior setups.
- **Baked-light detection:** Ensures dynamic assets do not receive static baked lighting incorrectly.
- **Lighting neutrality:** Crucial for Avatar/Material forges; verifies that inspection lighting has absolutely no color tint or stylized shadows.
- **Color management:** Strictly verifies that the pipeline remains in ACEScg linear space until display transform.
- **Engine compatibility:** Confirms that light limits (e.g., Unity's forward rendering limits) are respected for the target platform.

---

## 10. Future Expansion

The architecture reserves structural placeholders for:
- **AI Lighting Generation:** Text-to-HDRI synthesis.
- **Cinematic Lighting:** Automated cinematic composition (Chiaroscuro, Teal/Orange gradients).
- **Portrait Lighting:** Specially calibrated three-point setups specifically for the Avatar Forge.
- **Volumetric Lighting:** Procedural generation of god rays and localized fog volumes.
- **Procedural Weather:** Dynamic storm and cloud cover lighting systems.
- **Dynamic Day/Night:** Time-lapse lighting sequences.
- **Path Tracing:** Configuration targets for offline or high-end real-time path tracers.
- **Ray Tracing:** Hardware-accelerated ray tracing flag management for target engines.

---

## 11. Architecture Decision Record (ADR)

**Decision:** We are building the Lighting Forge around the **USD Lux** schema and **OpenColorIO (ACES)** standards, acting as a headless, programmatic translation layer rather than a visual lighting editor.

**Why this architecture is superior:**
1. **Engine Neutrality:** USD Lux provides a robust, industry-standard way to define physical lighting properties that translates seamlessly across Pixar's ecosystem, Unreal Engine, and modern renderers, eliminating the need to write proprietary light container formats.
2. **True Color Accuracy:** By hardcoding OCIO/ACES into the Lighting Forge's core, we permanently solve the "asset looks different in the engine" problem. Viper Studios operates exclusively in a scene-referred linear space.
3. **Physical Realism:** Basing all lighting on real-world units (Lux, EV, Kelvin) ensures that procedural or AI-generated materials (from the Material Forge) react exactly as they would in the real world.
4. **Automation:** The programmatic Node Graph allows Helios to light entire scenes, matching weather and time of day, instantly and headlessly, achieving the core Viper Studios vision of the user as a Director rather than a manual technician.
