# ARIA Living Avatar System

## Core Decision

Aria is the primary interface to Viper Studio. She is not a static image, menu graphic, NPC decoration, or loading screen portrait.

Aria needs an original Viper-owned IMVU/VRChat-style avatar body that a Mantella-style AI layer can manipulate.

## Quality Bar

The avatar system must be built for one flagship-quality Aria before it is built for many lower-quality avatars.

Do not use these as the visual foundation:

- South Park-style characters
- simple round-head avatars
- Roblox-style avatars
- stick figures
- flat cartoon characters
- generic mobile-game placeholders
- extremely low-polygon humanoids

Temporary development assets are acceptable only when they preserve the high-quality humanoid architecture: full skeleton, face rig, blendshapes or morph targets, visemes, eye/head tracking, hair, clothing slots, accessories, and animation clips.

The first impression should be: "That looks like a real avatar." Not: "That is a placeholder."

## Architecture

```text
User
-> voice or text input
-> speech-to-text, when voice is enabled
-> LLM personality layer
-> memory system
-> emotion and intent layer
-> Aria avatar directive
-> avatar animation controller
-> text-to-speech voice
-> Aria response
```

## Avatar Body Requirements

- Original Viper-owned Aria avatar, inspired by IMVU and VRChat creator workflows.
- Standard humanoid rig, preferably VRM/Mixamo-compatible.
- High-quality stylized human proportions, not round-head or block-body proportions.
- Persistent skeleton with swappable products attached by slot.
- Face, body, eyes, hair, clothing, lips, brows, lashes, nails, teeth, makeup, and accessory slots.
- Blendshape or mesh controls for blink, smile, mouth/visemes, eye direction, brow, and expression.
- Idle animation clips for breathing, subtle head turns, weight shift, listening, thinking, speaking, and greeting.
- Lip sync support through visemes or equivalent mouth-shape controls.
- Hair system and clothing attachment system must be designed for future marketplace assets.
- No cartoon bouncing. Feet stay planted unless a locomotion animation is intentionally playing.

## Voice Direction

Aria's target voice is Scottish English, female, warm, intelligent, friendly, and early-20s sounding. The voice should feel capable and present, not sad, robotic, harsh, or like a default male system voice.

Current reference:

- Lucy, "Scottish Accent", Audio.com: https://audio.com/lucy-1797427301325534/audio/scottish-accent

Use this as a tone/accent reference only. Do not clone, train on, or commercially ship a matching voice unless rights are explicitly secured. The near-term product should use a legally available TTS voice that best matches the target. Later, Viper can commission or license a signature Aria voice.

## Manipulation Contract

The AI layer should not directly poke bones one by one. It should emit a simple directive:

```json
{
  "emotion": "curious",
  "intent": "build",
  "speech": "speaking",
  "gaze": "project",
  "gesture": "present_project",
  "loadingLine": "Preparing workspace..."
}
```

The avatar controller translates that directive into:

- facial expression
- gaze
- blink rate
- head pose
- idle intensity
- gesture clip
- mouth/voice sync
- loading/status display

The first TypeScript contract lives at:

`artifacts/viper-studio/lib/ariaLivingAvatar.ts`

That contract includes `ARIA_MINIMUM_AVATAR_CAPABILITIES`, which should remain the bar for the real Aria avatar body.

## Current Viper Integration Points

- `artifacts/viper-studio/components/ThreeViewer.tsx`: renders Forge, Aria body, avatar bases, expressions, gaze, speaking state.
- `artifacts/viper-studio/app/(tabs)/workshop.tsx`: orchestrates Forge conversation, memory injection, voice, and viewer commands.
- `artifacts/viper-studio/lib/ariaMemory.ts`: current persistent learning seed.
- `artifacts/viper-studio/lib/intentEngine.ts`: current intent/recommendation layer.
- `artifacts/api-server/src/routes/chat.ts`: LLM stream endpoint.
- `artifacts/api-server/src/routes/tts.ts`: TTS endpoint.
- `artifacts/api-server/src/routes/extract-learnings.ts`: memory extraction endpoint.

## Mantella / Herika Lessons To Adapt

- Keep a server-side or runtime orchestrator that owns conversation, world/project state, memory, and action selection.
- Separate spoken response from action directives.
- Treat memory as structured context, not just raw transcript.
- Let the AI issue controlled actions, not arbitrary direct code.
- Give the avatar a fast local fallback so she appears alive before remote AI or full 3D loading finishes.

## Phases

1. Use `AriaPresence` only as a high-quality temporary presence layer while the real humanoid body loads. Do not show cartoon placeholder bodies.
2. Promote `ariaLivingAvatar.ts` into the single contract between Aria's mind and body.
3. Replace the current temporary presence with the proper Aria base avatar: flagship humanoid, IMVU/VRChat-style, facial rig, visemes, hair, outfit, and body-part slots.
4. Add expression and gesture mapping in `ThreeViewer.tsx`.
5. Add viseme/mouth hooks for TTS.
6. Expand memory into user, relationship, project, and technical memory.
7. Add autonomous greetings, project status, suggestions, and completed-task notifications.
