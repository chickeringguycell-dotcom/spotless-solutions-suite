# Viper Studios Workspace Storage Audit Report

This report presents a comprehensive storage audit of the Viper Studios workspace repository.

- **Audit Date**: 2026-06-25
- **Total Files Scanned**: 73377
- **Total Directories Scanned**: 11637
- **Total Workspace Size**: **6.11 GB** (6,563,698,539 bytes)

---

## 1. Storage Categories Breakdown

The table below breaks down the total disk space utilized by different file classes, folder types, and formats across the workspace.

| Category / Filter | Total Size | Description |
| :--- | :--- | :--- |
| **node_modules** | 672.73 MB | External npm dependencies |
| **build/dist output** | 20.86 MB | Compiled bundles and static assets in build/dist folders |
| **Blender files (`.blend`, `.blend1`)** | 13.38 MB | Blender design files and backup states |
| **FBX files** | 671.16 MB | FBX format assets (characters, animations, clothing) |
| **GLB files** | 1.47 GB | GLB runtime asset models |
| **images** | 536.94 MB | User interface, textures, and capture images (`.png`, `.jpg`, etc.) |
| **videos** | 0 B | Animation test records or visual documentation |
| **avatars** (in path) | 14.16 MB | Files situated in avatar/character folders |
| **animations** (in path) | 0 B | Files situated in animation/motions/clips folders |
| **textures** (in path) | 0 B | Materials and textures |
| **meshes** (in path) | 0 B | Mesh geometry subfolders |
| **logs** | 10.79 KB | Execution log files |
| **temporary/test folders** | 177.68 MB | Sandbox, scratch, and temporary run outputs |

---

## 2. Top 50 Largest Files

The table below lists the 50 largest files in the workspace (including dependencies and builds).

