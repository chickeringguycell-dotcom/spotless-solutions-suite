# Aria Digital Human Roadmap

Aria remains the focus. The goal is not to copy MetaHuman, Reallusion, HeyGen, Synthesia, NVIDIA ACE, IMVU, VRChat, or any other platform. The goal is to identify the digital-human principles that make a character feel alive, then adapt the realistic parts into a Viper-owned Aria avatar system.

Current product rule: **IMVU mechanics, Viper photoreal quality.** IMVU-style slots, UV maps, product derivation, material overrides, body-part thinking, attachment nodes, and preview testing are required for creators. The visible avatar quality bar is Aria's photoreal reference set, not a cartoon, primitive, or low-detail temporary body.

## Preferred Aria Creation Lane

Character Creator / CC4 or newer is now the preferred production lane for Aria once Starfield stabilization is complete.

Reason:

- Character Creator starts from a professional digital-human base instead of a rough open-source body.
- Headshot-style photo-to-3D tooling can use Aria's approved face references as the starting point for a recognizable head.
- The ecosystem is built for skin materials, eye materials, hair, clothing, facial expressions, body animation, lip sync, and FBX/Blender handoff.
- It gives us a much faster path to "this is Aria" than MakeHuman plus manual sculpting.

Use Character Creator for:

- Aria face/head likeness.
- Aria body proportions.
- High-quality skin and eye materials.
- Hair, brows, lashes, lips, and makeup.
- Base garment and wardrobe fitting.
- Rigging, facial expression support, and animation-ready export.

Keep MakeHuman/MPFB as a free fallback or testing base only. Do not treat MakeHuman as the visual target for Aria if Character Creator is available.

Important: do not store Reallusion account passwords, license keys, or private credentials in project files. The user will sign in directly when needed.

## What Makes Digital Humans Believable

The modern digital-human stack is usually a combination of:

- High-quality humanoid mesh topology with deformation-friendly loops around eyes, mouth, cheeks, jaw, shoulders, elbows, hips, and knees.
- Physically based skin material: albedo, normal, roughness, specular, ambient occlusion, subsurface scattering, transmission, micro-normal detail, and subtle color variation.
- Realistic eyes: cornea/sclera/iris separation, wetness, tearline/occlusion, catchlights, pupil/iris detail, gaze targets, and natural blink timing.
- Hair built as either strand/groom hair, high-quality cards, or hybrid cards plus flyaways, with anisotropic highlights and light motion.
- Facial expression rig: blendshapes or morph targets for blinks, smiles, brows, cheek movement, jaw, lips, and phonemes/visemes.
- Audio-driven lip sync: generated viseme curves from speech audio, ideally blended with emotion and head motion.
- Idle life: breathing, weight shift, tiny posture changes, head turns, gaze wander, blinking, micro-smiles, listening reactions.
- Intent layer: Aria's emotion, attention, current task, and response state drive animation choices instead of animations running randomly.
- Director Layer: Viper's runtime bridge that turns ChatGPT output into voice, facial expression, gaze, gestures, idle behavior, walking, and Forge actions. Mantella is a reference pattern for this idea, not a dependency.

## Highest Realism Per Effort

1. Eyes, blink, and gaze.
   These are the fastest way to make Aria feel present. Bad eyes make even a good mesh feel empty. Early work should add eye wetness/catchlights, asymmetrical blink timing, gaze targets, and micro-saccades.

2. Facial expressions.
   A small expression set matters more than many body animations: neutral, listening, thinking, curious, happy, focused, concerned, speaking. Each should drive brows, eyes, cheeks, mouth corners, and head pose.

3. Idle motion.
   Breathing, weight shift, head movement, and responsive listening motion make Aria feel like she is standing by instead of being a static product render.

4. Lip sync.
   Once Aria speaks, even simple visemes are a large perceived jump. Later this should become audio-driven facial animation.

5. Skin and eyes material polish.
   Skin realism needs maps and lighting, but the first big win is reducing plastic shine and adding subtle texture, roughness variation, and subsurface warmth.

6. Hair.
   Hair is extremely visible but expensive. Early: stylized high-quality hair cards with purple-black material and a few animated strands. Later: groom/strand system or imported hair asset with LODs.

7. Body language.
   Important for long-term sentience, but it is stronger after face/eyes/gaze work is in place.

## What Viper Can Adapt

### Early

