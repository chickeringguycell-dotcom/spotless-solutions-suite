# F001 - FULL-HEAD AND OCCLUSION COMPLETION

## INPUT
One front-facing portrait.

## REQUIRED OUTPUT
A coherent identity representation containing:
- Left profile
- Right profile
- Left three-quarter
- Right three-quarter
- Rear skull
- Scalp
- Back of hair
- Ear depth
- Neck sides
- Shoulder depth

The output must preserve:
- Identity
- Age
- Skin tone
- Hair
- Facial proportions
- Head scale
- Neck scale
- Cross-view consistency

## REGION CLASSIFICATION
- Frontal Face: SOURCE_OBSERVED
- Jawline/Chin: SOURCE_ANCHORED
- Ears: INFERRED
- Profile Depth: INFERRED
- Rear Skull: INFERRED
- Scalp/Hair Back: INFERRED
- Neck/Shoulders: INFERRED
