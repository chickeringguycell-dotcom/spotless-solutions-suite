# Titan Hallucination Policy

## 1. Source Preservation Mandate
Titan must preserve all visible evidence from the source:
- Face identity, eyes, nose, lips, jaw, chin, forehead, hairline, skin tone, apparent age, visible hair, visible clothing, visible body proportions, distinctive features.
- Titan must not randomly alter source-observed features to satisfy camera angle, pose, or full-body requests.

## 2. Controlled Hallucination Mandate
Titan must intelligently invent regions that are not visible (e.g. side of face, ears, rear skull, back of hair, torso, arms, legs, height, hidden clothing).
- Hallucinated regions must follow realistic human anatomy, match visible proportions, apparent age, skin tone, and hair style.
- Titan must generate the most believable completion instead of refusing because evidence is missing.

## 3. Hallucination Consistency
Once Titan invents an unseen detail, it must remain stable across the package.
- Examples: Same ear shape in profile and rear view, same skull size, same neck width, same body build, same height.
- Create a shared inferred-attribute state.

## 4. Confidence-Aware Output
Titan must never present inferred anatomy as recovered fact. Every output must have a region-level confidence map:
- **HIGH CONFIDENCE**: Directly visible in source.
- **MEDIUM CONFIDENCE**: Strongly constrained by visible anatomy.
- **LOW CONFIDENCE**: Plausibly inferred but not visible.
- **PROVISIONAL**: Generated for manufacturing continuity and awaiting human approval.

## 5. Full-Body Completion
When requested to generate a full-body image from a portrait:
1. Preserve the source face.
2. Infer a plausible body, height, proportions, and hidden clothing.
3. Keep limbs and extremities complete.
4. Classify unseen body details as inferred.
5. Do NOT answer "No full-body photo exists." Generate a plausible continuation.

## 6. Learning Loop (Rule 33)
Every rejection of an inferred hallucination must enter Rule 33:
FAIL -> AUDIT -> IDENTIFY ONE ROOT CAUSE -> CORRECT ONE CAUSE -> RERUN TEST -> COMPARE -> REPEAT.


## 7. Mandatory Occlusion Cleanup
A mandatory OCCLUSION-CLEANUP stage must occur ON the generated UV mapping photos if source occlusions (like a hand) are transferred into the UV space. The original side-profile source is NEVER altered or inpainted.
- Remove temporary occlusions (e.g., hand touching the jaw).
- Preserve the untouched original source photograph permanently.
- Reconstruct hidden regions (cheek, jawline, neck, hair, shoulder).
- Reconstructed pixels are classified as INFERRED / PROVISIONAL.
- Human approval (Guy) is required for the cleaned source before it becomes the canonical UV manufacturing input.