| Rank | File Path | Category | Size |
| :--- | :--- | :--- | :--- |
| 1 | [`.git/objects/pack/pack-fb4471a1f2254461e4906ae34ff2574b99fea0f2.pack`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/objects/pack/pack-fb4471a1f2254461e4906ae34ff2574b99fea0f2.pack) | other | 410.85 MB |
| 2 | [`.git/lfs/objects/d7/90/d7900a3337674e155c41a7767a430c3fd0c9f28a2fb72f4efad91d06341eb6c1`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/d7/90/d7900a3337674e155c41a7767a430c3fd0c9f28a2fb72f4efad91d06341eb6c1) | other | 189.63 MB |
| 3 | [`artifacts/api-server/public/avatars/aria/aria-v4-walk.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk.glb) | glb | 189.63 MB |
| 4 | [`artifacts/api-server/public/avatars/animation-tests/temp_test/Aria_V5_Camilla_Idle_Test.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/animation-tests/temp_test/Aria_V5_Camilla_Idle_Test.glb) | tempTest | 177.61 MB |
| 5 | [`.git/lfs/objects/65/c9/65c953b8026fedb3bcf958c32c84e200393f425309f61501f2f3b8ecb001c0a2`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/65/c9/65c953b8026fedb3bcf958c32c84e200393f425309f61501f2f3b8ecb001c0a2) | other | 176.65 MB |
| 6 | [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb) | glb | 176.65 MB |
| 7 | [`.git/lfs/objects/58/3a/583a5273c093c36d2fea6f14fd55fa84b3610a29427550bab5d88e41dca1807b`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/58/3a/583a5273c093c36d2fea6f14fd55fa84b3610a29427550bab5d88e41dca1807b) | other | 175.66 MB |
| 8 | [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb) | glb | 175.66 MB |
| 9 | [`.git/lfs/objects/01/7e/017e2d7d23ea26dccee638d2874b599a430ec120a347cfbf4697de9104999954`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/01/7e/017e2d7d23ea26dccee638d2874b599a430ec120a347cfbf4697de9104999954) | other | 148.09 MB |
| 10 | [`artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb) | glb | 148.09 MB |
| 11 | [`.git/lfs/objects/c5/65/c565173a5f45481bd8da4560706679e184282d55b7eb8ddac34e5ac5c784089f`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/c5/65/c565173a5f45481bd8da4560706679e184282d55b7eb8ddac34e5ac5c784089f) | other | 94.38 MB |
| 12 | [`artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx) | fbx | 94.38 MB |
| 13 | [`.git/lfs/objects/f7/2c/f72c683d66d0b27633f2b6cea4264d655706f6538e3c3693de8a0443d69afa29`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/f7/2c/f72c683d66d0b27633f2b6cea4264d655706f6538e3c3693de8a0443d69afa29) | other | 79.04 MB |
| 14 | [`artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx) | fbx | 79.04 MB |
| 15 | [`.git/lfs/objects/21/aa/21aa57cc5d993f470246ecf242ef028ce2affd218bc3e42ee34d2968415e6d27`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/21/aa/21aa57cc5d993f470246ecf242ef028ce2affd218bc3e42ee34d2968415e6d27) | other | 76.52 MB |
| 16 | [`artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb) | glb | 76.52 MB |
| 17 | [`.git/lfs/objects/67/28/67282d001469cf08a77104010c56e876f5929a621fefcc361478f024f950f480`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/67/28/67282d001469cf08a77104010c56e876f5929a621fefcc361478f024f950f480) | other | 76.52 MB |
| 18 | [`artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb) | glb | 76.52 MB |
| 19 | [`.git/lfs/objects/b8/6e/b86e6f25f98f9e4d331d33766ad9959bda4c749c38f0fd3b786b56387df8ca0c`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/b8/6e/b86e6f25f98f9e4d331d33766ad9959bda4c749c38f0fd3b786b56387df8ca0c) | other | 74.91 MB |
| 20 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v4-relaxed-frame120-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v4-relaxed-frame120-preview.glb) | glb | 74.91 MB |
| 21 | [`.git/lfs/objects/5e/0d/5e0dadb8a8428a1e8ff3271f11632959ce24562960e46d649d365ea7a96e1c70`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/5e/0d/5e0dadb8a8428a1e8ff3271f11632959ce24562960e46d649d365ea7a96e1c70) | other | 74.32 MB |
| 22 | [`.git/lfs/objects/cd/e9/cde97f240ddab188e807b9d0552aaa4f8eb49409a4602689394ca49441a03064`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/cd/e9/cde97f240ddab188e807b9d0552aaa4f8eb49409a4602689394ca49441a03064) | other | 74.32 MB |
| 23 | [`artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb) | glb | 74.32 MB |
| 24 | [`artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb) | glb | 74.32 MB |
| 25 | [`.git/lfs/objects/40/2d/402def1e785b8fb7cbe14ec7de3e0889d2424b3f4568acafb41b00a218fcbd42`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/40/2d/402def1e785b8fb7cbe14ec7de3e0889d2424b3f4568acafb41b00a218fcbd42) | other | 70.04 MB |
| 26 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame260-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame260-preview.glb) | glb | 70.04 MB |
| 27 | [`.git/lfs/objects/90/7d/907dd3590dc996d5914c2d1e13b18f0fe36febc6c3b81528bdd5ed35e93e4421`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/90/7d/907dd3590dc996d5914c2d1e13b18f0fe36febc6c3b81528bdd5ed35e93e4421) | other | 70.03 MB |
| 28 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame420-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame420-preview.glb) | glb | 70.03 MB |
| 29 | [`.git/lfs/objects/57/f0/57f0e851df10356c5fb25707d88d4b819eac6c858743e747a1c12a15b64aa820`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/57/f0/57f0e851df10356c5fb25707d88d4b819eac6c858743e747a1c12a15b64aa820) | other | 69.99 MB |
| 30 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame120-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame120-preview.glb) | glb | 69.99 MB |
| 31 | [`.git/lfs/objects/fd/9c/fd9ca3eb67fd900fbddeec32414511fbd8c284855735f04c5d377841ff53ce7a`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/fd/9c/fd9ca3eb67fd900fbddeec32414511fbd8c284855735f04c5d377841ff53ce7a) | other | 69.74 MB |
| 32 | [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-preview.glb) | glb | 69.74 MB |
| 33 | [`.git/lfs/objects/6c/11/6c11d86301fb6231f897d890994f19162b371a6889049666e1d2a1aa79ad811c`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/6c/11/6c11d86301fb6231f897d890994f19162b371a6889049666e1d2a1aa79ad811c) | other | 69.74 MB |
| 34 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-preview.glb) | glb | 69.74 MB |
| 35 | [`.git/lfs/objects/25/60/25608f7bc9160e68282f443c54ff4a098a402370dd7577c5989dd33c6c908241`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/25/60/25608f7bc9160e68282f443c54ff4a098a402370dd7577c5989dd33c6c908241) | other | 69.74 MB |
| 36 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-v2-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-v2-preview.glb) | glb | 69.74 MB |
| 37 | [`.git/lfs/objects/04/3f/043fa1d3a84dc36480163d9f233c845f24d8fb28e5ff8d28113ac33025e01410`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/04/3f/043fa1d3a84dc36480163d9f233c845f24d8fb28e5ff8d28113ac33025e01410) | other | 62.31 MB |
| 38 | [`artifacts/api-server/public/avatars/aria/protected/new-headshot/Aria_New_Headshot_ccProject.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/new-headshot/Aria_New_Headshot_ccProject.fbx) | fbx | 62.31 MB |
| 39 | [`.git/lfs/objects/b9/c4/b9c425eac689b49c66c375ca7177daefa5df4cb2516e03753d3f916171ac97fe`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/b9/c4/b9c425eac689b49c66c375ca7177daefa5df4cb2516e03753d3f916171ac97fe) | other | 59.69 MB |
| 40 | [`artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx) | fbx | 59.69 MB |
| 41 | [`.git/lfs/objects/9a/65/9a658b8c9a87ef7bcf480e3bd48e25f351bd292a3a68cc85a6ced98626aa6ff8`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/9a/65/9a658b8c9a87ef7bcf480e3bd48e25f351bd292a3a68cc85a6ced98626aa6ff8) | other | 53.13 MB |
| 42 | [`artifacts/api-server/public/avatars/aria/protected/new-hair-donor/Aria_New_Hair_Headshot_ccProject.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/new-hair-donor/Aria_New_Hair_Headshot_ccProject.fbx) | fbx | 53.13 MB |
| 43 | [`.git/lfs/objects/ed/3a/ed3a4bc511b2b1b32ce6fafbcfea50e9265ab1243967eee259f36ab305067f59`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/ed/3a/ed3a4bc511b2b1b32ce6fafbcfea50e9265ab1243967eee259f36ab305067f59) | other | 52.68 MB |
| 44 | [`artifacts/api-server/public/avatars/camilla/motions/source/Cammilla_Posing_f.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions/source/Cammilla_Posing_f.fbx) | fbx | 52.68 MB |
| 45 | [`.git/lfs/objects/c8/ca/c8caca20774dab86eeae8576f0129c09b17f26f18a711f71aeff67c955f8d9f1`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/c8/ca/c8caca20774dab86eeae8576f0129c09b17f26f18a711f71aeff67c955f8d9f1) | other | 52.68 MB |
| 46 | [`artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle_F.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle_F.fbx) | fbx | 52.68 MB |
| 47 | [`.git/lfs/objects/9f/e9/9fe9b332f2d32c9001286c95968a6ada6f07f6c52a3cce8e7c806964e1ba8184`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/9f/e9/9fe9b332f2d32c9001286c95968a6ada6f07f6c52a3cce8e7c806964e1ba8184) | other | 52.68 MB |
| 48 | [`artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Walk_F.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Walk_F.fbx) | fbx | 52.68 MB |
| 49 | [`.git/lfs/objects/e5/cf/e5cf12c84babde6c47d34b8eba642574a3be5cb35c90e59b9bc5cc374fa9f198`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/e5/cf/e5cf12c84babde6c47d34b8eba642574a3be5cb35c90e59b9bc5cc374fa9f198) | other | 52.67 MB |
| 50 | [`artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle02_F.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions/source/Camilla_Idle02_F.fbx) | fbx | 52.67 MB |

