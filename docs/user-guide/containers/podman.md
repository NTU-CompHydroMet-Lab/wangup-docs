# Using Podman on Threadripper

## Introduction

This guide covers using rootless Podman on the Threadripper server for CPU-intensive tasks.

## Basic Podman Commands

Podman commands are nearly identical to Docker. If you know Docker, you already know Podman!

### Pulling Images

```bash
# From our Harbor registry
podman pull harbor.example.com/library/ubuntu:latest

# From Docker Hub (if needed)
podman pull docker.io/ubuntu:latest
```

### Running Containers

```bash
# Interactive container
podman run -it ubuntu:latest bash

# Run in background (detached)
podman run -d ubuntu:latest sleep infinity

# Run with a name
podman run -it --name my-container ubuntu:latest bash
```

### Listing Containers

```bash
# Show running containers
podman ps

# Show all containers (including stopped)
podman ps -a
```

### Managing Containers

```bash
# Stop a container
podman stop container-name

# Start a stopped container
podman start container-name

# Remove a container
podman rm container-name

# Execute command in running container
podman exec -it container-name bash
```

### Managing Images

```bash
# List images
podman images

# Remove an image
podman rmi image-name

# Clean up unused images
podman image prune
```

## Mounting Volumes

To access your data and NAS directories in containers:

```bash
# Mount your NAS home
podman run -it \
  -v /nas/homes/your-username:/nas:Z \
  ubuntu:latest bash

# Mount specific data directory
podman run -it \
  -v /data/ERA5:/data/ERA5:Z \
  -v /nas/homes/your-username:/workspace:Z \
  ubuntu:latest bash
```

!!! note
    The `:Z` flag is important for SELinux contexts. Include it when mounting volumes.

## Using Sudo Inside Containers

Inside your container, you have full sudo access:

```bash
# Enter container
podman run -it ubuntu:latest bash

# Inside container - install packages
sudo apt update
sudo apt install python3 python3-pip vim
pip3 install numpy pandas
```

## Running Long Jobs

For jobs that take hours or days, use detached mode:

```bash
# Start container in background
podman run -d \
  --name data-processing \
  -v /data:/data:Z \
  -v /nas/homes/your-username:/workspace:Z \
  harbor.example.com/base/python:latest \
  python /workspace/process_data.py

# Check logs
podman logs data-processing

# Follow logs in real-time
podman logs -f data-processing

# Check if still running
podman ps

# Stop if needed
podman stop data-processing
```

## Practical Example: Data Processing

[Content to be added: Complete example of a data processing workflow]

```bash
# Pull our Python data science image
podman pull harbor.example.com/base/python-datascience:latest

# Run processing script
podman run -it --rm \
  -v /data/ERA5:/input:Z \
  -v /nas/homes/your-username/results:/output:Z \
  harbor.example.com/base/python-datascience:latest \
  python /output/process_era5.py
```

## Saving Your Work

### Option 1: Commit Changes

If you've modified a container and want to save it:

```bash
# Make changes in a container
podman run -it --name my-work ubuntu:latest bash
# (install things, make changes)
exit

# Commit to new image
podman commit my-work my-custom-image:latest

# Push to Harbor
podman tag my-custom-image:latest harbor.example.com/your-project/my-custom-image:latest
podman push harbor.example.com/your-project/my-custom-image:latest
```

### Option 2: Use Dockerfiles (Recommended)

See [Building Your Containers](building.md) for a better approach using Dockerfiles.

## Tips and Tricks

### 1. Use Screen or Tmux

For long-running jobs, use screen or tmux so your session persists:

```bash
# Start a screen session
screen -S mywork

# Run your container
podman run ...

# Detach with Ctrl+A then D

# Reattach later
screen -r mywork
```

### 2. Check Resource Usage

[Content to be added: Monitoring CPU/memory usage]

### 3. Clean Up Regularly

[Content to be added: Removing old containers and images]

## Troubleshooting

### Permission Denied

[Content to be added: Common permission issues]

### Out of Space

[Content to be added: Check quota, clean up]

### Container Won't Start

[Content to be added: Common issues]

---

**Next Step**: Learn about our [Harbor Registry](harbor.md)
