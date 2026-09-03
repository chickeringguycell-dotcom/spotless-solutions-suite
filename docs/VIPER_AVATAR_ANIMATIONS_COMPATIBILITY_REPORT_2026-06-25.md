# VIPER STUDIOS AVATAR ANIMATION COMPATIBILITY REPORT
**Date**: 2026-06-25  
**Status**: APPROVED FOR TEST / NO ASSETS MODIFIED  

---

## 1. Five Camilla Animations
The five Camilla animations are:
1. **`Camilla_Idle_F`** (Idle 01)
2. **`Camilla_Idle02_F`** (Idle 02)
3. **`Camilla_Walk_F`** (Walk)
4. **`Cammilla_Posing_f`** (Posing)
5. **`Camilla_Emote_F`** (Emote)

---

## 2. Storage Format (Blender Actions vs. FBX Clips)
* **Both formats exist in the system**:
  * **Blender Actions**: Defined as actions inside the `Avatar_Animations.blend` collection.
  * **FBX Clips**: Exported as individual FBX files (`.fbx` with `.json` metadata sidecars) under `artifacts/api-server/public/avatars/camilla/motions/source/`.

---

## 3. Aria Reuse Compatibility
* **Direct Reuse**: **Technically Possible but Production-Unsafe without Cleanup**
* **Details**:
  * Aria V5 protected FBX and runtime GLB models share all **101 bone names** and matching armature hierarchies with Camilla's armature.
  * A direct bone-name assignment is technically supported.
  * However, differences in rest-pose structures and export scales can result in visual issues (foot sliding, hand drift, clipping, or hip offsets).
  * Direct production assignment is not recommended; a retargeting export pass is recommended.

---

## 4. Gaius/Guy Reuse Compatibility
* **Direct Reuse**: **Technically Possible but Stylistically Unsafe**
* **Details**:
  * Gaius/Guy's rigs share the same **101 bone names** and armature parent structures as Camilla.
  * While assignment is technically feasible, the Camilla clips represent feminine-styled motion. Applying them directly to Gaius (the male companion character) is stylistically inappropriate.
  * Gaius should use native male/protected assistant motion exports for production.

---

## 5. Is Retargeting Required?
* **For temporary diagnostics**: No. Armature bone structures are compatible enough to assign raw motion channels directly on duplicate test rigs.
* **For production use**: Yes. Both Aria and Gaius require clean retargeting passes and dedicated, character-specific animation clips to ensure correct stance, grounding, and style.

---

## 6. Safest Test Method (Duplicate Copies Only)
To test animations without modifying protected assets:
1. **Isolate**: Copy the target avatar (e.g. `Aria_V5_NaturalHair.fbx`) to a temporary test folder. Never edit or overwrite the protected master files.
2. **Assign**: Load the duplicate rig and assign the target Camilla action (such as `Camilla_Idle_01_F` Blender action or FBX animation track).
3. **Export**: Export to a test GLB.
4. **Inspect**: Render and verify key visual details:
   * Feet grounding (no floor sliding or floating).
   * Hip position offsets.
   * Spine, shoulder, and arm joint rotation limits.
   * Hand and finger placement.
   * Facial expression and jaw animation boundaries.
   * Hair-to-body collision clipping.
5. **Promote**: Only promote to runtime clips after a visual review passes.

---

*All source animations and protected avatar rigs remain unmodified.*
