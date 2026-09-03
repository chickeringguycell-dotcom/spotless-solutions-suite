# VIPER CURRENT THREAD ATTACHMENT VERIFICATION REPORT

Date: 2026-06-15

Status: verification only.

No Viper feature work was performed. No Codex configuration was modified during this verification.

## 1. Current Working Directory

The current live thread working directory is:

```text
C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

This is the old projectless Codex thread folder, not the Viper project folder.

## 2. Current Git Root

Running Git from the current thread working directory resolves to:

```text
C:/Users/U
```

Git dir:

```text
C:/Users/U/.git
```

Running Git directly inside the Viper project still resolves correctly:

```text
C:/Users/U/Documents/Codex/Projects/Viper Studio/project
```

Git dir:

```text
.git
```

## 3. Current Trusted Project

Codex config currently keeps the Viper project trusted:

```text
[projects.'c:\users\u\documents\codex\projects\viper studio\project']
trust_level = "trusted"
```

The broad home trust entry is not present:

```text
[projects.'c:\users\u']
```

Result:

```text
Home trust entry:  not present
Viper trust entry: present
```

## 4. Review-Summary Root

Fresh post-check logs show review-summary is still using:

```text
C:/Users/U
```

Recent log counts:

```text
review-summary using C:/Users/U: 6
review-summary using Viper:     0
AppData warnings:               4
Cookies warnings:               4
Local Settings warnings:        4
Filename-too-long warnings:     4
unable-to-index warnings:       4
```

Representative latest line:

```text
requestKind=review-summary
cwd=C:/Users/U
subcommand=add
success=false
```

## 5. Is This Thread Attached To Viper?

No.

The active Codex thread list reports:

```text
Thread: Viper Studios thread 2
ID:     019eb97f-7477-7412-8d9c-e7acae8f8652
Status: active
cwd:    C:\Users\U\Documents\Codex\2026-06-11\ive-been-almost-a-week-without
```

The thread is not currently attached to:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

## Short Conclusion

The Viper project repository is healthy and trusted, but this live thread is still running from the old projectless Codex folder. Because of that, plain Git and review-summary activity still climb to `C:/Users/U`.

Phase 4H should remain paused until Viper work happens in a thread whose live `cwd` is:

```text
C:\Users\U\Documents\Codex\Projects\Viper Studio\project
```

