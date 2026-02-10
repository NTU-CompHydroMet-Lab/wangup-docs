# Understanding Your Environment

Guide to the computing environment you're working in.

---

## Where Are You?

You're on a **remote Linux server**, not your local computer.

**What this means:**
- Commands execute on the server, not your PC
- Files live on the server storage
- Multiple users share the same machine
- You access it via SSH or VSCode Remote

Check which server you're on:
```bash linenums="1"
hostname
whoami
```

---

## What Is Linux?

Linux is an operating system, like Windows or macOS.

**Key differences from Windows/Mac:**
- No graphical desktop by default
- Work via command line (terminal)
- Case-sensitive file names (`File.txt` ≠ `file.txt`)
- Different file paths (`/home/user` not `C:\Users\user`)

**Our setup:**
- Distribution: Ubuntu 22.04 LTS
- Shell: Bash
- Access: SSH, VSCode Remote

---

## The Terminal

The terminal is a text interface to run commands.

**Why use terminal instead of clicking?**
- Required for remote work (no GUI)
- Faster for repetitive tasks
- Can automate with scripts
- Standard for scientific computing

Basic commands:
```bash linenums="1"
pwd                    # Print current directory
ls                     # List files
cd projects            # Change directory
python3 script.py      # Run program
```

See [The Linux command line for beginners](https://ubuntu.com/tutorials/command-line-for-beginners#3-opening-a-terminal) for more tutorials.

---

## File System

### Directory Structure

| Path | What It Is | Example |
|------|------------|---------|
| `/home/NAS/homes/<user>` | Your home on NAS | `/home/NAS/homes/dani` |
| `/home/<user>` | Local home (temporary) | `/home/dani` |
| `/home/NAS/data/` | Shared datasets | `/home/NAS/data/Nimrod/` |

### Understanding Paths

**Absolute path:** Full path from root
```bash linenums="1"
/home/NAS/homes/dani/projects/
```

**Relative path:** Path from current location
```bash linenums="1"
cd ~/projects          # ~ means your home
cd ../Data             # .. means parent directory
```

### NAS vs Local Storage

**NAS (`/home/NAS/`):**
- Network storage
- Shared across all servers
- Persistent and backed up
- Slower (network latency)

**Local (`/home/<user>`):**
- Local disk on each server
- Faster access
- Not backed up
- Not shared between servers

!!! warning
    Use NAS for important files. Use local for temporary work or tools.

---

## What You Can Do

### Available Software
- Python 3.11+ (pre-installed)
- NVIDIA GPU drivers (pre-installed)
- Common tools: git, vim, tmux, htop
- Install user software in your home directory

Check Python version:
```bash linenums="1"
python3 --version
which python3
```

Check GPU drivers:
```bash linenums="1"
nvidia-smi
```

### Running Programs
Execute Python scripts:
```bash linenums="1"
python3 my_script.py
```

Run in background:
```bash linenums="1"
nohup python3 long_job.py > output.log 2>&1 &
```

Monitor GPU usage:
```bash linenums="1"
watch -n 1 nvidia-smi
```

---

## What You Cannot Do

### No Root Access
You **cannot** use `sudo` or install system packages.

**Why:**

* Multi-user system (security)
* System stability
* Prevents accidental damage

**What you can't do:**
```bash linenums="1"
sudo apt install package        # ❌ Not allowed
sudo systemctl restart service  # ❌ Not allowed
sudo reboot                     # ❌ Not allowed
```

**Solution:** Use containers for system-level needs.
See [Containers](../../containers/intro.md).

### Installing Software

**Can do:**

* Install Python packages in your environment
* Download and run user-space programs
* Use pip, conda, uv in your home

**Cannot do:**

* Install system packages (apt, yum)
* Modify system configuration
* Install drivers or kernel modules

---

## Python Environments

### Why Use Environments?
- Isolate project dependencies
- Avoid package conflicts
- Reproduce research
- Easy cleanup (delete environment)

### UV (Recommended)

Modern Python package manager. Fast and simple.

Install UV (if not available):
```bash linenums="1"
curl -LsSf https://astral.sh/uv/install.sh | sh
```
Visit [UV official](https://docs.astral.sh/uv/) for more details.

Create project with UV:
```bash linenums="1"
cd ~/projects/my_project
uv venv
source .venv/bin/activate
uv pip install numpy pandas torch
```

### Conda (Alternative)

Good for scientific packages and non-Python dependencies.

Check if available:
```bash linenums="1"
conda --version
```

Create environment:
```bash linenums="1"
conda create -n myenv python=3.11
conda activate myenv
conda install pytorch torchvision pytorch-cuda=12.1 -c pytorch -c nvidia
```

### Which to Use?

| Tool | Use When |
|------|----------|
| UV | Python-only projects, modern workflow |
| Conda | Need non-Python packages, CUDA libraries |
| venv | No special needs, standard library |

---

## Computing Resources

### Available Hardware

Check server specs: [Computing Specs](../../../infrastructures/computing/computing-specs.md)

| Resource | How to Check | Command |
|----------|--------------|---------|
| CPU | Core count | `nproc` or `lscpu` |
| RAM | Memory usage | `free -h` |
| GPU | GPU info | `nvidia-smi` |
| Disk | Storage usage | `df -h` |

### GPU Usage

List available GPUs:
```bash linenums="1"
nvidia-smi --list-gpus
```

Check what's running on GPU:
```bash linenums="1"
nvidia-smi
```

Monitor in real-time:
```bash linenums="1"
watch -n 1 nvidia-smi
```

### Using GPU in Python

PyTorch example:
```python linenums="1"
import torch
print(f"CUDA available: {torch.cuda.is_available()}")
print(f"GPU count: {torch.cuda.device_count()}")
print(f"Current GPU: {torch.cuda.get_device_name(0)}")

# Move tensor to GPU
x = torch.rand(1000, 1000).cuda()
```

---

## Monitoring System Resources

Understanding resource usage on shared servers.

### Checking System Load

View CPU and RAM usage:
```bash linenums="1"
htop                   # Interactive process viewer (press q to quit)
top                    # Another process viewer
free -h                # Memory usage
uptime                 # System load average
```

View GPU usage:
```bash linenums="1"
nvidia-smi             # GPU status and processes
watch -n 1 nvidia-smi  # Real-time monitoring
```

See who's logged in:
```bash linenums="1"
who                    # Currently logged in users
w                      # Users and what they're running
```

### Finding Available Resources

Check GPU memory details:
```bash linenums="1"
nvidia-smi --query-gpu=index,name,memory.used,memory.total --format=csv
```

Check your own processes:
```bash linenums="1"
ps aux | grep <username>
top -u <username>
```

### Resource Usage Guidelines

For proper resource usage and etiquette, see [Rules of Conduct](rules-of-conduct.md).

For large-scale jobs, use HPC cluster: [HPC Tutorial](../../hpc/overview.md)

### When Things Go Wrong

1. Check error messages carefully
2. Search error message + tool name (Google, ChatGPT)
3. Check if GPU is available (`nvidia-smi`)
4. Verify environment is activated
5. Ask lab members or admin
