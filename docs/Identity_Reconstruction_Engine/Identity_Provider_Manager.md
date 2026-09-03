# Identity Provider Manager

**Scope:** The architectural layer responsible for orchestrating, wrapping, and abstracting all AI generation providers.

## 1. The "No Permanent Trust" Principle
Viper Studios never hardwires a model or provider directly into Project Titan. Every generation capability must exist behind an abstract interface. The Identity Provider Manager treats every model as a hot-swappable module that must continuously justify its usage through performance and quality metrics.

## 2. Abstract Provider Interface
Every provider (Open-Source, Cloud API, or Native) must implement the `IIdentityProvider` interface:
```typescript
interface IIdentityProvider {
  name: string;
  capabilities: GenerationCapability[]; // e.g., [FACE_EMBEDDING, MULTIVIEW, DEPTH]
  licenseType: 'COMMERCIAL' | 'NON_COMMERCIAL';
  executeGeneration(request: IGenerationRequest): Promise<IGenerationResult>;
  getQualityScore(): number;
}
```

## 3. Dynamic Selection Routing (Helios)
Helios utilizes the Identity Provider Manager to select the provider based on:
1. **Requested Task:** (e.g., Does it require 3D depth estimation or just 2D inpainting?)
2. **Available Providers:** (Which providers are currently online and reachable?)
3. **Viper Quality Scores:** (Which provider historically performs best at this specific task?)
4. **Creator Preferences:** (Has the user explicitly requested open-source local execution?)
5. **Licensing Constraints:** (Is this project marked for commercial export? If so, immediately drop any Non-Commercial providers from the candidate list.)
6. **Local vs. Cloud:** (VRAM availability on the local machine vs. Cloud API cost.)

## 4. Current Wrapped Candidates
- `AuraFaceAdapter` (Identity Extraction)
- `Hunyuan3DAdapter` (Multi-view / Mesh generation)
- `MediaPipeAdapter` (Landmark / Depth)
- `InsightFaceEnterpriseAdapter` (Optional commercial fallback)
