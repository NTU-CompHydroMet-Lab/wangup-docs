# Specification of Nodes

## Overview

The lab has 3 GPU servers and 1 CPU server that students can SSH into directly
and install software as needed. These servers are ideal for interactive work,
initial experiments, and moderate computation.

If you need to train large scale models, please check [HPC Tutorial](../../hpc/overview.md).

---

## Server Specifications

| Server | CPU | GPU | RAM | External IP | Internal IP |
|--------|-----|-----|-----|-------------|-------------|
| **Server 1**<br>i7 + RTX 3080 Ti | Intel i7-11700 | NVIDIA RTX 3080 Ti | 126GB | 140.112.13.236 | - |
| **Server 2**<br>i7 + RTX 4090 | Intel i7-12700 | NVIDIA RTX 4090 | 126GB | 140.112.13.91 | 192.168.250.91 |
| **Server 3**<br>5950 + RTX 3090 | AMD Ryzen 9 5950X | NVIDIA RTX 3090 | 78.5GB | 140.112.13.64 | 192.168.250.64 |
| **Server 4**<br>Threadripper | AMD Threadripper 7965WX | - | 256GB<br>(8-channel) | - | 192.168.250.100 |

---

## Quick Reference

### GPU Capabilities

| Model | VRAM | CUDA Cores | Best Use Case |
|-------|------|------------|---------------|
| RTX 4090 | 24GB | 16,384 | Largest models, fastest training |
| RTX 3090 | 24GB | 10,496 | Large models, good performance |
| RTX 3080 Ti | 12GB | 10,240 | Medium models, testing |

### Choosing a Server

- **Need most GPU power?** → Server 2 (RTX 4090)
- **Need most RAM?** → Server 4 (256GB Threadripper)
- **Quick testing?** → Server 1 (RTX 3080 Ti)
- **Balanced workload?** → Server 3 (Ryzen + RTX 3090)
