# Lighting Forge Technology Survey v1

## 1. Executive Summary

- **Mission:** Evaluate the state of the art in 3D lighting systems to design a universal, engine-agnostic Lighting Forge capable of generating physically accurate lighting for all Viper Studios assets.
- **Why it exists:** Lighting is engine-dependent. To ensure assets (avatars, vehicles, environments) look correct across Starfield, Skyrim, VRChat, IMVU, Unity, and Unreal, Viper Studios needs a central Lighting Forge that defines lighting mathematically and procedurally, independent of the final renderer.
- **Inputs:** 3D assets, environment context, HDRI maps, IES profiles, time-of-day/weather parameters, artistic mood descriptors.
- **Outputs:** Engine-agnostic lighting definitions (JSON/XML), baked lightmaps, SH (Spherical Harmonics) probes, and standardized rendering configurations.
- **Dependencies:** Materials (OpenPBR), Color Management (ACES/OCIO), and target Engine Adapters.
- **Current status:** Survey / Architecture Planning.

---

## 2. Technology Survey & Competitive Benchmark

### 2.1 Blender Cycles Lighting
- **License:** GPL (Open Source)
- **Maturity:** Production-ready
- **Strengths:** Unbiased physically based path tracer, highly accurate, supports all modern rendering features (volumetrics, SSS, caustics).
- **Weaknesses:** Slow for real-time applications; purely offline.
- **Realism:** Very High
- **Performance:** Low (Offline)
- **Automation Level:** High (Python API)
- **Engine Compatibility:** N/A (Offline renderer)
- **Export Support:** Can bake lighting to textures.
- **Integration Difficulty:** Medium (via headless Blender CLI/Python).

### 2.2 Blender Eevee Lighting
- **License:** GPL (Open Source)
- **Maturity:** Production-ready
- **Strengths:** Real-time rasterization, fast iteration, node compatibility with Cycles.
- **Weaknesses:** Screen-space limitations, less accurate global illumination compared to path tracing.
- **Realism:** Medium-High
- **Performance:** High
- **Automation Level:** High (Python API)
- **Engine Compatibility:** N/A (Offline/Preview renderer)
- **Export Support:** Limited baking.
- **Integration Difficulty:** Medium.

### 2.3 Unreal Engine Lumen
- **License:** Commercial / Royalty-based
- **Maturity:** Production-ready
- **Strengths:** Fully dynamic real-time global illumination and reflections without baking.
- **Weaknesses:** High performance cost, requires modern hardware, proprietary to Unreal.
- **Realism:** High
- **Performance:** Medium
- **Automation Level:** Medium (Blueprint/Python API)
- **Engine Compatibility:** Unreal Engine 5 only.
- **Export Support:** None (Engine locked).
- **Integration Difficulty:** High (requires UE backend).

### 2.4 Unreal Path Tracer
- **License:** Commercial / Royalty-based
- **Maturity:** Production-ready
- **Strengths:** Ground-truth rendering, seamless swap from Lumen for high-end cinematic output.
- **Weaknesses:** Hardware raytracing required, offline performance.
- **Realism:** Very High
- **Performance:** Low
- **Automation Level:** Medium
- **Engine Compatibility:** Unreal Engine 5.
- **Export Support:** Rendered image sequence output.
- **Integration Difficulty:** High.

