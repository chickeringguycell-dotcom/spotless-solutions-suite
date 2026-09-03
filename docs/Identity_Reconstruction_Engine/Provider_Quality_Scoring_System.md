# Provider Quality Scoring System

**Scope:** A permanent Viper Studios competition framework to evaluate, score, and rank Identity Reconstruction providers continuously.

## 1. Core Principle
No provider is trusted permanently. Every provider competes for routing priority based on objective quality metrics. If an open-source provider outscores a commercial API, the system automatically routes to the open-source provider.

## 2. The Viper Quality Score (VQS)
Each provider receives a composite score (0-100) calculated from automated telemetry and SentinelQC visual evaluation gates.

### 2.1 Quality & Accuracy Metrics (60% Weight)
- **Identity Preservation:** Cosine similarity of the generated face embedding vs. the source embedding.
- **Profile Accuracy:** Precision of nose, jaw, and brow geometry mapping from frontal reference to profile projection.
- **Multi-view Consistency:** The geometric divergence between generated Front, Side, and 3/4 views (lower divergence = higher score).
- **Expression Consistency:** The ability to retain facial structure while modifying facial action units (smiles, frowns).
- **Lighting Consistency:** The ability to match the target ambient environment without altering skin albedo.
- **Pose Control:** Adherence accuracy to ControlNet / MediaPipe skeletal inputs.
- **Depth Accuracy:** Correlation of the generated depth map to the intended 3D volume.

### 2.2 Operational Metrics (40% Weight)
- **Performance:** Time to First Byte (TTFB) and total generation time (ms).
- **Commercial Licensing:** Providers with Apache 2.0 / Commercial-Safe licenses receive a heavy multiplier over restrictive/academic licenses.
- **Maintenance:** Frequency of underlying model updates and bug fixes from the upstream repository.
- **Community:** Open-source health (GitHub stars, forks, active issues) ensuring long-term viability.
- **Provider Stability:** Uptime percentage and error/timeout rates for the given adapter.

## 3. Automated Re-Evaluation
The `ProviderManager` runs a nightly CRON benchmark using a standardized test set of 10 source photographs. The VQS is updated daily. 

## 4. Helios Routing Impact
When Helios receives a generation intent, it reads the VQS table. If the top-scoring provider is locally available (and VRAM allows), it is chosen immediately. If the top-scoring provider is a cloud API, Helios compares the score delta against the cost delta before executing.
