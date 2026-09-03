# Viper Studios Subsystem Status Matrix

| Subsystem | Status | Evidence |
| :--- | :--- | :--- |
| **SentinelQC** | VERIFIED WORKING | Python scripts exist. Outputs (`SentinelQC_JSON_Output.md`, `qc_output.txt`) exist. |
| **Avatar Forge (Project Titan)** | FUNCTIONAL BUT INCOMPLETE | Pipeline generates PNGs and `.blend` files (`Render_front.png`, `Avatar_Candidate_01.blend`), but orchestration is manual. |
| **Headquarters UI** | UI ONLY | React frontend (`landing-page/src`) is robust but disconnected from a backend. |
| **Helios Orchestrator** | MISSING | No `helios_server.py` or Node.js equivalent exists. UI mocks Helios events (`dispatchHeliosEvent`). |
| **Aria / Gaius Companions** | MISSING | Prompt definitions exist (`HAL_STARTER_PROMPT_utf8.md`, `AGENTS.md`), but no conversational LLM backend is wired to the UI. |
| **Workspace Registry** | UI ONLY | Configured in `forgeApi.ts` but backed by mock data. |
| **Reality Gate** | UI ONLY | Defined in React components, but no game engine streaming backend exists. |
| **Job Queue** | UI ONLY | Implemented in `JobQueue` component, powered by mock data. |
