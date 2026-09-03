# Viper Studios External Tool Boundaries
**Date:** 2026-07-20

This document defines the strict engineering boundaries governing the use of external AI accelerator tools (Google Stitch, Google Opal, Google Flow, Google Pomelli, Gemini Canvas) within the Viper Studios ecosystem. 

These rules are permanent to prevent vendor lock-in, protect intellectual property, and ensure Viper Studios retains full ownership of its core architecture.

---

## 1. Core Architecture Independence
- **No Replacement of Viper Systems:** External tools must NEVER replace core Viper Studio systems, including Helios, Titan, SentinelQC, the Workspace Registry, the Job Queue, the Product Library, or the Reality Gate.
- **No Hosted Backends:** Core Helios logic, persistence, authentication, or production jobs must NEVER be placed inside Google Opal or other external workflow tools.
- **Opal Prototyping:** Google Opal is strictly classified as PROTOTYPING ONLY. Its internal Breadboard technology is not a supported Viper integration API.

## 2. Integrity of Evidence and Benchmarks
- **No Fabrication of Evidence:** Google Flow, Gemini, and other generators must NEVER be classified as Titan evidence. 
- **No Hidden Conditioning:** External generated assets cannot be used as hidden inputs for benchmarking Titan's performance.

## 3. Security and Privacy Boundaries
- **Blind Upload Prohibition:** Do not upload private Viper Studios source code or proprietary creator assets to experimental vendor platforms without reviewing and confirming the privacy terms.
- **Account & Expenditure Freeze:** The swarm must not create paid subscriptions, connect Google accounts, or spend money to bypass limitations. 

## 4. Code Integration and Vendor Lock-in
- **Exported Code Requirement:** Tools like Google Stitch may be used after P0 build repair. Exported work must be preserved as ordinary Viper-owned source files.
- **Mandatory Review:** Do not allow proprietary hooks or vendor dependencies into production without review.

## 5. Temporary Prototyping & Marketing
- External accelerators should be viewed as temporary scaffolds or external workshops.
- Google Pomelli and Google Flow are strictly limited to marketing and cinematic uses (trailers, Reality Gate demos). They must not produce source code or core assets.
- Gemini Canvas is an external documentation, specification, coding-prototype, and planning workspace.
