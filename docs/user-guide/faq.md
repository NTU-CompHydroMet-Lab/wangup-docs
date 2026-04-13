# Frequently Asked Questions
🚧
## Account and Access

??? question "My SSH key isn't working. What should I check?"
    1. Verify you uploaded the **public** key (`.pub` file), not the private key.
    2. Check that the key is properly added in LDAP Account Manager.
    3. Ensure your local SSH config points to the correct private key.
    4. Check file permissions: `~/.ssh/id_ed25519` should be `600`.

??? question "Why do I have two home directories?"
    - **Local home** (`/home/username`): Fast local storage on the server you're logged into. Not shared.
    - **NAS home** (`/home/NAS/homes/username`): Shared across all servers via NFS.

    Keep important files on NAS. Use local home for temporary work.

---

## Server Usage

??? question "Which server should I use for my task?"
    | Task | Server |
    |------|--------|
    | Quick experiments, interactive work | GPU servers |
    | CPU-intensive data processing | Threadripper |
    | Long production runs | Taiwan HPC |

??? question "How do I keep a job running after I disconnect?"
    Run your session inside `tmux`. Your job continues even if SSH drops.

    ```bash
    tmux new -s work      # Start a new session
    tmux attach -t work   # Reconnect later
    ```

    Inside tmux: `Ctrl+B D` to detach without killing the session.

??? question "How do I check if someone is using the GPU?"
    ```bash
    nvidia-smi
    ```
    Check the **Processes** section at the bottom. If it's empty, the GPU is free.

??? question "The server is slow. What should I do?"
    Check what's consuming resources:
    ```bash
    htop          # CPU and memory
    nvidia-smi    # GPU usage
    df -h         # Disk space
    ```
    If another user is saturating the machine, switch to a different server.

??? question "How do I transfer files to/from the server?"
    - **VSCode**: Drag and drop in the remote file explorer.
    - **Small files**: `scp localfile user@server:/destination`
    - **Large or many files**: `rsync -avz localdir/ user@server:/destination/` — resumable if interrupted.

---

## Containers and Podman

??? question "What's the difference between Docker and Podman?"
    Docker runs a background daemon as root. Podman is daemonless and rootless — containers run as your own user process. Commands are nearly identical; most Docker tutorials work by replacing `docker` with `podman`.

??? question "Do I have to use containers?"
    Yes on all lab servers. There is no sudo access for regular users — containers are how you install and manage software.

??? question "Why did my container suddenly stop?"
    Three common causes:

    **1. Your SSH session ended.**
    Podman is daemonless — containers run as child processes of your session. When you disconnect or log out, they die. Fix: enable lingering so your processes survive logout:
    ```bash
    loginctl enable-linger $USER
    ```
    This only needs to be run once.

    **2. The process inside the container exited.**
    If the command your container was running finished or crashed, the container stops. Check what happened:
    ```bash
    podman logs <container-name>
    ```

    **3. The server ran out of memory.**
    The kernel kills processes when memory is exhausted. Check if this happened:
    ```bash
    podman inspect <container-name> --format '{{.State.OOMKilled}}'
    ```
    If it returns `true`, your container was OOM-killed. Use a server with more RAM or reduce memory usage.

??? question "My container can't access my files. What's wrong?"
    You need to mount directories explicitly with the `-v` flag:
    ```bash
    podman run -v /home/NAS/homes/username:/workspace:Z ...
    ```
    The `:Z` flag sets the correct SELinux label. Without it, permission errors occur even if the path is correct.

---

## Data and Storage

??? question "Where should I store my data?"
    | Data type | Location |
    |-----------|----------|
    | Raw datasets | `/home/NAS/data` — reference directly, never copy |
    | Code and results | `/home/NAS/homes/username` — persists across servers |
    | Temporary files | `/home/username` — local, fast, not shared |

??? question "I'm running out of disk space. What should I do?"
    Find what's using space:
    ```bash
    ncdu /home/NAS/homes/$USER
    ```
    Then clean up:
    ```bash
    podman image prune     # Remove unused container images
    ```
    Remove old temporary files and compress results you no longer actively use.

---

## Troubleshooting

??? question "Permission denied"
    1. Check file permissions: `ls -l filename`
    2. For scripts, make them executable: `chmod +x script.sh`
    3. For SSH issues, verify your key is correctly set up in LDAP Account Manager.

??? question "No space left on device"
    ```bash
    df -h           # Check which filesystem is full
    ncdu ~          # Find large files in your home
    ```
    Clean up temporary files or unused container images (`podman image prune`). Contact the administrator if you need a quota increase.

??? question "Cannot connect to server"
    1. Check your internet connection.
    2. Verify the hostname in your SSH config is correct.
    3. Try from a different network — campus VPN may be required off-site.

??? question "My job was killed unexpectedly"
    Check the container exit status:
    ```bash
    podman inspect <container-name> --format '{{.State.OOMKilled}}'
    ```
    Common causes: out of memory (`true` above), out of disk space (`df -h`), or the process crashed (check `podman logs <container-name>`).
