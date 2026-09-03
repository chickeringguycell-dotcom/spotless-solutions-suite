# Experiment 004 Ablation Report

## Execution Summary
We executed 4 controlled runs using a strictly frozen seed (`12345`) to isolate the failure mechanism of dual-conditioning.

### Frozen Parameters
- **Source**: `girl_1_front.jpg`
- **Control**: Station 7C OpenPose `control_landmarks_LEFT_PROFILE.png`
- **Seed**: `12345`
- **Checkpoint**: `v1-5-pruned-emaonly.safetensors`
- **Prompt**: "A photorealistic portrait of a 20s female"

## Results

### Run A: Text Only
- **Input**: Prompt only
- **Output**: Detectable human face, but generic identity and frontal/random pose.
- **SentinelQC**: MEASURED (Identity match failed, Geometry match failed).

### Run B: Text + ControlNet Only
- **Input**: Prompt + Station 7C Control Image
- **Output**: Detectable blob/noise. No human face detected.
- **SentinelQC**: `UNMEASURABLE_OUTPUT` (`FACE_NOT_DETECTED`).
- **Analysis**: The `control_v11p_sd15_openpose.pth` model could not interpret the white-dot scatterplot. It corrupted the UNet's positive conditioning.

### Run C: Text + IP-Adapter Only
- **Input**: Prompt + `girl_1_front.jpg` Identity
- **Output**: Detectable human face, high resemblance to source, frontal pose.
- **SentinelQC**: MEASURED (Identity match passed, Geometry match failed).
- **Analysis**: IP-Adapter functioned perfectly on its own.

### Run D: Text + ControlNet + IP-Adapter
- **Input**: Prompt + Control Image + Identity
- **Output**: Complete corruption.
- **SentinelQC**: `UNMEASURABLE_OUTPUT` (`FACE_NOT_DETECTED`).
- **Analysis**: The garbage ControlNet conditioning combined with IP-Adapter weighting resulted in total generation failure.

## Weight & Range Diagnostics
*Skipped*. Because Run B (ControlNet Only) failed to produce a face, the failure in Run D is NOT due to dual-conditioning weight conflicts. It is an independent failure of the ControlNet path due to bad inputs.

## Conclusion
The ablation study proves that **ControlNet independently failed** because the Station 7C control image format was incompatible. The "latent space collision" hypothesis is rejected as the primary cause.