---

## 3. Top 20 Largest Directories

The table below details the top 20 largest folders (excluding `node_modules` and root `/`).

| Rank | Directory Path | Total Size |
| :--- | :--- | :--- |
| 1 | [`artifacts`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts) | 2.89 GB |
| 2 | [`artifacts/api-server`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server) | 2.63 GB |
| 3 | [`artifacts/api-server/public`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public) | 2.61 GB |
| 4 | [`.git`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git) | 2.56 GB |
| 5 | [`artifacts/api-server/public/avatars`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars) | 2.38 GB |
| 6 | [`.git/lfs`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs) | 2.16 GB |
| 7 | [`.git/lfs/objects`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects) | 2.16 GB |
| 8 | [`artifacts/api-server/public/avatars/aria`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria) | 1.70 GB |
| 9 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12) | 424.50 MB |
| 10 | [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments) | 424.50 MB |
| 11 | [`artifacts/api-server/public/avatars/aria/rejected`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected) | 424.50 MB |
| 12 | [`.git/objects`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/objects) | 411.28 MB |
| 13 | [`.git/objects/pack`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/objects/pack) | 411.13 MB |
| 14 | [`artifacts/api-server/public/avatars/aria/protected`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected) | 401.44 MB |
| 15 | [`artifacts/api-server/public/avatars/animation-tests`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/animation-tests) | 325.81 MB |
| 16 | [`artifacts/api-server/public/avatars/camilla`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla) | 265.38 MB |
| 17 | [`artifacts/api-server/public/avatars/camilla/motions/source`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions/source) | 265.37 MB |
| 18 | [`artifacts/api-server/public/avatars/camilla/motions`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/camilla/motions) | 265.37 MB |
| 19 | [`.git/lfs/objects/d7`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/d7) | 231.11 MB |
| 20 | [`artifacts/api-server/public/avatars/aria/protected/v5-naturalhair`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/v5-naturalhair) | 190.82 MB |

