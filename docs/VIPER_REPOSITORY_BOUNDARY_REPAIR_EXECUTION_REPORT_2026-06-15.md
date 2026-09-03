# VIPER REPOSITORY BOUNDARY REPAIR EXECUTION REPORT

Date: 2026-06-15

Status: Repair Option A executed and verified.

Copy-ready note: this report is intentionally standalone so the Reports page can place the copy button directly above it.

No Viper feature development was continued. Phase 4H was not started. Viper architecture was not modified. Viper source files were not modified except for the approved repository initialization metadata.

## Mission

Execute Repair Option A from:

- `VIPER_GIT_ROOT_AND_CODEX_SESSION_STABILITY_REPORT_2026-06-15.md`

Primary goal:

Give Viper its own Git boundary while leaving:

```text
C:\Users\U\.git
```

untouched.

## Important Execution Note

Repair Option A had already been applied immediately before this execution report request.

Because of that, the live current state at the start of this report already showed Viper resolving to its own Git root.

The required before-state values below are therefore recorded from the prior repair capture in:

- `VIPER_REPOSITORY_BOUNDARY_REPAIR_REPORT_2026-06-15.md`

The repair command was safely re-run against the existing Viper-local repository and Git reported:

```text
Reinitialized existing Git repository in C:/Users/U/Documents/Codex/Projects/Viper Studio/project/.git/
```

## Task 1: Document Current State Before Repair

Before Option A was applied, Viper inherited the home-folder Git root.

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

Before result:

```text
C:/Users/U
```

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --git-dir
```

Before result:

```text
C:/Users/U/.git
```

Viper-local Git directory before repair:

```text
missing
```

Conclusion:

Viper previously inherited the home-folder Git repository.

## Task 2: Initialize Viper Repository

Target folder:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

Command:

```text
git init
```

Execution result during this report:

```text
Reinitialized existing Git repository in C:/Users/U/Documents/Codex/Projects/Viper Studio/project/.git/
```

Created/confirmed local Viper Git directory:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git
```

No action was taken against:

```text
C:\Users\U\.git
```

## Safe Directory Note

During the first Option A execution, Git detected an ownership mismatch because the Viper folder is owned by `CodexSandboxOffline` while the current user is `U`.

The exact Viper path was added as a Git safe directory:

```text
git config --global --add safe.directory "C:/Users/U/Documents/Codex/Projects/Viper Studio/project"
```

This was required for Git to operate in the Viper-local repository.

It does not touch, move, or delete `C:\Users\U\.git`.

## Task 3: Verify New Boundary

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

After result:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --git-dir
```

After result:

```text
.git
```

Boundary verification:

```text
passed
```

## Task 4: Verify Status Cleanup

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" status --short --untracked-files=normal
```

After repair, status lists Viper-local paths only.

Representative after output:

```text
?? .agents/
?? .config/
?? .gitattributes
?? .gitignore
?? .npmrc
?? VIPER_NEW_THREAD_STARTUP.md
?? artifacts/
?? data/
?? docs/
?? lib/
?? package.json
?? pnpm-lock.yaml
?? pnpm-workspace.yaml
?? public/
?? screenshots/
?? scripts/
?? tsconfig.base.json
?? tsconfig.json
```

No parent-relative home-folder paths were reported.

## Before/After Status Comparison

### Before

Before Option A, `git status` from the Viper project reported home-folder paths such as:

```text
?? ../../../../../.android/
?? ../../../../../.cache/
?? ../../../../../.codex/
?? ../../../../../AppData/
?? ../../../../../Desktop/
?? ../../../../../Documents/
?? ../../../../../Downloads/
?? ../../../../../OneDrive/
```

Before Option A, Git also reported protected Windows profile warnings:

```text
warning: could not open directory 'Application Data/': Permission denied
warning: could not open directory 'Cookies/': Permission denied
warning: could not open directory 'Local Settings/': Permission denied
warning: could not open directory 'My Documents/': Permission denied
warning: could not open directory 'NetHood/': Permission denied
warning: could not open directory 'PrintHood/': Permission denied
warning: could not open directory 'Recent/': Permission denied
warning: could not open directory 'SendTo/': Permission denied
warning: could not open directory 'Start Menu/': Permission denied
warning: could not open directory 'Templates/': Permission denied
```

