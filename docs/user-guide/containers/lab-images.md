# Images

An image is the blueprint your container runs from — OS, packages, tools, and config bundled together. Pick one from a registry or build your own.

---

## Where Images Come From

| Registry | What's There |
|----------|-------------|
| [Lab Harbor](https://registry.lab.wangup.org) | Lab base images, personal images |
| [NVIDIA NGC](https://catalog.ngc.nvidia.com)| Official CUDA, TensorRT, PyTorch, cuDNN images |
| [Docker Hub](https://hub.docker.io) (default) | General-purpose public images, official distros |
| [GitHub Container Registry](https://ghcr.io) | Open source project images |
| [Microsoft Container Registry](https://mcr.microsoft.com) | Official Microsoft images, VS Code dev containers |

For browsing and managing images on the lab registry, see [Harbor Registry](../services/harbor.md).

---

## Choosing an Image

Images fall into three broad categories based on size and lifecycle. Knowing 
which category you need narrows the choice significantly.

### Developing Images

Large, interactive, long-lived. These images bundle an entire toolchain — 
compiler, interpreter, debugger, shell, editor — because a developer needs all 
of it at different points. You enter the container, work inside it, and keep it 
running across sessions. Size typically ranges from 2 GB to 20 GB depending on 
CUDA and framework inclusions.

| Image | Registry | Use when |
|-------|---------|---------|
| [`nvcr.io/nvidia/cuda`](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda) | NGC | You need CUDA and will build everything else yourself |
| [`nvcr.io/nvidia/pytorch`](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch) | NGC | PyTorch with matching CUDA and cuDNN, pre-built |
| [`pytorch/pytorch`](https://hub.docker.com/r/pytorch/pytorch) | Docker Hub | Same as above without an NGC account |
| [`tensorflow/tensorflow`](https://hub.docker.com/r/tensorflow/tensorflow) | Docker Hub | TensorFlow with GPU support |
| [`ubuntu`](https://hub.docker.com/_/ubuntu), [`debian`](https://hub.docker.com/_/debian) | Docker Hub | Bare OS — no Python, no CUDA; build from scratch |
| [`python`](https://hub.docker.com/_/python) | Docker Hub | Python only, no system bloat; good for pure Python work |
| [`mcr.microsoft.com/devcontainers/universal`](https://mcr.microsoft.com/en-us/artifact/mar/devcontainers/universal/about) | MCR | Microsoft's dev container with many languages pre-installed |

!!! info
    For research and development on lab servers, the [lab images](#lab-images) are pre-built on the NVIDIA CUDA base and ready to use without any configuration.

### Service Images

Medium-sized, daemonized, rarely entered. These images contain only what a 
specific service needs to run — a database, a web server, a registry. You start 
them and leave them running in the background; you only exec into the shell to 
debug something broken. Because they carry no development tools, they stay lean.

| Image | Registry | What it runs |
|-------|---------|-------------|
| [`goharbor/harbor-core`](https://hub.docker.com/r/goharbor/harbor-core) | Docker Hub | Harbor container registry (what our lab registry runs on) |
| [`postgres`](https://hub.docker.com/_/postgres) | Docker Hub | PostgreSQL relational database |
| [`grafana/grafana`](https://hub.docker.com/r/grafana/grafana) | Docker Hub | Grafana monitoring and dashboards |
| [`jupyter/scipy-notebook`](https://hub.docker.com/r/jupyter/scipy-notebook) | Docker Hub | Jupyter Notebook with SciPy stack, served over HTTP |
| [`traefik`](https://hub.docker.com/_/traefik) | Docker Hub | Reverse proxy and TLS termination |

Most lab services are already deployed and managed by the [lab maintainer](../../maintainer/team.md#maintainer). 
You would choose a service image when delivering a project that includes a 
running component — a web API, a database, a dashboard — that others need to 
access without entering a shell.

### Tool Images

Minimal, one-shot, no persistent state. These images contain exactly one CLI 
tool and its dependencies. You run them, get the output, and the container exits. 
They are rarely kept alive. Because there is no OS layer beyond the bare minimum, 
they are often under 100 MB.

| Image | Registry | What it does |
|-------|---------|-------------|
| [`alpine/git`](https://hub.docker.com/r/alpine/git) | Docker Hub | Git without installing it on the host |
| [`gcc`](https://hub.docker.com/_/gcc) | Docker Hub | C/C++ compiler |
| [`pipelinecomponents/black`](https://hub.docker.com/r/pipelinecomponents/black) | Docker Hub | Python formatter |
| [`koalaman/shellcheck`](https://hub.docker.com/r/koalaman/shellcheck) | Docker Hub | Shell script linter |
| [`aquasec/trivy`](https://hub.docker.com/r/aquasec/trivy) | Docker Hub | Container image vulnerability scanner |

A typical invocation mounts your source directory and discards the container on exit:

```bash linenums="1"
podman run --rm -v $(pwd):/src pipelinecomponents/black black /src
```
!!! note
    In practice, if you already have a developing container running, it is usually 
    simpler to install the tool inside it rather than reaching for a tool image. 
    Tool images are most useful in CI pipelines where you want a reproducible, 
    isolated tool invocation without managing a full environment.

### Other Specialized Types

Beyond the three main categories, a few other image types appear in more advanced setups.

**Base images** are the absolute minimum starting point for building your own 
image — not meant to run directly. `scratch` is a completely empty image with no 
OS at all, used for statically compiled binaries. `alpine` is a 5 MB Linux image 
with a shell and package manager. Google's `distroless` images sit in between: 
a minimal OS without a shell, making them harder to exploit but also harder to 
debug. You would choose one of these as the `FROM` line when building a custom 
image and want the smallest possible footprint.

| Image | Size | Use when |
|-------|------|---------|
| [`scratch`](https://hub.docker.com/_/scratch) | 0 B | Statically compiled binary with zero dependencies |
| [`alpine:3`](https://hub.docker.com/_/alpine) | ~5 MB | Tiny Linux with `apk` package manager |
| [`gcr.io/distroless/python3`](https://github.com/GoogleContainerTools/distroless) | ~30 MB | Python app in production, no shell needed |

**Sidecar images** run alongside a main container and share its network or volumes. 
They handle a supporting concern — log forwarding, metrics collection, secret 
injection, service mesh proxying — without modifying the main container. 
They start and stop with the main container's lifecycle. Common examples are 
Fluentd for log shipping or Envoy as a proxy.

**Init container images** run to completion before the main container starts. 
They are used for one-time setup: seeding a database, downloading a config file
, waiting for a dependency to become healthy. If the init container exits non-zero, 
the main container never starts.

**Job/batch images** are designed to run a task and exit with a result code 
rather than stay alive. An ML training script, a data processing pipeline, or a 
report generator all fit this pattern. In compose you run these with 
`podman run --rm`; in Kubernetes they map to `Job` or `CronJob` resources.

---

## Lab Images

The lab maintains a curated base image (`library/devel`) on top of the NVIDIA 
CUDA image. The [lab maintainer](../../maintainer/team.md#maintainer) also 
publishes a personal image (`kilin/devel`) built on top of it.

| Image | Based on | Purpose |
|-------|----------|---------|
| [library/devel](https://registry.lab.wangup.org/harbor/projects/1/repositories/devel/artifacts-tab) | [NVIDIA CUDA Image](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/cuda?version=13.2.1-cudnn-runtime-ubuntu24.04) | Lab base — CUDA, Python, dev tools |
| [kilin/devel](https://registry.lab.wangup.org/harbor/projects/2/repositories/devel/artifacts-tab) | [library/devel](https://registry.lab.wangup.org/harbor/projects/1/repositories/devel/artifacts-tab) | Maintainer's personal image — adds zsh, nvim, lazygit, tectonic, Claude Code |

If you're unsure where to start, `kilin/devel` is a reasonable default. For first-time setup, see [Development](../onboard/development.md).

### Base Image (`library/devel`)

Provides CUDA, a shared Python environment, SSH server, and common CLI tools. 
Designed for multi-user use — any LDAP user can run it.

!!! warning "This may be outdated"
    The Containerfile shown here is for reference only. For the latest version, see the [containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) repository.

```dockerfile linenums="1"
FROM nvcr.io/nvidia/cuda:13.1.1-devel-ubuntu24.04

COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /uvx /usr/local/bin/

ENV TERM=xterm-256color
ENV SHELL=/bin/bash
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Taipei
ENV VIRTUAL_ENV="/opt/venv"
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ENV UV_PYTHON_INSTALL_DIR="/opt/uv-toolchain"
ENV UV_TOOL_BIN_DIR="/opt/uv-tool"
ENV UV_CACHE_DIR="/opt/uv-cache"
# (1)!
ENV UV_PROJECT_ENVIRONMENT=$VIRTUAL_ENV 
# (2)!
ENV UV_LINK_MODE=copy
# (3)!
ENV UV_COMPILE_BYTECODE=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git vim tmux wget curl htop sudo zip unzip build-essential openssh-client \
    nvtop jq ripgrep fd-find bat fzf openssh-server net-tools stow \
    && userdel -r ubuntu || true
# (4)!

RUN echo 'ALL ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# (5)!

RUN mkdir -p /var/run/sshd && ssh-keygen -A

RUN mkdir -p $UV_PYTHON_INSTALL_DIR $UV_TOOL_BIN_DIR $UV_CACHE_DIR $VIRTUAL_ENV /workspace \
    && uv python install 3.13 \
    && uv venv $VIRTUAL_ENV --python 3.13 \
    && chmod -R 777 /opt $UV_PYTHON_INSTALL_DIR $VIRTUAL_ENV $UV_CACHE_DIR $UV_TOOL_BIN_DIR
# (6)!

RUN { \
    echo "export TZ=${TZ}"; \
    echo "export VIRTUAL_ENV=${VIRTUAL_ENV}"; \
    echo "export UV_PYTHON_INSTALL_DIR=${UV_PYTHON_INSTALL_DIR}"; \
    echo "export UV_TOOL_BIN_DIR=${UV_TOOL_BIN_DIR}"; \
    echo "export UV_CACHE_DIR=${UV_CACHE_DIR}"; \
    echo "export UV_PROJECT_ENVIRONMENT=${UV_PROJECT_ENVIRONMENT}"; \
    echo "export UV_LINK_MODE=${UV_LINK_MODE}"; \
    echo "export UV_COMPILE_BYTECODE=${UV_COMPILE_BYTECODE}"; \
    echo 'export PATH="$VIRTUAL_ENV/bin:$PATH"'; \
    } > /etc/profile.d/container-env.sh
# (7)!

WORKDIR /workspace
CMD ["/bin/bash"]
```

1. uv cache directory inside the container. The compose file mounts your host cache here — packages are shared between host and container.
2. uv uses `/opt/venv` as the default project environment automatically.
3. Hard links don't work across NFS and local filesystems. `copy` mode ensures installs always succeed regardless of where files land.
4. The default `ubuntu` user (UID 1000) conflicts with LDAP users. Removed to avoid permission issues.
5. All users get passwordless sudo inside the container. This is the whole point — you have root here, not on the host.
6. `/opt` is made world-writable so any LDAP user (with any UID) can install packages into the shared venv and tools.
7. Docker `ENV` variables are not inherited by SSH sessions. This file makes them available to every login shell.

---

### Maintainer's Image (`kilin/devel`)

The [maintainer's](../../maintainer/team.md#maintainer) personal image built on top of the base. Adds zsh, Neovim, lazygit, tectonic, and other tools. If you don't want to build your own image, this is a good starting point.

!!! warning "This may be outdated"
    The Containerfile shown here is for reference only. For the latest version, see the [containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) repository.

```dockerfile linenums="1"
FROM library/devel:0.6-cuda13.1.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    zsh locales clang libclang-dev libgraphite2-3 imagemagick ghostscript \
    && locale-gen en_US.UTF-8 \
    && echo 'emulate sh -c ". /etc/profile"' >> /etc/zsh/zprofile
# (1)!

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV EDITOR=nvim

ENV ZSH="/usr/local/bin/ohmyzsh"
# (2)!
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH}/custom/themes/powerlevel10k
ENV SHELL=/usr/bin/zsh

RUN curl -fsSL "https://claude.ai/install.sh" | bash \
    && cp /root/.local/bin/claude /usr/local/bin/claude \
    && chmod 755 /usr/local/bin/claude

ARG NVIM_VERSION=0.11.6
RUN curl -fsSL "https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" \
    | tar -xz -C /opt \
    && ln -s /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

ENV RUSTUP_HOME=/opt/cargo
ENV CARGO_HOME=/opt/cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y \
    && chmod -R 777 /opt/cargo
# (3)!

RUN /opt/cargo/bin/cargo install --locked tree-sitter-cli

RUN curl --proto '=https' --tlsv1.2 -fsSL https://drop-sh.fullyjustified.net | sh \
    && mv tectonic /usr/local/bin/tectonic
# (4)!

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
    | \grep -Po '"tag_name": *"v\K[^"]*') \
    && curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" \
    && tar xf lazygit.tar.gz lazygit \
    && install lazygit -D -t /usr/local/bin/

RUN sed -i '/^auth.*required.*pam_shells.so/a auth       sufficient pam_usertype.so isregular' /etc/pam.d/chsh
# (5)!

RUN { \
    echo "export LANG=${LANG}"; \
    echo "export LC_ALL=${LC_ALL}"; \
    echo "export LANGUAGE=${LANGUAGE}"; \
    echo "export EDITOR=${EDITOR}"; \
    echo "export ZSH=${ZSH}"; \
    echo "export SHELL=${SHELL}"; \
    echo "export RUSTUP_HOME=${RUSTUP_HOME}"; \
    echo "export CARGO_HOME=${CARGO_HOME}"; \
    } > /etc/profile.d/container-env.sh
# (6)!

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/zsh"]
```

1. zsh login shells don't source `/etc/profile` by default, so ENV vars from `profile.d` would be missing. This line makes zsh source them.
2. Oh-My-Zsh is installed to `/usr/local/bin/ohmyzsh` instead of `$HOME` so it is shared across all LDAP users.
3. Cargo is installed to `/opt/cargo` (world-writable) so all users can use it, not just root.
4. [Tectonic](https://tectonic-typesetting.github.io/) is a modern LaTeX engine — useful for writing papers.
5. Allows LDAP users to change their shell inside the container with `chsh`, bypassing the `/etc/shells` check.
6. Exports all image-specific ENV vars to `profile.d` so they are available in SSH login shells, not just interactive shells.

---

## Recommended Compose File

The lab images are designed to run with the following compose setup — SSH server, GPU passthrough, NAS mounts, and persistent host keys all wired up.

!!! warning "This may be outdated"
    For the latest version and a ready-to-copy file, see the [containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) repository.

--8<-- "snippets/compose-dev.md"
