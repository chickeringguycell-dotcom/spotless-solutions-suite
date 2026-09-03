# Viper Studios Sync and Storage Strategy

This document details the sync and storage strategy for the Viper Studios workspace repository, outlining the synchronization patterns, large asset management, and folder exclusions between the local development environment and GitHub.

---

## 1. Workspace Topology (Local vs. Cloud)

- **Local Development Environment**: The active workspace folder (`C:\Users\U\Documents\antigravity\dazzling-noether`) resides on the local Windows machine. Local builds, development server runs, and physical hardware operations take place here.
- **Remote Version Control (GitHub)**: The remote repository `chickeringguycell-dotcom/Vipe-Studios` acts as the centralized host for source code, history tracking, and remote backup.
- **No Parallel Cloud Copies**: Antigravity operates directly on the local filesystem and does not maintain a separate cloud hosting sync of the workspace files other than the remote Git repository on GitHub.

---

## 2. Synchronization Boundaries

Antigravity does **not** automatically sync local builds, third-party libraries, or runtime test outputs to the cloud. Synchronization is strictly bounded:

- **Manual Commit and Push**: Code and assets are pushed to GitHub only when developers or agents run explicit Git commands (`git commit` and `git push`).
- **Secret & Cache Ignorance**: API tokens, `.env` files, databases, logs, and `node_modules` are restricted locally using `.gitignore` and are never committed.

---

## 3. Large File & Binary Asset Strategy (Git LFS)

Large creator assets (such as character models, clothing, textures, and animation sources) are managed through Git LFS (Large File Storage) to avoid repository size bloating.

### Active Tracking Rules (`.gitattributes`)
- **GLB Models (`*.glb`)**: Tracked via Git LFS.
- **FBX Models/Rigging (`*.fbx`)**: Tracked via Git LFS.
- **TGA Textures (`*.tga`)**: Tracked via Git LFS.
- **Blender Design Files (`*.blend`)**: **Tracked via Git LFS**. These are binary files representing source design geometry and are subject to large changes; tracking them via LFS prevents git packfile inflation.

### Excluded Formats (`.gitignore`)
- **Blender Backup Files (`*.blend1`)**: **Ignored completely**. Blender automatically creates `.blend1` recovery files during saves. These are transient local backups and serve no purpose in remote source control. They are excluded globally via `.gitignore`.
- **Trial Animation GLBs**: Maintained inside the ignored folder `artifacts/api-server/public/avatars/animation-tests/temp_test/`.

---

## 4. Folders Excluded from Syncing (Local-Only)

The following folders are excluded from Git version control to keep the remote workspace light:

1. `node_modules/` (Local dependencies)
2. `dist/`, `build/`, `static-build/` (Compiled output bundles)
3. `data/` (Local workspace JSON database databases, job queues, and fallback tables)
4. `artifacts/api-server/public/avatars/animation-tests/temp_test/` (Animation trial folders)
5. `artifacts/api-server/data/aria-memory/` (LLM context logs)
6. `.env`, `.env.*` (Credentials and local secrets)

---

## 5. Storage Optimization Guidelines

To prevent local disk space exhaustion:
1. **Develop inside Ignored Trial Folders**: Conduct transient model or texture test runs inside folders matching the ignore patterns (e.g. `temp_test/` or `scratch/`).
2. **Periodic Cleanup**: Delete local build artifacts and uncompressed trial images (`.png`/`.glb`) before migrating environments or packaging releases.
3. **LFS Offloading**: Verify that newly introduced binary formats (like Blender `.blend` files) are registered for Git LFS tracking before committing.
