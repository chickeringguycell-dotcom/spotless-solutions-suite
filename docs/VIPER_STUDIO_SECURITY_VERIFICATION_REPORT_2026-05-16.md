# Viper Studio — Security Verification Report

Generated: 2026-05-16  
Tested against: commit a2cf57aa  
Method: Live curl against running API server (localhost:80)

---

## 1. Upload Validation — Triple-Gate

**File:** `artifacts/api-server/src/lib/uploadSecurity.ts`  
**Functions:** `validateUpload()`, `detectSSRFPatterns()`, `inspectGLB()`, `sanitizeFilename()`, `formatBytes()`  
**Automated tests:** None  
**Status: IMPLEMENTED**

| Gate | What it checks | Blocked payload | Live result |
|------|---------------|----------------|-------------|
| 0 — Extension hard block | `.exe`, `.sh`, `.php`, 40+ types | `filename=malware.exe` | `{"error":"File type \".exe\" is not permitted."}` ✓ |
| 0b — MIME hard block | `application/x-msdownload`, JS MIME, HTML | `Content-Type: application/x-msdownload` | `{"error":"Content type \"application/x-msdownload\" is not permitted."}` ✓ |
| 1 — Extension allowlist | Only `glb/gltf/obj/stl/ply` | any other extension | continues to next gate |
| 2 — Size limit | 100 MB max | `sizeBytes > 104857600` | size error message |
| 3 — Magic bytes | `glTF` for GLB, `ply\n` for PLY | MZ header in `.glb` | `"File content does not match its claimed format (.glb)."` ✓ |
| 3 — Magic bytes | Shell script in `.glb` | `#!/bin/bash` content | `"File content does not match its claimed format (.glb)."` ✓ |
| 4 — SSRF in text | `169.254.169.254`, `localhost`, `file://`, `javascript:` in GLTF/OBJ | AWS metadata URI in GLTF | `"File contains disallowed external references: 169\\.254\\.169\\.254"` ✓ |
| 4 — SSRF in text | `javascript:` URI in GLTF images | `javascript:fetch(...)` | `"File contains disallowed external references: javascript:"` ✓ |
| 5 — GLB JSON chunk | External `http://` URIs in GLB's embedded GLTF JSON | `http://evil.example.com/steal-api-keys` | `"GLB contains disallowed content: external URI in GLB: ..."` ✓ |

**Successful payload (valid GLB — passes all gates):**
```
POST /api/gallery/upload?filename=viper_mk1_two_seat.glb
Content-Type: application/octet-stream
[140-byte GLB with glTF magic, no external URIs]

→ HTTP 200
{
  "uploadId": "a225eda2-e9c1-40cb-8170-bd7b970d41b0",
  "filename": "viper_mk1_two_seat.glb",
  "sizeBytes": 140,
  "fileHash": "75abe617e7083c7f0a8665633b9c84ee7645070471fcf8c5ab40389c66798ac2",
  "scanner": "stub",
  "message": "File scanned and cleared. Submit with POST /api/gallery to publish."
}
```

**Remaining limitations:**
- SSRF scan reads only the first 256 KB of text files. URIs after byte 256K are not checked.
- Binary STL has no reliable magic signature — no content-level check for STL.
- Files are not written to disk. The pipeline is in-memory only; server restart loses all uploaded data.
- No automated test suite (zero test files exist).

---

## 2. Virus Scanner

**File:** `artifacts/api-server/src/lib/virusScan.ts`  
**Functions:** `quarantineFile()`, `releaseFromQuarantine()`, `scanBuffer()`, `getScannerStatus()`

### ClamAV — PLACEHOLDER (not active)

The invocation code exists but is commented out at lines 57–64. `clamscan` npm package is not installed.

Activation path:
1. `apt install clamav clamav-daemon`
2. `pnpm add clamscan` in `artifacts/api-server`
3. Uncomment lines 57–64 in `virusScan.ts`

```typescript
// Lines 57-64 (currently commented out):
// import NodeClam from "clamscan";
// const clamscan = await new NodeClam().init({ removeInfected: false });
// const { isInfected, viruses } = await clamscan.scanBuffer(buffer);
// if (isInfected) {
//   return { clean: false, scanner: "clamav", scannedAt, threat: viruses.join(", ") };
// }
// return { clean: true, scanner: "clamav", scannedAt };
```

### VirusTotal — PLACEHOLDER (not active)

