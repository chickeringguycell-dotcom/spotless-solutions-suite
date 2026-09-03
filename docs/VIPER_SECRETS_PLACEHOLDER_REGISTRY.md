# VIPER SECRETS PLACEHOLDER REGISTRY

Date: 2026-06-16

Status: placeholder registry for Gemini/Firebase export safety.

No live credentials are included in this document. Every export value is `REDACTED`.

## Purpose

This registry tells a cloud reviewer which credentials and environment values Viper uses, where those values appear, what they are for, and how to restore them after migration.

Rules:

- Do not paste real secrets into Gemini/Firebase review packages.
- Do not commit real secrets.
- Do not ship server secrets to mobile or Website bundles.
- Restore secrets through Firebase Secret Manager, cloud environment variables, EAS secrets, or local `.env.local` files.
- Keep public client keys separate from server-only secrets.

## Secret And Environment Records

| Secret Name | File Location | Purpose | Required For | Export Value | Restore Instructions |
|---|---|---|---|---|---|
| `OPENAI_API_KEY` | `artifacts/api-server/.env`; read by `artifacts/api-server/src/lib/openaiConfig.ts`, `artifacts/api-server/src/routes/aria.ts`, `artifacts/api-server/src/routes/tts.ts`, `lib/integrations-openai-ai-server/src/env.ts` | Server-side OpenAI access for Aria, chat, image/audio integration fallback, and TTS fallback. | API server AI routes. | `REDACTED` | Add to Firebase/Cloud secret store or API server `.env.local`. Never expose to mobile. |
| `AI_INTEGRATIONS_OPENAI_API_KEY` | `artifacts/api-server/.env`; read by OpenAI integration packages under `lib/integrations-openai-ai-server` and `lib/integrations/openai_ai_integrations` | Alternate OpenAI key for generated integration client paths. | OpenAI image/audio integrations. | `REDACTED` | Restore as a server-only cloud secret. May mirror `OPENAI_API_KEY` if that is the chosen policy. |
| `OPENAI_TTS_KEY` | `artifacts/api-server/.env`; read by `artifacts/api-server/src/routes/tts.ts` | Optional separate OpenAI key for voice fallback. | Aria voice fallback when separate TTS billing/key is desired. | `REDACTED` | Add only if using a distinct TTS key; otherwise leave unset and use `OPENAI_API_KEY`. |
| `OPENAI_BASE_URL` | `artifacts/api-server/.env`; read by `artifacts/api-server/src/lib/openaiConfig.ts` and `tts.ts` | Optional OpenAI-compatible endpoint override. | Custom OpenAI-compatible routing. | `REDACTED` | Restore only if using a custom endpoint. Leave unset for normal OpenAI. |
| `AI_INTEGRATIONS_OPENAI_BASE_URL` | `artifacts/api-server/.env`; read by OpenAI integration packages | Optional base URL override for generated OpenAI integration clients. | Custom OpenAI-compatible routing for integration clients. | `REDACTED` | Restore only if required by deployment. |
| `GEMINI_API_KEY` | `artifacts/api-server/.env`; read by `lib/integrations-gemini-ai/src/env.ts` | Server-side Gemini access. | Gemini-backed image/text routes. | `REDACTED` | Add to Firebase/Cloud secret store or API server `.env.local`. Never expose to mobile. |
| `GOOGLE_API_KEY` | Fallback read by `lib/integrations-gemini-ai/src/env.ts` | Alternate Google/Gemini API key name. | Gemini-backed routes if `GEMINI_API_KEY` is not used. | `REDACTED` | Restore as server-only cloud secret if this naming convention is preferred. |
| `AI_INTEGRATIONS_GEMINI_API_KEY` | `artifacts/api-server/.env`; read by `lib/integrations-gemini-ai/src/env.ts` and `lib/integrations/gemini_ai_integrations/src/server/image/client.ts` | Alternate Gemini key for generated integration paths. | Gemini integration package. | `REDACTED` | Restore as server-only cloud secret. |
| `GEMINI_BASE_URL` | `artifacts/api-server/.env`; read by Gemini integration env loader | Optional Gemini-compatible endpoint override. | Custom Gemini-compatible routing. | `REDACTED` | Restore only if using a custom endpoint. |
| `AI_INTEGRATIONS_GEMINI_BASE_URL` | `artifacts/api-server/.env`; read by Gemini integration package | Optional base URL override for generated Gemini integration clients. | Custom Gemini-compatible routing. | `REDACTED` | Restore only if required by deployment. |
| `CVOICE_API_KEY` | Read by `artifacts/api-server/src/routes/tts.ts`; referenced by voice reports | cvoice.ai key for Aria voice route before OpenAI fallback. | Aria voice output if cvoice.ai is enabled. | `REDACTED` | Add to server-only cloud secret store. Leave unset to use OpenAI TTS fallback. |
| `VIRUSTOTAL_API_KEY` | Read by `artifacts/api-server/src/lib/virusScan.ts`; referenced in security reports | Optional VirusTotal scanner key for upload safety checks. | Asset upload scanning if VirusTotal is enabled. | `REDACTED` | Add to server-only cloud secret store. Leave unset for current mock/no-real-scanner mode. |
| `VIPER_APP_TOKEN` | `.replit`; read by `artifacts/api-server/src/app.ts` | Server-side expected app token for API request gate. | API app-token protection. | `REDACTED` | Store as server-only secret. Mobile/Website must receive matching public token only through approved build config. |
| `EXPO_PUBLIC_VIPER_APP_TOKEN` | `.replit`; `artifacts/viper-studio/eas.json`; `artifacts/viper-studio/package.json`; `artifacts/viper-studio/scripts/dev.cjs`; read by `artifacts/viper-studio/lib/apiClient.ts`; hardcoded dev copy in `artifacts/landing-page/src/pages/StudioPage.tsx` | Client-side app token sent as `X-Viper-App-Token`. | Mobile/Website API access in current architecture. | `REDACTED` | Prefer EAS/Firebase public config or build-time env. Rotate token before production cloud migration if it has ever been shared. |
| `VIPER_OWNER_CODE` | `.replit`; `artifacts/api-server/src/routes/validate-promo.ts`; `artifacts/api-server/src/middleware/entitlement.ts`; local/dev copies in `artifacts/landing-page/src/pages/LandingPage.tsx` and `artifacts/viper-studio/app/(tabs)/settings.tsx`; docs references | Owner/Architect promo access code. | Owner access, entitlement bypass/dev unlocks. | `REDACTED` | Store server-side only. Remove local hardcoded copies before production or replace with server validation only. |
| `REVENUECAT_SECRET_KEY` | Read by `artifacts/api-server/src/middleware/entitlement.ts`; referenced in architecture docs | Server-side RevenueCat entitlement lookup. | Production entitlement verification. | `REDACTED` | Add to server-only cloud secret store. Never ship to mobile. |
| `EXPO_PUBLIC_REVENUECAT_TEST_API_KEY` | `.replit`; `artifacts/viper-studio/.env`; `artifacts/viper-studio/eas.json`; read by `artifacts/viper-studio/lib/revenuecat.tsx` | RevenueCat test/public SDK key. | Mobile dev/test purchases. | `REDACTED` | Restore through EAS public env or local mobile `.env.local`. Public client key but still redacted for external review. |
| `EXPO_PUBLIC_REVENUECAT_IOS_API_KEY` | `.replit`; `artifacts/viper-studio/.env`; `artifacts/viper-studio/eas.json`; read by `artifacts/viper-studio/lib/revenuecat.tsx` | RevenueCat iOS public SDK key. | iOS purchases/subscription checks. | `REDACTED` | Restore through EAS public env or local mobile `.env.local`. |
| `EXPO_PUBLIC_REVENUECAT_ANDROID_API_KEY` | `.replit`; `artifacts/viper-studio/.env`; `artifacts/viper-studio/eas.json`; read by `artifacts/viper-studio/lib/revenuecat.tsx` | RevenueCat Android public SDK key. | Android purchases/subscription checks. | `REDACTED` | Restore through EAS public env or local mobile `.env.local`. |
| `REVENUECAT_PROJECT_ID` | `.replit`; referenced by `scripts/src/seedRevenueCat.ts` output | RevenueCat project identifier. | RevenueCat setup/reconciliation scripts. | `REDACTED` | Restore in cloud environment or script-specific `.env.local` if needed. |
| `REVENUECAT_TEST_STORE_APP_ID` | `.replit`; referenced by `scripts/src/seedRevenueCat.ts` output | RevenueCat test store app identifier. | RevenueCat setup/reconciliation scripts. | `REDACTED` | Restore in cloud environment or script-specific `.env.local` if needed. |
| `REVENUECAT_APPLE_APP_STORE_APP_ID` | `.replit`; referenced by `scripts/src/seedRevenueCat.ts` output | RevenueCat Apple App Store app identifier. | RevenueCat iOS setup/reconciliation scripts. | `REDACTED` | Restore in cloud environment or script-specific `.env.local` if needed. |
| `REVENUECAT_GOOGLE_PLAY_STORE_APP_ID` | `.replit`; referenced by `scripts/src/seedRevenueCat.ts` output | RevenueCat Google Play app identifier. | RevenueCat Android setup/reconciliation scripts. | `REDACTED` | Restore in cloud environment or script-specific `.env.local` if needed. |
| `EXPO_TOKEN` | `artifacts/viper-studio/.env`; referenced by `.replit`, `replit.md`, `artifacts/viper-studio/contexts/AppContext.tsx` | Expo/EAS access token for Android builds. | EAS cloud builds. | `REDACTED` | Store in EAS secrets, CI secret store, or local `.env.local`. Never commit. |

