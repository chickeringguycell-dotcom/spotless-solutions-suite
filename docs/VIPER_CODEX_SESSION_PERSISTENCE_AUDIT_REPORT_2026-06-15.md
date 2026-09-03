# VIPER CODEX SESSION PERSISTENCE AUDIT REPORT

Date: 2026-06-15

Status: reliability audit only. No Viper feature work was continued. Phase 4H was not started. No legacy systems were deleted. No protected assets were moved.

## Mission

Investigate why Codex sessions appear to close, disappear, reload, or require reopening even when Viper validation passes.

This is not a Viper architecture phase. This report focuses on Codex desktop/session reliability, local host connection behavior, thread restoration, and workspace attachment risk.

## Executive Finding

The strongest finding is that the Viper project is currently inside a Git repository rooted at:

```text
C:/Users/U
```

When commands are run from the Viper project folder, Git resolves the repository root as the whole Windows user folder, not the Viper project:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
=> C:/Users/U

git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --git-dir
=> C:/Users/U/.git
```

Codex desktop logs show repeated Git/review-summary failures while trying to scan or add files from the user home tree. The failures include permission-denied folders, cached runtime paths, and a Windows filename-too-long error.

This is the most likely reliability hazard. Viper validation can pass while Codex itself is still being stressed by an oversized, noisy, accidental-looking Git boundary.

## Most Likely Cause

Most likely cause:

Codex is not losing Viper because Viper is broken. Codex appears to be reloading/restarting desktop session processes while also repeatedly trying to process an enormous home-folder Git workspace.

Evidence points to:

- Viper API and Website stayed healthy.
- The project folder remained present and recently updated.
- Codex desktop process groups restarted repeatedly during the work window.
- Codex logs show repeated local app connection startup from disconnected state.
- Codex logs show repeated Git/review-summary worker failures from the home-folder Git root.
- Windows crash logs did not show an obvious Codex/OpenAI/node application crash during the checked window.
- Windows sleep/hibernate settings are not causing this; sleep and hibernate are disabled.

## Evidence

### Codex Process Lifecycle

Current Codex process group was started around:

```text
2026-06-15 9:06 PM local time
```

Recent Codex desktop logs show several distinct process/log groups starting from disconnected state and reconnecting:

```text
2026-06-16T01:14Z
2026-06-16T01:42Z
2026-06-16T02:17Z
2026-06-16T02:51Z
2026-06-16T03:18Z
2026-06-16T03:47Z
2026-06-16T04:06Z
```

Those UTC times correspond to the evening of 2026-06-15 local time. This supports the user's observation that sessions appear to disappear or need reopening.

### App Server Connection

Codex logs repeatedly show:

```text
app_server_connection.state_changed cause=start_process currentState=disconnected
app_server_connection.state_changed cause=post_initialize_connection_state currentState=connecting
remoteControl/status/read
thread/list
```

Interpretation:

The local app/host connection is able to reconnect, but the app process lifecycle is not continuous across the whole work period.

### Git Boundary Failure

Codex logs repeatedly show Git/review-summary work failing with:

```text
warning: could not open directory 'AppData/Local/Application Data/': Permission denied
warning: could not open directory 'Application Data/': Permission denied
error: Filename too long
error: unable to index file
fatal: adding files failed
```

The failing path includes cached runtime dependencies under:

```text
.cache/codex-runtimes/codex-primary-runtime/dependencies/node/node_modules/...
```

Interpretation:

Codex is trying to summarize or stage a workspace that includes the user's whole home folder. That creates permission errors, huge file lists, path-length failures, and unnecessary memory/CPU pressure.

### Viper Server Health

Safe server helper health check returned:

```text
API     http://127.0.0.1:18082/api/healthz          200
Website http://127.0.0.1:19006/landing-page/        200
```

Interpretation:

The local Viper services were alive after the session persistence check.

### Power Settings

Active Windows power plan:

```text
High performance
```

Sleep after:

```text
AC: never
DC: never
```

Hibernate after:

```text
AC: never
DC: never
```

Display timeout:

```text
AC: never
DC: never
```

Interpretation:

Windows sleep/hibernate is not the likely cause of the observed Codex reloads.

### Windows Crash/Event Logs

Application and system event logs were checked for recent Codex/OpenAI/node/Electron crash or power events.

Finding:

No obvious Windows Error Reporting or Kernel-Power crash event was found in the checked window.

Interpretation:

The issue looks more like app/session reload, host reconnection, or workspace processing pressure than a plain Windows-level hard crash.

## Session Lifecycle Audit

When Codex appears closed:

- App restart: likely, based on repeated distinct Codex process/log groups.
- Thread reload: likely, because thread state persists but the UI/process appears to restart.
- Task stop: likely during process reloads; active tool/runtime state may not survive.
- Project detach: not fully detached; the project still exists and can be reached.
- Host disconnect: yes, logs show local app connection starting from disconnected state.
- Session restore failure: not proven. Thread files persisted and were updated.

## Background Session Audit

Thread/session persistence files exist under:

```text
C:\Users\U\.codex\sessions
```

The active thread file remained present and updated:

```text
C:\Users\U\.codex\sessions\2026\06\11\rollout-2026-06-11T18-43-23-019eb97f-7477-7412-8d9c-e7acae8f8652.jsonl
```

Session index still references the Viper thread.

Known from this audit:

- 90-second persistence smoke test survived.
- Same Codex process IDs remained before and after the 90-second check.
- Viper API and Website health checks remained 200 after the smoke check.

Not proven in this audit:

- 15-minute idle survival.
- 30-minute idle survival.
- 60-minute idle survival.

Based on historical process turnover, 30+ minute unattended work should be treated as risky until the Git-root problem is fixed and a longer idle test is run.

## Host Connection Audit

Current host model:

- Codex desktop runs the local host/app connection.
- The in-app browser and local Viper servers run on the desktop machine.
- Mobile access depends on the desktop app/host connection staying alive and reconnecting cleanly.

When the user opens Codex Mobile:

- Desktop Codex must remain open or restorable.
- The local host connection must reconnect.
- The project attachment must still point to the intended workspace.
- Any local Viper browser/server work only exists on the desktop machine.

If Codex desktop reloads, closes, updates, or loses its app server connection, the mobile view may appear to lose the active task even though the underlying Viper files still exist.

## Project Attachment Findings

Codex global state contains workspace root hints pointing threads toward:

```text
C:\Users\U\Documents\Codex
```

Codex config also includes trusted projects for:

```text
c:\users\u
c:\users\u\documents\codex\projects\viper studio\project
```

Risk:

The broad trusted home path plus home-folder Git root makes it easier for Codex desktop to treat too much of the machine as one workspace.

## User Fixes

Recommended user-side fixes, in priority order:

1. Fix the Git boundary.

   The Viper project should not resolve its Git root as `C:\Users\U`.

   Safe options:

   - Confirm whether `C:\Users\U\.git` is intentional.
   - If it is accidental, archive or move that home-level `.git` folder only after explicit confirmation.
   - Create or restore a proper Viper-only Git root at `C:\Users\U\Documents\Codex\Projects\Viper Studio\project`.
   - Reopen Codex and confirm `git rev-parse --show-toplevel` returns the Viper project folder.

2. Narrow Codex workspace trust.

   After the Git boundary is corrected, prefer trusting only the Viper project folder, not the whole user home folder.

3. Run a longer persistence test after the Git fix.

   Test:

   - 15 minutes idle.
   - 30 minutes idle.
   - 60 minutes idle.
   - Confirm same Codex process group or clean restore.
   - Confirm Viper API/Website still healthy.

4. Keep checkpoint reports during long phases.

   Continue creating phase reports and crash recovery notes. They are working: they allow the next session to resume without guessing.

5. Avoid overnight giant phases until the Git boundary is fixed.

   Long unattended work should be split into smaller checkpoints with validation and report creation after each phase.

## Likely Codex Limitations

These are limitations or risks of the Codex desktop/mobile workflow:

- Active tool/runtime state may not survive a desktop app process reload.
- In-app browser and Node/browser automation state may reset when Codex desktop restarts.
- Mobile cannot keep a local desktop workspace alive by itself.
- A thread can persist while the active task still stops.
- Background execution may not be reliable for long unattended phases without checkpointing.
- Local logs can identify restart patterns, but they do not expose complete remote/server-side task lifecycle state.

## Viper-Side Findings

No evidence was found that Viper validation failures are the main reason sessions disappear.

Confirmed:

- Viper project directory is present.
- Viper docs continue to update.
- Viper API health check returns 200.
- Viper Website health check returns 200.
- Recent Phase 4G report exists.

Viper development can continue, but the Codex workspace/Git boundary should be fixed before trusting long unattended runs again.

## Reproduction Results

Lightweight persistence test performed:

```text
Duration: 90 seconds
Before Codex process count: 9
After Codex process count: 9
Same process IDs: true
Result: survived
```

Server health after the test:

```text
API: 200
Website: 200
```

Long idle tests were not completed in this audit. The available log history suggests longer sessions have been turning over repeatedly.

## Recommended Workflow Changes

Use this workflow until the Git boundary is corrected:

1. Keep Viper phases shorter.
2. Always create the phase report before moving on.
3. Include validation results in every report.
4. When a crash happens, run crash recovery before resuming feature work.
5. Avoid broad Git operations until the repo root is fixed.
6. Use the safe server helper for runtime checks.
7. Keep mobile requests focused on monitoring or new instructions, not assuming the desktop task survived.

## Recommended Immediate Next Action

Before Phase 4H or any new Viper feature work:

1. Ask for explicit permission to repair the Git boundary.
2. Determine whether `C:\Users\U\.git` is accidental or intentional.
3. If accidental, safely archive or relocate the home-level Git metadata.
4. Initialize or restore Git at the Viper project root.
5. Confirm:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

returns:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

6. Re-run Codex persistence smoke test and Viper health checks.

## Should Viper Development Continue Normally?

Yes, with caution.

The Viper app and services are healthy enough to continue. The reliability risk is primarily the Codex/session/workspace layer, especially the home-folder Git root.

Recommended stance:

- Continue Viper work only in checkpointed phases.
- Do not run another long unattended package until the Git boundary is repaired.
- Fix the workspace/Git root before trusting Codex to stay stable through another heavy overnight run.

## Final Assessment

The repeated "crashes" are most likely not Viper code crashes.

They are most likely Codex desktop/session reloads made worse by an oversized workspace boundary:

```text
Viper project -> Git root resolves to C:\Users\U -> Codex scans/indexes the whole home folder -> permission/path failures -> session instability risk
```

The concrete fix is to isolate Viper as its own project/repo boundary and keep Codex focused on that folder only.
