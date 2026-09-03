# Pippo: Weight and Training Feasibility

## Phase 8 — Training Feasibility
Since Pippo is a `CODE_ONLY` release with no pretrained weights, Titan would have to train the model from scratch to use the architecture.

### Dataset Requirements
- **Number of identities**: 10,000+ (Based on standard human-generation dataset requirements like Ava-256).
- **Number of views per identity**: Dense multi-view (e.g., 360-degree video or 100+ views per person).
- **Camera labels**: Exact intrinsic and extrinsic camera parameters for every frame.
- **Resolution**: 1024x1024.
- **Identity annotations**: Required for ID loss.

### Compute Requirement
- **GPU type**: NVIDIA A100 (80GB) or H100.
- **GPU count**: 8 to 64 GPUs for full training.
- **Estimated training time**: Weeks to Months.
- **Estimated cost**: $50,000 to $200,000+ in cloud compute.

### Feasibility Conclusion
- **Small proof-of-concept**: Feasible on a single A100 using the `128_4v_tiny.yml` config and the Ava-256 subset.
- **Production training**: HIGHLY UNFEASIBLE for a solo developer or small studio due to the massive multi-view dataset collection requirements and extreme compute costs for a 1K Diffusion Transformer.
- **Synthetic data**: Could potentially be used to supplement, but rendering 10,000 high-quality photorealistic synthetic humans with exact camera parameters is a massive project itself.