## Non-Secret Deployment Configuration

These values are not credentials, but reviewers may need to set them during cloud migration.

| Name | File Location | Purpose | Export Value | Restore Instructions |
|---|---|---|---|---|
| `EXPO_PUBLIC_API_BASE_URL` | `artifacts/viper-studio/eas.json`; `artifacts/viper-studio/lib/apiBase.ts`; mobile routes/components | Public API endpoint for mobile builds. | `REDACTED` in export copy if it points to a local/current deployment. | Replace with Firebase/Cloud API URL. |
| `EXPO_PUBLIC_DOMAIN` | `artifacts/viper-studio/scripts/dev.cjs`; `artifacts/viper-studio/scripts/build.js`; `artifacts/viper-studio/lib/apiBase.ts` | Replit-style hosted domain fallback. | Placeholder/env reference. | Replace with cloud domain or remove if unused. |
| `EXPO_PUBLIC_REPL_ID` / `REPL_ID` | `artifacts/viper-studio/scripts/dev.cjs`; `artifacts/viper-studio/scripts/build.js` | Replit build/dev metadata. | Placeholder/env reference. | Remove or replace during Firebase migration if no longer needed. |
| `VITE_API_BASE_URL` | `scripts/viper-local-server-stability.ps1`; Website build/runtime config | Website API base URL. | Local/dev placeholder. | Set to Firebase/Cloud API URL in Website hosting config. |
| `BASE_PATH` | `scripts/viper-local-server-stability.ps1`; Website build/runtime config | Website base route for `/landing-page/`. | Local/dev placeholder. | Configure according to Firebase hosting path. |

