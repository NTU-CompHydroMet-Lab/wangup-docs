# NAS Storage

Network-attached storage for persistent data.

---

## Overview

NAS provides persistent, backed-up storage shared across all servers.

| Feature | Value |
|---------|-------|
| Path | `/home/NAS/homes/<username>` |
| Backup | Yes (daily) |
| Quota | 100GB per user |
| Shared | Across all servers |
| Speed | Network speed (~100MB/s) |

---

## Accessing NAS

### Via SSH
NAS mounts automatically when you SSH into servers:
```bash linenums="1"
ssh up4090
cd /home/NAS/homes/<username>
ls -lah
```

### Via VSCode Remote
Open folder on `/home/NAS/homes/<username>` when connected to server.
See [First Program](../onboard/first-program.md) for setup.

### Via Web UI
Login to [NAS Web UI](https://wangup.synology.me:6110).
Use **File Station** to browse and manage files.

---

## Directory Structure

### Your Home Directory
```text linenums="1"
/home/NAS/homes/<username>/
├── projects/          # Your code
├── models/            # Trained models
└── results/           # Experiment results
```

### Shared Data
```text linenums="1"
/home/NAS/data/
├── datasets/          # Shared datasets (read-only)
└── shared/            # Shared project files
```

---

## Permissions

### Home Directory
- Full access to `/home/NAS/homes/<username>`
- No access to other users' homes
- Readable by admins for support

### Shared Data
- `/home/NAS/data/datasets/` - Read-only
- `/home/NAS/data/shared/` - Write access for team
- Contact admin for permission changes

Check permissions:
```bash linenums="1"
ls -lah /home/NAS/homes/<username>
```

---

## Quotas

Check your usage:
```bash linenums="1"
du -sh /home/NAS/homes/<username>
ncdu /home/NAS/homes/<username>
```

Check total NAS space:
```bash linenums="1"
df -h /home/NAS
```

If quota exceeded, clean up:
- Old experiment results
- Unused model checkpoints
- Cached datasets

---

## Best Practices

**Store on NAS:**
- Source code
- Trained models
- Final results
- Configuration files

**Don't store on NAS:**
- Temporary files
- Datasets during training (copy to local first)
- Cached data

**Performance tips:**
- NAS is slower than local disk
- Copy large datasets to local for training
- Write final results back to NAS
- Use `rsync` for large transfers

Example workflow:
```bash linenums="1"
# Copy dataset to local for training
rsync -av /home/NAS/data/dataset/ /home/<username>/scratch/dataset/

# Run training (reads from local, saves to NAS)
python train.py --data /home/<username>/scratch/dataset \
                --checkpoint-dir /home/NAS/homes/<username>/models/

# Clean up local copy
rm -rf /home/<username>/scratch/dataset
```

---

## Common Issues

### Cannot access NAS
Check if mounted:
```bash linenums="1"
ls /home/NAS/homes/<username>
df -h | grep NAS
```

If empty or error, contact admin.

### Permission denied
Verify path:
```bash linenums="1"
whoami
pwd
ls -lah /home/NAS/homes/<username>
```

### Slow access
NAS is network storage. For I/O intensive work:
1. Copy to local
2. Process locally
3. Copy results back

---

## Technical Details

For NAS hardware specs, see [Storage Infrastructure](../../infrastructures/storage.md).