---

## 4. Significant Duplicate Files

The following files share identical sizes and contents (same MD5 hash), indicating redundancy.

| Size | Count | Wasted Space | Duplicate Files |
| :--- | :--- | :--- | :--- |
| 189.63 MB | 2 | **189.63 MB** | `.git/lfs/objects/d7/90/d7900a3337674e155c41a7767a430c3fd0c9f28a2fb72f4efad91d06341eb6c1`<br>`artifacts/api-server/public/avatars/aria/aria-v4-walk.glb` |
| 176.65 MB | 2 | **176.65 MB** | `.git/lfs/objects/65/c9/65c953b8026fedb3bcf958c32c84e200393f425309f61501f2f3b8ecb001c0a2`<br>`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb` |
| 175.66 MB | 2 | **175.66 MB** | `.git/lfs/objects/58/3a/583a5273c093c36d2fea6f14fd55fa84b3610a29427550bab5d88e41dca1807b`<br>`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb` |
| 148.09 MB | 2 | **148.09 MB** | `.git/lfs/objects/01/7e/017e2d7d23ea26dccee638d2874b599a430ec120a347cfbf4697de9104999954`<br>`artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb` |
| 94.38 MB | 2 | **94.38 MB** | `.git/lfs/objects/c5/65/c565173a5f45481bd8da4560706679e184282d55b7eb8ddac34e5ac5c784089f`<br>`artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx` |
| 79.04 MB | 2 | **79.04 MB** | `.git/lfs/objects/f7/2c/f72c683d66d0b27633f2b6cea4264d655706f6538e3c3693de8a0443d69afa29`<br>`artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx` |
| 76.52 MB | 2 | **76.52 MB** | `.git/lfs/objects/21/aa/21aa57cc5d993f470246ecf242ef028ce2affd218bc3e42ee34d2968415e6d27`<br>`artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb` |
| 76.52 MB | 2 | **76.52 MB** | `.git/lfs/objects/67/28/67282d001469cf08a77104010c56e876f5929a621fefcc361478f024f950f480`<br>`artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb` |
| 74.91 MB | 2 | **74.91 MB** | `.git/lfs/objects/b8/6e/b86e6f25f98f9e4d331d33766ad9959bda4c749c38f0fd3b786b56387df8ca0c`<br>`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v4-relaxed-frame120-preview.glb` |
| 74.32 MB | 2 | **74.32 MB** | `.git/lfs/objects/5e/0d/5e0dadb8a8428a1e8ff3271f11632959ce24562960e46d649d365ea7a96e1c70`<br>`artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb` |
| 74.32 MB | 2 | **74.32 MB** | `.git/lfs/objects/cd/e9/cde97f240ddab188e807b9d0552aaa4f8eb49409a4602689394ca49441a03064`<br>`artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb` |
| 70.04 MB | 2 | **70.04 MB** | `.git/lfs/objects/40/2d/402def1e785b8fb7cbe14ec7de3e0889d2424b3f4568acafb41b00a218fcbd42`<br>`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame260-preview.glb` |
| 70.03 MB | 2 | **70.03 MB** | `.git/lfs/objects/90/7d/907dd3590dc996d5914c2d1e13b18f0fe36febc6c3b81528bdd5ed35e93e4421`<br>`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame420-preview.glb` |
| 69.99 MB | 2 | **69.99 MB** | `.git/lfs/objects/57/f0/57f0e851df10356c5fb25707d88d4b819eac6c858743e747a1c12a15b64aa820`<br>`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame120-preview.glb` |
| 69.74 MB | 2 | **69.74 MB** | `.git/lfs/objects/fd/9c/fd9ca3eb67fd900fbddeec32414511fbd8c284855735f04c5d377841ff53ce7a`<br>`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-preview.glb` |

