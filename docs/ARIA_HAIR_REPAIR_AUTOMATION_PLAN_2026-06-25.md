# Aria Hair Repair Automation Plan

**Date:** 2026-06-25
**Subject:** Programmatic Pipeline for CC5 Hair Asset Repair

## Overview
This document outlines practical automation paths to repair Aria's hair asset opacity, clipping, and material settings without requiring direct GUI interaction from the AI agent. The objective is to achieve production-ready quality while rigorously protecting original files.

---

## Path 1: CC5 / Reallusion API Bridge
Reallusion provides a Python API for Character Creator. A specialized MCP (Model Context Protocol) server could act as a bridge between the agent and CC5.

**What Can Be Automated:**
- **Material Automation:** Querying material names, updating shader types, and modifying specific parameters (e.g., Opacity Threshold, Two-Sided, Blend Modes).
- **Texture Swaps:** Programmatically re-linking the diffuse and opacity map paths to updated files.
- **File Management:** Loading a project, saving a duplicate, and triggering avatar export formats.

**What Cannot Be Automated (Reliably):**
- **Mesh/Vertex Manipulation:** Natively adjusting exact vertices to resolve clipping is highly complex via API without visual feedback. 
- **Visual Validation:** The API cannot inherently tell if a texture looks "natural" or if shoulder clipping is resolved without a human or vision-model evaluating a render.

---

## Path 2: Programmatic Texture Repair (Recommended)
Because the primary issue stems from opacity bleeding and hard edges, we can solve this programmatically using Python image processing libraries (Pillow/OpenCV).

**Methodology:**
1. **Load Duplicate Texture:** Read the duplicate black-and-white opacity map.
2. **Apply Spatial Masking:** Apply a mathematical coordinate mask over the lower shoulders and neck (the bleed zones).
3. **Feather & Taper:** Use OpenCV morphological operations (erosion/dilation) or gradient overlays to taper the hard square edges into soft noise (representing hair tips).
4. **Preservation:** The script strictly locks canvas size and pixel density to preserve the UV layout perfectly.
5. **Versioned Output:** Save the file as `Aria_Hair_Opacity_vX.png`.

---

## Path 3: Hybrid Manual CC5 Verification Workflow
Since the agent lacks direct viewport access, a structured human-in-the-loop workflow bridges the gap.

1. **Agent Executes Script:** The agent runs the programmatic texture repair and generates `Aria_Hair_Opacity_v1.png`.
2. **User Applies:** The user applies the texture in CC5 and takes screenshots of the Front, Side, and Back.
3. **Agent Reviews:** The user provides the screenshots to the agent. The agent uses its vision capabilities to identify remaining bleed or square edges.
4. **Iteration:** The agent adjusts the Python script coordinates (e.g., "widen the neck mask by 10 pixels") and generates `v2`.

---

## Implementation Plan: `repair_aria_hair_opacity.py`
A safe Python script has been outlined in `scripts/repair_aria_hair_opacity.py`. The script is heavily constrained to ensure it strictly acts on duplicate files, logs all transformations, and prevents any modification of protected assets.
