# Antigravity Working Rules for Viper Studios

These are the permanent working rules for the Antigravity AI coding assistant when developing inside the Viper Studios codebase.

---

## 1. Work Session Completion & Reporting

Every time Antigravity stops work or completes a task, it must produce a clear, copy-pasteable completion report (suitable for sharing with other environments or models, such as ChatGPT).

Each report must include:
* **What was changed**: Summary of features, fixes, or enhancements.
* **Modified Files**: List of all files changed, created, or deleted.
* **Tests Executed**: Test scripts run and their outcomes.
* **Typecheck Status**: Status of typescript typechecking (`pnpm run typecheck`).
* **Build Status**: Compilation status of the packages (`pnpm build`).
* **Git Status**: Output of the staged and unstaged files.
* **Commit Hash**: The remote push commit hash (if pushed).
* **Unresolved Issues**: Outstanding tasks, blockers, or warnings if any.

---

## 2. Session Saving & GitHub Synchronization

At the end of every work session, Antigravity must ask the user whether they want to save the day's work to GitHub.

If the user approves, Antigravity must automatically execute this workflow:
1. **Run Git Status**: Check for dirty files or uncommitted changes.
2. **Run Typecheck**: Ensure the entire workspace typechecks successfully (`pnpm run typecheck`).
3. **Run Build**: Verify that the production bundles compile cleanly (`pnpm build`).
4. **Clean Workspace**: Automatically discard or ignore test runtime data, mock logs, temporary files, heavy cached GLB assets, and protected avatar assets, unless explicitly approved by the user.
5. **Commit**: Stage and commit only safe source code, documentation, and configuration changes.
6. **Push**: Push the commit to the `main` branch on GitHub.
7. **Report Commit**: Disclose the final commit hash in the summary.

---

## 3. Resource Preservation & Security

* **Protected Assets**: Antigravity must **never** delete, move, overwrite, or purge avatars, animations, GLB, FBX, Blender files, or other protected character assets without explicit user approval.
* **API Credentials & Secrets**: Antigravity must **never** print, log, or leak API keys, access tokens, or private environment configuration values.
* **Phase Boundaries**: Antigravity must **not** begin Phase 5 or integrate external 3D generators (e.g. Meta SAM, Trellis, InstantMesh) without explicit user authorization.
* **Source of Truth**: GitHub is the definitive source of truth for all Viper Studios code and config assets.
