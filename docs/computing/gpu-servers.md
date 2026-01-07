# Simple GPU Servers

## Overview

The lab has three GPU servers that students can SSH into directly and install software as needed. These servers are ideal for interactive work, initial experiments, and moderate computation.

## Available GPU Servers

### Server 1: i7 + RTX 3080 Ti

**Hostname**: [To be added]

**Specifications**:
- CPU: Intel i7
- GPU: NVIDIA RTX 3080 Ti
- RAM: [To be added]

**Best For**:
- Quick experiments and testing
- Initial model development
- Interactive debugging

### Server 2: i9 + RTX 4090

**Hostname**: [To be added]

**Specifications**:
- CPU: Intel i9
- GPU: NVIDIA RTX 4090 (most powerful GPU)
- RAM: [To be added]

**Best For**:
- Heavy deep learning tasks
- Large model training
- GPU-intensive computations

### Server 3: 5950 + RTX 3090

**Hostname**: [To be added]

**Specifications**:
- CPU: AMD Ryzen 9 5950X
- GPU: NVIDIA RTX 3090
- RAM: [To be added]

**Best For**:
- General GPU computing
- Medium-scale experiments

## Connecting to GPU Servers

Using your SSH config:

```bash
ssh gpu1  # or gpu2, gpu3
```

[Content to be added: First login, verifying you're on the right server]

## Key Features

### SSSD Authentication

All GPU servers use SSSD to communicate with the central LDAP server for authentication. This means:
- Your username and password work on all servers
- Your user account is consistent across all servers

### NFS-Mounted NAS

Your NAS home directory is automatically mounted and available:

```bash
cd /nas/homes/your-username
```

### Sudo Access

Unlike the Threadripper server, you have sudo access on these machines through a **dedicated sudo account**.

[Content to be added: How to switch to sudo account and use it]

## Installing Software

### Using Package Managers

```bash
# Switch to sudo account
[Content to be added: command to switch]

# Install system packages
sudo apt update
sudo apt install package-name
```

### Python Environments

It's recommended to use virtual environments or conda:

```bash
# Using venv
python3 -m venv myenv
source myenv/bin/activate
pip install numpy pandas torch

# Using conda (if installed)
conda create -n myenv python=3.10
conda activate myenv
conda install pytorch torchvision -c pytorch
```

### CUDA and GPU Libraries

[Content to be added: CUDA version installed, nvidia-smi usage]

## Checking GPU Usage

### See Available GPUs

```bash
nvidia-smi
```

### Monitor GPU Usage in Real-Time

```bash
watch -n 1 nvidia-smi
```

### Check Who's Using GPUs

```bash
nvidia-smi
# Look at the "Processes" section at the bottom
```

## Best Practices

### 1. Check Before Using

Before starting a GPU-intensive task, check if someone else is using the GPU:

```bash
nvidia-smi
```

### 2. Be Considerate

[Content to be added: Resource sharing etiquette]

### 3. Monitor Your Jobs

[Content to be added: Using tmux/screen for long-running jobs]

### 4. Clean Up

[Content to be added: Stopping processes, freeing GPU memory]

## Common Tasks

### Running Python Scripts

```bash
python your_script.py
```

### Using Jupyter Notebooks

[Content to be added: Setting up Jupyter on remote server, port forwarding]

### Using TensorBoard

[Content to be added: Port forwarding for TensorBoard]

## When to Use HPC Instead

These GPU servers are great for interactive work and moderate tasks, but consider using Taiwan HPC when:

- Your job will run for days
- You need multiple GPUs
- You need guaranteed resources
- You're running production experiments

See [Preparing for Taiwan HPC](../hpc/preparing.md) for more information.

---

**Next Step**: Learn about the [CPU-Intensive Threadripper Server](threadripper.md)