### After

After Option A:

| Check | Result |
|---|---:|
| AppData warning | false |
| Cookies warning | false |
| Local Settings warning | false |
| Windows profile permission warning | false |
| Home-folder scan behavior | false |
| Dubious ownership error | false |
| Status line count | 64 |

## Warning Comparison

| Warning / Behavior | Before Repair | After Repair |
|---|---:|---:|
| `AppData` scan | present | absent |
| `Application Data` permission warning | present | absent |
| `Cookies` permission warning | present | absent |
| `Local Settings` permission warning | present | absent |
| Parent-relative home paths | present | absent |
| Home-folder Git scan from Viper | present | absent |
| Viper-local repo boundary | missing | present |

## Task 5: Codex Stability Impact Check

### Git Scans

Before:

```text
Viper path -> C:/Users/U
```

After:

```text
Viper path -> C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Assessment:

Git scans are now Viper-only when started from the Viper project.

### Review Summaries

Before:

Codex review summaries could treat the entire Windows user profile as the active repository.

After:

Codex review summaries started from Viper should stop at:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git
```

Assessment:

Review summaries should now be Viper-only for this project.

### Repository Indexing

Before:

Repository indexing could hit:

- `AppData`
- `.codex`
- `.cache`
- `Cookies`
- `Local Settings`
- Windows profile junctions
- long runtime dependency paths

After:

Repository indexing from Viper sees Viper project contents only.

Assessment:

Repository indexing is now Viper-only for this workspace path.

## Expected Codex Stability Impact

Expected impact on Codex reloads:

```text
medium-to-high positive
```

Expected impact on Codex session persistence:

```text
medium-to-high positive
```

Expected impact on background task stability:

```text
high positive
```

Reason:

The strongest confirmed local instability factor was the accidental home-folder Git boundary. Viper no longer inherits that boundary, so Codex should no longer need to scan, summarize, or index the entire Windows user profile while working in Viper.

This does not guarantee Codex can never reload, but it removes the strongest confirmed local repository-boundary cause.

## Home Git Metadata Check

`C:\Users\U\.git` remains present.

It still resolves as the home-folder Git root when commands are run from `C:\Users\U`:

```text
git -C "C:\Users\U" rev-parse --show-toplevel
=> C:/Users/U
```

Tracked file count remains:

```text
0
```

Conclusion:

The requested condition was met. `C:\Users\U\.git` was left untouched.

## Task 6: Rollback Documentation

Rollback is documented only. It was not executed.

To roll back Option A, rename the Viper-local Git metadata directory:

```text
Move-Item -LiteralPath "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git" -Destination "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git.rollback-2026-06-15"
```

Then verify Viper again inherits the home Git root:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

Expected rollback result:

```text
C:/Users/U
```

If needed, remove the Viper safe-directory entry:

```text
git config --global --unset-all safe.directory "C:/Users/U/Documents/Codex/Projects/Viper Studio/project"
```

Do not delete Git metadata as part of rollback.

## Is Option B Still Needed?

Option B is not required for Viper anymore.

Viper is now isolated.

However, `C:\Users\U\.git` still exists and can still affect other folders under the user profile.

Recommendation:

1. Pause Option B for now.
2. Continue using the Viper-local repository boundary.
3. Watch Codex logs/session behavior during the next work session.
4. If Codex still scans the home profile from other threads or folders, consider Option B later with explicit approval.
5. If Option B is executed later, archive `C:\Users\U\.git`; do not delete it.

## Success Condition

Required final Git root:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Actual final Git root:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Required Git dir:

```text
.git
```

Actual Git dir:

```text
.git
```

Required protected condition:

```text
C:\Users\U\.git remains untouched
```

Actual protected condition:

```text
C:\Users\U\.git remains present and was not moved or deleted
```

## Final Conclusion

Repair Option A is complete.

Viper now has its own Git repository boundary:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git
```

Codex should now treat the Viper project as the active repository instead of the whole Windows user profile when operating from the Viper workspace.
