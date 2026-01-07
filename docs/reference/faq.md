# Frequently Asked Questions

## Account and Access

### How do I get an account?

[Content to be added: Specific process for your lab]

Contact the lab administrator or your advisor to request an account.

### I forgot my password. How do I reset it?

[Content to be added: Password reset procedure]

### My SSH key isn't working. What should I check?

1. Verify you uploaded the **public** key (`.pub` file), not the private key
2. Check that the key is properly uploaded in LDAP Account Manager
3. Ensure your local SSH config points to the correct private key
4. Check file permissions: `~/.ssh/id_ed25519` should be 600

### Why do I have two home directories?

For performance and accessibility:
- **Local home** (`/home/username`): Fast local storage on each server
- **NAS home** (`/nas/homes/username`): Shared across all servers via network

Use local home for temporary work, NAS home for important files you want to keep.

## Server Usage

### Which server should I use for my task?

- **Quick experiments, interactive work**: GPU servers (i7, i9, or 5950)
- **Data processing, many CPU cores**: Threadripper
- **Long production runs**: Taiwan HPC

### Can I run long jobs on GPU servers?

Yes, but use `screen` or `tmux` so your job continues if you disconnect.

### How do I check if someone is using the GPU?

```bash
nvidia-smi
```

Look at the "Processes" section to see what's running.

### The server is slow. What should I do?

Check resource usage:
```bash
htop          # CPU and memory usage
nvidia-smi    # GPU usage
df -h         # Disk space
```

If someone else is using all resources, wait or use another server.

## Containers and Podman

### What's the difference between Docker and Podman?

They're very similar! Podman can run rootless (without sudo) and commands are nearly identical. Just replace `docker` with `podman`.

### Why do we use containers?

- **Reproducibility**: Your environment is the same everywhere
- **Portability**: Same container runs on lab servers and HPC
- **Isolation**: Your work doesn't conflict with others'

### Do I have to use containers?

- **GPU servers**: No, but recommended
- **Threadripper**: Yes, because you don't have sudo access
- **HPC**: Usually yes

### Where can I find base images?

Check our Harbor registry: [URL to be added]

### My container can't access my files. What's wrong?

You need to mount directories with the `-v` flag:
```bash
podman run -v /nas/homes/username:/workspace:Z ...
```

Don't forget the `:Z` flag!

## Data and Storage

### Where should I store my data?

- **Raw datasets**: Don't copy! Use from `/data` directly
- **Your code and results**: NAS home (`/nas/homes/username`)
- **Temporary processing files**: Local home

### I'm running out of space. What should I do?

Check your usage:
```bash
du -sh ~
du -sh /nas/homes/username
```

Clean up:
- Remove old temporary files
- Delete unused container images: `podman image prune`
- Compress old results

### How do I access the shared datasets (ERA5, IMERG)?

They're in `/data`:
```bash
ls /data/ERA5
ls /data/IMERG
```

Reference them directly in your scripts - don't copy!

## HPC

### How do I get access to Taiwan HPC?

[Content to be added: Specific application process]

### Can I use my lab containers on HPC?

Yes! Convert them to Singularity/Apptainer format. See [Preparing for HPC](../hpc/preparing.md).

### How long does my HPC job take to start?

It depends on the queue and requested resources. Could be minutes to hours. Check with `squeue`.

## Linux and SSH

### I'm new to Linux. Where should I start?

Start with these sections:
1. [Why Linux?](../getting-started/why-linux.md)
2. [Linux Command Line Basics](../basic-usage/linux-basics.md)
3. [Using VSCode](../basic-usage/vscode.md) for a more familiar interface

### How do I transfer files to/from the server?

- **With VSCode**: Drag and drop in the file explorer
- **Command line**: Use `scp` or `rsync`
- **Large datasets**: Use `rsync` for resumable transfers

### What's the difference between `~` and `/home/username`?

They're the same! `~` is a shortcut to your home directory.

## Troubleshooting

### "Permission denied" error

Check:
1. File permissions: `ls -l filename`
2. If it's a script, make it executable: `chmod +x script.sh`
3. If SSH: Check your SSH key setup

### "No space left on device"

You've run out of disk space:
```bash
df -h          # Check disk usage
du -sh ~/*     # Find large directories
```

Clean up unnecessary files or contact the administrator.

### "Cannot connect to server"

1. Check your internet connection
2. Verify the server hostname/IP is correct
3. Check if a VPN is required [if applicable]
4. Try pinging the server: `ping hostname`

### My job is killed unexpectedly

Possible causes:
- Out of memory: Check logs and request more memory
- Out of disk space: Clean up temporary files
- Time limit exceeded (on HPC): Request more time

## Getting More Help

### Where can I find more information?

- This documentation!
- Ask senior lab members
- Check the [External Resources](resources.md) page

### Who should I contact for help?

- **Account issues**: [Contact to be added]
- **Hardware problems**: [Contact to be added]
- **HPC questions**: [Contact to be added]
- **Research questions**: Your advisor or senior lab members

### How do I report a problem?

[Content to be added: Issue reporting procedure]

### Can I request new software or hardware?

[Content to be added: Request procedure]
