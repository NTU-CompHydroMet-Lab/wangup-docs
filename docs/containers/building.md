# Building Your Containers

## Why Build Custom Containers?

While our base images are a good starting point, you'll often need to create custom containers with:
- Specific software versions
- Your own code
- Custom dependencies
- Reproducible research environments

## Dockerfile Basics

A Dockerfile is a text file with instructions for building a container image.

### Simple Example

```dockerfile
# Start from a base image
FROM harbor.example.com/base/python:latest

# Set working directory
WORKDIR /workspace

# Install Python packages
RUN pip install numpy pandas matplotlib

# Copy your code
COPY my_script.py /workspace/

# Set default command
CMD ["python", "my_script.py"]
```

## Dockerfile Instructions

### FROM

```dockerfile
FROM harbor.example.com/base/ubuntu:latest
```

Specifies the base image to start from.

### RUN

```dockerfile
RUN apt update && apt install -y python3
RUN pip install numpy pandas
```

Executes commands during image build.

### COPY

```dockerfile
COPY local_file.txt /container/path/
COPY requirements.txt /workspace/
```

Copies files from your computer into the image.

### WORKDIR

```dockerfile
WORKDIR /workspace
```

Sets the working directory for subsequent commands.

### ENV

```dockerfile
ENV DATA_PATH=/data
ENV PYTHONUNBUFFERED=1
```

Sets environment variables.

### CMD

```dockerfile
CMD ["python", "script.py"]
```

Default command when container starts.

## Building an Image

```bash
# Build from Dockerfile in current directory
podman build -t my-image:latest .

# Build with specific Dockerfile
podman build -f Dockerfile.custom -t my-image:latest .

# Tag for Harbor
podman tag my-image:latest harbor.example.com/your-project/my-image:latest
```

## Best Practices

### 1. Start from Our Base Images

[Content to be added: Benefits of using lab base images]

### 2. Combine RUN Commands

❌ Creates many layers:
```dockerfile
RUN apt update
RUN apt install -y python3
RUN apt install -y vim
```

✅ More efficient:
```dockerfile
RUN apt update && apt install -y \
    python3 \
    vim \
    && rm -rf /var/lib/apt/lists/*
```

### 3. Use .dockerignore

[Content to be added: Exclude unnecessary files from build]

### 4. Install Dependencies First

```dockerfile
# Copy and install dependencies first (cached layer)
COPY requirements.txt /workspace/
RUN pip install -r requirements.txt

# Copy code later (changes frequently)
COPY . /workspace/
```

## Example: Research Project

[Content to be added: Complete example Dockerfile for a typical research project]

```dockerfile
FROM harbor.example.com/base/python-datascience:latest

# Install additional packages
RUN pip install xarray netCDF4 rasterio

# Copy analysis code
WORKDIR /workspace
COPY analysis/ /workspace/analysis/
COPY requirements.txt /workspace/

# Install project-specific packages
RUN pip install -r requirements.txt

# Default command
CMD ["python", "analysis/main.py"]
```

## Multi-Stage Builds

[Content to be added: For more advanced users, building efficient images]

## Testing Your Image

```bash
# Build the image
podman build -t my-image:latest .

# Test it locally
podman run -it --rm my-image:latest bash

# Run your actual command
podman run --rm \
  -v /data:/data:Z \
  -v /nas/homes/your-username:/workspace:Z \
  my-image:latest
```

## Pushing to Harbor

Once your image works:

```bash
# Tag for Harbor
podman tag my-image:latest harbor.example.com/your-project/my-image:v1.0

# Push
podman push harbor.example.com/your-project/my-image:v1.0
```

## HPC Preparation

[Content to be added: How to convert Podman images for HPC (Singularity/Apptainer)]

The great thing about building containers is that the same image can run:
1. On your laptop (for testing)
2. On Threadripper (for medium-scale processing)
3. On Taiwan HPC (for large-scale production)

---

**Next Step**: Learn about [Preparing for Taiwan HPC](../hpc/preparing.md)
