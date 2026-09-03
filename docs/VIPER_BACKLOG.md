# Viper Studios Backlog

Purpose: this is the master parking lot for future Viper Studios work.

Use this file for ideas, requests, commands, wishlist items, and future build tasks that should not interrupt the active repair work.

This file is also the chosen place to preserve:

- Past commands and decisions already discussed.
- Present active commands and priorities.
- Future commands and ideas the user gives later.

## Ground Rules

- Current priority stays first: fix Aria, Forge loading, app connection, and API key configuration.
- Future ideas go here until the foundation is stable.
- Do not automatically begin backlog items.
- When the critical milestones are complete, review backlog items with the user and prioritize implementation together.
- Do not store secrets, API keys, tokens, passwords, or private account data here.
- IMVU remains compatibility/reference language unless explicit written permission or clean licensing is confirmed.
- Prefer Viper-authored or properly licensed assets for production.

## Critical Milestone Gate

Backlog items stay parked until these are complete:

1. OpenClaw/OpenAI authentication working.
2. Forge opens on website.
3. Forge opens on mobile app.
4. Aria visible.
5. Aria speaks.
6. Aria supports basic conversation and memory.

## Active Priorities

### P0: Aria Activation

- Aria is the number one flagship goal.
- Load protected CC5 Aria on web and mobile.
- Make Aria visible, animated, walking, talking, and connected to OpenAI/ChatGPT.
- Use the Viper-native Aria Director Layer to convert ChatGPT output into voice, facial expressions, gestures, gaze, idle behavior, movement, and avatar actions.
- Treat Mantella and Herika as reference architectures only, not dependencies.
- Keep asking clearly when an Aria-critical blocker requires a user-provided key, export, texture folder, voice service, build token, license, plugin, or asset file.
- When Aria activation is blocked, continue backlog work without losing the Aria-first priority.

### P0: Viper Activity Indicator

- Add a Viper orange Cylon-style scanning indicator for thinking, implementing, loading, processing, generating, and working states.
- Use it near labels such as Thinking, Implementing, Loading, Generating, or Working.
- Make it part of Viper's interface identity so the app never feels frozen while the system is active.

### P0: Foundation Fixes

- Fix OpenClaw/OpenAI authentication.
- Treat previous reports that OpenClaw was fixed as unverified; user confirmed OpenClaw never worked and needs fresh attention.
- Install and verify a fresh server-side `OPENAI_API_KEY` in `artifacts/api-server/.env`.
- Verify `/api/chat` responds after the key is installed.
- Verify `/api/tts` returns audio or a clear provider error.
- Confirm Forge opens on the website.
- Confirm the mobile app points to the correct live API target.
- Confirm the installed phone build is not an outdated build.
- Confirm Forge opens first on mobile.
- Confirm Aria loading presence appears while Forge initializes.
- Remove or hide old placeholder avatar paths from the visible flagship experience.

## Command Log

### Present Commands

- Fix Aria first.
- Fix website / Forge loading issues.
- Fix app connection and API key configuration.
- Do not let lower-priority creator features delay visible Aria V1.
- Keep a safe backlog for future work items.

### Past Commands Captured

- Treat Aria as the center of Viper Studios, not a static image or decoration.
- Make Forge open automatically with Aria present and ready to build.
- Avoid cartoon, noodle, robot, tire, or toy-like avatar placeholders in the visible flagship experience.
- Retire MakeHuman / MPFB and Viper Female Base V1 from active Viper production scope.
- Do not build Viper as a public avatar generator or skin generator.
- Treat Aria as the protected CC5 flagship assistant, not a public creator base.
- Preserve IMVU-style creator mechanics as compatibility/reference concepts while keeping production assets Viper-authored or properly licensed.
- Build creator workflows around feasible non-avatar products: clothing, accessories, props, furniture, rooms, buildings, vehicles, ships, weapons, tools, non-skin materials, lighting, effects, audio, inventory, product cards, and export behavior.
- Keep wardrobe products separate from Aria identity.
- Keep mobile lighter and move heavy creator/studio tooling primarily to the website.

### Future Command Inbox

Add new user requests here first if they are not part of the immediate fix work.

- Backlog item: Aria Builder-Agent Vision.
- Backlog item: Hands-Free Voice System.
- Backlog item: Viper Studios Security Audit.
- Requirement: do not begin backlog items automatically; review and prioritize with user after critical milestones.
- Priority command: Aria first, backlog second. Build the protected CC5 Aria assistant before lower-priority creator systems.
- Architecture command: build Viper's own Aria Director Layer; do not assume Mantella itself is the solution.

