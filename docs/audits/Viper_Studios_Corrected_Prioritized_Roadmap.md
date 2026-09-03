# Viper Studios Corrected Prioritized Roadmap

## EVIDENCE-BASED ROADMAP

### P0.0: Quarantine Typecheck Failures (COMPLETE)
- **Dependency:** None
- **Affected:** `api-server`
- **Action:** Fix `TS2349` callable-string errors across all Forge services.
- **Status:** **VERIFIED COMPLETE**. Typechecks, builds, and runtime initialization pass.

### P0.1: Establish Persistent Storage Schema (BLOCKED)
- **Dependency:** P0.0, Local PostgreSQL Installation
- **Affected:** `api-server`, Database
- **Action:** Provision local PostgreSQL database, then create `Drizzle` schemas for Workspace, Job, and Product.
- **Status:** **BLOCKED**. Postgres is not installed locally. Local-dev dummy configuration is temporarily active to bypass startup errors.

### P0.2: Implement Minimal Helios Orchestration (Blocker Resolved: Disconnected UI)
- **Dependency:** P0.1
- **Affected:** `api-server`
- **Action:** Replace `MOCK_FORGE_SUMMARY` with real database reads/writes.

### P1.0: Connect Project Titan to Helios (Blocker Resolved: End-to-end Path)
- **Dependency:** P0.2
- **Affected:** `api-server`, `services/project-titan-3d`
- **Action:** Allow Helios to spawn subprocesses executing Titan.

### P1.1: Connect SentinelQC to Job Pipeline (Blocker Resolved: QA Automation)
- **Dependency:** P1.0
- **Affected:** `api-server`, `sentinel_qc_engine.py`
- **Action:** Run SentinelQC automatically on Titan outputs before marking job complete.
