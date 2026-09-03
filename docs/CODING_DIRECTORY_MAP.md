# Viper Studios Coding Directory Map

Status: active policy for read-only Coding Studio tools.

This document defines the technical boundaries and domain responsibilities for the AI coding agents within the Viper Studios workspace. It also defines the Viper Studios paths that Helios, Aria, and Gaius may inspect through read-only code tools.

The runtime must deny anything outside these paths, any secret-bearing path, protected avatar assets, large binary assets, generated build output, dependency folders, and machine-local data.

## Aria (Creative Director & Frontend)

Aria is responsible for UI, UX, Creator experience, Character behavior, Visual systems, and Frontend integration.

**Assigned Directories:**

- `artifacts/viper-studio/` (Expo React Native application)
- `artifacts/landing-page/` (Vite marketing and landing application)

## Gaius (Systems Architect & Backend)

Gaius is responsible for Backend, Architecture, Validation, Build fixes, Performance, and Infrastructure.

**Assigned Directories:**

- `artifacts/api-server/` (Express/Node.js backend)
- `scripts/` (Build, automation, and infrastructure scripts)
- `artifacts/mockup-sandbox/` (Technical sandbox tests)

## Allowed directories

- `artifacts/api-server/src`
- `artifacts/landing-page/src`
- `artifacts/viper-studio/app`
- `artifacts/viper-studio/components`
- `artifacts/viper-studio/contexts`
- `artifacts/viper-studio/lib`
- `artifacts/viper-studio/hooks`
- `artifacts/viper-studio/utils`
- `lib`
- `scripts`
- `docs`

## Allowed root files

- `package.json`
- `pnpm-workspace.yaml`
- `pnpm-lock.yaml`
- `tsconfig.json`
- `tsconfig.base.json`
- `.gitignore`
- `.gitattributes`
- `.npmrc`
- `README.md`
- `VIPER_NEW_THREAD_STARTUP.md`

## Denied paths

The Coding Studio read-only tools must always deny:

- `.env`
- `.env.*`
- `.secrets/`
- secret, credential, token, certificate, and key files
- `node_modules/`
- `dist/`
- `build/`
- cache folders
- log files
- generated packages
- model weights
- binary assets
- protected avatar source assets
- `artifacts/api-server/public/avatars/`
- protected Aria assets
- protected Gaius assets

## Tool scope

Allowed read-only tools:

- `inspectRepository`
- `searchFiles`
- `readFile`
- `gitStatus`
- `gitDiff`

Denied tool categories:

- edit tools
- write tools
- delete tools
- move tools
- commit tools
- push tools
- process-kill tools
- dependency installation tools
- external generator integration
