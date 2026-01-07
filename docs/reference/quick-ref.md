# Quick Reference

## SSH Connection

```bash
# Connect to servers (using SSH config)
ssh gpu1
ssh gpu2
ssh gpu3
ssh threadripper

# Generate SSH key
ssh-keygen -t ed25519 -C "your.email@example.com"

# Copy SSH key to clipboard (to upload to LAM)
cat ~/.ssh/id_ed25519.pub
```

## Essential Linux Commands

```bash
# Navigation
pwd                          # Show current directory
ls -lh                      # List files with details
cd directory_name           # Change directory
cd ~                        # Go to home
cd ..                       # Go up one level

# File operations
cp source dest              # Copy file
mv source dest              # Move/rename file
rm file                     # Delete file
mkdir directory             # Create directory

# Viewing files
cat file.txt                # Display file
less file.txt               # View file (q to quit)
head -n 20 file.txt         # First 20 lines
tail -f logfile.txt         # Follow file updates

# Searching
grep "text" file.txt        # Search in file
find . -name "*.py"         # Find files by name

# Disk usage
df -h                       # Disk space
du -sh directory/           # Directory size

# Processes
htop                        # Monitor processes
nvidia-smi                  # GPU status
```

## Podman Commands

```bash
# Pull images
podman pull harbor.example.com/base/python:latest

# Run container
podman run -it ubuntu:latest bash
podman run -d --name mycontainer ubuntu:latest

# With volume mounts
podman run -it \
  -v /nas/homes/username:/workspace:Z \
  -v /data:/data:Z \
  image:tag bash

# Manage containers
podman ps                   # List running containers
podman ps -a               # List all containers
podman stop container-name
podman start container-name
podman rm container-name

# Manage images
podman images              # List images
podman rmi image-name      # Remove image
podman image prune         # Clean up unused images

# Execute in running container
podman exec -it container-name bash

# View logs
podman logs container-name
podman logs -f container-name    # Follow logs
```

## GPU Monitoring

```bash
# One-time check
nvidia-smi

# Continuous monitoring
watch -n 1 nvidia-smi

# Detailed info
nvidia-smi -l 1            # Update every second
nvidia-smi --query-gpu=utilization.gpu --format=csv -l 1
```

## SLURM Commands (HPC)

```bash
# Submit job
sbatch job_script.sh

# Check queue
squeue                      # All jobs
squeue -u username          # Your jobs

# Cancel job
scancel job-id

# Job info
sinfo                       # Cluster info
sacct                       # Job history
```

## Module Commands (HPC)

```bash
# Available modules
module avail
module avail python

# Load modules
module load python/3.10
module load cuda/11.8

# List loaded
module list

# Unload
module unload python/3.10
module purge               # Unload all
```

## Data Locations

```bash
# Your homes
/home/username              # Local home (fast, not shared)
/nas/homes/username         # NAS home (shared across servers)

# Shared data
/data/ERA5                  # ERA5 reanalysis
/data/IMERG                 # GPM IMERG precipitation
/data/radar                 # Radar data
/data/satellite             # Satellite data
/data/gauge                 # Gauge data
```

## Server Information

### GPU Servers

| Server | Hostname | GPU | Purpose |
|--------|----------|-----|---------|
| 1 | [To be added] | RTX 3080 Ti | Quick experiments |
| 2 | [To be added] | RTX 4090 | Heavy computation |
| 3 | [To be added] | RTX 3090 | General GPU work |

**Access**: Direct SSH, sudo available via dedicated account

### Threadripper Server

| Hostname | CPU | Purpose |
|----------|-----|---------|
| [To be added] | Threadripper 7965 | Data processing |

**Access**: Rootless Podman only, no sudo

## Common File Paths

```bash
# SSH config
~/.ssh/config

# SSH keys
~/.ssh/id_ed25519          # Private key
~/.ssh/id_ed25519.pub      # Public key

# Podman storage
~/.local/share/containers/storage/

# Bash config
~/.bashrc
~/.bash_profile
```

## Screen/Tmux (For Long Jobs)

```bash
# Screen
screen -S session-name     # Create session
# Ctrl+A then D             # Detach
screen -ls                 # List sessions
screen -r session-name     # Reattach

# Tmux
tmux new -s session-name   # Create session
# Ctrl+B then D             # Detach
tmux ls                    # List sessions
tmux attach -t session-name # Reattach
```

## File Permissions

```bash
# Check permissions
ls -l file

# Make executable
chmod +x script.sh

# Change permissions (owner, group, others)
chmod 755 file             # rwxr-xr-x
chmod 644 file             # rw-r--r--
```

## Harbor Registry

```bash
# Login
podman login harbor.example.com

# Pull image
podman pull harbor.example.com/library/image:tag

# Tag image
podman tag local-image:tag harbor.example.com/project/image:tag

# Push image
podman push harbor.example.com/project/image:tag
```

## Useful Aliases (Add to ~/.bashrc)

```bash
alias ll='ls -lh'
alias la='ls -lah'
alias gpu='nvidia-smi'
alias pods='podman ps'
alias podsa='podman ps -a'
```

## Getting Help

```bash
# Command help
man command                # Manual page
command --help            # Quick help
```

## Service URLs

[Content to be added: Actual URLs]

- **Harbor**: `https://harbor.example.com`
- **LDAP Account Manager**: `https://lam.example.com`
- **Web Portal**: `https://portal.example.com`
