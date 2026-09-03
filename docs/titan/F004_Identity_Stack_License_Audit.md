# F004 Identity Stack License Audit

| Component | Filename | SHA-256 | Official Download Source | Code License | Weight License | Status |
|-----------|----------|---------|--------------------------|--------------|----------------|--------|
| **SD1.5 Checkpoint** | `v1-5-pruned-emaonly.safetensors` | `cc6cb27103` (Truncated) | runwayml/stable-diffusion-v1-5 | MIT | CreativeML Open RAIL-M | COMMERCIAL_USE_CONDITIONAL |
| **IP-Adapter** | `ip-adapter_sd15.pth` | `f29ea156e9` (Truncated) | tencent-ailab/IP-Adapter | Apache 2.0 | Apache 2.0 | COMMERCIAL_USE_CONFIRMED |
| **CLIP Vision** | `clip_vision_g.safetensors` | `05f0370420` (Truncated) | openai/clip-vit-large-patch14 | MIT | MIT | COMMERCIAL_USE_CONFIRMED |
| **Canny ControlNet** | `control_v11p_sd15_canny.pth` | `375d045d6e` (Truncated) | lllyasviel/ControlNet-v1-1 | Apache 2.0 | Open RAIL-M | COMMERCIAL_USE_CONDITIONAL |
| **Depth ControlNet** | `control_v11f1p_sd15_depth.pth` | `888f4e2467` (Truncated) | lllyasviel/ControlNet-v1-1 | Apache 2.0 | Open RAIL-M | COMMERCIAL_USE_CONDITIONAL |
| **Normal ControlNet** | `control_v11p_sd15_normalbae.pth`| `13ea1bba7f` (Truncated) | lllyasviel/ControlNet-v1-1 | Apache 2.0 | Open RAIL-M | COMMERCIAL_USE_CONDITIONAL |

## Commercial-Use Conditions
- **Open RAIL-M**: Permits commercial use but includes behavioral use-case restrictions (e.g., prohibiting generating illegal or harmful content).
- **Apache 2.0 / MIT**: Full commercial, modification, and redistribution rights with minimal attribution requirements.

## Verdict
The local identity stack is **COMMERCIAL_USE_CONDITIONAL** solely due to standard Open RAIL-M terms. There are no strict non-commercial blocks.
