# Viper Studios Platform Contract Migration Map

## Migration Phases

### Phase A: Schema Unification
1. Extract `ForgeJob`, `WorkspaceState`, `ProductCard` from `landing-page/src/lib/forgeApi.ts`.
2. Map to a new Prisma or SQLAlchemy schema definition for the `api-server`.

### Phase B: State Handover
1. Deprecate `localStorage` usage in `ForgeIntelligence.tsx`.
2. Reroute `globalPersistence.save` calls to `/api/workspace/sync` endpoints.

### Phase C: Generator Registration
1. Define a `Provider` registry schema in the database.
2. Register `services/project-titan-3d` as the canonical `AvatarForge` provider.

### Phase D: Lifecycle Wiring
1. Bind SentinelQC validation outputs to the `JobStep` schema.
2. Store `qc_output.json` directly against the `Asset` ID.
