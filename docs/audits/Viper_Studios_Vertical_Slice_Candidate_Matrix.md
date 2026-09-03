# Viper Studios Vertical Slice Candidate Matrix

## Candidate Evaluation

| Candidate Domain | Functional Generator | Existing UI | Persistence | Validation | Recommendation |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Avatar Forge** | YES (`project-titan-3d`) | YES | NO | YES (`SentinelQC`) | **BEST CANDIDATE** |
| **Material Forge** | NO | YES | NO | NO | Discard |
| **Furniture Forge** | NO | YES | NO | NO | Discard |
| **Terrain Forge** | NO | NO | NO | NO | Discard |
| **Vehicle Forge** | NO | YES | NO | NO | Discard |

## SELECTION ALGORITHM
If a domain cannot complete the path:
*Creator Request -> Helios -> Job -> Generator -> Preview -> Validation -> Product*

...it cannot be a vertical slice. **Currently, no domain can complete this path because the Helios API Server is broken and disconnected.**

**The Selected First Enabling Slice:** 
The API bridge between `landing-page`'s Job Queue and `project-titan-3d`'s local execution, with a SQLite backing store. This makes the Avatar Forge the only feasible candidate once the infrastructure is repaired.
