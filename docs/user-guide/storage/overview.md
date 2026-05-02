# Storage Overview

Two Synology NAS units are mounted via NFS on all servers, plus local disk on each machine.

| Path | NAS | Capacity | Purpose |
|------|-----|----------|---------|
| `/home/NAS/house/<user>` | DS1823xs+ | 35 TB | Primary user home |
| `/home/NAS/data` | DS923+ | 83.7 TB | Shared datasets (read-only) |
| `/home/NAS/homes/<user>` | DS923+ | 83.7 TB | Legacy home (being phased out) |
| `/home/<user>` | Local disk | — | Per-machine, not shared |

---

## What to Store Where

| Data | Location |
|------|----------|
| Code, models, results | `/home/NAS/house/<user>` |
| Active training data | `/home/<user>` (local — faster I/O) |
| Shared datasets | `/home/NAS/data` — reference directly, never copy |
| Temporary files | `/home/<user>` |

---

## NAS vs Local

| | NAS | Local |
|-|-----|-------|
| Shared across servers | Yes | No |
| Persists across sessions | Yes | Yes |
| Speed | ~600 MB/s | Faster |

NAS is network storage. For I/O-heavy work (training, preprocessing large datasets), copy data to local first and write results back to NAS when done.

---

## Commands

```bash linenums="1"
ncdu /home/NAS/house/$USER       # Interactive usage breakdown
df -h | grep NAS                 # NAS mount sizes
mount | grep NAS                 # Verify mounts are up
```

For large transfers, use `rsync` instead of `cp` — it can resume if interrupted:

```bash linenums="1"
rsync -av /home/NAS/data/dataset/ /home/$USER/dataset/    # Copy to local
rsync -av /home/$USER/results/ /home/NAS/house/$USER/results/  # Save back to NAS
```

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
    NAS is network storage. For I/O-intensive work, copy data to `/home/$USER` (local) first, process locally, then copy results back to NAS.

---

For shared datasets, see [Shared Datasets](datasets.md). For managing files via browser, see [Synology Web UI](synology.md).
