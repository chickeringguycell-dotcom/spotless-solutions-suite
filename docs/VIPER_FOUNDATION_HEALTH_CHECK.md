# Viper Foundation Health Check

## Verified Milestone

Date: 2026-06-03

The local Viper API foundation now starts cleanly enough to answer health checks.

Verified:

- API server builds successfully.
- API server starts from `artifacts/api-server/dist/index.mjs`.
- Local health endpoint returns `200 {"status":"ok"}` at `http://127.0.0.1:3000/api/healthz`.
- Mobile TypeScript check passes.
- API TypeScript check passes.
- OpenAI integration TypeScript check passes.
- Gemini integration TypeScript check passes.
- Focused mobile behavior tests pass: 60 tests, 0 failures.

## Fixes Applied

### API `.env` startup loading

The API server now loads `artifacts/api-server/.env` before app routes initialize.

This fixes the case where a key or port exists in the file but is invisible to the running server.

### API local port

The API `.env` now includes:

- `PORT=3000`

Deployments can still override this with their own `PORT`.

### OpenAI configuration

OpenAI server routes now accept the normal Viper key holder:

- `OPENAI_API_KEY`

They also still support Replit/integration-style variables:

- `AI_INTEGRATIONS_OPENAI_API_KEY`
- `AI_INTEGRATIONS_OPENAI_BASE_URL`

OpenAI clients are lazy-loaded, so missing OpenAI keys no longer crash the whole server during startup. Routes that actually need OpenAI will still fail clearly until the key is installed.

### Gemini configuration

Gemini clients are also lazy-loaded. Missing optional Gemini keys no longer crash the whole server during startup.

Supported holders:

- `GEMINI_API_KEY`
- `GOOGLE_API_KEY`
- `AI_INTEGRATIONS_GEMINI_API_KEY`

## Current API Target Check

Current default mobile fallback API target:

- `REDACTED/api/healthz`

Result:

- `200 {"status":"ok"}`

Previously shared dev preview URL:

- `https://5db4be00-0bb5-4d99-8751-4cbc41ee1359-00-3u4w1phlond22.picard.replit.dev/api/healthz`

Result:

- `404 Not Found`

This means the Picard dev preview URL should not be treated as the confirmed current API target unless Replit exposes the API on a different path.

## Forge Source State

Current source supports the desired startup direction:

- Mobile tab layout starts on `workshop`.
- `workshop` is titled `FORGE`.
- The Forge greeting is present: `What shall we build today?`
- `ThreeViewer` auto-boots the Forge environment.
- `AriaPresence` provides an animated loading presence.

Important limitation:

- Visible Aria is still a photoreal reference/presence path, not the final live rigged Aria GLB.

## Remaining Blockers

### Server OpenAI key

`OPENAI_API_KEY` is still empty in the API server `.env`.

Until a valid non-exposed server key is installed, health and static assets can work, but Aria chat, transcript correction, research, build planning, and voice fallback cannot be fully verified.

### Installed phone build

The source code is newer than what may be installed on the phone.

If the phone app was built before the current Forge fixes, it may still fail even though the source is healthier now.

### Visible Aria V1

Viper Female Base V1 and Aria references exist, but the next product milestone remains:

- Assemble a visible Aria V1 preview from the accepted base, identity texture blocks, dark hair, violet eyes, and necklace slot.

## Next Recommended Milestone

Install a valid server-side `OPENAI_API_KEY`, then verify:

1. `/api/chat` responds.
2. `/api/tts` returns audio or a clear provider error.
3. Mobile Forge opens first.
4. Aria loading presence appears.
5. Aria V1 preview path is advanced from reference presence to live avatar assembly.
