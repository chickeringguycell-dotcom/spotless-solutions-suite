# Viper Studios Prioritized Roadmap

## P0: The Platform Spine (Bridge the Gap)
Build the central Helios API Server (Node.js/Express or Python FastAPI) to replace `MOCK_FORGE_SUMMARY` and `localStorage` persistence. The frontend must talk to a real backend.

## P1: First Vertical Slice (Avatar Forge)
Connect the existing `services/project-titan-3d` Python scripts to the new Helios API Server. This allows a user to click "Generate" in the web UI and trigger the real Python pipeline natively.

## P2: SentinelQC Automation
Wire the existing SentinelQC scripts (`sentinel_qc_engine.py` and validators) into the Helios API Server so generated assets are automatically validated before being returned to the UI Review Queue.

## P3: Expanding Forges
Once Avatar Forge is connected end-to-end, begin replacing the UI mocks for Vehicle Forge, Environment Forge, etc., with real generative backends.
