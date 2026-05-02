```yaml linenums="1" title="compose.yml"
services:
  dev:
    image: registry.lab.wangup.org/kilin/devel:0.6-cuda13.1.1
    container_name: example-container # (1)!
    hostname: ripper-pod # (2)!
    init: true # (3)!
    userns_mode: "keep-id" # (4)!
    group_add:
      - keep-groups # (5)!

    ports:
      - "12345:22" # (6)!

    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - TERM=xterm-kitty

    volumes:
      - ${HOME}:${HOME}                     # User home
      - .:/workspace                        # Project directory
      - /home/NAS/data:/home/NAS/data:ro    # NAS data (read-only)
      - /home/NAS/homes:/home/NAS/homes     # NAS home directories
      - ${HOME}/.cache/uv:/opt/uv-cache     # uv package cache
      - ${HOME}/.ssh/container-keys:/etc/ssh/host_keys # (7)!

    working_dir: /workspace

    command: >
      sh -c "
        if [ ! -f /etc/ssh/host_keys/ssh_host_rsa_key ]; then
          sudo ssh-keygen -A &&
          sudo cp /etc/ssh/ssh_host_* /etc/ssh/host_keys/
        else
          sudo cp /etc/ssh/host_keys/ssh_host_* /etc/ssh/
        fi &&
        sudo /usr/sbin/sshd -D -e &&
        sleep infinity
      "
    devices:
      - nvidia.com/gpu=all
```

1. Must be unique among your containers on this machine. Use something descriptive: `yourname-dev`.
2. The name the container calls itself in the terminal prompt. Change this to anything you like — e.g. `myserver-pod`.
3. Runs a minimal init process as PID 1 so signal handling and zombie reaping work correctly.
4. The container process runs as your UID instead of root, so files you create in mounted volumes are owned by you.
5. Preserves supplementary groups (e.g. `video`, `render`) that give your user GPU access on the host.
6. Maps host port `12345` to container port `22` (sshd). Pick any unused port in `10000–65535`. Verify it's free before starting: `ss -tlnp | grep :12345`.
7. Persists SSH host keys to your home directory so they survive container restarts. Without this, SSH clients show "REMOTE HOST IDENTIFICATION HAS CHANGED" after every `compose down && compose up`.
