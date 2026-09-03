# Titan Open-Source Candidate Registry

This document classifies every open-source system evaluated for integration into the Titan multi-view identity pipeline.

## TIER A (Complete Solution Candidates)
These systems attempt to solve identity-consistent multi-view generation directly.
1. **InstantID**
   - *Intended Task:* Zero-shot identity-preserving image generation.
   - *Mechanism:* Face embedding injected directly into diffusion UNet with weak spatial control.
   - *Status:* NOT_PRESENT (Requires download and isolated test).
2. **PuLID**
   - *Intended Task:* High-fidelity identity tuning for diffusion models.
   - *Mechanism:* Lightning tuning of face IDs.
   - *Status:* NOT_PRESENT (Requires download and isolated test).

## TIER B (Foundational Components)
These systems solve specific missing geometrical or identity requirements but require composition.
1. **IP-Adapter FaceID**
   - *Task:* Facial conditioning.
   - *Status:* OPERATIONAL (Available via ComfyUI nodes).
2. **3DDFA_V2**
   - *Task:* Fast 3D face alignment and morphable model fitting.
   - *Status:* INSTALLED_UNTESTED (`titan_3ddfa`).
3. **PRNet**
   - *Task:* Joint 3D face reconstruction and dense alignment.
   - *Status:* INSTALLED_UNTESTED (`titan_prnet`).
   - *Expected Benefit:* Generates UV position maps directly from images (crucial for UV-style identity references).
4. **InsightFace (ArcFace)**
   - *Task:* Face recognition and embedding extraction.
   - *Status:* PARTIALLY_OPERATIONAL (Weights installed, library available).

## TIER C (Research References)
These are relevant for understanding architecture but may be overkill, computationally prohibitive, or legally restricted.
1. **PanoHead / EG3D** (3D GANs - often difficult to run on consumer hardware).
2. **DECA / EMOCA** (Excellent for albedo extraction, but heavy dependencies).
3. **Zero123** (Object-centric, often fails on specific human facial identity).

## REJECT (Wrong Task)
1. **InstantMesh / TripoSR / TRELLIS / Stable Fast 3D**
   - *Reasoning:* These are generic Image-to-3D mesh generators. They do not understand human facial identity, they merely project pixels onto a 3D blob. They cannot synthesize unseen facial features (like ears from a front profile) intelligently; they will just smudge the side of the head.
