# Building Images

If you've never written a Containerfile before, read either of the following
tutorial first.  

1. [Podman build documentation](https://docs.podman.io/en/latest/markdown/podman-build.1.html) 
2. [Docker build documentation](https://docs.docker.com/get-started/docker-concepts/building-images/) 

This page covers only what's specific to building on top of the lab infrastructure.

---

## Start from the Lab Base

```dockerfile linenums="1" title="Containerfile"
FROM registry.lab.wangup.org/library/devel:0.6-cuda13.1.1
```

Our lab base image make all infra work seamlessly. Including CUDA, NAS, User, 
SSH, venv, sudo and many more. You can starting from this image, install software
you need and start the container with the [recommended compose file](lab-images.md#recommended-compose-file)


---

## Venv Management

**Do not put Python dependencies in the Containerfile.** The image is for the system environment — CUDA, system libraries, the Python interpreter. Project dependencies belong to the project, managed by `uv` at runtime.

### The container venv

The base image creates a Python venv at `/opt/venv` and pre-activates it — `VIRTUAL_ENV` and `PATH` are both set, so `python` inside the container already points to it with no activation step needed.

The key variable is `UV_PROJECT_ENVIRONMENT=/opt/venv`. This tells `uv` to use `/opt/venv` as the project environment instead of creating a `.venv` in your project directory. When you run `uv sync`, packages go into `/opt/venv` automatically.

`/opt` is also world-writable, so any LDAP user sharing the container can install into the same venv without permission issues.

### The cache mount

The compose file mounts your local uv cache into the container:

```yaml linenums="1" title="compose.yml"
volumes:
  - ${HOME}/.cache/uv:/opt/uv-cache
```

This overrides `UV_CACHE_DIR` to point at your host's cache on the server's local disk. When you throw away and recreate a container, `uv sync` restores the full environment from local cache in seconds — no re-downloading.

### Workflow

```bash linenums="1" title="In the Container"
cd /workspace          # your project, mounted from host
uv sync                # install from uv.lock into /opt/venv using local cache
uv run python train.py # or just: python train.py
```

To add a dependency: edit `pyproject.toml`, run `uv sync`. No image rebuild, no push, no pull.

**When to bake deps into the image** — only when delivering a [service image](lab-images.md#service-images) to someone else. The recipient runs `podman compose up` and expects it to work without any setup. Bake the deps in with `RUN uv sync` against a locked `uv.lock` so the image is self-contained. For any dev container you run yourself, it is never necessary.

---

## Environment Variables and SSH Sessions

`ENV` in a Containerfile is available to `podman run`, but SSH sessions do not inherit it. A user who SSHes into the container gets none of the `ENV`s you set.

Any variable that should be present in the shell must be explicitly written to a file in `/etc/profile.d/`:

```dockerfile linenums="1" title="Containerfile"
ENV MY_TOOL_HOME=/opt/mytool
RUN echo "export MY_TOOL_HOME=${MY_TOOL_HOME}" >> /etc/profile.d/container-env.sh
```

Extend the existing `container-env.sh` — the base image already uses it for its own variables.

---

## Building and Pushing

Build from the directory containing your `Containerfile`:

```bash linenums="1" title="On the Host"
podman build -t myimage:v1.0 .
```

Test before pushing:

```bash linenums="1" title="On the Host"
podman run --rm -it myimage:v1.0 bash
```

Tag and push to Harbor:

```bash linenums="1" title="On the Host"
podman login registry.lab.wangup.org
podman tag myimage:v1.0 registry.lab.wangup.org/<project>/myimage:v1.0
podman push registry.lab.wangup.org/<project>/myimage:v1.0
```

`<project>` is your Harbor project name — see [Harbor Registry](../services/harbor.md) to create one. Use explicit version tags; `latest` causes [stale image issues](../faq.md#stale-image).

To run your image, use the [recommended compose file](lab-images.md#recommended-compose-file) and replace the `image:` field with your new image address.

---

## Example

A research image that adds system-level geospatial libraries on top of the lab base. Python packages are not baked in — they are managed per-project with `uv sync` at runtime.

```dockerfile linenums="1"
FROM registry.lab.wangup.org/library/devel:0.6-cuda13.1.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgdal-dev \
    libproj-dev \
    && rm -rf /var/lib/apt/lists/*
```

Then inside the running container:

```bash linenums="1"
uv sync    # installs xarray, cartopy, etc. from pyproject.toml + local cache
```

The [containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) repository has the full source for `library/devel` and `kilin/devel` as real production examples.
