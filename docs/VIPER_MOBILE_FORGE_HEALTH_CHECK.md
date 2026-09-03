# Viper Mobile Forge Health Check

## Concern

The Forge failed during a real demonstration. The likely causes are now documented in the project.

## Evidence Found

The file `artifacts/api-server/public/forge-diagnostic.html` records the old mobile failure:

- Three.js was loaded from an external CDN and could hang on device networks.
- The GLB loader never initialized when Three.js failed.
- Aria's old model path never loaded.
- Chat requests returned 401 because the APK was built without `EXPO_PUBLIC_VIPER_APP_TOKEN`.
- TTS could silently stop behind subscription verification.

The same diagnostic says the CDN and missing app token issues were fixed in v1.0.45.

## Current Source State

Current source contains the expected mobile app token in:

- `artifacts/viper-studio/eas.json`
- `artifacts/viper-studio/package.json`
- `artifacts/viper-studio/scripts/dev.cjs`

Current source also includes bundled Three.js support in:

- `artifacts/viper-studio/lib/three-scripts.ts`
- `artifacts/viper-studio/assets/three-0134.min.js`
- `artifacts/viper-studio/assets/three-vrm-1.min.js`

The current tab layout sets the initial route to Forge:

- `artifacts/viper-studio/app/(tabs)/_layout.tsx`
- `initialRouteName="workshop"`

## Finding

The desired startup flow is technically feasible and partly implemented:

Launch Viper Studios -> Forge tab opens first.

The remaining experience gap is:

Forge opens -> Aria visible -> Aria asks "What should we build today?"

That requires the Forge viewer to reliably load the current Aria/Viper Female Base V1 preview and not fall back to older placeholder systems.

## Risk

If the installed phone app predates v1.0.45 or was built from an older project copy, it may still fail even though the source files now contain the fix.

## Recommendation

For the next mobile checkpoint:

1. Build/install the newest APK from the saved project state.
2. Confirm Forge opens first.
3. Confirm local/bundled Three.js loads.
4. Confirm `/api/healthz` succeeds.
5. Confirm `/api/chat` includes the app token.
6. Confirm Viper Female Base V1 or Aria V1 preview appears instead of old fallback visuals.
7. Keep mobile as Forge Lite and move heavier creator workflows to the website.

## 2026-06-03 Foundation Update

Local API startup has been repaired and verified:

- API `.env` loading added.
- Local `PORT=3000` holder added.
- OpenAI and Gemini integrations now lazy-load instead of crashing the whole API when optional keys are missing.
- API build passes.
- Local `/api/healthz` returns `200 {"status":"ok"}`.

The current default mobile API fallback `REDACTED/api/healthz` is alive.

The previously shared Picard dev preview URL returned `404` for `/api/healthz`, so it should not be treated as the confirmed current API endpoint without further Replit verification.
