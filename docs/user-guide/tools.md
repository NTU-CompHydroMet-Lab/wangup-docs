# Tools

🚧

Tools available on the servers. Click the tool name for official documentation.

---

## [tmux](https://github.com/tmux/tmux/wiki)

Terminal multiplexer. Keeps your session alive after SSH disconnects. Use it for any long-running job.

```bash linenums="1"
tmux new -s work        # Start new session named "work"
tmux ls                 # List sessions
tmux attach -t work     # Reconnect to session
```

Inside a session: `Ctrl+B D` to detach, `Ctrl+B %` to split pane.

---

## [uv](https://docs.astral.sh/uv/)

Python package and project manager. Replaces `pip`, `venv`, and `pip-tools`.

```bash linenums="1"
uv venv                         # Create virtual environment
source .venv/bin/activate       # Activate
uv pip install numpy torch      # Install packages
uv pip install -r requirements.txt
```

---

## [git](https://git-scm.com/doc)

Version control. Pre-installed on all servers.

```bash linenums="1"
git clone <url>
git status
git add . && git commit -m "message"
git push
```

---

## [nvtop](https://github.com/Syllo/nvtop)

Interactive GPU monitor. Shows utilization, memory, and running processes across all GPUs.

```bash linenums="1"
nvtop
```

Use this before starting a GPU job to check availability.

---

## [htop](https://htop.dev/)

Interactive CPU and RAM monitor. Shows per-core usage and all running processes.

```bash linenums="1"
htop
htop -u $USER       # Filter to your own processes
```

---

## [ncdu](https://dev.yorhel.nl/ncdu)

Interactive disk usage viewer. Useful for finding what's eating your NAS quota.

```bash linenums="1"
ncdu ~                          # Scan your home directory
ncdu /home/NAS/homes/$USER      # Scan your NAS home
```

---

## [fd](https://github.com/sharkdp/fd)

Fast file finder. Simpler syntax than `find`.

```bash linenums="1"
fd "*.py"                   # Find all Python files
fd "*.nc" /home/NAS/data    # Find NetCDF files in data directory
```

---

## [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)

Fast text search across files. Respects `.gitignore`.

```bash linenums="1"
rg "def train"              # Search for pattern in current directory
rg "loss" --type py         # Search only in Python files
```
