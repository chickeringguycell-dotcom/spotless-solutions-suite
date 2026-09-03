# VIPER AVATAR ANIMATIONS ARIA / GAIUS COMPATIBILITY REPORT
**Date**: 2026-06-24  
**Status**: Compatibility report only.  

> [!IMPORTANT]
> No Aria files were modified.  
> No Gaius/Guy files were modified.  
> No animation was applied to a protected character.  
> No retargeted output was created.  

---

## Files Inspected

### Camilla Source Rig
* `artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle_F.fbx`
* `artifacts/api-server/public/avatars/Avatar_Animations/Avatar_Animations.blend`

### Aria Rigs
* `artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx`
* `artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb`

### Gaius/Guy Rigs
* `artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx`
* `artifacts/api-server/public/avatars/guy/motions/source/Guy_Idle_M.fbx`

---

## Summary

Camilla, Aria, and Gaius/Guy all use the same Character Creator (CC) Base skeleton naming and hierarchy. At the bone-name and armature-parent level, Camilla's five collected actions are compatible with both Aria and Gaius/Guy.

However, production use should still go through duplicate-only visual testing and likely retarget/export cleanup before any protected Aria or Gaius runtime asset is changed.

---

## Bone Name Compatibility

| Comparison | Camilla Bones | Target Bones | Shared Bones | Missing Target Bones |
|---|---|---|---|---|
| Camilla to Aria V5 protected FBX | 101 | 101 | 101 | 0 |
| Camilla to Aria V5 runtime GLB | 101 | 101 | 101 | 0 |
| Camilla to Gaius/Guy source FBX | 101 | 101 | 101 | 0 |
| Camilla to Gaius/Guy idle FBX | 101 | 101 | 101 | 0 |

### Conclusion
* Yes, they share compatible bone names.
* Every Camilla action target bone exists on Aria.
* Every Camilla action target bone exists on Gaius/Guy.

#### Sample Shared Bones
* `CC_Base_BoneRoot`
* `CC_Base_Hip`
* `CC_Base_Pelvis`
* `CC_Base_Spine01`
* `CC_Base_Spine02`
* `CC_Base_Head`
* `CC_Base_L_Upperarm`
* `CC_Base_R_Upperarm`
* `CC_Base_L_Hand`
* `CC_Base_R_Hand`
* `CC_Base_L_Thigh`
* `CC_Base_R_Thigh`
* `CC_Base_L_Foot`
* `CC_Base_R_Foot`

---

## Armature Structure Compatibility

| Comparison | Parent Mismatches |
|---|---|
| Camilla to Aria V5 protected FBX | 0 |
| Camilla to Aria V5 runtime GLB | 0 |
| Camilla to Gaius/Guy source FBX | 0 |
| Camilla to Gaius/Guy idle FBX | 0 |

### Conclusion
* Yes, they share compatible armature structure.
* The parent chain matches across all inspected targets.
* No missing parent relationships were found.

---

## Camilla Action Channel Compatibility

The collected `Avatar_Animations.blend` contains five Camilla actions:

| Action | Frame Range | Channel Paths | Target Bones |
|---|---|---|---|
| `Camilla_Idle_01_F` | 1-520 | 1010 | 101 |
| `Camilla_Idle_02_F` | 1-520 | 1010 | 101 |
| `Camilla_Walk_F` | 1-520 | 1010 | 101 |
| `Camilla_Posing_F` | 1-520 | 1010 | 101 |
| `Camilla_Emote_F` | 1-520 | 1010 | 101 |

For each action:
* Missing target bones on Aria: 0
* Missing target bones on Gaius/Guy: 0

### Conclusion
The actions can technically be assigned to Aria and Gaius/Guy armatures because the targeted pose bone names exist.

---

## Direct Application To Aria

* **Technical Feasibility**: Yes.
* **Production-Safe without testing**: No.

### Rationale
* Aria and Camilla share all 101 bone names and the same parent hierarchy.
* Aria's existing motion diagnostics identify Camilla as the intended shared feminine motion source.
* The Aria shared motion map still marks these motions as pending retarget or runtime clip conversion.

### Risks
* Rest-pose and export-scale differences exist between Camilla source FBX and Aria runtime GLB.
* A direct action assignment may animate correctly but show visual problems such as foot sliding, hip offsets, hand drift, hair/body clipping, or face/jaw oddities.
* Protected Aria assets must not be overwritten during testing.

### Recommendation
1. Test `Camilla_Idle_01_F` on a duplicate Aria copy first.
2. If the visual result is good, create a clean Aria-specific runtime clip.
3. Do not promote directly to protected Aria until visual review passes.

---

## Direct Application To Gaius

* **Technical Feasibility**: Yes.
* **Production-Safe without retarget/cleanup**: No.

### Rationale
* Gaius/Guy and Camilla share all 101 bone names and the same parent hierarchy.
* All Camilla action target bones exist on the inspected Gaius/Guy rigs.

### Risks
* Camilla motions are feminine creator/test motions.
* Gaius/Guy is a protected male Forge assistant.
* Even though the skeleton is compatible, the movement style, torso/hip motion, hand placement, facial/jaw motion, and stance may not fit Gaius.

### Recommendation
* Treat Camilla-to-Gaius as technically compatible but stylistically unsafe for direct production use.
* Prefer Gaius/Guy's own protected male motion exports for production.
* Use Camilla actions on Gaius only as a duplicate-only diagnostic if needed.

---

## Is Retargeting Required?

* **For temporary duplicate-only testing**: Not strictly required. The actions can be assigned by matching CC Base bone names.
* **For production Aria use**: Yes, a controlled retarget/export cleanup pass is recommended. Aria should receive Aria-specific runtime clips after visual inspection.
* **For production Gaius use**: Yes, retargeting or motion replacement is recommended. Gaius should use male/protected assistant motion exports unless there is a deliberate design reason to use a Camilla motion.

---

## Safest Next Step

Perform a duplicate-only Aria test with one low-risk animation:
1. Copy Aria V5 to a temporary animation-test folder. Do not modify the protected source file.
2. Assign `Camilla_Idle_01_F` from `Avatar_Animations.blend` to the duplicate Aria armature.
3. Export a temporary preview GLB only.
4. Create a manifest that records:
   - Source Aria duplicate
   - Source Camilla action
   - No protected overwrite
   - Test-only status
5. Visually inspect:
   - Feet grounding
   - Hip position
   - Spine/shoulder motion
   - Hands/fingers
   - Jaw/face motion
   - Hair/body clipping
6. If clean, repeat with `Camilla_Walk_F`.
7. Only after visual approval, create an Aria-specific runtime animation clip.

**Recommended first test action**: `Camilla_Idle_01_F` (lowest risk, avoids locomotion bugs).

---

## Final Compatibility Decision

* **Aria**: Bone-name compatible, armature-structure compatible, direct test application possible on duplicate. Production direct use is NOT recommended; retarget/export cleanup is recommended.
* **Gaius**: Bone-name compatible, armature-structure compatible, direct test application possible on duplicate. Production direct use is NOT recommended; retarget/export cleanup or Gaius-native motion use is recommended.
