# Viper Studios - TripoSR Manual Setup Guide
**Date:** 2026-06-25

This guide provides the exact instructions required to set up TripoSR manually for Viper Studios, ensuring that you maintain complete control over your local environment, GPU utilization, and storage. **Helios will never automatically download gigabytes of models or install Python dependencies without explicit consent.**

---

## 1. Prerequisites

### Hardware Requirements
- **OS:** Windows 10/11
- **GPU:** NVIDIA GPU with at least 6-8GB VRAM (TripoSR runs smoothly on consumer cards like the RTX 3060).
- **Disk Space:** ~2.5GB total (1GB for Python environment, 1.5GB for TripoSR model weights).

### Software Requirements
- **Python Version:** 3.10 or 3.11 (Do not use Python 3.12+ as some PyTorch/CUDA extensions may lack pre-built wheels).
- **CUDA Toolkit:** 11.8 or 12.1+ installed on your system.

---

## 2. Recommended Directory Structure

To keep the Viper Studios repository clean, we recommend configuring the TripoSR dependencies outside of the tracked Git directories, or within explicitly ignored folders.

* **Python Virtual Environment:** `C:\venv\triposr`
* **TripoSR Model Weights:** `C:\models\triposr`
* **Generated Outputs Staging:** `C:\temp\triposr_output`

*(Note: If you clone the TripoSR repository or create virtual environments inside the Viper Studios project folder, ensure they are named `TripoSR/`, `venv/`, or `triposr_output/` as these are already configured in `.gitignore`.)*

---

## 3. Installation Steps

Open a **Powershell** terminal and execute the following commands one by one.

### Step 1: Create the Python Environment
```powershell
# Create a dedicated virtual environment for TripoSR
python -m venv C:\venv\triposr

# Activate the environment
C:\venv\triposr\Scripts\activate
```

### Step 2: Install PyTorch with CUDA Support
```powershell
# Install PyTorch targeting CUDA 12.1
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
```

### Step 3: Install TripoSR Dependencies
```powershell
# Install the required generation and mesh processing libraries
pip install transformers trimesh rembg einops Pillow
```

### Step 4: Clone TripoSR (Optional for Scripts)
If you wish to use TripoSR's official scripts rather than relying entirely on Helios wrappers:
```powershell
cd C:\models
git clone https://github.com/VAST-AI-Research/TripoSR.git
cd TripoSR
pip install -e .
```

### Step 5: Download Model Weights
TripoSR downloads its model weights automatically on the first run using `transformers`. However, to download them manually or pre-cache them:
```powershell
# In the activated environment, run python:
python -c "from transformers import from_pretrained; from_pretrained('stabilityai/TripoSR', cache_dir='C:\\models\\triposr')"
```

### Step 6: Create the Output Directory
```powershell
mkdir C:\temp\triposr_output
```

---

## 4. Configuring Helios

Viper Studios will look for environment variables to locate your manual installation. If these variables are missing, it defaults to the paths listed in Section 2.

To customize your configuration, you can set the following environment variables (e.g., in your system environment variables or an `.env` file):

- `TRIPOSR_PYTHON_ENV`: Path to the python executable (e.g., `C:\venv\triposr\Scripts\python.exe`).
- `TRIPOSR_MODEL_PATH`: Path to the directory containing model weights (e.g., `C:\models\triposr`).
- `TRIPOSR_OUTPUT_DIR`: Path where intermediate meshes are generated before review (e.g., `C:\temp\triposr_output`).

---

## 5. Verifying the Setup (Re-running the Probe)

Once you have completed the manual installation, return to the **Mission Control** tab in Viper Studios.

1. Locate the **TRIPOSR READINESS** panel.
2. The probe refreshes automatically every few seconds.
3. The status should change from **MISSING DEPENDENCIES** (Red) to **READY** (Blue).
4. All checks (Python, CUDA, Model Weights) should report as available.

---

## 6. What NOT to Commit

If you choose to set up everything inside the repository folder, **DO NOT** commit the following:
- `.venv/`, `venv/`, or `env/` folders containing Python binaries.
- The `TripoSR/` clone directory.
- `triposr_output/` or any `.obj`/`.glb` files generated directly by the python script.

*Helios is configured to route final, approved outputs to safe locations in the `public/assets/` directory via the Universal Review Queue.*
