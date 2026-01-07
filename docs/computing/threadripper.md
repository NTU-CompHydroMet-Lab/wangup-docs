# CPU-Intensive Server (Threadripper)

## Overview

The Threadripper server is a high-core-count machine designed for CPU-intensive data processing tasks. It has a fundamentally different workflow from the GPU servers.

**Hostname**: [To be added]

## Specifications

- **CPU**: AMD Threadripper 7965 (24 cores, 48 threads)
- **GPU**: Basic GPU for display only (not for computation)
- **RAM**: [To be added]

## Key Differences from GPU Servers

### No Sudo Access

Unlike the GPU servers, you **do not have sudo access** on the Threadripper. This is intentional.

### Rootless Podman Workflow

Instead of installing software directly, you use **rootless Podman** to run containers. This provides:

- Isolation between users
- Reproducibility
- No need for sudo on the host
- Easy migration to HPC

Inside your containers, you **do have sudo access**, so you can install whatever you need.

## Why This Approach?

[Content to be added: Benefits of containerized workflow]

1. **Reproducibility**: Your environment is defined in a container
2. **Portability**: Same container runs on HPC
3. **Isolation**: Your work doesn't interfere with others
4. **Flexibility**: Full control inside your container

## Getting Started with Podman

[Content to be added: This section will be covered in detail in the Containers section]

For detailed Podman usage, see [Using Podman on Threadripper](../containers/podman.md).

## When to Use Threadripper

### Good Use Cases

- Data preprocessing and cleaning
- Parallel processing of many files
- CPU-bound scientific computations
- Building and compiling code
- Tasks that need many CPU cores

### Not Ideal For

- GPU-accelerated deep learning (use GPU servers)
- Interactive development (use GPU servers)
- Tasks requiring frequent system package installation (use GPU servers or containers)

## Quick Start Example

[Content to be added: Simple example of pulling an image from Harbor and running it]

```bash
# Pull a base image from our Harbor registry
podman pull harbor.example.com/base/ubuntu:latest

# Run an interactive container
podman run -it --rm harbor.example.com/base/ubuntu:latest bash

# Inside the container, you have sudo
sudo apt update && sudo apt install python3
```

## Best Practices

### 1. Use Containers from Harbor

[Content to be added: Why use internal registry]

### 2. Mount Your Data

[Content to be added: Using -v flag to mount directories]

### 3. Long-Running Jobs

[Content to be added: Using podman in detached mode]

## Common Workflows

[Content to be added: Examples of typical data processing workflows]

---

**Next Step**: Learn about [Containers](../containers/intro.md) to understand how to effectively use Threadripper
