# Storage Overview

Two Synology NAS units are mounted via NFS on every server, plus a local SSD on each machine.

## Locations

| Path | Backing store | Capacity | Shared | Speed |
|------|---------------|----------|--------|-------|
| `/home/NAS/house/<user>` | DS1823xs+ (wangup26) | 35 TB | All servers | 10 GbE¹ |
| `/home/NAS/data` | DS923+ (wangup) | 83.7 TB | All servers, read-only | 10 GbE¹ |
| `/home/<user>` | Local SSD | ~1.5 TB (shared on the machine) | This machine only | Local (fastest) |
| `/home/NAS/homes/<user>` | DS923+ (wangup) | 83.7 TB | Legacy — see below | 10 GbE¹ |

1. 10 GbE private switch on `up3090`, `up4090`, `ripper`. `up3080` is 1 GbE on the public switch (~110 MB/s).

!!! note "Initialize first"
    Your NAS homes must be activated by logging in once — see [Account Registry](../onboard/account.md#initialize-nas-storage).

`/home/NAS/homes` is the **legacy** home on the older NAS. New users ignore it — it exists only for existing users who haven't migrated to `house`.

---

## What Goes Where

| Data | Location | Why |
|------|----------|-----|
| Code, configs, notebooks | `/home/NAS/house/<user>`, in a git repo | Canonical, shared, recoverable via GitHub |
| Results you want to keep | `/home/NAS/house/<user>` | Shared across servers |
| Shared datasets | `/home/NAS/data` | Read-only — reference directly, never copy |
| Hot training data (many small files) | `/home/<user>` (local SSD) | Avoids NFS latency — see [Speed](#speed) |
| Container env, `/opt/venv`, caches, temp | `/home/<user>` (local) | Fast, disposable, automatic |

---

## Speed

Over the 10 GbE private network the NAS sustains ~600 MB/s — fast enough that you usually **don't** need to copy data to local. What matters is the access *pattern*, not the size:

- **Large sequential files** (netCDF, zarr) — read straight from NAS.
- **Many small files, random access** (image datasets, thousands of files per epoch) — NFS latency dominates. Copy that subset to local SSD first.
- **On `up3080`** (1 GbE, ~110 MB/s) — copying hot data to local is more often worth it.

This is the same reason `/opt/venv` lives on local disk — a venv is thousands of tiny files.

---

## Data Safety

**There is no backup. RAID5 is not a backup.**

The NAS uses RAID5, which survives a single failed disk. It does **not** protect against accidental deletion, overwrites, or a bad script — and there are **no snapshots**. `rm` is permanent and unrecoverable.

Protect your own work:

- **Code, configs, docs — keep in git and push to the [lab GitHub org](https://github.com/NTU-CompHydroMet-Lab).** GitHub is your real backup. Never leave code only on the NAS.
- **Structure projects so the bulk is reproducible** — code in git; datasets, outputs, and checkpoints in gitignored directories you can regenerate. Then there is nothing irreplaceable to lose:

```text
myproject/
  .git/                   # pushed to GitHub
  src/                    # code, in git
  pyproject.toml uv.lock  # in git — rebuilds /opt/venv
  data/                   # gitignored — reproducible
  outputs/                # gitignored — checkpoints, figures, logs
```

- **Raw datasets** in `/home/NAS/data` are re-downloadable from their source — that is their backup.
- For the rare artifact that is **not in git, not re-downloadable, and expensive to reproduce** (a long-trained checkpoint), there is no lab backup target — copy it off to your own machine.

There is **no per-user quota**. Space is shared on a small team — clean up what you no longer need.

---

## Privacy

NAS storage is **readable by every lab member** — your home and project files included. Local home (`/home/<user>`) is private to you, but disposable.

Keep credentials out of sight and never commit them to git. `chmod 700` anything sensitive:

```bash linenums="1"
chmod 700 ~/.ssh ~/.secrets
```

---

## Managing Files

```bash linenums="1"
ncdu /home/NAS/house/$USER     # what's using space
df -h | grep NAS               # mount sizes
mount | grep NAS               # verify mounts are up
```

Copy a dataset subset to local for faster I/O, and results back to NAS:

```bash linenums="1"
rsync -avP /home/NAS/data/subset/ /home/$USER/subset/
rsync -avP /home/$USER/results/ /home/NAS/house/$USER/results/
```

To move files between your laptop and the servers, see [Transferring Data](transfer.md).

---

## Troubleshooting

??? question "NAS mount is empty or missing"
    Verify the mount is up:
    ```bash
    mount | grep NAS
    df -h | grep NAS
    ```
    If nothing shows, contact the administrator — the NFS mount may need to be restarted.

??? question "Permission denied on NAS"
    Check you're accessing your own directory:
    ```bash
    whoami
    ls -lah /home/NAS/house/$USER
    ```
    If your directory doesn't exist, it needs to be initialized — see [Account Registry](../onboard/account.md#initialize-nas-storage).

??? question "Slow file access"
    See [Speed](#speed). For many-small-file workloads, copy the subset to `/home/$USER` (local SSD) first, then process locally.

---

For shared datasets, see [Shared Datasets](datasets.md). For browser access, see [Synology Web UI](synology.md).
