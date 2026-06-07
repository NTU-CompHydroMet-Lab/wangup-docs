# Tools

Tools pre-installed on every server. The lab dev container ([`kilin/devel`](containers/lab-images.md)) adds more — zsh, Neovim, lazygit, bat, fzf, tectonic, Claude Code.

Each heading links to official docs. For tools worth learning properly, a **Learn** link points to a tutorial.

---

## Sessions

### [tmux](https://github.com/tmux/tmux/wiki)

Terminal multiplexer — keeps your session alive after SSH disconnects. Use it for any long-running job.

```bash linenums="1"
tmux new -s work        # start a session named "work"
tmux ls                 # list sessions
tmux attach -t work     # reconnect
```

Inside: `Ctrl+B D` to detach, `Ctrl+B %` to split. **Learn:** [a quick guide to tmux](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/).

---

## Python

### [uv](https://docs.astral.sh/uv/)

Fast Python package and project manager — replaces `pip`, `venv`, and `pip-tools`. In the lab container, `uv sync` installs into `/opt/venv`.

```bash linenums="1"
uv sync                       # install project deps from uv.lock
uv add numpy                  # add a dependency
uv run python script.py       # run in the project environment
```

---

## Version Control

### [git](https://git-scm.com/doc)

Version control — and your code's real backup once pushed to the [lab GitHub org](https://github.com/NTU-CompHydroMet-Lab).

```bash linenums="1"
git clone <url>
git add . && git commit -m "message"
git push
```

**Learn:** [Pro Git book](https://git-scm.com/book). The container also ships [lazygit](https://github.com/jesseduffield/lazygit), a terminal UI for git.

---

## Monitoring

### [htop](https://htop.dev/)

Interactive CPU and memory monitor.

```bash linenums="1"
htop
htop -u $USER       # only your own processes
```

### [nvtop](https://github.com/Syllo/nvtop)

Interactive GPU monitor — utilization, memory, and processes across all GPUs. Check it before starting a GPU job.

```bash linenums="1"
nvtop
```

### nvidia-smi

GPU snapshot. The **Processes** section shows who's using each GPU.

```bash linenums="1"
nvidia-smi
nvidia-smi --query-gpu=memory.used,memory.total --format=csv
```

---

## Disk and Search

### [ncdu](https://dev.yorhel.nl/ncdu)

Interactive disk-usage browser — find what's filling a disk.

```bash linenums="1"
ncdu /home/$USER             # local disk
ncdu /home/NAS/house/$USER   # NAS home
```

### [fd](https://github.com/sharkdp/fd)

Fast, simple file finder.

```bash linenums="1"
fd -e py                     # find Python files
fd -e nc /home/NAS/data      # netCDF files under data
```

### [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)

Fast text search across files; respects `.gitignore`.

```bash linenums="1"
rg "def train"               # search the current directory
rg "loss" --type py          # only Python files
```

### [fzf](https://github.com/junegunn/fzf)

Fuzzy finder — pipe anything into it, or use `Ctrl+R` for fuzzy command-history search.

```bash linenums="1"
vim "$(fzf)"                 # pick a file, open it
```

---

## Transfer

### [rsync](https://download.samba.org/pub/rsync/rsync.1.html)

Resumable, incremental file copy — the default for moving data between your laptop and the servers.

```bash linenums="1"
rsync -avP ./dir/ up4090:/home/NAS/house/$USER/dir/
```

See [Transferring Data](storage/transfer.md) for `scp` and `sftp` too. **Learn:** [rsync tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories).

---

## Data

### [jq](https://jqlang.github.io/jq/)

Command-line JSON processor — handy for `podman inspect` and API output.

```bash linenums="1"
podman inspect <name> | jq '.[0].Mounts'
```
