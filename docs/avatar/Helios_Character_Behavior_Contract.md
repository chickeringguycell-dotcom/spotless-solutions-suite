# Helios Character Behavior Contract

## Philosophy
Helios must not control raw arbitrary bone names directly (e.g., "Rotate RightUpperArm.Yaw by 45 degrees"). Instead, Helios acts through a semantic Character Behavior Contract. 

Aria, Gaius, Fluffy, and future user-created residents must remain puppeteered by Helios through this common behavior layer. Character proportions may differ, but the semantic behavior contract remains mathematically stable.

## Semantic Behavior Examples
Helios issues high-level intents:
- Walk to the Avatar Forge
- Look at Guy
- Smile slightly
- Wave
- Point at the hologram
- Sit down
- Speak with concern
- Pick up this object
- Follow the creator
- Enter the Reality Gate

## Runtime Flow
The execution of behavior follows a strict hierarchical pipeline:

1. **Helios intention** (e.g., "Greet creator")
2. **Character Behavior Controller** (Interprets intent into a sequence of state-machine triggers)
3. **Sub-systems** (Locomotion / Gesture / Gaze / Facial / Speech systems process the active states)
4. **Viper Canonical Rig** (Receives the blended animation curves and IK targets)
5. **Rendered Avatar Behavior** (The mesh physically deforms in the Headquarters)
