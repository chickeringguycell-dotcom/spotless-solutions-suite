# VIPER CODEX POST-GIT-REPAIR CRASH REPORT

Date: 2026-06-15

Status: crash investigation only.

No Viper feature development was continued. Phase 4H was not started. Proxy Image Request work was not continued. No Viper source architecture was modified.

## Source Of Truth

This investigation used:

- `VIPER_REPOSITORY_BOUNDARY_REPAIR_EXECUTION_REPORT_2026-06-15.md`

## Primary Answer

The Viper repository boundary repair succeeded and remained healthy after the crash.

However, the post-repair Codex logs still show Codex running review-summary / Git activity against:

```text
C:/Users/U
```

So the crash still involved the Windows user profile Git root, but not because Viper failed to become its own repository. The remaining issue appears to be that this Codex thread/app state is still partly rooted too broadly outside the Viper project.

## Repository Boundary Status

Post-crash check:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

Result:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Git dir:

```text
.git
```

Confirmed:

- Viper local `.git` exists.
- `C:\Users\U\.git` still exists and was not touched.
- Viper no longer inherits `C:\Users\U` when Git is run from the Viper project folder.
- Viper `git status --short` did not show AppData, Cookies, Local Settings, permission-denied, dubious ownership, or home-folder scan warnings.

## Crash Evidence

After the user-visible crash/reload, Codex processes were freshly started around:

```text
2026-06-15 9:30:44 PM local time
```

Current post-restart process set included:

```text
Codex     started 2026-06-15 9:30:44 PM
codex     started 2026-06-15 9:30:46 PM
node_repl started 2026-06-15 9:30:58 PM
```

No matching Windows Application crash event was found after:

```text
2026-06-15 9:24:00 PM
```

This suggests the visible failure was likely an app reload/restart/session reset rather than a Windows-recorded hard process fault.

## Log Findings

Latest post-repair Codex log path:

```text
C:\Users\U\AppData\Local\Packages\OpenAI.Codex_2p2nqsd0c76g0\LocalCache\Local\Codex\Logs\2026\06\16
```

Relevant post-restart evidence:

```text
2026-06-16T04:30:45.076Z Launching app
2026-06-16T04:30:45.183Z Checking Windows Store for package updates
2026-06-16T04:30:45.329Z AppServerConnection initializing
2026-06-16T04:30:46.717Z Transport start success
2026-06-16T04:30:47.709Z remoteControl/status/read succeeded
2026-06-16T04:30:47.748Z thread/list succeeded
```

This confirms Codex restarted/reloaded, then reconnected the local app server and restored thread listing.

Additional log finding:

```text
Statsig: workspace_type invalid input: expected string/number/boolean/array/undefined, received null
```

This does not directly prove the crash cause, but it is a post-restart app bootstrap error worth tracking.

## Git Findings

Despite Viper now resolving to its own repository, Codex still attempted review-summary Git work from:

```text
C:/Users/U
```

The post-repair logs include review-summary failures with:

```text
warning: could not open directory 'AppData/Local/Application Data/': Permission denied
warning: could not open directory 'Cookies/': Permission denied
warning: could not open directory 'Local Settings/': Permission denied
cwd=C:/Users/U
requestKind=review-summary
source=review_model
subcommand=add
success=false
```

The logs also showed very large Git add attempts, including command activity with:

```text
argsCount=1026
git add -- .android/adbkey ...
git add -A
```

These are home-profile paths, not Viper project paths.

## Codex State Findings

Codex global state still has this thread rooted broadly at:

```text
C:\Users\U\Documents\Codex
```

The thread output directory is:

```text
C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without\outputs
```

Codex config still contains both trusted project entries:

```text
[projects.'c:\users\u']
[projects.'c:\users\u\documents\codex\projects\viper studio\project']
```

This explains the split behavior:

- Direct Git commands inside Viper are now correct.
- Codex desktop review-summary / workspace scanning can still reach the broad `C:\Users\U` context.

## Host Findings

Viper services were still healthy after the Codex reload:

```text
API health:     200
Website health: 200
```

Codex local app-server connection recovered:

```text
AppServerConnection transport=stdio connected
remoteControl/status/read succeeded
thread/list succeeded
```

The host did not appear permanently detached. It reattached automatically after the reload.

Mobile connection state exists in Codex global state:

```text
codex-mobile-has-connected-device: true
```

No direct evidence showed that mobile handoff caused the crash.

## Session Findings

Observed behavior:

- Codex app/session visibly reloaded or restarted.
- The active task was interrupted.
- The thread state was restored after restart.
- The local host connection reconnected automatically.
- Viper API and website stayed healthy.
- No Windows hard-crash event was found.

This points to session/app instability rather than a Viper runtime crash.

## Cause Assessment

Most likely cause:

```text
Codex session/app instability caused by remaining broad workspace / home-profile Git review-summary activity.
```

Confidence:

```text
Medium-high that C:\Users\U Git/review-summary activity is still involved.
Medium that it is the direct crash trigger.
```

Reasoning:

- Viper's repository boundary is repaired and clean.
- Post-repair logs still show Codex review-summary work from `C:/Users/U`.
- The same AppData/Cookies/Local Settings warnings returned after the repair.
- Codex restarted/reconnected around the time the user observed the crash.
- Viper API/website remained healthy, so the failure does not look like a Viper server crash.
- Windows did not log a hard application fault.

## Classification

| Cause | Rating | Notes |
|---|---:|---|
| Viper Git boundary issue | Low | Viper-local `.git` works correctly now. |
| Remaining home-profile Git scan issue | High | Logs still show review-summary from `C:/Users/U`. |
| Session persistence issue | Medium | Thread restored, but active work was interrupted. |
| Codex app issue | Medium | App relaunched and logged bootstrap/update activity. |
| Host connection issue | Low-medium | Local host reconnected successfully. |
| Resource pressure | Medium | Not proven, but broad home scans can create heavy file/index pressure. |
| Viper runtime issue | Low | API and website stayed healthy. |
| Mobile connection issue | Low | No direct evidence found. |

## Recommended Next Step

Do not continue Phase 4H yet.

Recommended next stability task:

```text
VIPER CODEX WORKSPACE ROOT AND TRUST CLEANUP
```

Goals:

1. Make this Codex thread/session attach directly to:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

2. Remove or neutralize the broad Codex trusted project entry for:

```text
c:\users\u
```

only after explicit approval.

3. Confirm Codex review-summary work no longer uses:

```text
C:/Users/U
```

4. Re-run a short 5-minute stability observation before attempting 15-minute or 30-minute idle tests.

5. Consider Option B for `C:\Users\U\.git` only if Codex still scans the home profile after the workspace-root/trust cleanup.

## Option B Status

Option B is not yet required, but it remains a candidate.

The current evidence says:

- The Viper repo is fixed.
- The broad Codex workspace/trust context is still not fixed.
- The home-level `.git` still enables Codex to treat `C:\Users\U` as a repository when the app points there.

Therefore, the safer next repair is Codex workspace-root/trust cleanup before changing or archiving `C:\Users\U\.git`.

## Development Status

Phase 4H should remain paused.

Viper feature development should resume only after Codex stops performing review-summary / Git scanning against `C:/Users/U`.