## Export Redaction Policy

For Gemini/Firebase review, the export copy must contain:

- `REDACTED`
- `REDACTED_VIPER_APP_TOKEN`
- `REDACTED_VIPER_OWNER_CODE`
- `REDACTED_REVENUECAT_*`
- no `.env` files
- no live OpenAI/Gemini/CVoice/VirusTotal keys
- no Expo access token
- no active owner promo code

## Restore Order After Cloud Migration

1. Create cloud secret store entries for server-only secrets.
2. Restore server-only secrets: OpenAI, Gemini, cvoice.ai, VirusTotal, RevenueCat secret key, Viper app token, owner code.
3. Restore mobile public build env values through EAS/Firebase build configuration.
4. Remove or replace hardcoded dev owner/app token copies before production.
5. Rebuild mobile and Website with cloud endpoints.
6. Verify API health, app-token gate, RevenueCat entitlement checks, Aria route, TTS route, and upload scanner.

## Production Recommendations

- Rotate `VIPER_APP_TOKEN` before a real public cloud launch.
- Rotate `VIPER_OWNER_CODE` and remove local hardcoded owner-code fallbacks.
- Move RevenueCat public SDK keys to EAS/Firebase build config instead of static source/config files.
- Keep OpenAI/Gemini/CVoice/VirusTotal keys server-only.
- Add a CI secret scanner before every cloud export.
- Add a cloud secret registry owned by Viper, not by reports only.

