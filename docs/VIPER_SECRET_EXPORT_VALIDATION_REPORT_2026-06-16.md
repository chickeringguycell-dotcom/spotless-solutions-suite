# VIPER SECRET EXPORT VALIDATION REPORT

Date: 2026-06-16

Status: export safety validation complete.

No live credentials are included in this report.

## Mission

Prepare the Gemini/Firebase cloud migration export safely.

Requirements:

- Do not expose real credentials.
- Do not remove credentials from the live Viper project.
- Do not modify runtime behavior.
- Create documentation only.
- Redact the export copy only.

## Summary

Secret placeholder registry created:

- `docs/VIPER_SECRETS_PLACEHOLDER_REGISTRY.md`

Export package updated:

- `cloud-review-export/Viper_Studios_Complete_Cloud_Review_Package`

Zip package to rebuild:

- `cloud-review-export/Viper_Studios_Complete_Cloud_Review_Package.zip`

## Secret Count

Inventory result:

- 24 credential/secret/service-identifier records documented.
- 5 non-secret deployment environment records documented.
- 2 live `.env` files identified and excluded from export.
- 1 live `.replit` environment block identified and redacted in export copy.

## Live Secret-Bearing Files Identified

The following live files contain or reference credential values or environment-controlled secrets:

- `artifacts/api-server/.env`
- `artifacts/viper-studio/.env`
- `.replit`
- `artifacts/viper-studio/eas.json`
- `artifacts/viper-studio/package.json`
- `artifacts/viper-studio/scripts/dev.cjs`
- `artifacts/landing-page/src/pages/StudioPage.tsx`
- `artifacts/landing-page/src/pages/LandingPage.tsx`
- `artifacts/viper-studio/app/(tabs)/settings.tsx`
- `artifacts/viper-studio/contexts/AppContext.tsx`
- `artifacts/viper-studio/lib/revenuecat.tsx`
- API/server source files that read env vars but do not contain active values
- docs and architecture files that reference secret names

## Registry Coverage

The placeholder registry documents:

- `OPENAI_API_KEY`
- `AI_INTEGRATIONS_OPENAI_API_KEY`
- `OPENAI_TTS_KEY`
- `OPENAI_BASE_URL`
- `AI_INTEGRATIONS_OPENAI_BASE_URL`
- `GEMINI_API_KEY`
- `GOOGLE_API_KEY`
- `AI_INTEGRATIONS_GEMINI_API_KEY`
- `GEMINI_BASE_URL`
- `AI_INTEGRATIONS_GEMINI_BASE_URL`
- `CVOICE_API_KEY`
- `VIRUSTOTAL_API_KEY`
- `VIPER_APP_TOKEN`
- `EXPO_PUBLIC_VIPER_APP_TOKEN`
- `VIPER_OWNER_CODE`
- `REVENUECAT_SECRET_KEY`
- `EXPO_PUBLIC_REVENUECAT_TEST_API_KEY`
- `EXPO_PUBLIC_REVENUECAT_IOS_API_KEY`
- `EXPO_PUBLIC_REVENUECAT_ANDROID_API_KEY`
- `REVENUECAT_PROJECT_ID`
- `REVENUECAT_TEST_STORE_APP_ID`
- `REVENUECAT_APPLE_APP_STORE_APP_ID`
- `REVENUECAT_GOOGLE_PLAY_STORE_APP_ID`
- `EXPO_TOKEN`

Non-secret deployment environment values documented:

- `EXPO_PUBLIC_API_BASE_URL`
- `EXPO_PUBLIC_DOMAIN`
- `EXPO_PUBLIC_REPL_ID`
- `VITE_API_BASE_URL`
- `BASE_PATH`

## Export Copy Files Affected

The export copy contains redactions in these files:

- `project/.replit`
- `project/replit.md`
- `project/artifacts/landing-page/public/architecture.html`
- `project/artifacts/landing-page/src/pages/LandingPage.tsx`
- `project/artifacts/landing-page/src/pages/StudioPage.tsx`
- `project/artifacts/viper-studio/app/(tabs)/settings.tsx`
- `project/artifacts/viper-studio/components/ThreeViewer.tsx`
- `project/artifacts/viper-studio/contexts/AppContext.tsx`
- `project/artifacts/viper-studio/eas.json`
- `project/artifacts/viper-studio/lib/apiBase.ts`
- `project/artifacts/viper-studio/lib/revenuecat.tsx`
- `project/artifacts/viper-studio/package.json`
- `project/artifacts/viper-studio/scripts/dev.cjs`
- `project/docs/VIPER_FOUNDATION_HEALTH_CHECK.md`
- `project/docs/VIPER_MOBILE_FORGE_HEALTH_CHECK.md`

Documentation added to export:

- `VIPER_SECRETS_PLACEHOLDER_REGISTRY.md`
- `project/docs/VIPER_SECRETS_PLACEHOLDER_REGISTRY.md`
- `project/docs/VIPER_SECRET_EXPORT_VALIDATION_REPORT_2026-06-16.md`

## Export Exclusions Confirmed

The export package excludes:

- `.env`
- `.env.*`
- `node_modules`
- `dist`
- build folders
- cache folders
- Git metadata
- logs
- zip/temp files
- browser profile cache
- Expo cache
- LocalLow cache
- model weights

## Validation Results

### Live Project Still Contains Original Values

Confirmed:

- Live API `.env` still contains the original server OpenAI key lines.
- Live mobile `.env` still contains the original Expo/RevenueCat environment lines.
- Live `.replit` still contains the original Viper app token and owner-code lines.
- Runtime source behavior was not changed.

Only documentation files were added to the live project.

### Export Package Contains No Active Credentials

Checked the staged export package for known active credential patterns:

- OpenAI project-key prefix pattern
- Viper app token value
- owner-code value
- RevenueCat public key values
- RevenueCat project/app identifiers
- current Replit public API URL

Result:

```text
NO_ACTIVE_CREDENTIAL_PATTERNS_FOUND
```

### Placeholder Registry Coverage

Confirmed:

- Every redacted credential family has a registry entry.
- Every registry entry includes purpose, location, required use, export value, and restore instructions.
- Export values are placeholders only.

## Confirmation

The live Viper project was not stripped of secrets.

The Gemini/Firebase export copy has redacted credential values and includes a restore registry.

The package can be shared for cloud migration review without intentionally exposing live credentials.

## Recommended Follow-Up

Before production cloud migration:

1. Rotate `VIPER_APP_TOKEN`.
2. Rotate `VIPER_OWNER_CODE`.
3. Remove hardcoded dev owner/app token copies from runtime source.
4. Move all server secrets to Firebase/Cloud Secret Manager.
5. Move public mobile build values to EAS/Firebase build configuration.
6. Add a secret-scanning step before every future export.