- Add an Aria expression controller that maps Aria's emotional/intent state to blendshape values, head pose, blink rate, gaze target, breathing, and idle stance.
- Use an ARKit-style blendshape vocabulary as the naming target for Aria's future face rig: eyeBlinkLeft/Right, jawOpen, mouthSmileLeft/Right, brow movement, eye look directions, and mouth shapes.
- Build a small viseme system before full AI lip sync: AA, EE, IH, OH, OU, closed mouth, smile/speaking blend.
- Upgrade current Aria skin materials with roughness/specular/normal/AO maps, then plan SSS/transmission for engines that support it.
- Add eye material rules: iris color, sclera, cornea gloss, tearline/occlusion fake, catchlight plane, gaze target.
- Keep the approved Aria target visible while the rigged mesh catches up.

### Middle

- Build or source a Viper-owned rigged Aria mesh with clean topology and standard skeleton.
- Add expression blendshapes and test them with the Aria expression controller.
- Add hair cards or a groom-convertible hair asset with LODs.
- Add audio-driven viseme generation from TTS output.
- Add "listening" and "thinking" animation states tied to LLM/Forge state.
- Add a creator-facing UV/slot system for skin, face, eyes, hair, makeup, base garment, and accessories.

### Later

- Integrate advanced audio-to-face models or external pipelines where licensing/performance fits.
- Add camera/device face tracking support for creators who want to puppeteer/test Aria-style avatars.
- Add high-end skin rendering in a native/desktop renderer: SSS, transmission, micro-normal, wrinkle maps, tension maps.
- Add strand/groom hair simulation with cards fallback.
- Add autonomous body language: turn toward work, gesture at build objects, react to completed tasks, look at user, look at scene objects.
- Add full memory/emotion/personality loop into animation: Aria should not just speak; she should visibly listen, think, react, and decide.

## Aria Architecture Target

```text
User voice/text
-> STT or text input
-> LLM/personality layer
-> memory and project context
-> Aria Director Layer
-> emotion + intent + action directive
-> Aria animation controller
-> face/gaze/body/lip-sync channels
-> TTS voice
-> Aria response in the Forge
```

## Recommended Milestones

### Milestone 1: Presence Lock

- Keep only Aria visible in the main avatar path.
- Use the photoreal Aria references as the visible quality bar.
- Add eye/gaze/blink/breath/smile state to the loading and Forge presence.
- Route visible Aria states through the Aria Director Layer instead of text-only guessing.
- Never show low-quality test bodies in the presented experience.

### Milestone 2: Rigged Aria V1

- Create Aria V1 through the Character Creator production lane when available; otherwise use the best legal fallback base temporarily.
- Match the approved Aria target: face direction, body proportions, hair, eyes, base garment, pendant, and colors.
- Add skeleton, idle stance, breathing, blink, head motion, and gaze.

### Milestone 3: Expression Face

- Add blendshape targets for blink, smile, brows, jaw, lips, cheeks, and basic visemes.
- Connect `ariaLivingAvatar.ts` style intent states to the rig.
- Add expression previews inside the creator room.

### Milestone 4: Voice-Synced Aria

- Use a legal Aria voice.
- Connect Director speech duration to speaking state, gaze, and expression.
- Generate viseme curves from TTS output.
- Blend lip sync with emotion so speech does not look mechanical.

### Milestone 5: Protected Aria Runtime

- Expose Aria-internal slots: skin, face, eyes, hair, makeup, lips, brows, lashes, baked modesty layer, approved wardrobe, and protected accessories.
- Add UV maps and test overlays for Viper-internal Aria development only.
- Do not use Aria as a public creator mannequin. Public creator products must be developed on the Male Creator Base and Female Creator Base.
- Route Aria outfit changes through an approved Aria wardrobe/loadout system.

### Milestone 6: Advanced Digital Human

- Add richer skin shader, eye wetness, hair physics/cards/groom LODs, wrinkle/tension maps, and audio-to-emotion.
- Add autonomous Forge reactions: inspecting builds, pointing, thinking, celebrating, warning, and guiding.

## Source Notes

- Epic MetaHuman / Unreal Digital Humans: skin subsurface scattering, eye/mouth boundary treatment, screen-space irradiance, hair shading, facial animation, Control Rig, and MetaHuman Animator.
- NVIDIA ACE / Audio2Face: speech, LLM, emotion, and audio-driven facial animation as a digital-human pipeline.
- Apple ARKit blendshapes: practical facial-expression naming and tracking vocabulary.
- Reallusion Character Creator: digital human shader concepts for skin, eyes, teeth, hair, micro-normal, SSS, and expression profiles.
- Reallusion Headshot / Character Creator photo-to-3D workflow: preferred Aria likeness lane if licensing and installation are available.
- Synthesia and HeyGen: proof that perceived realism depends heavily on lip sync, facial expressions, body motion, pacing, and consent/licensing for likeness.
