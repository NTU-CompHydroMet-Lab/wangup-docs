# Frequently Asked Questions

## Account and Access

<a id="ssh-key-not-working"></a>
??? question "My SSH key isn't working. What should I check?"
    1. Verify you uploaded the **public** key (`WangupServer.pub`), not the private key.
    2. Check it's added in [LDAP Account Manager](https://account.lab.wangup.org).
    3. Ensure your `~/.ssh/config` points to the private key `~/.ssh/WangupServer`.
    4. Check permissions: `chmod 600 ~/.ssh/WangupServer`.

<a id="two-home-directories"></a>
??? question "Why do I have more than one home directory?"
    - **Local home** (`/home/<user>`) — per-machine, private, fast, but disposable. Holds dotfiles, caches, and container storage.
    - **NAS home** (`/home/NAS/house/<user>`) — shared across all servers via NFS. Your projects live here.
    - `/home/NAS/homes/<user>` is a **legacy** NAS home being phased out — ignore it unless you're an existing user with data there.

    Keep work on NAS, in git. See [Storage Overview](storage/overview.md).

---

## Server Usage

<a id="which-server"></a>
??? question "Which server should I use for my task?"
    | Task | Server |
    |------|--------|
    | Quick experiments, interactive GPU work | `up3080`, `up3090`, `up4090` |
    | CPU-intensive processing | `ripper` (Threadripper) |
    | Large production runs | Taiwan HPC (NCHC) |

<a id="keep-job-running"></a>
??? question "How do I keep a job running after I disconnect?"
    Run it inside `tmux`. Your job continues even if SSH drops.

    ```bash
    tmux new -s work      # Start a new session
    tmux attach -t work   # Reconnect later
    ```

    Inside tmux: `Ctrl+B D` to detach without killing the session. For containers, also enable lingering — see [Why did my container stop?](#container-stopped).

<a id="check-gpu-usage"></a>
??? question "How do I check if someone is using the GPU?"
    ```bash
    nvtop          # interactive (recommended)
    nvidia-smi     # snapshot — check the Processes section
    ```
    If the process list is empty, the GPU is free. GPUs are shared — check before launching.

<a id="server-slow"></a>
??? question "The server is slow. What should I do?"
    Check what's consuming resources:
    ```bash
    htop          # CPU and memory
    nvtop         # GPU usage
    df -h         # disk space
    ```
    These are shared machines. If another user is saturating one, switch to a different server.

<a id="transfer-files"></a>
??? question "How do I transfer files to/from the server?"
    - **VSCode** — drag and drop in the remote file explorer.
    - **CLI** — `rsync` (large/repeated), `scp` (one-offs), or `sftp`/FileZilla (GUI).

    See [Transferring Data](storage/transfer.md) for the full guide.

---

## Containers and Podman

<a id="docker-vs-podman"></a>
??? question "What's the difference between Docker and Podman?"
    Docker runs a background daemon as root. Podman is daemonless and rootless — containers run as your own user process. Commands are nearly identical; most Docker tutorials work by replacing `docker` with `podman`.

<a id="must-use-containers"></a>
??? question "Do I have to use containers?"
    Yes on all lab servers. There is no sudo access for regular users — containers are how you install and manage software, and where you get root.

<a id="install-dependencies"></a>
??? question "How do I install packages in my container?"
    Inside the container you have full root.

    ```bash
    uv sync                 # Python deps from uv.lock into /opt/venv (fast, on local disk)
    uv pip install <pkg>    # ad-hoc Python package
    sudo apt install <pkg>  # system package
    ```

    `apt` packages and `/opt/venv` live in the container's **writable layer** and disappear when the container is removed. For dependencies you want every time, bake them into your image — see [Building Images](containers/building.md).

<a id="container-stopped"></a>
??? question "Why did my container suddenly stop?"
    Three common causes:

    **1. Your SSH session ended.**
    Podman is daemonless — containers run as child processes of your session. When you disconnect, they die. Fix: enable lingering once so your processes survive logout:
    ```bash
    loginctl enable-linger $USER
    ```

    **2. The process inside the container exited.**
    If the command your container ran finished or crashed, the container stops. Check:
    ```bash
    podman logs <container-name>
    ```

    **3. The server ran out of memory.**
    The kernel kills processes when memory is exhausted. Check:
    ```bash
    podman inspect <container-name> --format '{{.State.OOMKilled}}'
    ```
    If it returns `true`, your container was OOM-killed. Use a server with more RAM or reduce memory usage.

<a id="stale-image"></a>
??? question "I updated the lab image but my container still has the old version. Why?"
    `podman pull` skips the download if a local image with the same tag already exists — even if the remote tag now points to a newer version. Force a fresh pull by removing the local copy first:

    ```bash
    podman rmi registry.lab.wangup.org/kilin/devel:latest
    podman pull registry.lab.wangup.org/kilin/devel:latest
    ```

    Or use `--force`:

    ```bash
    podman pull --force registry.lab.wangup.org/kilin/devel:latest
    ```

    After pulling, recreate the container — a running container is not affected by a new image until it is stopped and started fresh. Prefer explicit version tags over `latest` to avoid this.

<a id="container-no-file-access"></a>
??? question "My container can't access my files. What's wrong?"
    NFS rejects the container's user unless its UID matches yours. The [recommended compose file](containers/lab-images.md#recommended-compose-file) handles this with `userns_mode: keep-id`, which maps the container user to your host UID.

    For a manual `podman run`, add `--userns=keep-id` and mount the path at its real location:
    ```bash
    podman run --userns=keep-id \
      -v /home/NAS/house/$USER:/home/NAS/house/$USER ...
    ```
    Without `keep-id`, the container runs as a subUID the NAS doesn't recognize, and access to `/home/NAS/...` is denied.

<a id="new-container-host-key"></a>
??? question "A new container on the same machine asks me to confirm the host key (or VSCode hangs)"
    The lab containers share one persisted SSH host key, but each listens on a different port — so to your SSH client a new container is a new target it hasn't seen, even though the key looks familiar. It asks you to trust it. This is expected and safe (it's your own key).

    - **Terminal**: type `yes` at the prompt.
    - **VSCode**: the prompt is hidden — click the SSH status in the bottom-right (or its **Detail** link) and type `yes` in the terminal that opens.

