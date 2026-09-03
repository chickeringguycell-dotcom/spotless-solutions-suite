# Viper Studios: Helios Current State & Backlog Report

**Date**: June 25, 2026  
**Status**: Foundation Operational (Phase 5 Pending Approval)

---

## 1. Executive Summary

This document outlines the current architectural state of the **Helios Initiative** (the central orchestration, memory, embodiment, and routing layer of Viper Studios) and defines the remaining development backlog. 

> [!IMPORTANT]
> **Phase 5 (3D Generative AI Integration) has NOT started yet.**
> Development remains strictly focused on foundation verification and backlog priority items.
>
> **CRITICAL CONSTRAINT**: Avatars, character rigs, and protected production assets (e.g., CC5 Aria, Gaius, Camilla, or production meshes) must NOT be modified, replaced, or deleted without explicit, written approval.

---

## 2. Fully Complete Helios Foundation Items

The core orchestration layer is fully operational and type-safe across the workspace. The following subsystems are complete:

* **Unified Input Router & Failover**: `/api/helios/chat` handles real-time dialogue stream generation using OpenAI with automatic fallback routing to Gemini.
* **Dual-Tier Memory System**: Postgres-backed episodic conversation history and semantic fact recall (with local JSON store fallback in `data/helios-memory/` if `DATABASE_URL` is omitted).
* **Character Embodiment Engine v2**: Procedural viseme timeline keyframes and emotion blendshape weights generated from chat prompts, consumed dynamically in the client-side `ThreeViewer`.
* **Companion Selection Support**: Persona routing that loads distinct creative direction context for Aria and practical systems context for Gaius depending on user preference.
* **Helios Tool Registry & Intent Classifier**: Classifies dialogue intents (e.g., `forge_create`, `export_readiness`, `general_chat`) and automatically triggers tool behaviors.
* **Animation Intent Routing**: Automatically resolves and returns compatible CC5 clips from the Viper Animation Library based on user intent.
* **Speech Correction Service**: A context-aware `/correct-transcript` endpoint that cleans up voice transcription mistakes using user-specific vocabulary and learned patterns.
* **Wardrobe Inventory System Backend**: Relational Postgres schema (with a fallback JSON ledger store) managing wardrobe items, active equip states across slot sets (neck, hair, jacket, sneakers), and saved outfits.
* **Cylon Activity Indicator**: Custom React components and CSS animations mounted in the landing-page Forge panel to show premium activity scan states.

---

## 3. Remaining Development Backlog

The following areas are scheduled for development upon receiving approval:

### A. Phase 5: 3D Generative AI Integration (Backlog - P3)
* **Generative Gateway**: Establish the `/api/forge/generate` route and background queue handling.
* **Image-to-3D Mesh Integration**: Integrate open-source pipelines (Trellis, TripoSR, and InstantMesh) behind the worker dispatcher.
* **Modular Assembly Orchestrator**: Build systems that allow Gaius or Aria to assemble spacecraft parts procedurally based on user prompts.
* **SAM 3D Segmentation**: Integrate part-level segmentation to allow isolation and texturing of specific sub-mesh components.

### B. Client-Side Wardrobe & Outfit UI (Backlog - P2)
* **Runway Equip Controls**: Connect web (`landing-page`) and mobile (`viper-studio`) viewers to send and display live equip actions (`POST /api/forge/wardrobe/equip`).
* **Inventory Catalog Grid**: Render the user's wardrobe items in a grid layout, enabling them to browse and filter by slot (e.g., sneakers, jackets).
* **Outfit Configurator**: Add buttons to save active outfits by name (`POST /api/forge/outfits`) and load them onto the runway mannequin.

### C. Advanced Memory & Audio Refinements (Backlog - P1)
* **Semantic Consolidation Worker**: Build a periodic background task to resolve conflicting facts (e.g., if a user changes their mind about a color or metric scale) and clean up stale preferences.
* **Phonetic Lip-Sync alignment**: Upgrade standard text-to-viseme heuristics to real-time audio-amplitude / phonetic phoneme alignment for TTS output.

---

## 4. Verification History

All backend services, routes, and compilation requirements have been validated:
* `npx pnpm run typecheck` passes with `0` errors.
* `npx pnpm build` compiles all workspace projects cleanly.
* End-to-end routing checked via `test_helios_endpoint.js`, `test_helios_foundation.js`, and `test_wardrobe.js`.
