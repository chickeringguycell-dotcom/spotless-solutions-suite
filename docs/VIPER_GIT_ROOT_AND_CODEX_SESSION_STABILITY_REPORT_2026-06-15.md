# VIPER GIT ROOT AND CODEX SESSION STABILITY REPORT

Date: 2026-06-15

Status: repository-boundary and Codex stability investigation only.

Copy-ready note: this report is intentionally standalone so the Reports page can place a copy button directly above it.

No Viper feature development was continued. Phase 4H was not started. No repositories were deleted. No Git metadata was moved. No Viper files were moved.

## Mission

Investigate and document whether `C:\Users\U` is incorrectly acting as the Git root for Viper, and provide a safe repair plan before changing anything.

Source of truth:

- `VIPER_CODEX_SESSION_PERSISTENCE_AUDIT_REPORT_2026-06-15.md`

## Executive Finding

Confirmed:

```text
C:\Users\U
```

is currently acting as the Git root for Viper.

Viper does not currently have its own `.git` folder.

Running Git from the Viper project resolves to the home-folder repository:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
=> C:/Users/U

git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --git-dir
=> C:/Users/U/.git
```

This means Viper is unintentionally inheriting the home-folder Git repository.

## Task 1: Home Git Root Inspection

Inspected:

```text
C:\Users\U\.git
```

Findings:

| Item | Finding |
|---|---|
| Exists | Yes |
| Type | Hidden Git metadata directory |
| Creation time | 2026-05-07 3:28:32 PM |
| Last write time | 2026-06-15 9:13:59 PM |
| Branch | `master` |
| Commits | None found |
| Remotes | None found |
| Tracked files | 0 |
| Config | Default local Git repo config only |

Home `.git/config` contains only:

```text
[core]
  repositoryformatversion = 0
  filemode = false
  bare = false
  logallrefupdates = true
  symlinks = false
  ignorecase = true
