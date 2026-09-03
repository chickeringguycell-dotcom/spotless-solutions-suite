# Viper Studios Exact Subsystem Status Matrix

## Exact Subsystem Inventory

| Subsystem Name | Domain | Path | Classification | Primary Blocker |
| :--- | :--- | :--- | :--- | :--- |
| **SentinelQC Engine** | Validation | `sentinel_qc_engine.py` | DISCONNECTED | Lacks API / Webhook integration |
| **Project Titan** | ML Pipeline | `services/project-titan-3d/` | FUNCTIONAL BUT INCOMPLETE | Cannot run end-to-end without manual execution |
| **Helios API Server** | Orchestration | `artifacts/api-server` | BROKEN | `TS2349` compilation errors |
| **Headquarters UI** | Frontend | `artifacts/landing-page` | FUNCTIONAL BUT INCOMPLETE | Relies on `MOCK_FORGE_SUMMARY` |
| **Workspace Registry** | Frontend State | `ForgeIntelligence.tsx` | MOCKED | Relies on browser `localStorage` |
| **Job Queue Manager** | Backend State | `artifacts/api-server/src/lib/forge/jobQueue.ts`| BROKEN | Failing Typecheck |
| **Product Library** | Backend State | `artifacts/api-server/src/lib/forge/productLibrary.ts`| BROKEN | Failing Typecheck |
| **Reality Gate** | Frontend UI | `artifacts/landing-page/src/components/` | UI ONLY | No streaming backend |
| **Aria / Gaius Agents**| LLM Integration | N/A | MISSING | No LLM backend implemented |
| **Vehicle Forge** | Generator | `VehicleForgeWorkspace.tsx` | UI ONLY | Python generators do not exist |
| **Animation Forge** | Generator | `AnimationForgeWorkspace.tsx` | UI ONLY | Python generators do not exist |

## Exact Counts
- VERIFIED WORKING: 0 (No subsystem works flawlessly end-to-end connected to UI)
- FUNCTIONAL BUT INCOMPLETE: 2 (Headquarters UI, Project Titan)
- UI ONLY: 3 (Reality Gate, Vehicle Forge, Animation Forge)
- MOCKED: 1 (Workspace Registry)
- DISCONNECTED: 1 (SentinelQC Engine)
- BROKEN: 3 (Helios API Server, Job Queue, Product Library)
- MISSING: 1 (Aria / Gaius LLM Backend)
