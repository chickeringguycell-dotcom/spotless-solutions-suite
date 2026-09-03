# Viper Studios Route and API Truth Table

## Frontend Routes (React / wouter)
| Path | Method | Source File | Real Implementation | Missing Service |
| :--- | :--- | :--- | :--- | :--- |
| `/landing-page` | GET | `LandingPage.tsx` | YES | None |
| `/landing-page/forge` | GET | `ForgePage.tsx` | YES | Backend API Server |
| `/landing-page/studio` | GET | `StudioPage.tsx` | YES | Backend API Server |
| `/landing-page/aria-report`| GET | `ARIAReport.tsx` | YES | Backend API Server |
| `/landing-page/creator-gallery`| GET | `CreatorGalleryPage.tsx`| YES | Backend API Server |

## Backend API Endpoints (Express / TS)
*Located in `artifacts/api-server/src/routes/`*

| Path | Method | Source File | Real Implementation | Missing Service | Test Coverage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `/api/forge/summary` | GET | `routes/forge.ts` | NO (MOCKED) | Persistence/Database | `test_sqlite_persistence.ts` (Failed typecheck) |
| `/api/forge/products`| POST/GET| `routes/forge.ts` | NO (MOCKED) | Persistence/Database | None |
| `/api/forge/jobs` | POST/GET| `routes/forge.ts` | NO (MOCKED) | Job Queue Worker | `test_helios_jobs.ts` |
| `/api/forge/previews`| POST/GET| `routes/forge.ts` | NO (MOCKED) | Persistence/Database | None |

## Python ML Endpoints
| Path | Method | Source File | Real Implementation | Consumer | Test Coverage |
| :--- | :--- | :--- | :--- | :--- | :--- |
| Local Script Execution | CLI | `services/project-titan-3d/*` | YES | Manual Execution Only | Yes (`viper_qa_suite.py`) |
| Local Script Execution | CLI | `sentinel_qc_engine.py` | YES | Manual Execution Only | Yes |

## CONCLUSION
The frontend routes are fully implemented visually, but the backend API routes return hardcoded mock responses or are blocked by typecheck failures. The Python machine learning pipelines exist but have no HTTP/WebSocket endpoints exposed to consume them from the React frontend.