```

Home `.git/HEAD` contains:

```text
ref: refs/heads/master
```

No remote origin was found.

No commits were found.

No tracked files were found:

```text
git -C "C:\Users\U" ls-files
=> 0 files
```

## What Repository Does It Belong To?

Based on available evidence, the home-level Git repo does not appear to belong to a real project.

Reasons:

- It has no commits.
- It has no remotes.
- It tracks zero files.
- It was created before the current Viper project folder.
- It causes the entire Windows user profile to appear as one Git working tree.

Assessment:

This looks like an accidental or abandoned `git init` at `C:\Users\U`, not an intentional active repository.

## What Folders Are Currently Under It?

Because the Git root is `C:\Users\U`, Git sees the whole user profile as the working tree.

Examples reported by `git status --short --untracked-files=normal`:

```text
.android/
.cache/
.codex/
.expo/
.openclaw/
.vscode/
AGENTS.md
AppData/
Desktop/
Documents/
Downloads/
OneDrive/
Pictures/
SOUL.md
USER.md
Videos/
```

Git also reports permission warnings:

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

## Task 2: Viper Project Inspection

Inspected:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

Findings:

| Item | Finding |
|---|---|
| Project exists | Yes |
| Project creation time | 2026-05-30 11:04:53 AM |
| Project last write time | 2026-06-15 6:56:02 PM |
| Viper `.git` folder | Missing |
| Current Git root from Viper | `C:/Users/U` |
| Current Git dir from Viper | `C:/Users/U/.git` |
| Branch inherited by Viper | `master` |
| Viper remote | None, because inherited home repo has no remote |

Conclusion:

Viper is not isolated as its own repository. It is inheriting the home-folder Git repo.

## Task 3: Impact Analysis

The current Git boundary can cause:

| Impact | Confirmed? | Evidence |
|---|---:|---|
| Permission errors | Yes | Git status reports protected Windows folders as permission denied. |
| Filename-too-long errors | Yes | Codex desktop logs reported `Filename too long` inside cached runtime dependencies. |
| Indexing failures | Yes | Codex logs reported `unable to index file` and `fatal: adding files failed`. |
| Repo scanning failures | Yes | Codex review-summary/Git worker repeatedly failed against home-folder paths. |
| Codex reloads | Likely | Codex logs show repeated app process groups and reconnects in the same work window. |
| Session instability | High likelihood | Oversized Git workspace creates recurring background worker failures. |

### Codex Log Evidence

The previous audit found repeated Codex desktop log failures containing:

```text
warning: could not open directory 'AppData/Local/Application Data/': Permission denied
warning: could not open directory 'Application Data/': Permission denied
error: Filename too long
error: unable to index file
fatal: adding files failed
```

The filename-too-long path was inside cached runtime dependency folders under the user home tree, not inside a focused Viper-only repo.

### Why This Matters

Codex uses Git/review-summary behavior to inspect changes and project state.

If Git says the project root is `C:\Users\U`, Codex may try to reason over:

- personal user folders
- `AppData`
- `.codex`
- runtime caches
- browser profiles
- package manager stores
- long Windows dependency paths
- protected Windows junctions

That greatly increases scan cost and error rate.

## Session Stability Assessment

Likelihood that the Git-root issue contributes to Codex reloads:

```text
high
```

Likelihood that it contributes to Codex session loss or background task instability:

```text
high
```

Reason:

The home-folder Git root directly matches the observed Codex log failures and explains why Viper can validate cleanly while Codex desktop still becomes unstable or reload-prone.

This does not prove it is the only cause. It is the strongest confirmed local cause found so far.

## Task 4: Safe Repair Plan

Do not execute this automatically.

Only proceed after explicit user approval.

### Goal

Make Viper resolve as its own Git root:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Expected future result:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
=> C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

### Repair Option A: Safest Viper-Only Boundary

This option leaves the home `.git` directory in place and creates a nested Viper repo.

Steps:

1. Verify Viper project path:

   ```text
   C:\Users\U\Documents\Codex\Projects\Viper Studio\project
   ```

2. Initialize Git inside Viper:

   ```text
   git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" init
   ```

3. Confirm Viper now resolves to itself:

   ```text
   git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
   ```

4. Confirm expected result:

   ```text
   C:/Users/U/Documents/Codex/Projects/Viper Studio/project
   ```

5. Run a clean Viper-focused status:

   ```text
   git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" status --short
   ```

6. Confirm no Windows home-folder warnings appear.

7. Leave `C:\Users\U\.git` untouched until the user decides whether it should be archived.

Pros:

- Does not move or delete existing home Git metadata.
- Immediately isolates Viper Git behavior.
- Low risk to Viper files.
- Easy rollback by removing only the newly created Viper `.git` folder if needed.

Cons:

- The accidental home `.git` remains in place and can still affect other folders under `C:\Users\U`.
- Codex may still have broad workspace trust hints until those are narrowed.

Recommended if the user wants the least disruptive first repair.

### Repair Option B: Archive The Accidental Home Git Metadata

This option removes the accidental home Git boundary by moving it to a recoverable archive name.

Do not delete it.

Steps:

1. Confirm `C:\Users\U\.git` is still empty/no-commit/no-remote:

   ```text
   git -C "C:\Users\U" ls-files
   git -C "C:\Users\U" remote -v
   git -C "C:\Users\U" log --oneline -5
   ```

2. Move home `.git` to an archive folder:

   ```text
   Move-Item -LiteralPath "C:\Users\U\.git" -Destination "C:\Users\U\.git.home-accidental-archive-2026-06-15"
   ```

3. Initialize Viper as its own repo:

   ```text
   git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" init
   ```

4. Confirm Viper root:

   ```text
   git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
   ```

5. Confirm `C:\Users\U` no longer acts as a repo:

   ```text
   git -C "C:\Users\U" rev-parse --show-toplevel
   ```

   Expected:

   ```text
   fatal: not a git repository
   ```

Pros:

- Fully removes the accidental home-folder Git boundary.
- Prevents other Codex or Git operations from scanning the whole user profile.
- Likely best long-term repair.

Cons:

- Slightly higher risk because it changes existing home Git metadata location.
- Must be done only after explicit user approval.

Recommended long-term if the home `.git` is confirmed accidental.

## Rollback Plan

### Rollback For Option A

If creating a nested Viper repo causes problems:

1. Do not delete immediately.
2. Rename the newly created Viper `.git` folder:

   ```text
   Move-Item -LiteralPath "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git" -Destination "C:\Users\U\Documents\Codex\Projects\Viper Studio\project\.git.rollback-2026-06-15"
   ```

3. Viper will again inherit the home Git root.

### Rollback For Option B

If archiving the home `.git` causes problems:

1. Move it back:

   ```text
   Move-Item -LiteralPath "C:\Users\U\.git.home-accidental-archive-2026-06-15" -Destination "C:\Users\U\.git"
   ```

2. Verify:

   ```text
   git -C "C:\Users\U" rev-parse --show-toplevel
   ```

3. Expected:

   ```text
   C:/Users/U
   ```

## Risk Assessment

| Risk | Level | Notes |
|---|---:|---|
| Leaving current state unchanged | High | Codex can continue scanning the whole home folder. |
| Option A nested Viper repo | Low | Minimal change; home `.git` remains untouched. |
| Option B archive home `.git` | Medium | Best long-term fix, but moves existing metadata. |
| Deleting home `.git` | Not recommended | User explicitly requested no deletion. |
| Moving Viper files | Not recommended | Not needed. |

## Recommendation

Recommended path:

1. Start with Option A if immediate Viper stability is the priority.
2. After confirming Viper is stable as its own repo, decide whether to perform Option B.
3. If `C:\Users\U\.git` is not intentionally used by anything else, archive it rather than delete it.
4. Reopen Codex after the repo boundary repair.
5. Confirm Codex no longer reports home-folder Git/review-summary failures.
6. Run a 15-minute, then 30-minute, then 60-minute idle persistence check.

## Success Criteria For Repair

After repair, this command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" rev-parse --show-toplevel
```

must return:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

And this command:

```text
git -C "C:\Users\U\Documents\Codex\Projects\Viper Studio\project" status --short
```

must not report protected Windows home-folder warnings such as:

```text
Application Data/: Permission denied
Cookies/: Permission denied
Local Settings/: Permission denied
```

## Final Conclusion

The suspected Git-root problem is confirmed.

Viper is currently inheriting an empty, no-commit, no-remote Git repository rooted at:

```text
C:\Users\U
```

This is very likely contributing to Codex session instability because Codex/Git helper work is scanning the whole user profile instead of the Viper project.

No repair was executed in this phase. A safe repair plan and rollback plan are documented above.
