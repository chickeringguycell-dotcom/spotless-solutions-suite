# F001 Benchmark Protocol

**Source Image:** Canonical GB001 source portrait.

**Required generated views:**
- Left profile
- Right profile
- Left three-quarter
- Right three-quarter
- Rear view

**Execution:**
Generate at least three runs per view (Best, Median, Worst).
Do not retouch outputs. Do not use Gemini pixels as conditioning.

**Compare against:**
- Gemini profile benchmark
- Source portrait
- Titan current baseline
- PRNet-guided result
- MediaPipe-guided result

**Metrics:**
- View compliance
- Source identity similarity
- Cross-view identity consistency
- Cross-seed consistency
- Ear consistency
- Hair consistency
- Skull consistency
- Neck consistency
- Skin tone
- Age
- Anatomical plausibility
- Photorealism
- Runtime
- VRAM
- RAM