---

## 5. Candidate Files for Archival

The following files are identified as safe candidates for archival or Git LFS tracking to keep the repository light.

| File Path | Size | Reason |
| :--- | :--- | :--- |
| [`artifacts/api-server/public/avatars/aria/aria-v4-walk.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk.glb) | 189.63 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/animation-tests/temp_test/Aria_V5_Camilla_Idle_Test.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/animation-tests/temp_test/Aria_V5_Camilla_Idle_Test.glb) | 177.61 MB | Temporary or test asset > 1MB |
| [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-rigged.glb) | 176.65 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-skinned.glb) | 175.66 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/animation-tests/camilla-idle01-cc5-test.glb) | 148.09 MB | Temporary or test asset > 1MB |
| [`artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/Aria_V4_walk.fbx) | 94.38 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/v5-naturalhair/Aria_V5_NaturalHair.fbx) | 79.04 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk-yup-preview.glb) | 76.52 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-walk-preview.glb) | 76.52 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v4-relaxed-frame120-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v4-relaxed-frame120-preview.glb) | 74.91 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-static-frame30-preview.glb) | 74.32 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v4-static-preview.glb) | 74.32 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame260-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame260-preview.glb) | 70.04 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame420-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame420-preview.glb) | 70.03 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame120-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-frame120-preview.glb) | 69.99 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/aria-v5-naturalhair-preview.glb) | 69.74 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-preview.glb) | 69.74 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-v2-preview.glb`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/rejected/failed_experiments/pose_math_2026-06-12/aria-v5-naturalhair-relaxed-v2-preview.glb) | 69.74 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/aria/protected/new-headshot/Aria_New_Headshot_ccProject.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/aria/protected/new-headshot/Aria_New_Headshot_ccProject.fbx) | 62.31 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |
| [`artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/artifacts/api-server/public/avatars/guy/motions/source/Guy_Emote_M.fbx) | 59.69 MB | Large asset/texture (> 10MB) candidate for remote/LFS storage |

---

## 6. Unexpected Disk Space Consumers

These items are consuming significant space or represent non-standard workspace assets.

