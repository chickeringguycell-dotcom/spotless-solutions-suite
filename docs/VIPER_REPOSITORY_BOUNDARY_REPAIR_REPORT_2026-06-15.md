# VIPER REPOSITORY BOUNDARY REPAIR REPORT

Date: 2026-06-15

Status: Option A repair completed.

Copy-ready note: this report is intentionally standalone so the Reports page can place a copy button directly above it.

No Viper feature development was continued. Phase 4H was not started. No Viper files were moved. No Git metadata was deleted. `C:\Users\U\.git` was not moved or deleted.

## Mission

Execute the safe Git-boundary repair recommended by:

- `VIPER_GIT_ROOT_AND_CODEX_SESSION_STABILITY_REPORT_2026-06-15.md`

Goal:

Make Viper resolve as its own Git repository without touching:

```text
C:\Users\U\.git
```

## Task 1: Current State Before Repair

Before repair, Viper inherited the home-folder Git root.

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

Viper-local `.git` before repair:

```text
missing
```

Conclusion:

Viper was inheriting the home-folder Git repository.

## Before Status Output

Before repair, Git status from Viper showed home-folder paths such as:

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

Before repair, Git also reported protected Windows folder warnings:

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

## Task 2: Repair Performed

Inside:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

Executed:

```text
git init
```

Result:

```text
Initialized empty Git repository in C:/Users/U/Documents/Codex/Projects/Viper Studio/project/.git/
```

This created:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git
```

No action was taken against:

```text
C:\Users\U\.git
```

## Git Safety Adjustment

After creating the Viper-local repo, Git detected a Windows ownership mismatch:

```text
fatal: detected dubious ownership in repository at 'C:/Users/U/Documents/Codex/Projects/Viper Studio/project'
```

Git reported:

```text
Folder owner: GUYSPC/CodexSandboxOffline
Current user: GUYSPC/U
```

To allow Git to use the exact Viper project path, the standard exact-path safe-directory entry was added:

```text
git config --global --add safe.directory 'C:/Users/U/Documents/Codex/Projects/Viper Studio/project'
```

Scope:

- This did not touch `C:\Users\U\.git`.
- This did not move Viper files.
- This did not delete Git metadata.
- This only tells Git that the exact Viper folder is trusted for the current user.

## Task 3: Repair Verification

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

Current branch:

```text
master
```

Viper-local `.git` exists:

```text
true
```

## Task 4: Status Check

Command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" status --short --untracked-files=normal
```

After repair, status listed only Viper project paths such as:

```text
?? .agents/
?? .config/
?? .gitattributes
?? .gitignore
?? artifacts/
?? data/
?? docs/
?? lib/
?? package.json
?? pnpm-lock.yaml
?? pnpm-workspace.yaml
?? public/
?? scripts/
```

No parent-relative home paths were reported.

Validation flags:

| Check | Result |
|---|---:|
| AppData warning | false |
| Cookies warning | false |
| Local Settings warning | false |
| Permission denied warning | false |
| Parent-relative entries like `../../../../../` | false |
| Dubious ownership error after safe-directory entry | false |

Status line count after repair:

```text
64
```

This means Git now scans Viper project files only.

## Home Git Metadata Check

`C:\Users\U\.git` still exists.

It was not deleted, moved, or modified by the repair command.

Post-repair check from the home folder still reports:

```text
git -C "C:\Users\U" rev-parse --show-toplevel
=> C:/Users/U
```

Home repository tracked file count remains:

```text
0
```

Conclusion:

Option A succeeded without changing the home-level Git metadata.

## Task 5: Codex Impact Check

### Git Scans

Before:

Git scans from Viper resolved to:

```text
C:/Users/U
```

After:

Git scans from Viper resolve to:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Assessment:

Git scans are now Viper-only when commands are run from the Viper project.

### Review Summaries

Before:

Codex review-summary/Git helper work could see the entire user home tree.

After:

Review summaries started from the Viper project should now stop at the Viper-local `.git` folder.

Assessment:

Expected to be Viper-only. This should substantially reduce Codex background scan pressure.

### Repository Indexing

Before:

Indexing could hit:

- `AppData`
- `Cookies`
- `Local Settings`
- `.codex`
- `.cache`
- long runtime dependency paths
- protected Windows junctions

After:

Indexing from the Viper project sees the Viper folder only.

Assessment:

Repository indexing is now Viper-only for this project path.

## Permission Warning Comparison

| Warning Type | Before Repair | After Repair |
|---|---:|---:|
| `AppData` / `Application Data` | present | absent |
| `Cookies` | present | absent |
| `Local Settings` | present | absent |
| `Permission denied` | present | absent |
| `Filename too long` risk from home caches | high | greatly reduced |
| Parent-relative home folder entries | present | absent |

## Expected Codex Stability Impact

Expected impact:

```text
high positive
```

Reason:

The strongest confirmed local Codex instability trigger was the home-folder Git root. Viper now has its own repository boundary, so Codex should no longer need to treat the whole Windows user profile as the active project when working inside Viper.

This should reduce:

- Git scan cost
- review-summary failures
- permission-denied noise
- filename-too-long risk
- accidental home-folder indexing
- background worker pressure

This does not guarantee Codex will never reload, but it removes the strongest confirmed local cause.

## Rollback Instructions

Do not delete anything immediately.

If Option A causes problems, rollback by archiving the Viper-local `.git` folder:

```text
Move-Item -LiteralPath "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git" -Destination "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git.rollback-2026-06-15"
```

Then Viper would again inherit:

```text
C:\Users\U\.git
```

If the safe-directory entry must also be removed:

```text
git config --global --unset-all safe.directory "C:/Users/U/Documents/Codex/Projects/Viper Studio/project"
```

Rollback risk:

```text
low
```

## Is Option B Still Needed?

Option B is still recommended later, but it is no longer urgent for Viper itself.

Current state:

- Viper is isolated.
- `C:\Users\U\.git` still exists.
- Other folders under `C:\Users\U` can still accidentally inherit the home repo.

Recommendation:

1. Leave Option B paused for now.
2. Work in Viper and verify Codex stability.
3. If Codex still scans home-folder paths from other threads or projects, then archive `C:\Users\U\.git` later with explicit approval.
4. Do not delete `C:\Users\U\.git`.

## Success Condition

Required result:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Actual result:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Required result for Git dir:

```text
.git
```

Actual result:

```text
.git
```

Required condition:

No modification or deletion of:

```text
C:\Users\U\.git
```

Actual condition:

`C:\Users\U\.git` remains present and untouched by the repair.

## Final Conclusion

Option A repair succeeded.

Viper now resolves as its own repository:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Git status no longer scans the Windows user profile from the Viper project and no longer reports the previous protected-folder permission warnings.

Codex should now treat Viper as the active repository boundary instead of the entire user profile when working from the Viper project.
