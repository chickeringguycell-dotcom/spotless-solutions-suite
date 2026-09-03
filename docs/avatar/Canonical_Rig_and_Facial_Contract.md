# Canonical Rig and Facial Contract

## Canonical Viper Rig
The Viper Avatar is built on a professional game-development skeleton capable of extreme deformation and modularity.

**Core Hierarchy**:
- Standard humanoid skeleton (Spine, Neck, Head, Clavicles, Arms, Legs).
- **Facial Rig**: Detailed bone structures for the jaw, eyes, and tongue.
- **Micro-Controls**: Finger controls down to the distal phalanges.
- **Deformation Helpers**: Twist bones (for wrists/shoulders) and corrective bones (to fix joint collapsing during extreme poses).
- **Mounting**: Cloth and accessory attachment points, equipment sockets (e.g., holsters, weapon mounts).
- **Dynamics**: Physics bones where appropriate (e.g., ponytails, loose straps) to be simulated by the runtime engine.

## Facial Control Contract
The face must be a highly expressive, speech-ready rig.

**Supported Modalities**:
- Expressions & Emotion controls (Joy, Anger, Sadness, Surprise).
- Speech visemes (A, E, I, O, U, consonants) for lip synchronization.
- Eye blinks, Eye direction (gaze tracking).
- Brow movement, Cheek movement, Jaw movement, Lip shapes (puckering, rolling).
- Subtle asymmetry (e.g., half-smirks, single brow raises).

**Evaluation Mandate**:
We will evaluate ARKit-style 52-blendshape controls, FACS-based controls, and engine-specific facial systems (like MetaHuman). Do not assume one standard is sufficient without auditing compatibility for our target export platforms.
