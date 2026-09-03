# Viper Studios: Hosting & Deployment Cost Analysis (2026-06-27)

This document provides a comparative analysis of hosting environments for the Viper Studios platform based on its current architectural requirements.

## 1. Architectural Baseline

Viper Studios is not a standard web app; it is a heavy AI orchestration platform. The current architecture requires:
- **Landing Page**: A static Vite single-page application (SPA).
- **Mobile App**: An Expo React Native application (deployable to stores or via EAS).
- **API Server**: An Express.js backend that handles OpenAI streaming.
- **AI Orchestration (Helios)**: A background worker system that uses `child_process.exec` to run local Python scripts (TripoSR, Hair Studio).
- **Database**: Local SQLite.
- **Storage**: Local filesystem operations for generating and serving massive `.glb`, `.fbx`, and image assets.

---

## 2. Platform Comparison

### A. Replit Deployments (Current Configuration)
*   **Suitability**: High for rapid prototyping; low for long-term production.
*   **Architecture Fit**: Supports the current monolithic setup natively. The `.replit` config spins up Node.js, Python, SQLite, and the Vite server in a single Autoscale container.
*   **Limitations**: Heavy Python inference (TripoSR) will severely bottleneck a standard Replit container, requiring expensive Autoscale tiers. Persistent storage limits make storing thousands of `.glb` files risky.

### B. Vercel / Cloudflare Pages / Firebase Hosting
*   **Suitability**: Excellent for the Landing Page; **impossible** for the API server in its current state.
*   **Architecture Fit**: Serverless environments (Vercel/Cloudflare) have strict timeout limits (10s–60s) and read-only ephemeral filesystems.
*   **Limitations**: They cannot run persistent background workers, cannot execute `child_process` Python scripts, and cannot host a local SQLite file reliably.

### C. Google Cloud Platform (GCP)
*   **Suitability**: Best for long-term production and heavy AI generation.
*   **Architecture Fit**: 
    - Google Cloud Run or Compute Engine (VMs) can handle the Express API and spawn Python subprocesses natively. 
    - Compute Engine allows attaching GPUs for TripoSR/Trellis generation.
    - Cloud Storage (GCS) safely handles limitless 3D asset uploads.

---

## 3. Cost Estimations

*Assuming moderate initial traffic and generation loads.*

| Component | Replit (Autoscale) | Google Cloud | Vercel / Cloudflare |
| :--- | :--- | :--- | :--- |
| **Website (Static)** | Included in container cost | ~$1-5/mo (Cloud Storage) | **$0** (Free Tier) |
| **API & Orchestration** | ~$10-40/mo (High compute) | ~$10-30/mo (Cloud Run) | N/A (Cannot run) |
| **AI Inference (GPUs)** | Very Expensive / Unsupported | Variable (Pay-per-second GPU) | N/A |
| **Database (SQLite -> SQL)** | Free (Local file) | ~$10-15/mo (Cloud SQL instance)| N/A |
| **File Storage (.glb)** | Limited by Repl storage | pennies per GB (GCS) | N/A |
| **Estimated Total/Mo** | **~$20 - $60** (Performance will suffer) | **~$30 - $80** (Highly scalable) | **N/A** |

---

## 4. Architectural Flexibility & Migration

**Can we migrate later without major code changes?**
*   **Yes, but with caveats.** The current Express API and SQLite database are highly portable to any Docker/VM environment (like Google Cloud). 
*   **The Bottleneck:** The current architecture relies on saving files directly to the local disk (e.g., `artifacts/api-server/public`). To migrate to a true scalable cloud architecture, the code must be refactored to use an Object Storage bucket (like AWS S3 or Google Cloud Storage) instead of local filesystem paths.

**Does our current architecture already support changing hosting providers?**
Partially. Because it is a standard Node.js/Express app, it can run anywhere Node is supported. However, the hard dependency on spawning local Python environments requires a provider that grants full OS-level access (VMs or Docker containers), locking you out of pure serverless providers.

**Is Replit still the best temporary production home?**
**Yes.** For the immediate future (0–3 months), Replit is the easiest place to host the project because it requires zero infrastructure setup to run Node, Python, and SQLite simultaneously. 

---

## 5. Official Recommendations for the Next 12 Months

To balance cost, reliability, and the heavy compute requirements of 3D generative AI, the platform should eventually be decoupled.

### Phase 1: Immediate Term (0 - 3 Months)
*   **Development**: **Cloud Antigravity**. It provides the safest sandbox and manages Git LFS properly.
*   **Testing/Staging**: **Replit**. Use the existing Replit configuration to manually pull from GitHub and preview the monolithic app for stakeholders.
*   **Production**: Do not launch a heavy public beta yet. 

### Phase 2: Long-Term Production (3 - 12 Months)
We recommend adopting a **Split Architecture**:
1.  **Frontend (Landing Page)**: Migrate to **Vercel** or **Cloudflare Pages**. It is free, globally distributed, and offers the absolute lowest cost and highest performance.
2.  **API Server & AI Orchestration**: Migrate to **Google Cloud Run** (or Compute Engine if GPUs are strictly required). Containerize the Helios backend via Docker.
3.  **Storage**: Refactor file generation to upload directly to **Google Cloud Storage (GCS)** rather than local disk.
4.  **Database**: Migrate from SQLite to **Google Cloud SQL (PostgreSQL)** or Turso (distributed SQLite).

By splitting the stack, you eliminate Replit's single-container bottleneck, reduce frontend hosting costs to zero, and unlock limitless scale for your AI Forges on Google Cloud.
