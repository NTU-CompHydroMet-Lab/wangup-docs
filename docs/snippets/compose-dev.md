!!! warning "This may be outdated"
    The compose file shown here is for reference only. For the latest version and a ready-to-copy file, see the [containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) repository.

```yaml linenums="1" title="compose.yml"
x-podman:
  in_pod: false
services:
  dev:
    image: registry.lab.wangup.org/kilin/devel:0.17-cuda13.1.1
    container_name: example-container # (1)!
    hostname: ripper-example-container # (2)!
    init: true # (3)!
    userns_mode: "keep-id" # (4)!
    group_add:
      - keep-groups # (5)!
    working_dir: "${HOME}"
    shm_sizes: '32gb'

    ports:
      - "12345:22" # (6)!

    environment:
      - ANTHROPIC_API_KEY=${ANTHROPIC_API_KEY}
      - OPENAI_API_KEY=${OPENAI_API_KEY}
      - TERM=xterm-kitty

    volumes:
      - ${HOME}:${HOME}                     # User home
      - /home/NAS/:/home/NAS/               # NAS data
      - ${HOME}/.cache/uv:/opt/uv-cache     # (7)!
      - ${HOME}/.ssh/container-keys:/etc/ssh/host_keys #
      - /var/lib/sss/pipes:/var/lib/sss/pipes
      - /var/lib/sss/mc:/var/lib/sss/mc:ro

    command: ["sleep", "infinity"] 
    devices:
      - nvidia.com/gpu=all
```

1. Must be unique among your containers on this machine. Use something descriptive: `yourname-dev`.
2. The name the container calls itself in the terminal prompt. Change this to anything you like — e.g. `myserver-pod`.
3. Runs a minimal init process as PID 1 so signal handling and zombie reaping work correctly.
4. Maps container UID to your host UID. Required for NFS mounts — without this, the container runs as a subUID the NFS server doesn't recognize, and access to your files is denied.
5. Preserves supplementary groups (e.g. `video`, `render`) that give your user GPU access on the host.
6. Maps host port `12345` to container port `22` (sshd). Pick any unused port in `10000–65535`. Verify it's free before starting: `ss -tlnp | grep :12345`.
7. You can also do `/home/NAS/house/<user>/uv-cache:/opt/uv-cache` so that all machine share the same uv cache. It might be slightly slower than local `${HOME}/.cache/uv`