---

## Data and Storage

<a id="where-to-store-data"></a>
??? question "Where should I store my data?"
    | Data | Location |
    |------|----------|
    | Code, notebooks, results | `/home/NAS/house/<user>` — in a git repo pushed to GitHub |
    | Shared datasets | `/home/NAS/data` — read-only, reference directly, never copy |
    | Hot data, caches, temp | `/home/<user>` — local, fast, disposable |

    NAS is **not** a backup — keep code in git. See [Storage Overview](storage/overview.md).

<a id="data-backup"></a>
??? question "Is my data backed up? Can I recover a deleted file?"
    No. The NAS uses RAID5, which only survives a single failed disk — there are **no snapshots and no backups**. `rm` is permanent and unrecoverable.

    Protect your own work: keep code in git pushed to GitHub, structure projects so the bulk (data, outputs, checkpoints) is reproducible, and copy any irreplaceable artifact off the NAS yourself. See [Data Safety](storage/overview.md#data-safety).

<a id="data-privacy"></a>
??? question "Can other people see my files?"
    On the NAS, yes — homes and data are readable by every lab member. Local home (`/home/<user>`) is private to you, but disposable.

    Never store plaintext secrets (API keys, tokens) in NAS paths or commit them to git. `chmod 700` anything sensitive. See [Privacy](storage/overview.md#privacy).

<a id="copy-data-to-local"></a>
??? question "Should I copy datasets to local disk for speed?"
    Usually not. Over the 10 GbE network the NAS sustains ~600 MB/s — fine for large sequential reads (netCDF, zarr). Copy a subset to local SSD only for **many-small-file random access** (image datasets) or on `up3080` (1 GbE). See [Speed](storage/overview.md#speed).

<a id="disk-space"></a>
??? question "I'm running out of disk space."
    NAS and local disk are **separate** — first find which one is full:
    ```bash
    df -h
    ```
    Check the `Use%` of the filesystem holding the path you care about.

    **A NAS mount is full** (`/home/NAS/house`, `/home/NAS/data`) — these hold only your files; podman stores nothing here.
    ```bash
    ncdu /home/NAS/house/$USER
    ```
    Remove or archive old datasets, outputs, and checkpoints — they're reproducible.

    **Local disk is full** (`/home/<user>`, the local SSD) — this is where podman keeps images, container layers, `/opt/venv`, and the uv cache. It's almost always the cause, and the SSD is shared with other users on that machine.
    ```bash
    ncdu /home/$USER
    podman image prune     # unused images — usually the biggest culprit
    podman system prune    # also stopped containers and dangling layers
    podman volume prune    # unused volumes
    ```
    Also clear local scratch data you copied for I/O and a bloated uv cache (`~/.cache/uv`).

    There's no quota, but space is shared — be considerate.

---

## Troubleshooting

<a id="permission-denied"></a>
??? question "Permission denied"
    1. Check you own the path: `ls -l <file>`, `whoami`.
    2. On NAS, confirm your home is initialized — see [Account Registry](onboard/account.md#initialize-nas-storage).
    3. For scripts: `chmod +x script.sh`.
    4. For SSH: verify your key in [LDAP Account Manager](https://account.lab.wangup.org).

<a id="cannot-connect"></a>
??? question "Cannot connect to server"
    1. Check your internet connection.
    2. Verify the hostname, IP, and key path in `~/.ssh/config`.
    3. `ripper` has no public IP — it needs a `ProxyJump` through `up3090`/`up4090`. See [Login into Server](onboard/account.md#login-into-server).
    4. If you see *"REMOTE HOST IDENTIFICATION HAS CHANGED"*, see [below](#host-key-changed).

<a id="host-key-changed"></a>
??? question "SSH says 'REMOTE HOST IDENTIFICATION HAS CHANGED'"
    The server's SSH host key changed — usually because its OS was reinstalled. Your `~/.ssh/known_hosts` still has the old key, so the client blocks the connection.

    Remove the stale entry by alias **and** by IP, then reconnect:
    ```bash
    ssh-keygen -R up4090
    ssh-keygen -R 140.112.13.91
    ```
    You'll be asked to trust the new key on the next connection — type `yes`. (If this happens connecting to a *container*, its host-key persistence mount is missing — see [Using Podman](containers/use-podman.md).)