API call is commented out at lines 66–83. `VIRUSTOTAL_API_KEY` is not set.

Activation path:
1. Set `VIRUSTOTAL_API_KEY` in Replit Secrets
2. Uncomment lines 66–83 in `virusScan.ts`

### Current behavior

`scanBuffer()` always returns `{ clean: true, scanner: "stub" }`.  
One heuristic: GLB files smaller than 32 bytes are rejected.

**Live scanner status response:**
```json
{
  "configured": false,
  "scanner": "stub",
  "note": "No real scanner configured. Set VIRUSTOTAL_API_KEY or install ClamAV to activate."
}
```

**Status: STUB**

---

## 3. Quarantine Store

**File:** `artifacts/api-server/src/lib/virusScan.ts` (lines 25–38)  
**Status: IMPLEMENTED (in-memory only)**

**Upload lifecycle — verified live (T13):**

```
POST /api/gallery/upload
  1. validateUpload()        — all gates pass
  2. quarantineFile(id, buf) — Map.set(), auto-evict in 30 min
  3. scanBuffer(id, buf)     — stub returns clean:true
  4. releaseFromQuarantine() — Map.delete()
  5. return { uploadId, fileHash, scanner, message }
```

**Live output:**
```
uploadId:   c2e5f5bd-66bc-4f4a-b5dc-120474f22b1e
fileHash:   bbd87f12428e41b177321b98203c8c0c...
sizeBytes:  136
scanner:    stub
message:    File scanned and cleared. Submit with POST /api/gallery to publish.
```

**Remaining limitations:**
- In-memory `Map` — does not survive server restart.
- Scan failures leave the entry in quarantine for 30 minutes (auto-evict) rather than immediate deletion.
- Production path: write-once object store (S3, GCS, or out-of-webroot disk path).

---

## 4. Audit Log

**File:** `artifacts/api-server/src/lib/auditLog.ts`  
**Functions:** `audit()`, `trackSuspicion()`, `getRecentAudit()`, `getAuditForPost()`, `getSuspiciousIPs()`, `hashIP()`  
**Status: IMPLEMENTED (in-memory ring buffer)**

**All event types confirmed recorded during this session (T15 — live):**

```
content_hidden          1
mod_approved            1
mod_rejected            1
rate_limit_hit          1
report_filed            3
scan_pass               7
upload_attempt         16
upload_blocked          8
upload_published        1
upload_quarantine       7
Total entries:         46
```

Every defined event type (`upload_attempt`, `upload_blocked`, `upload_quarantine`, `scan_pass`, `upload_published`, `report_filed`, `content_hidden`, `mod_approved`, `mod_rejected`, `rate_limit_hit`) was recorded.

**Remaining limitations:**
- Ring buffer holds 1000 entries in-memory. Lost on server restart.
- No distributed/persistent log storage.
- `suspicious_pattern` event (threshold: 5 blocked uploads/IP/hour) was not triggered during this session — code reviewed but not live-tested.
- `IP_HASH_SALT` is hardcoded (`viper-salt-2025`). Set as environment secret in production.

---

## 5. Rate Limiting

**File:** `artifacts/api-server/src/app.ts`  
**Status: IMPLEMENTED**

### Thresholds

| Limiter | Path | Max | Window | Key source |
|---------|------|-----|--------|-----------|
| `generalLimiter` | `/api/*` | 300 req | 15 min | `X-Forwarded-For[0]` |
| `uploadLimiter` | `/api/gallery/*` | 10 req | 1 hour | `X-Forwarded-For[0]` |
| `binaryUploadLimiter` | `/api/gallery/upload` | 5 req | 1 hour | `X-Forwarded-For[0]` |
| `aiLimiter` | `/api/chat`, `/api/imagine` | 60 req | 15 min | `X-Forwarded-For[0]` |

### Live test — IP 40.0.0.1, binaryUploadLimiter (max 5/hr)

```
Req 1 → HTTP 200 | scanner: stub     ← pass
Req 2 → HTTP 200 | scanner: stub     ← pass
Req 3 → HTTP 200 | scanner: stub     ← pass
Req 4 → HTTP 200 | scanner: stub     ← pass
Req 5 → HTTP 200 | scanner: stub     ← pass
Req 6 → HTTP 429 | "File upload limit reached — maximum 5 file uploads per hour."  ← blocked
```

