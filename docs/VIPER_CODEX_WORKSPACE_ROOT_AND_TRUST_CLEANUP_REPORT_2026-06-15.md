# VIPER CODEX WORKSPACE ROOT AND TRUST CLEANUP REPORT

Date: 2026-06-15

Status: stability/configuration cleanup with partial live-session success.

No Viper feature development was continued. Phase 4H was not started. Proxy Image Request work was not continued. No Viper architecture files were modified.

## Source Of Truth

This cleanup used:

- `VIPER_CODEX_POST_GIT_REPAIR_CRASH_REPORT_2026-06-15.md`
- `VIPER_REPOSITORY_BOUNDARY_REPAIR_EXECUTION_REPORT_2026-06-15.md`

## Primary Result

The saved Codex trust and root configuration was repaired:

- The broad Codex trusted project entry for `c:\users\u` was removed.
- The Viper project trust entry was retained.
- This active thread's saved workspace root hint was changed from `C:\Users\U\Documents\Codex` to `C:\Users\U\Documents\Codex\Projects\Viper Studio\project`.
- `C:\Users\U\.git` was not touched.

However, the current live loaded thread still reports its active `cwd` as the old projectless Codex folder:

```text
C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

Fresh post-cleanup logs still show review-summary / Git activity using:

```text
C:/Users/U
```

Therefore, this cleanup fixed the saved configuration, but the currently loaded thread has not fully reattached to the Viper project at runtime.

## Backups Created

Backups were created before editing Codex configuration:

```text
C:\Users\U\.codex\config.toml.viper-root-cleanup-20260615-2138.bak
C:\Users\U\.codex\.codex-global-state.json.viper-root-cleanup-20260615-2138.bak
```

## Project Trust Entries Found

Before cleanup, Codex config contained:

```text
[projects.'c:\users\u']
[projects.'c:\users\u\documents\codex\projects\viper studio\project']
```

After cleanup, Codex config contains only:

```text
[projects.'c:\users\u\documents\codex\projects\viper studio\project']
trust_level = "trusted"
```

Verification:

```text
ExactHomeTrustEntryPresent:  false
ExactViperTrustEntryPresent: true
```

## Workspace Root Entries Found

Before cleanup, this active thread had:

```text
Thread: 019eb97f-7477-7412-8d9c-e7acae8f8652
Root:   C:\Users\U\Documents\Codex
```

After cleanup, saved Codex state has:

```text
Thread: 019eb97f-7477-7412-8d9c-e7acae8f8652
Root:   C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

Historical projectless Viper-related threads still have remembered roots under:

```text
C:\Users\U\Documents\Codex
```

These were not changed because they are not the currently active thread.

## Live Thread Finding

The Codex thread list still reports the active thread as:

```text
Thread: Viper Studios thread 2
ID:     019eb97f-7477-7412-8d9c-e7acae8f8652
Status: active
cwd:    C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

This is the key remaining issue.

The persisted root hint now points to Viper, but the currently loaded thread is still running from the old projectless folder. Because that folder sits under the Windows user profile and `C:\Users\U\.git` still exists, Codex review-summary can still climb to:

```text
C:/Users/U
```

## Viper Git Verification

Viper remains a valid local repository:

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

Status check:

```text
AppData warnings:        false
Cookies warnings:        false
Local Settings warnings: false
Permission denied:       false
Home folder scan:        false
```

This confirms the Viper repository repair is still healthy.

## Review-Summary Verification

After cleanup, a short observation still found fresh review-summary activity against:

```text
C:/Users/U
```

Post-cleanup log counts included:

```text
review-summary:       57
cwd=C:/Users/U:       42
Permission denied:    82
AppData/Local:        82
Cookies/:             23
Local Settings:       23
Filename too long:    23
unable to index:      23
argsCount=1026:       21
```

Latest representative line:

```text
git add -A
cwd=C:/Users/U
requestKind=review-summary
source=review_model
success=false
```

This means the success condition is not fully met in the currently loaded session.

## Stability Observation

A short observation was run in three chunks.

Results:

```text
Chunk 1: survived
Chunk 2: survived
Chunk 3: survived
Codex process count: stable at 9
```

No immediate new user-visible reload occurred during the observation window.

Viper services stayed healthy:

```text
API health:     200
Website health: 200
```

However, Codex memory continued to rise while review-summary activity remained pointed at `C:/Users/U`, so the remaining risk is still real.

## Cleanup Performed

Performed:

- Backed up Codex config and global state.
- Removed `[projects.'c:\users\u']` from `C:\Users\U\.codex\config.toml`.
- Retained `[projects.'c:\users\u\documents\codex\projects\viper studio\project']`.
- Updated active thread saved root hint to the Viper project path.
- Verified Viper Git root remains project-local.
- Verified Viper API and website remained healthy.

Not performed:

- Did not touch `C:\Users\U\.git`.
- Did not archive anything.
- Did not delete any Codex data.
- Did not continue Viper feature work.
- Did not start Phase 4H.

## Remaining Risk

The currently loaded thread is still projectless at runtime.

As long as the live thread `cwd` remains:

```text
C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

Codex may continue to run review-summary against:

```text
C:/Users/U
```

The saved configuration cleanup may take effect only after reopening the thread, restarting Codex, or moving to a project-attached Viper thread.

## Recommendation

Do not begin Phase 4H in the current loaded projectless thread.

Recommended next action:

1. Open or create a Codex thread attached directly to the saved Viper project:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

2. Confirm the thread `cwd` is:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

3. Run a 5-minute stability observation.

4. Confirm no new log entries contain:

```text
cwd=C:/Users/U
requestKind=review-summary
AppData/Local
Cookies/
Local Settings
Filename too long
unable to index
```

5. Only then consider Phase 4H safe to resume.

If a project-attached thread still causes `C:/Users/U` review-summary activity, then Option B should be reconsidered: safely archiving or disabling `C:\Users\U\.git` with explicit approval.

## Rollback Instructions

Rollback was not executed.

If needed, restore:

```text
C:\Users\U\.codex\config.toml.viper-root-cleanup-20260615-2138.bak
```

to:

```text
C:\Users\U\.codex\config.toml
```

and restore:

```text
C:\Users\U\.codex\.codex-global-state.json.viper-root-cleanup-20260615-2138.bak
```

to:

```text
C:\Users\U\.codex\.codex-global-state.json
```

## Phase 4H Recommendation

Phase 4H should not begin yet in this current loaded thread.

The next safe step is to run Viper work from a project-attached thread whose active `cwd` is the Viper project folder, then verify that review-summary stops touching `C:/Users/U`.

