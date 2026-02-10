# Preparing for Taiwan HPC

## Introduction

Taiwan's national HPC systems provide massive computational resources for research. This guide helps you transition from lab servers to HPC.

## Why Use HPC?

[Content to be added: When lab resources aren't enough]

- Very long-running jobs (days to weeks)
- Need for many GPUs simultaneously
- Large-scale parallel computing
- Production research runs

## How Containers Help

If you've been using containers on Threadripper, transitioning to HPC is much easier:

1. **Same Environment**: Your container runs the same way on HPC
2. **Tested Workflow**: You've already debugged on lab servers
3. **Portable**: No need to reinstall everything on HPC

## Container Formats on HPC

Most HPC systems use **Singularity** (now called **Apptainer**) instead of Docker/Podman:

- Designed for HPC environments
- No root required
- Compatible with Docker images

## Converting Your Images

[Content to be added: How to convert Podman/Docker images to Singularity]

```bash
# On HPC, pull from Docker Hub or Harbor
singularity pull docker://harbor.example.com/your-project/my-image:latest

# This creates a .sif file you can use
```

## Accessing Taiwan HPC

[Content to be added: How to get an account]

### Account Setup

[Content to be added: Application process]

### Connecting

[Content to be added: SSH to HPC, VPN requirements if any]

## Transferring Data

[Content to be added: Moving data between lab and HPC]

### Using Our NAS

[Content to be added: If there's any shared storage or transfer node]

### Best Practices

[Content to be added: Don't transfer raw datasets if HPC already has them]

---

**Next Step**: Learn about [Using SLURM](slurm.md)
