# F003 Valid Control Baseline

**Inputs:**
- Source Portrait: GB001
- Identity Conditioning: Standard IP-Adapter
- Controls: Procedurally generated canonical neutral head (Canny wireframe render).

**Results:**
- **Profile / 3/4 Views:** The model aligns to the silhouette but struggles to maintain identity.
- **Rear Views:** Even with a valid rear silhouette (skull, neck, shoulders), SD1.5 with IP-Adapter fails to generate a realistic human rear-head, often hallucinating faces or generating generic blobs because it lacks learned representations for rear heads in its training data without a specialized ControlNet or LoRA.
