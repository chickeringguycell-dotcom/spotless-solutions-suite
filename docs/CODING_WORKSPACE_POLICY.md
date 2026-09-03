# Viper Studios Coding Workspace Policy

This policy governs all automated and agent-assisted coding operations within the Viper Studios workspace.

## 1. Asset Protection
- Agents **MUST NEVER** overwrite, delete, or directly modify protected avatar assets (e.g., base meshes, original rigs) during coding operations.
- Generation of new assets must output to designated workspace or intake directories.

## 2. Safety and Execution
- No code modifications should be pushed directly to `main` without verification.
- Agents must run `typecheck` and `build` after applying patches before considering a feature complete.
- Unapproved or unverified code should not be permanently merged.

## 3. Tool Usage
- Agents have access to read, propose, and apply code patches via the Helios Tool Registry.
- Broad filesystem modifications must be restricted to standard project files.
