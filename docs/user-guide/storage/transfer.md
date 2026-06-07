# Transferring Data

Move files between your laptop and the lab servers. All methods run over SSH — the same key and config from [Account Registry](../onboard/account.md#login-into-server). For copying *within* a server (NAS ↔ local), see [Storage Overview](overview.md#managing-files).

---

## rsync — recommended

`rsync` is the default for anything large or repeated: it resumes after an interruption, copies only changed files, and is scriptable.

```bash linenums="1"
# Laptop → server
rsync -avP ./localdir/ up4090:/home/NAS/house/$USER/localdir/

# Server → laptop
rsync -avP up4090:/home/NAS/house/$USER/results/ ./results/
```

| Flag | Meaning |
|------|---------|
| `-a` | Archive — preserve permissions, timestamps, symlinks |
| `-v` | Verbose |
| `-P` | Progress + resume partial transfers |
| `-z` | Compress in transit — helps on the 1 GbE `up3080` link |
| `-h` | Human-readable sizes |
| `-n` / `--dry-run` | Preview what would change without copying anything |
| `--exclude '<pat>'` | Skip matching paths, e.g. `--exclude '.venv' --exclude '__pycache__'` |
| `--delete` | Mirror — delete files at the destination missing from the source (use with care) |

!!! tip "Trailing slash matters"
    A trailing `/` on the source copies the directory's *contents*; without it, the directory itself nests inside the destination. `rsync -avP dir/ dest/` and `rsync -avP dir dest/` do different things — run with `-n` first to confirm.

For `ripper` (no public IP), rsync tunnels through the jump host automatically as long as your `~/.ssh/config` has its `ProxyJump` entry.

For the full reference, see the [rsync man page](https://download.samba.org/pub/rsync/rsync.1.html) or this [rsync tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-rsync-to-sync-local-and-remote-directories).

---

## scp — quick one-offs

Simpler than rsync, but no resume. Fine for a single small file.

```bash linenums="1"
scp ./file.txt up4090:/home/NAS/house/$USER/      # to server
scp up4090:/home/NAS/house/$USER/file.txt ./      # from server
scp -r ./dir up4090:/home/NAS/house/$USER/        # recursive
```

---

## SFTP — interactive or GUI

SFTP runs over SSH and suits browsing a remote tree or drag-and-drop.

Command line:

```bash linenums="1"
sftp up4090
# get remote.txt   put local.txt   ls   cd   bye
```

GUI: [FileZilla](https://filezilla-project.org/). Create a site with:

| Field | Value |
|-------|-------|
| Protocol | SFTP - SSH File Transfer Protocol |
| Host | server IP — see [Specs](../../infrastructures/computing-specs.md) |
| Port | 22 |
| Logon type | Key file |
| Key file | `~/.ssh/WangupServer` |

FileZilla connects directly to public-IP servers (`up3080`, `up3090`, `up4090`). For `ripper`, use `rsync`/`scp` from the command line instead — the `ProxyJump` is awkward in the GUI.

---

## Browser — Synology Web UI

For an occasional file without a terminal, or to share a download link with someone **outside** the lab, use the [Synology Web UI](synology.md). It goes over HTTPS, can't resume, and may relay through QuickConnect — not for bulk transfers.

---

## Which to Use

| Situation | Use |
|-----------|-----|
| Large or repeated transfer | `rsync` |
| One small file | `scp` |
| Browsing / drag-and-drop GUI | SFTP / FileZilla |
| No terminal, or sharing with an outsider | [Web UI](synology.md) |
