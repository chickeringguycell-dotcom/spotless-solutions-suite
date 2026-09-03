# SciPy Binary Blocker Event Audit

## Phase 1 Execution
- **Event Log Name:** `Microsoft-Windows-CodeIntegrity/Operational`
- **Event ID:** `3077` and `3033`
- **Timestamp:** 7/15/2026 6:31:33 PM
- **Blocked File:** `\Device\HarddiskVolume3\Users\U\Documents\antigravity\dazzling-noether\local-compute-node\.venv\Lib\site-packages\scipy\spatial\transform\_rigid_transform_cy.cp313-win_amd64.pyd`
- **Process Attempting Load:** `\Device\HarddiskVolume3\Users\U\miniconda3\python.exe`
- **Policy Name / ID:** `{0283ac0f-fff1-49ae-ada1-8a933130cad6}`
- **Signer Information:** Unsigned / untrusted PyPI wheel binary.
- **Enforcement Result:** Blocked.
- **Exact Error Text:** "Code Integrity determined that a process... attempted to load... that did not meet the Enterprise signing level requirements or violated code integrity policy."
- **Classification:** **APP_CONTROL_FOR_BUSINESS / WDAC** (Device Guard / Code Integrity).

## Conclusion
The blocker was not consumer "Smart App Control" via Defender, but rather a strict OS-level Code Integrity (WDAC) policy enforcing Enterprise signing level requirements on executable DLLs/PYDs. However, subsequent isolated imports allowed the binary to pass (likely due to cloud reputation caching, managed installer caching, or delayed intelligent security graph telemetry).
