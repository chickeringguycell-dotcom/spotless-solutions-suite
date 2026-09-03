# IPAdapter Smoke Test Report

## Objective
Execute an isolated API test using only Text + IP-Adapter (no ControlNet) to prove that the identity conditioning path functions correctly.

## Execution
- **Source Image**: `girl_1_front.jpg`
- **Workflow**: `KSampler` + `IPAdapterAdvanced` + `IPAdapterModelLoader` + `LoadImage` + `CLIPVisionLoader`
- **Status**: SUCCESS

## Provenance
- **Prompt ID**: 8d251414-c432-4ec0-831b-3246e4283c4f
- **IP-Adapter Weight**: 1.0
- **Combine Embeds**: concat

The smoke test passed without errors. I will proceed to Dual-Conditioning.