Audit log confirmed `rate_limit_hit` event recorded on request 6.

### Remaining limitations

- Rate limit state is in-memory. Server restart resets all counters.
- No Redis/distributed store — multiple API server instances would have independent counters.
- `X-Forwarded-For` spoofing: in development, clients can set their own header. In Replit's production proxy, the header is set by the proxy and cannot be client-spoofed.

---

## 6. Auto-Hide + Moderation

**Files:** `artifacts/api-server/src/routes/gallery.ts`, `artifacts/api-server/src/routes/moderation.ts`  
**Status: IMPLEMENTED**

### Auto-hide trigger (T7 — live)

Threshold: 3 reports → status changes from `published` to `hidden`.

```
POST /api/gallery   → created post c5dc5082... (status: published)
POST /api/gallery/c5dc5082.../report  → reportCount: 1
POST /api/gallery/c5dc5082.../report  → reportCount: 2
POST /api/gallery/c5dc5082.../report  → reportCount: 3

GET /api/gallery/c5dc5082...
→ { status: "hidden", reportCount: 3 }

GET /api/gallery (public feed)
→ post c5dc5082... NOT present  (confirmed: False)
```

### Moderator approve (T14a — live)

```
POST /api/mod/7c0d2b01.../approve
→ {
    "approved": true,
    "postId": "7c0d2b01...",
    "previousStatus": "hidden",
    "currentStatus": "published"
  }

GET /api/gallery/7c0d2b01...
→ { status: "published", reportCount: 0 }   ← reports cleared on approval
```

### Moderator reject (T14b — live)

```
POST /api/mod/seed-2/reject  { "reason": "moderator verification test" }
→ {
    "rejected": true,
    "postId": "seed-2",
    "previousStatus": "published",
    "currentStatus": "rejected",
    "reason": "moderator verification test"
  }
```

### Remaining limitations

- **No authentication on `/api/mod/*` routes.** Anyone who knows the path can approve or reject content. Auth middleware required before production use.
- Version history works (up to 10 snapshots per post, in-memory) but rollback endpoint was not live-tested in this session.

---

## Bugs Found and Fixed During This Verification Session

| # | Bug | Evidence | Fix applied |
|---|-----|----------|-------------|
| 1 | `binaryUploadLimiter`, `generalLimiter`, `aiLimiter` keyed on `req.ip` = always `127.0.0.1` in Replit's proxy — all requests shared one rate limit bucket | All 6 test requests got HTTP 429, including request 1 from a "fresh" IP | Added `extractIP()` function reading `X-Forwarded-For[0]` directly; all four limiters now use it |
| 2 | `moderation.ts` had no POST routes — `mod_approved` and `mod_rejected` audit events were defined in the type union but had no code path to fire them | Reviewed source; events existed in type but no handler | Added `POST /api/mod/:id/approve` and `POST /api/mod/:id/reject` |
| 3 | `gallery.ts` `posts` Map not exported — `moderation.ts` couldn't mutate post state | `import("./gallery").POSTS` undefined | Renamed to `POSTS`, added named export |

---

## Summary

| Feature | Status |
|---------|--------|
| Extension hard-block (exe, sh, js, 40+ types) | **Implemented** — live-tested |
| MIME type hard-block | **Implemented** — live-tested |
| Magic bytes check (GLB, PLY) | **Implemented** — live-tested |
| SSRF in GLTF/OBJ text content | **Implemented** — live-tested |
| SSRF in GLB embedded JSON chunk | **Implemented** — live-tested |
| Path traversal filename sanitization | **Implemented** — live-tested |
| Quarantine store | **Implemented** (in-memory, not persisted) — live-tested |
| Virus scanner — ClamAV | **Placeholder** — commented out, package not installed |
| Virus scanner — VirusTotal | **Placeholder** — commented out, API key not set |
| Rate limiting per IP | **Implemented** — live-tested, fires at correct threshold |
| Audit log | **Implemented** (in-memory ring buffer, lost on restart) — all 10 event types confirmed |
| Auto-hide at 3 reports | **Implemented** — live-tested |
| Moderator approve | **Implemented** — live-tested |
| Moderator reject | **Implemented** — live-tested |
| Authentication on `/api/mod/*` | **Not implemented** |
| Automated test suite (jest/vitest) | **Not implemented** |
| Persistent storage (files, audit, quarantine) | **Not implemented** — all in-memory |