### P1: Visible Aria V1

- Keep protected CC5 Aria V5 visible as the current Aria checkpoint.
- Do not resume MakeHuman morphing, public avatar bases, or public skin/face/eye/makeup product work.
- Preserve dark hair as protected Aria identity/wardrobe work, not a public hair product.
- Preserve violet/purple eyes as protected Aria identity, not a public eye product.
- Add geometric triangle necklace as an approved Aria wardrobe attachment.
- Keep wardrobe separate from Aria identity.
- Show a visible checkpoint that clearly reads as: "This is the girl we are building."

### P1: Forge Startup Experience

- Long-term startup flow:
  Launch Viper Studios -> Forge opens automatically -> Aria is visible -> Aria asks, "What shall we build today?"
- Keep Aria as the primary interface, not a static profile image.
- Prevent repeated/stuttering speech such as duplicate words or nonsense loops.
- Preserve conversation context.
- Show progress clearly when Forge systems are loading.

## Aria Identity Backlog

- Improve face resemblance using approved Aria references.
- Improve head shape, jawline, cheekbones, eye spacing, nose, lips, chin, and forehead.
- Build toward a believable digital human, not cartoon, noodle, robot, or toy-style placeholder.
- Add facial expression system: neutral, smile, thinking, surprised, concerned, focused.
- Add blinking, gaze movement, breathing, subtle head movement, posture, and idle presence.
- Add speech/lip-sync later after the visual identity is stable.
- MakeHuman/Blender/MPFB morphing is retired from active scope.
- Aria's active lane is protected CC5 Aria assets, not Viper Female Base V1.

## Wardrobe Backlog

- Aria Leather Jacket V1:
  dark weathered leather, purple accents, layered collar/inner liner, not a hood.
- Aria Jeans V1.
- Aria Sneakers V1.
- Aria Necklace V1.
- Aria Hair V1.
- Add casual outfit, work outfit, seasonal outfits, and creator showcase outfits.
- Let Aria change clothes by equipping wardrobe products, not rebuilding her avatar.
- Keep clothing as product entries with categories and attachment slots.

## Product Library / Inventory Backlog

- Add Product Library / Wardrobe system.
- Finished products should appear as product cards, not raw files.
- Product cards should include:
  thumbnail, product name, category, status, and equip button.
- Add Equipped Items / Current Outfit list.
- Current outfit should show active products by slot:
  jacket, pants, shoes, necklace, approved hair/wardrobe references, and protected Aria appearance state.
- Support equip/unequip without rebuilding Aria.
- Apply same product-card workflow to Aria, user avatars, NPCs, and future creator products.

## Creator Workflow Backlog

- Build IMVU-style creator category thinking without copying proprietary assets.
- Category-first workflow:
  jacket, shirt, pants, shoes, necklace, hat, accessory, prop, furniture, room, building, vehicle, ship, weapon, tool, material, decal, lighting, effect, audio.
- World categories:
  furniture, decorations, lighting, effects, audio, environment assets.
- Vehicle categories:
  ships, parts, engines, weapons, interior assets.
- Assets should know where they belong and how they attach.
- Add attachment slots:
  neck, head, hair, eyes, torso, arms, hands, hips, legs, feet, back, world socket, vehicle socket.
- Support derivable/creator workflow using Viper-authored or properly licensed base assets.
- Keep manual creator controls available; Aria assists but does not replace manual mode.

## IMVU Creator / Dev Room Backlog

- Add IMVU Creator / Dev Room workspace when foundation is stable.
- Left side: product preview pane or approved fit/reference preview.
- Right side: creator controls.
- Do not support public female/male avatar base generation.
- Allow rotate, zoom, inspect, and preview on products, rooms, props, vehicles, or approved fixed fit references.
- Support texture tests for clothing, accessories, props, rooms, furniture, vehicles, ships, weapons, tools, decals, and non-skin materials.
- Support upload of clothing textures, object textures, material maps, UV maps, and UV frames.
- Support applying textures to selected product surfaces, not public avatar skin/body parts.
- Support reset preview, save preview, export test result.
- Support object and room asset development: furniture, rooms, walls, floors, decor, lighting.
- Add multi-actor preview later:
  add actor, remove actor, select active actor, pose actors, dress each actor separately.

