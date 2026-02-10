# Introduction to Containers

## What Are Containers?

Containers are lightweight, portable packages that include your application and all its dependencies. Think of them as a complete computing environment that you can run anywhere.

[Content to be added: Visual analogy, comparison to VMs]

## Why Containers Matter for Research

### 1. Reproducibility

[Content to be added: Your exact environment can be recreated]

### 2. Portability

[Content to be added: Same container runs on lab servers and HPC]

### 3. Dependency Management

[Content to be added: No more "it works on my machine"]

### 4. Isolation

[Content to be added: Different projects with conflicting dependencies]

## Container Concepts

### Images

[Content to be added: Templates for containers]

### Containers

[Content to be added: Running instances of images]

### Registries

[Content to be added: Where images are stored (like GitHub for containers)]

## Docker vs Podman

You'll hear both terms in this documentation. Here's what you need to know:

### Docker

- The original container platform
- Requires root/sudo access
- Most popular, lots of documentation online
- Many images on Docker Hub

### Podman

- Docker-compatible alternative
- Can run **rootless** (no sudo needed)
- Command syntax nearly identical to Docker
- What we use on Threadripper

### Key Point

If you find a Docker tutorial online, you can usually replace `docker` with `podman` and it will work!

```bash
# Docker command
docker run -it ubuntu bash

# Equivalent Podman command
podman run -it ubuntu bash
```

## How We Use Containers in the Lab

### GPU Servers

On GPU servers, you have sudo access and can install software directly. Containers are optional but recommended for:
- Testing before deploying to HPC
- Reproducible research
- Complex dependency management

### Threadripper

On Threadripper, containers are **required** because you don't have sudo. But this is actually a good thing - it teaches good practices for HPC.

### Taiwan HPC

[Content to be added: Most HPC systems support containers (Singularity/Apptainer)]

## Our Harbor Registry

Instead of Docker Hub, we run our own private registry using Harbor:

**URL**: [To be added]

Benefits:
- Faster (local network)
- Private images for lab projects
- Curated base images for common tasks

---

**Next Step**: Learn about [Using Podman on Threadripper](podman.md)
