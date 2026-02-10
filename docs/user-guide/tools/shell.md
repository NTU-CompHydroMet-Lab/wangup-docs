# Shell Tools

Essential command-line tools for remote work.

---

## Background Jobs

Running programs that continue after you disconnect.

### tmux

Terminal multiplexer. Best for interactive work and persistent sessions.

**Start new session:**
```bash linenums="1"
tmux new -s mysession
```

**Detach from session:**
Press `Ctrl+b`, then `d`

**List sessions:**
```bash linenums="1"
tmux ls
```

**Attach to session:**
```bash linenums="1"
tmux attach -t mysession
```

**Kill session:**
```bash linenums="1"
tmux kill-session -t mysession
```

**Basic commands:**

| Action | Key |
|--------|-----|
| Detach | `Ctrl+b` then `d` |
| New window | `Ctrl+b` then `c` |
| Next window | `Ctrl+b` then `n` |
| Previous window | `Ctrl+b` then `p` |
| Split horizontal | `Ctrl+b` then `"` |
| Split vertical | `Ctrl+b` then `%` |

### screen

Alternative to tmux. Simpler but less features.

**Start session:**
```bash linenums="1"
screen -S mysession
```

**Detach:**
Press `Ctrl+a` then `d`

**List sessions:**
```bash linenums="1"
screen -ls
```

**Reattach:**
```bash linenums="1"
screen -r mysession
```

### nohup

Run command immune to hangups. For non-interactive jobs.

**Basic usage:**
```bash linenums="1"
nohup python3 train.py > output.log 2>&1 &
```

**What this does:**
- `nohup` - Ignores disconnect signals
- `> output.log` - Redirects stdout to file
- `2>&1` - Redirects stderr to stdout
- `&` - Runs in background

**Check output:**
```bash linenums="1"
tail -f output.log
```

---

## Process Management

### Viewing Processes

**Your processes:**
```bash linenums="1"
ps aux | grep $USER
```

**All processes:**
```bash linenums="1"
htop                 # Interactive (recommended)
top                  # Basic viewer
ps aux               # Static list
```

**Find specific process:**
```bash linenums="1"
ps aux | grep python
pgrep -a python      # Simpler alternative
```

### Background Jobs

**Run in background:**
```bash linenums="1"
python3 script.py &
```

**List background jobs:**
```bash linenums="1"
jobs
```

**Bring to foreground:**
```bash linenums="1"
fg %1               # Brings job 1 to foreground
```

**Send to background:**
```bash linenums="1"
bg %1               # Resume job 1 in background
```

**Suspend current job:**
Press `Ctrl+z`, then use `bg` to continue in background

### Killing Processes

**By job number:**
```bash linenums="1"
kill %1             # Kill job 1
```

**By process ID:**
```bash linenums="1"
kill 12345          # Send SIGTERM
kill -9 12345       # Force kill (SIGKILL)
```

**Kill by name:**
```bash linenums="1"
pkill python3       # Kill all python3 processes
killall python3     # Alternative
```

!!! warning
    Be careful with `pkill` - it kills ALL matching processes.

---

## Log Management

### Output Redirection

**Save stdout:**
```bash linenums="1"
python3 script.py > output.log
```

**Save stderr:**
```bash linenums="1"
python3 script.py 2> errors.log
```

**Save both:**
```bash linenums="1"
python3 script.py > output.log 2>&1
```

**Append instead of overwrite:**
```bash linenums="1"
python3 script.py >> output.log 2>&1
```

### Monitoring Logs

**Follow log file:**
```bash linenums="1"
tail -f output.log              # Update as file grows
tail -f -n 100 output.log       # Last 100 lines + follow
```

**View last N lines:**
```bash linenums="1"
tail -n 50 output.log           # Last 50 lines
head -n 20 output.log           # First 20 lines
```

**Search logs:**
```bash linenums="1"
grep "error" output.log         # Find lines with "error"
grep -i "error" output.log      # Case-insensitive
grep -C 5 "error" output.log    # Show 5 lines context
```

---

## Useful Tools

### fd

Find files. Faster than `find`.

**Find by name:**
```bash linenums="1"
fd train.py                     # Find train.py
fd -e py                        # All .py files
fd "^test" -e py                # Python files starting with "test"
```

**Search in directory:**
```bash linenums="1"
fd config.yaml ~/projects       # Search in specific path
```

### rg (ripgrep)

Search file contents. Faster than `grep`.

**Basic search:**
```bash linenums="1"
rg "import torch"               # Find in current dir
rg "def train" -t py            # Search only Python files
rg -i "error"                   # Case-insensitive
```

**Show context:**
```bash linenums="1"
rg -C 3 "import torch"          # Show 3 lines before/after
```

### jq

Process JSON data.

**Pretty print:**
```bash linenums="1"
cat data.json | jq .
```

**Extract field:**
```bash linenums="1"
cat data.json | jq '.results[0].name'
```

### ncdu

Analyze disk usage interactively.

```bash linenums="1"
ncdu ~                          # Scan home directory
ncdu /home/NAS/homes/$USER      # Scan NAS home
```

Navigate with arrows, press `d` to delete.

---

## Git Basics

Essential for version control.

**Clone repository:**
```bash linenums="1"
git clone https://github.com/user/repo.git
```

**Check status:**
```bash linenums="1"
git status
git diff                        # View changes
```

**Save changes:**
```bash linenums="1"
git add file.py                 # Stage file
git commit -m "Fix bug"         # Commit
git push                        # Push to remote
```

**Update from remote:**
```bash linenums="1"
git pull
```

---

## Vim Basics

Text editor available on all servers.

**Open file:**
```bash linenums="1"
vim file.txt
```

**Modes:**
- **Normal mode** - Navigate (press `Esc`)
- **Insert mode** - Edit text (press `i`)
- **Command mode** - Save/quit (press `:`)

**Essential commands:**

| Action | Key |
|--------|-----|
| Enter insert mode | `i` |
| Exit insert mode | `Esc` |
| Save | `:w` |
| Quit | `:q` |
| Save and quit | `:wq` |
| Quit without saving | `:q!` |
| Delete line | `dd` (in normal mode) |
| Undo | `u` |

**Alternative editors:**
- `nano` - Simpler, shows commands at bottom
- VSCode Remote - GUI editor