| File Path | Size | Description |
| :--- | :--- | :--- |
| [`.git/lfs/objects/01/7e/017e2d7d23ea26dccee638d2874b599a430ec120a347cfbf4697de9104999954`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/01/7e/017e2d7d23ea26dccee638d2874b599a430ec120a347cfbf4697de9104999954) | 148.09 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/04/3f/043fa1d3a84dc36480163d9f233c845f24d8fb28e5ff8d28113ac33025e01410`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/04/3f/043fa1d3a84dc36480163d9f233c845f24d8fb28e5ff8d28113ac33025e01410) | 62.31 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/21/aa/21aa57cc5d993f470246ecf242ef028ce2affd218bc3e42ee34d2968415e6d27`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/21/aa/21aa57cc5d993f470246ecf242ef028ce2affd218bc3e42ee34d2968415e6d27) | 76.52 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/25/60/25608f7bc9160e68282f443c54ff4a098a402370dd7577c5989dd33c6c908241`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/25/60/25608f7bc9160e68282f443c54ff4a098a402370dd7577c5989dd33c6c908241) | 69.74 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/40/2d/402def1e785b8fb7cbe14ec7de3e0889d2424b3f4568acafb41b00a218fcbd42`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/40/2d/402def1e785b8fb7cbe14ec7de3e0889d2424b3f4568acafb41b00a218fcbd42) | 70.04 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/45/e2/45e2e4017b4e447dc859e8e66b6bc4e1e708d1dcefcee340ad17a708f47c98b7`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/45/e2/45e2e4017b4e447dc859e8e66b6bc4e1e708d1dcefcee340ad17a708f47c98b7) | 11.83 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/57/f0/57f0e851df10356c5fb25707d88d4b819eac6c858743e747a1c12a15b64aa820`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/57/f0/57f0e851df10356c5fb25707d88d4b819eac6c858743e747a1c12a15b64aa820) | 69.99 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/58/3a/583a5273c093c36d2fea6f14fd55fa84b3610a29427550bab5d88e41dca1807b`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/58/3a/583a5273c093c36d2fea6f14fd55fa84b3610a29427550bab5d88e41dca1807b) | 175.66 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/5e/0d/5e0dadb8a8428a1e8ff3271f11632959ce24562960e46d649d365ea7a96e1c70`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/5e/0d/5e0dadb8a8428a1e8ff3271f11632959ce24562960e46d649d365ea7a96e1c70) | 74.32 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/65/c9/65c953b8026fedb3bcf958c32c84e200393f425309f61501f2f3b8ecb001c0a2`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/65/c9/65c953b8026fedb3bcf958c32c84e200393f425309f61501f2f3b8ecb001c0a2) | 176.65 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/67/28/67282d001469cf08a77104010c56e876f5929a621fefcc361478f024f950f480`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/67/28/67282d001469cf08a77104010c56e876f5929a621fefcc361478f024f950f480) | 76.52 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/6c/11/6c11d86301fb6231f897d890994f19162b371a6889049666e1d2a1aa79ad811c`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/6c/11/6c11d86301fb6231f897d890994f19162b371a6889049666e1d2a1aa79ad811c) | 69.74 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/90/7d/907dd3590dc996d5914c2d1e13b18f0fe36febc6c3b81528bdd5ed35e93e4421`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/90/7d/907dd3590dc996d5914c2d1e13b18f0fe36febc6c3b81528bdd5ed35e93e4421) | 70.03 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/9a/65/9a658b8c9a87ef7bcf480e3bd48e25f351bd292a3a68cc85a6ced98626aa6ff8`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/9a/65/9a658b8c9a87ef7bcf480e3bd48e25f351bd292a3a68cc85a6ced98626aa6ff8) | 53.13 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/9f/e9/9fe9b332f2d32c9001286c95968a6ada6f07f6c52a3cce8e7c806964e1ba8184`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/9f/e9/9fe9b332f2d32c9001286c95968a6ada6f07f6c52a3cce8e7c806964e1ba8184) | 52.68 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/b8/6e/b86e6f25f98f9e4d331d33766ad9959bda4c749c38f0fd3b786b56387df8ca0c`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/b8/6e/b86e6f25f98f9e4d331d33766ad9959bda4c749c38f0fd3b786b56387df8ca0c) | 74.91 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/b9/c4/b9c425eac689b49c66c375ca7177daefa5df4cb2516e03753d3f916171ac97fe`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/b9/c4/b9c425eac689b49c66c375ca7177daefa5df4cb2516e03753d3f916171ac97fe) | 59.69 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/c5/65/c565173a5f45481bd8da4560706679e184282d55b7eb8ddac34e5ac5c784089f`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/c5/65/c565173a5f45481bd8da4560706679e184282d55b7eb8ddac34e5ac5c784089f) | 94.38 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/c8/ca/c8caca20774dab86eeae8576f0129c09b17f26f18a711f71aeff67c955f8d9f1`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/c8/ca/c8caca20774dab86eeae8576f0129c09b17f26f18a711f71aeff67c955f8d9f1) | 52.68 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/cd/67/cd67ea0e59c31fc4bb80334f3b7bea4754cb599df4462c834b79eeedfc843904`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/cd/67/cd67ea0e59c31fc4bb80334f3b7bea4754cb599df4462c834b79eeedfc843904) | 16.66 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/cd/e9/cde97f240ddab188e807b9d0552aaa4f8eb49409a4602689394ca49441a03064`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/cd/e9/cde97f240ddab188e807b9d0552aaa4f8eb49409a4602689394ca49441a03064) | 74.32 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/d4/65/d465beeffecd681551002443974b1e1a4547146d7549578e8e3c1102b560238d`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/d4/65/d465beeffecd681551002443974b1e1a4547146d7549578e8e3c1102b560238d) | 52.66 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/d7/90/d7900a3337674e155c41a7767a430c3fd0c9f28a2fb72f4efad91d06341eb6c1`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/d7/90/d7900a3337674e155c41a7767a430c3fd0c9f28a2fb72f4efad91d06341eb6c1) | 189.63 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/d7/f0/d7f001a9a3c74e1269cc0f94f164dd6c217c22c243b8b4628975d2d10be2ade5`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/d7/f0/d7f001a9a3c74e1269cc0f94f164dd6c217c22c243b8b4628975d2d10be2ade5) | 41.49 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/e5/cf/e5cf12c84babde6c47d34b8eba642574a3be5cb35c90e59b9bc5cc374fa9f198`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/e5/cf/e5cf12c84babde6c47d34b8eba642574a3be5cb35c90e59b9bc5cc374fa9f198) | 52.67 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/ed/3a/ed3a4bc511b2b1b32ce6fafbcfea50e9265ab1243967eee259f36ab305067f59`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/ed/3a/ed3a4bc511b2b1b32ce6fafbcfea50e9265ab1243967eee259f36ab305067f59) | 52.68 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/f7/2c/f72c683d66d0b27633f2b6cea4264d655706f6538e3c3693de8a0443d69afa29`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/f7/2c/f72c683d66d0b27633f2b6cea4264d655706f6538e3c3693de8a0443d69afa29) | 79.04 MB | Large file with uncommon extension: "" |
| [`.git/lfs/objects/fd/9c/fd9ca3eb67fd900fbddeec32414511fbd8c284855735f04c5d377841ff53ce7a`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/lfs/objects/fd/9c/fd9ca3eb67fd900fbddeec32414511fbd8c284855735f04c5d377841ff53ce7a) | 69.74 MB | Large file with uncommon extension: "" |
| [`.git/objects/pack/pack-fb4471a1f2254461e4906ae34ff2574b99fea0f2.pack`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/.git/objects/pack/pack-fb4471a1f2254461e4906ae34ff2574b99fea0f2.pack) | 410.85 MB | Large file with uncommon extension: ".pack" |
| [`node_modules/.pnpm/@esbuild+win32-x64@0.27.3/node_modules/@esbuild/win32-x64/esbuild.exe`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/@esbuild+win32-x64@0.27.3/node_modules/@esbuild/win32-x64/esbuild.exe) | 10.85 MB | Large file with uncommon extension: ".exe" |
| [`node_modules/.pnpm/@expo+ngrok-bin-win32-x64@2.3.41/node_modules/@expo/ngrok-bin-win32-x64/ngrok.exe`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/@expo+ngrok-bin-win32-x64@2.3.41/node_modules/@expo/ngrok-bin-win32-x64/ngrok.exe) | 29.39 MB | Large file with uncommon extension: ".exe" |
| [`node_modules/.pnpm/lightningcss-win32-x64-msvc@1.31.1/node_modules/lightningcss-win32-x64-msvc/lightningcss.win32-x64-msvc.node`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/lightningcss-win32-x64-msvc@1.31.1/node_modules/lightningcss-win32-x64-msvc/lightningcss.win32-x64-msvc.node) | 9.01 MB | Large file with uncommon extension: ".node" |
| [`node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/osx-bin/hermes`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/osx-bin/hermes) | 10.01 MB | Large file with uncommon extension: "" |
| [`node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/osx-bin/hermesc`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/osx-bin/hermesc) | 6.01 MB | Large file with uncommon extension: "" |
| [`node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/win64-bin/icudt64.dll`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/node_modules/.pnpm/react-native@0.81.5_@babel+_5b5f786695eb3a8a4ec36c9b8d1b667a/node_modules/react-native/sdks/hermesc/win64-bin/icudt64.dll) | 26.26 MB | Large file with uncommon extension: ".dll" |
| [`phone-screen-after-forge-fix.png`](file:///C:/Users/U/Documents/antigravity/dazzling-noether/phone-screen-after-forge-fix.png) | 2.60 MB | Uncompressed phone screenshot/capture in root |
