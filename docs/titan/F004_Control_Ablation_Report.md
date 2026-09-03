# F004 Control Ablation Report

## Single Control Testing
- **F004-R-A (Canny)**: Extracts high-frequency edge data. Canny performs exceptionally well on interior details (e.g., eye shape, hair strands, ear definition). However, because Canny lacks volumetric awareness, the network can hallucinate structures behind missing boundaries.
- **F004-R-B (Depth)**: Normalizes depth and prevents the network from rendering outside the exact bounding volume of the head mesh. Depth forces strict anatomical envelope compliance, proving structural control over rear views. However, internal geometric details lacking sharp depth gradients (like soft facial features) may drift.
- **F004-R-C (Normal)**: Provides surface topology direction. While it effectively lights the surface, Normal alone is susceptible to minor boundary drift and lacks the absolute exterior bounding constraint of Depth.

## Combined Control Performance (F004-R-E)
- **Primary (Depth)** + **Secondary (Canny)**: Combining Depth (for absolute spatial bounding) and Canny (for high-frequency micro-topology) eliminates the weaknesses of both. The boundary cannot drift due to the depth constraint, and internal facial details are forced into compliance by the edge constraint. This pairing produces the most physically accurate result.
