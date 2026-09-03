# F002 No-Training Baseline

**Setup:**
- Base: SD 1.5 + IP-Adapter (Standard preset).
- Geometry Control: MediaPipe Left/Right Profile, 3/4, and Rear View Wireframes.
- Conditioning: Source Portrait (GB001).

**Results:**
- **View Compliance:** Left/Right Profile and 3/4 are PARTIAL to SUPPORTED. Rear view is FAIL (Model hallucinates a face on the back of the head or ignores the control entirely).
- **Identity Consistency:** Profiles maintain some identity, but degrade significantly at 3/4 and rear views.
- **Cross-View Consistency:** FAIL (Different hair, clothing details, and facial structures across views).
- **Conclusion:** F002 establishes that without training, SD1.5 + IP-Adapter cannot perform full-head (especially rear-head) generation even when forced by MediaPipe geometry.
