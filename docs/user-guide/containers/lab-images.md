# Lab Images

The lab provides a base image (`library/devel`) with CUDA, Python, and common dev tools. The lab maintainer (Kilin) also maintains a personal image (`kilin/devel`) built on top of it, with additional tools for daily use. If you're not sure where to start, `kilin/devel` is a reasonable choice.

| Image | Tag | Based on | Purpose |
|-------|-----|----------|---------|
| `library/devel` | `0.6-cuda13.1.1` | NVIDIA CUDA 13.1.1 | Lab base — CUDA, Python, dev tools |
| `kilin/devel` | `0.7-cuda13.1.1` | `library/devel` | Maintainer's personal image — adds zsh, nvim, lazygit, tectonic, Claude Code |

Both are on the lab registry: `registry.lab.wangup.org`

For setup and usage, see [Development](../onboard/development.md).

---

## Base Image (`library/devel`)

Provides CUDA, a shared Python environment, SSH server, and common CLI tools. Designed for multi-user use — any LDAP user can run it.


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

## Maintainer's Image (`kilin/devel`)

Kilin's personal image built on top of the base. Adds zsh, Neovim, lazygit, tectonic, and other tools. If you don't want to build your own image, this is a good starting point.

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

## Compose File

```yaml linenums="1" title="compose.yml"
services:
  dev:
    image: registry.lab.wangup.org/kilin/devel:0.6-cuda13.1.1
    container_name: pybl
    hostname: ripper-pod
    init: true
    userns_mode: "keep-id" # (1)!
    group_add:
      - keep-groups # (2)!

    ports:
      - "40000:22" # (3)!

    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - TERM=xterm-kitty

    volumes:
      - ${HOME}:${HOME}                     # (4)!
      - .:/workspace                        # Project directory
      - /home/NAS/data:/home/NAS/data:ro    # NAS data (read-only)
      - /home/NAS/homes:/home/NAS/homes     # NAS home (legacy)
      - /home/NAS/house:/home/NAS/house     # NAS home (primary)
      - ${HOME}/.cache/uv:/opt/uv-cache     # (5)!
      - ${HOME}/.ssh/container-keys:/etc/ssh/host_keys # (6)!

    working_dir: /workspace

    command: >
      sh -c "
        if [ ! -f /etc/ssh/host_keys/ssh_host_rsa_key ]; then
          sudo ssh-keygen -A &&
          sudo cp /etc/ssh/ssh_host_* /etc/ssh/host_keys/
        else
          sudo cp /etc/ssh/host_keys/ssh_host_* /etc/ssh/
        fi &&
        sudo /usr/sbin/sshd -D -e
      " # (7)!

    devices:
      - nvidia.com/gpu=all
```

1. Maps your container UID to your host UID. Without this, files you create inside the container would be owned by a wrong user on NAS.
2. Preserves your host groups inside the container. Required for NFS group-based read permissions on NAS.
3. The host port that maps to SSH (port 22) inside the container. **Change this to a unique number** — if two users pick the same port on the same server, one will fail to start.
4. Your local home is mounted at the exact same path. Paths are consistent between host and container.
5. Your host uv cache is mounted into the container. Packages you installed on the host are immediately available inside the container — no re-downloading.
6. SSH host keys are persisted on the host. If the container is recreated, the keys stay the same and your SSH client won't warn about a changed host key.
7. On first run, generates SSH host keys and saves them to the volume. On subsequent runs, reuses the saved keys. Then starts the SSH server in the foreground to keep the container alive.
