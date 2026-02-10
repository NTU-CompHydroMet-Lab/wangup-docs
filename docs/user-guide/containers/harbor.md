# Harbor Registry

## What is Harbor?

Harbor is our lab's private container registry. It's like Docker Hub, but:
- Runs on our Core server
- Only accessible to lab members
- Contains curated base images for common tasks
- Faster (local network)

**URL**: [To be added]

## Logging In

### Web Interface

[Content to be added: How to access web UI, credentials]

### Command Line

```bash
# Log in to Harbor
podman login harbor.example.com

# Enter your LDAP username and password
```

## Available Base Images

Our lab maintains several base images to make it easier to get started:

### `base/ubuntu:latest`

[Content to be added: Basic Ubuntu image]

### `base/python:latest`

[Content to be added: Python with common scientific packages]

### `base/python-datascience:latest`

[Content to be added: Full data science stack]

### `base/pytorch:latest`

[Content to be added: PyTorch for deep learning]

### `base/tensorflow:latest`

[Content to be added: TensorFlow for deep learning]

[Content to be added: More images as available]

## Pulling Images

```bash
# Pull a base image
podman pull harbor.example.com/library/ubuntu:latest

# Use it
podman run -it harbor.example.com/library/ubuntu:latest bash
```

## Creating Your Own Images

You can create and push your own images to Harbor:

### Build an Image

See [Building Your Containers](building.md) for details on creating images.

### Push to Harbor

```bash
# Tag your image
podman tag my-image:latest harbor.example.com/your-project/my-image:latest

# Push to Harbor
podman push harbor.example.com/your-project/my-image:latest
```

## Project Organization

[Content to be added: How projects are organized in Harbor]

## Image Tags

[Content to be added: Versioning, latest vs specific versions]

## Best Practices

### 1. Use Specific Tags for Reproducibility

❌ Don't rely on `latest`:
```bash
podman pull harbor.example.com/base/python:latest
```

✅ Use specific versions:
```bash
podman pull harbor.example.com/base/python:3.11-2024.1
```

### 2. Document Your Images

[Content to be added: Including README in your projects]

### 3. Keep Images Small

[Content to be added: Multi-stage builds, clean up in Dockerfile]

## Harbor Web Interface

### Browsing Images

[Content to be added: How to explore available images]

### Viewing Image Details

[Content to be added: Layers, size, tags]

### Managing Your Images

[Content to be added: Deleting old versions]

---

**Next Step**: Learn about [Building Your Containers](building.md)
