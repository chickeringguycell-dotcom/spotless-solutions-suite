# Viper Studios Platform Contract

## Canonical Entities

| Entity | Description | Persistence Owner | Missing Fields / Conflicts |
| :--- | :--- | :--- | :--- |
| **Workspace** | Top-level project container | Missing (SQLite/PostgreSQL needed) | Currently represented in TS mock `WorkspaceState`. Needs true relational schema linking Jobs and Products. |
| **Project** | Specific creative endeavor | Missing | Confused with Workspace in some mock states. |
| **Forge Domain** | Categorical pipeline (e.g., Avatar, Vehicle) | Helios API Server | None |
| **Forge Table** | UI instantiation of a Forge | React Frontend | Requires backend state sync to persist layout. |
| **Creator Request** | Original user intent prompt | Missing (Logs only) | Must be tied to Job creation. |
| **Agent Message** | Chat/event payload from Aria/Gaius | Missing | Needs conversational history schema. |
| **Agent Context** | SAKL active memory | File System (JSON) | Conflict: Context is file-based but intended for fast DB access. |
| **Job** | Orchestration wrapper for a generation task | Missing | TS type exists (`ForgeJob`) but schema missing. |
| **Job Step** | Discrete action within a Job | Missing | TS type `ForgeJobStep` exists, needs persistence. |
| **Provider / Generator** | Execution engine (e.g., Project Titan) | Python ML Pipeline | Unregistered in TS interface; dynamically hardcoded. |
| **Product / Asset** | Generated artifact | File System / Mocks | Conflict: `ProductLibrary` mocks fetch but assets exist locally. |
| **Preview** | Low-res manifestation for UI | File System / Mocks | None |
| **Validation Request** | SentinelQC invocation | `sentinel_qc_engine.py` | Disconnected from `ForgeJob` lifecycle. |
| **Reality Gate Scene**| Game engine map | UI ONLY | Missing entirely from backend schema. |

## Contract Conclusion
A strict GraphQL or REST schema (e.g., Prisma schema) must be generated consolidating these entities before building the Helios API server.
