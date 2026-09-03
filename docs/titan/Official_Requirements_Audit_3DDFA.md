# Official 3DDFA_V2 Requirements Audit

## Repository Identification
- **Repository**: https://github.com/cleardusk/3DDFA_V2
- **Architecture**: MobileNet_V1 backbone driving 3D Dense Face Alignment.

## Technical Requirements
- **Python Version**: Python 3.6 - 3.8 (recommended 3.8 for library compatibility).
- **PyTorch Version**: 1.1 or higher. Ideally 1.5 - 1.8 for stable Windows compatibility with older CUDA.
- **CUDA Compatibility**: Requires CUDA (e.g. 11.1) explicitly mapped in the PyTorch installation.
- **Cython Extensions**: Sim3DR_Cython must be built locally.
- **Compiler Tools**: Requires a C++ compiler (gcc on Linux, MSVC / Visual Studio Build Tools on Windows) to compile Sim3DR_Cython via sh build.sh (or python setup.py build_ext -i).
- **Required Model Weights**: mb1_120x120.pth, fm_noneck_v3.pkl.
- **Required Preprocessing**: Face detection (e.g. FaceBoxes).
- **Official Test Command**: python demo.py -f <image_path>

## Hardware Support
- **Windows Support**: Supported, but notoriously brittle during the Sim3DR compilation if Visual Studio environments are not perfectly aligned.
- **CPU Support**: Yes (--cpu flag, or automatically falls back if 	orch.cuda.is_available() == False).
- **GPU Support**: Yes, highly accelerated rendering.

## License Terms
- **Code License**: MIT License.
- **Model / Weight License**: The fm_noneck_v3.pkl is derived from the Basel Face Model (BFM). BFM explicitly prohibits commercial use.
- **Commercial Status**: RESEARCH_ONLY_CONFIRMED.
