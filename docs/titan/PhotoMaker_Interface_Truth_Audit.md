# PhotoMaker Interface Truth Audit

## Source Code Trace: ComfyUI-PhotoMaker-Plus/photomaker/model.py

### 1. The ID Encoder Interface
- **Input**: The node explicitly loads uffalo_l (InsightFace).
- **Exact Output Dimension**: The encoder extracts a latent feature embedding of exactly [B, 1, 512].
- **Identity Tokens**: The node uses a variable 
um_id_images (typically 1-4) and averages or concatenates the features.

### 2. The PhotoMaker Adapter (MLP)
- **Architecture**: A dense Multi-Layer Perceptron (
n.Linear layers with SiLU/GELU activations).
- **Function**: Takes the [B, 512] input and projects it into the SDXL text-encoder latent space [B, N, 768] and [B, N, 1280].
- **Trainable Components**: In the original PhotoMaker training, *only* this MLP adapter and the LoRA cross-attention weights were trainable. The base SDXL UNet was frozen. The uffalo_l ID encoder was frozen.

### 3. SDXL Cross-Attention Injection
- **Insertion Point**: The generated [B, N, 2048] (concat of 768 and 1280) replaces the text embeddings associated with the trigger word (e.g., <photomaker> man).

## Retraining Requirement Matrix
If we replace uffalo_l with another 512-dim encoder (even if legally safe), does it work?

- **NO_RETRAINING**: False. The [B, 512] space of the new encoder will mathematically mismatch the uffalo_l manifold. The MLP will output noise.
- **LINEAR_PROJECTION**: False. The manifold shift is non-linear.
- **MLP_ADAPTER_TRAINING**: **TRUE**. We must freeze the new ID encoder and the SDXL UNet, and retrain *only* the PhotoMakerAdapter MLP layer to map the new 512-dim space into the exact [B, N, 2048] projection expected by the pre-trained cross-attention layers.

## Conclusion
PhotoMaker V2 strictly requires **MLP_ADAPTER_TRAINING** if the uffalo_l encoder is replaced, regardless of whether the new encoder shares the exact [1, 512] tensor shape.
