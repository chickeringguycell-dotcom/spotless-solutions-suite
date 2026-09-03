# VIPER PHASE REPORT AUDIT CHECKLIST TEMPLATE

Status: reusable checklist for all significant Viper build phases.

Copy-ready note: include this section near the end of every phase report before the recommended next phase.

## Post-Build Audit

Every significant phase that creates or modifies services, APIs, workspace shells, workflows, planning systems, review systems, package systems, asset systems, workspace integrations, or dashboard panels must include this audit section.

## What Changed

- List the services, APIs, files, panels, contracts, or workflows changed.

## What Stayed Untouched

- Confirm protected assets were not moved.
- Confirm legacy systems were not deleted unless the task explicitly authorized deletion.
- Confirm heavy editors/viewers/export systems were not added unless the phase explicitly authorized them.

## Validation Results

| Check | Result | Notes |
|---|---|---|
| API typecheck |  |  |
| Website typecheck |  |  |
| Mobile typecheck |  |  |
| Existing tests |  |  |
| API build |  |  |
| Website build |  |  |
| API health check |  |  |
| Website browser check |  |  |
| Mobile startup validation |  |  |
| Protected asset validation |  |  |
| Legacy system validation |  |  |
| Workspace validation |  |  |

## Audit Findings

- Record architecture concerns, duplicated logic, missing relationships, validation gaps, or future scaling risks.

## Mobile Impact

- Confirm mobile remains guide, idea, references, job submission, preview, review, approve, and revise only.
- Confirm no heavy viewers, mesh tools, export tools, or large libraries were added to startup.

## Protected Asset Check

- Confirm Aria/Gaius protected assets were not moved or exposed.
- Confirm public avatar, public skin, MakeHuman, and MPFB paths remain blocked or retired.

## Legacy System Check

- Confirm Workshop, Shipyard, ThreeViewer, Viewer, IMVU Creator, and DevStudio legacy routes remain untouched unless explicitly authorized.

## Workspace Validation

- Confirm active workspace slices do not consume unrelated records.
- Confirm placeholder, deferred, internal-only, and retired workspaces are guarded.

## Failures

- Document every failed check and the first actionable error.
- If a failure is accepted as a deferral, say why.

## Remaining Risks

- List risks that remain after the phase.

## Recommended Next Phase

- Name the next phase and state the safest next implementation step.