## Website vs Mobile Backlog

- Mobile app should stay lighter:
  Aria, chat, Forge Lite, avatar preview/customization, simple texture testing, inventory/library browsing, social features.
- Website should carry heavier tools:
  Full Forge, world building, large scenes, heavy asset editing, animation tools, advanced creator workflows, project management.
- Do not remove Forge from mobile; split into Mobile Forge Lite and Website Full Forge.
- Track features that make mobile too heavy and move them to website when needed.

## Asset Intake Backlog

- Use `C:\Users\U\Documents\Viper_Asset_Drop` as the obvious asset drop folder.
- Treat drop folder as intake/staging only, not the organized final library.
- Inspect dropped assets before importing.
- Sort approved assets into the proper Viper project structure.
- Track source, license, category, slot, and status for every asset.

## Research / Architecture Backlog

- Continue studying AI NPC architecture concepts from Mantella and Herika for conversation, memory, emotion, intent, and avatar animation control.
- Add memory system later:
  user profile, relationship memory, project memory, long-term recall.
- Add emotion and intent layer later:
  happy, curious, excited, concerned, thinking, focused.
- Add autonomous behavior later:
  greetings, suggestions, project status, completed-task notifications.
- Keep Aria as primary interface and creative partner.

### Aria Builder-Agent Vision

Long-term objective: Aria is not merely a chatbot or avatar. Aria must evolve into an autonomous creator-agent.

Future capabilities:

- Reason through creative and technical tasks.
- Research references when uncertain.
- Inspect project files.
- Write and modify code.
- Operate internal Forge tools.
- Operate approved external tools when required.
- Build assets visibly inside the Forge.
- Explain decisions while working.
- Accept user corrections during construction.
- Maintain project memory and design decisions.
- Maintain backlog items and future tasks.

Target behavior example:

- User says: "Aria, build me a Colonial Viper for Starfield."
- Aria gathers references.
- Aria creates a build plan.
- Aria begins construction inside Forge.
- Aria shows visible progress.
- Aria accepts corrections.
- Aria researches discrepancies.
- Aria explains corrections.
- Aria continues building.

### Hands-Free Voice System

Future objective: move away from mandatory push-to-talk while keeping push-to-talk as an optional fallback.

Future capabilities:

- Voice Activity Detection.
- End-of-speech detection.
- Hands-free voice interaction.
- Automatic speech-to-text.
- Natural conversational flow.

Desired behavior:

- User simply speaks.
- System detects speech start.
- System detects speech end.
- Aria processes the request.
- Aria responds naturally.

## Security Backlog

### Viper Studios Security Audit

Future objective: perform a complete security audit after critical milestones are stable.

Audit scope:

- Website.
- Mobile application.
- APIs.
- Database access.
- Authentication systems.
- File upload systems.
- Forge systems.
- Aria systems.
- Admin tools.
- Third-party integrations.

Required report sections:

1. Critical Vulnerabilities:
   exposed API keys, secrets in source control, authentication bypasses, authorization failures, database exposure, remote code execution risks.
2. High Risk Vulnerabilities:
   missing rate limiting, weak password requirements, insecure uploads, unsafe input handling, XSS, injection vulnerabilities.
3. Medium Risk Issues:
   information leakage, excessive permissions, missing audit logs, missing monitoring, configuration weaknesses.
4. API Security Review.
5. Forge Security Review.
6. Aria Security Review.
7. Database Security Review.
8. Security Scorecard:
   authentication, authorization, API security, database security, mobile security, web security, AI security, overall security.
9. Remediation Plan:
   immediate, high priority, recommended, future improvements.

Output requirements:

- Findings must include file names.
- Findings must include code locations.
- Findings must include risk level.
- Findings must include recommended fixes.

## Parked Future Ideas

- Full creator marketplace-style flow.
- Product derivation and lineage tracking.
- Creator product export formats.
- Starfield mod creation pipeline.
- Ship, vehicle, room, and environment creation systems.
- Advanced digital human rendering: skin, eyes, hair, micro-expressions, voice sync, body language.
- Voice upgrade toward a warm, intelligent Scottish female voice using legally available TTS or commissioned/licensed voice work.

## Today / Inbox

Use this section for new items the user gives today. Move them into the proper section later.

- Created this backlog as the master place for future Viper Studios tasks.