### 2.5 Unity HDRP Lighting
- **License:** Commercial (Free tier available)
- **Maturity:** Production-ready
- **Strengths:** High-fidelity graphics, physical light units (Lux, Lumens, EV), advanced volumetrics.
- **Weaknesses:** Complex setup, heavy performance requirement.
- **Realism:** High
- **Performance:** Medium
- **Automation Level:** High (C# API)
- **Engine Compatibility:** Unity only.
- **Export Support:** None (Engine locked).
- **Integration Difficulty:** High.

### 2.6 Unity URP Lighting
- **License:** Commercial (Free tier available)
- **Maturity:** Production-ready
- **Strengths:** Highly optimized, scalable from mobile/VR to console.
- **Weaknesses:** Lacks advanced real-time GI (without add-ons), simplified lighting models.
- **Realism:** Medium
- **Performance:** Very High
- **Automation Level:** High (C# API)
- **Engine Compatibility:** Unity only.
- **Export Support:** None.
- **Integration Difficulty:** High.

### 2.7 Godot 4 Lighting
- **License:** MIT (Open Source)
- **Maturity:** Rapidly Maturing
- **Strengths:** SDFGI (Signed Distance Field GI) provides solid real-time dynamic lighting, completely open source.
- **Weaknesses:** Not yet at parity with Unreal Lumen for extreme high-end realism.
- **Realism:** Medium-High
- **Performance:** High
- **Automation Level:** High (GDScript/C++)
- **Engine Compatibility:** Godot 4.
- **Export Support:** None.
- **Integration Difficulty:** Low to Medium.

### 2.8 HDRI Lighting Pipelines
- **License:** Open standard (Images usually CC0 or commercial)
- **Maturity:** Industry Standard
- **Strengths:** Provides perfect 360-degree real-world lighting and reflections.
- **Weaknesses:** Static, difficult to change local lighting conditions without relighting.
- **Realism:** Very High
- **Performance:** Very High
- **Automation Level:** High (Parameter driven)
- **Engine Compatibility:** Universal.
- **Export Support:** Universal (EXR/HDR files).
- **Integration Difficulty:** Low.

### 2.9 Image-Based Lighting (IBL)
- **License:** Concept/Standard
- **Maturity:** Industry Standard
- **Strengths:** Foundation for physically based rendering, uses prefiltered environment maps.
- **Weaknesses:** Requires robust specular/diffuse convolution pipelines.
- **Realism:** High
- **Performance:** High
- **Automation Level:** High
- **Engine Compatibility:** Universal.
- **Export Support:** Spherical Harmonics / Cubemaps.
- **Integration Difficulty:** Medium.

### 2.10 OpenPBR Lighting Workflows
- **License:** Apache 2.0 (Open Standard)
- **Maturity:** Emerging Standard (Academy Software Foundation)
- **Strengths:** Unifies material and lighting interactions across software (subsuming Standard Surface/Disney PBR).
- **Weaknesses:** Still gaining adoption in real-time engines.
- **Realism:** Very High
- **Performance:** Varies by implementation.
- **Automation Level:** High.
- **Engine Compatibility:** Universal goal.
- **Integration Difficulty:** Medium.

### 2.11 ACES Color Management
- **License:** Open Standard (AMPAS)
- **Maturity:** Industry Standard
- **Strengths:** Massive color gamut, prevents color clipping, standardizes color from input to display.
- **Weaknesses:** Complex pipeline setup, can shift familiar hex colors.
- **Realism:** Very High (Cinematic)
- **Engine Compatibility:** Universal (Unreal, Unity, Godot, Blender).
- **Integration Difficulty:** Medium.

### 2.12 OpenColorIO (OCIO)
- **License:** BSD-3-Clause (Open Source)
- **Maturity:** Industry Standard
- **Strengths:** Standardized configuration file format for color management (including ACES).
- **Weaknesses:** Requires explicit pipeline enforcement.
- **Engine Compatibility:** Universal.
- **Integration Difficulty:** Low.

### 2.13 Photometric Lighting (IES Profiles)
- **License:** Open Standard (IESNA)
- **Maturity:** Industry Standard
- **Strengths:** Mathematically defines the exact shape and falloff of real-world light bulbs/fixtures.
- **Weaknesses:** Requires engine support to parse the 1D/2D arrays.
- **Realism:** Very High
- **Performance:** High (usually baked to a 1D texture).
- **Engine Compatibility:** High (Supported by Unreal, Unity, Blender).
- **Integration Difficulty:** Low.

### 2.14 Ray Tracing
- **License:** Algorithmic Concept (APIs like DXR/Vulkan RT are proprietary/open)
- **Maturity:** Production-ready
- **Strengths:** Physically accurate shadows, reflections, and refraction.
- **Weaknesses:** High hardware requirements.
- **Realism:** Very High.
- **Engine Compatibility:** Modern engines with DXR/Vulkan support.

### 2.15 Path Tracing
- **License:** Algorithmic Concept
- **Maturity:** Production-ready
- **Strengths:** Ground truth rendering.
- **Weaknesses:** Too slow for real-time.
- **Role in Viper:** SentinelQC validation (does the asset look correct under ground-truth physics?).

### 2.16 Screen Space GI (SSGI)
- **License:** Concept
- **Maturity:** Production-ready
- **Strengths:** Cheap dynamic GI.
- **Weaknesses:** Misses off-screen occluders, light leaks.
- **Role in Viper:** Fallback lighting mode.

### 2.17 Screen Space Reflections (SSR)
- **License:** Concept
- **Maturity:** Industry Standard
- **Strengths:** Fast, decent looking reflections.
- **Weaknesses:** Artifacts at screen edges, missing off-screen reflections.

### 2.18 Global Illumination (GI) Systems
- **License:** Concept
- **Strengths:** Bounces light for realistic ambient occlusion and color bleeding.
- **Weaknesses:** Extremely difficult to standardize across engines (Lightmass vs. Enlighten vs. Lumen).

### 2.19 Procedural Sky Systems
- **License:** Varies
- **Strengths:** Dynamic time-of-day, sun positioning, atmospheric scattering (Rayleigh/Mie).
- **Weaknesses:** Expensive to compute in real-time.
- **Integration:** Must be parameterized (Sun Angle, Turbidity, Ozone) for engine-agnostic transfer.

### 2.20 AI Lighting Optimization Tools
- **License:** Varies (Research / Proprietary)
- **Strengths:** Can hallucinate lighting on 2D images or optimize SH probes.
- **Weaknesses:** Often violates physical rules, hallucinates incorrect shadows.
- **Integration:** Requires strict SentinelQC validation.

---

## 3. Architecture Decision Record (ADR)

| Technology | Decision | Justification |
| :--- | :--- | :--- |
| **Blender Cycles** | **ADAPT** | Use as the headless ground-truth rendering engine for SentinelQC to validate asset appearance before export. |
| **Blender Eevee** | **REPLACE** | Do not use for Viper pipeline; rely on native target engines for real-time preview, or web-based WebGL/Three.js viewers. |
| **Unreal Lumen/Path Tracer** | **ADAPT** | Write an Unreal Engine adapter that translates Viper's agnostic lighting definitions into Unreal format. We do not use Unreal to *create* the lighting; we configure Unreal to *display* it. |
| **Unity HDRP/URP** | **ADAPT** | Write Unity C# adapters that translate Viper's agnostic JSON lighting into Unity GameObjects/Light components. |
| **Godot 4 Lighting** | **ADOPT** | Excellent candidate for an open-source real-time preview engine within the Viper Studios UI. |
| **HDRI / IBL** | **ADOPT** | The core foundational lighting model. Viper Studios will maintain a library of canonical HDRIs (Studio, Outdoor, Cinematic) to guarantee neutral asset validation. |
| **OpenPBR** | **ADOPT** | Strictly adhere to OpenPBR material definitions to ensure lighting interacts consistently across all platforms. |
| **ACES / OCIO** | **ADOPT** | Implement an OCIO pipeline to ensure textures and lighting are generated and viewed in a linear color space, avoiding sRGB clipping. |
| **IES Profiles** | **ADOPT** | Use IES for all artificial lights (vehicles, buildings, props) to maintain physical realism without artistic guesswork. |
| **Procedural Skies** | **HYBRIDIZE** | Define skies mathematically (sun vector, turbidity, albedo) and translate to the target engine's native sky system. |
| **AI Lighting Tools** | **REPLACE** | AI tools hallucinate lighting. Viper Studios will explicitly calculate lighting using physical parameters. Generative AI is forbidden from baking incorrect lighting into base albedo textures. |

---

## 4. Long-Term Lighting Forge Vision

The Lighting Forge is not a traditional 3D viewport where a user manually places lights. It is a **Universal Lighting Configuration System**. 

### 4.1 The Engine-Agnostic Definition
Viper Studios will generate an intermediate JSON/XML format for lighting (e.g., `ViperLightDef.json`). 
This definition will contain purely physical measurements:
- Light Type (Point, Spot, Directional, Area)
- Position & Rotation (Transform)
- Intensity (Lumens / Lux)
- Color Temperature (Kelvin)
- Falloff / IES Profile
- Environment HDRI / SH Coefficients

### 4.2 Cross-Domain Application
- **Avatars & Portraits:** Uses "Studio Rig" configurations (Key, Fill, Rim) tied to the character's bounding box.
- **Products & Props:** Neutral HDRI validation rigs to ensure correct PBR albedo values without baked lighting.
- **Vehicles & Spacecraft:** Interior lights driven by IES profiles; exterior lights driven by luminous intensity.
- **Environments & Buildings:** Day/night cycle parameters (Sun azimuth/elevation).

### 4.3 Lighting Neutrality & SentinelQC
A core mandate: **Albedo textures must remain lighting-neutral.**
SentinelQC will utilize the Lighting Forge to render assets under multiple extreme HDRI environments. If an asset looks correct in a neutral studio but broken outdoors, SentinelQC will flag the material for violating physical conservation of energy rules.

---

## 5. Recommendation

**Recommendation:** Do not build a standalone GUI for lighting. 
Build the **Lighting Forge Data Specification (ViperLightDef)** first. 
The immediate next step is to define the JSON schema for a physical light. Once the schema is approved, we can build the adapters that translate `ViperLightDef.json` into a Unity Scene, an Unreal Level, and a Blender Scene. This preserves Viper Studios as the single source of truth for the asset ecosystem.
