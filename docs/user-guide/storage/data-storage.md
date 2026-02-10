# Data Storage

Guide to storing and managing data on lab NAS.

---

## Storage Locations

| Location | Path | Purpose | Backup | Quota |
|----------|------|---------|--------|-------|
| Home | `/home/NAS/homes/<username>` | Personal code, configs | Yes | 100GB |
| Data | `/home/NAS/Data/` | Shared datasets | Yes | Shared |
| Scratch | `/home/<username>` | Temporary files | No | - |

**Important:** Only `/home/NAS/` paths are persistent and backed up.

---

## Accessing NAS

### Via SSH
NAS mounts automatically when you SSH into any server:
```bash linenums="1"
ssh up4090
cd /home/NAS/homes/<username>
ls -lah
```

### Via VSCode Remote
Open folder on `/home/NAS/homes/<username>` when connected to server.
See [First Program](onboard/first-program.md) for VSCode setup.

### Via Web UI
Login to [NAS Web UI](https://wangup.synology.me:6110) with your credentials.
Use **File Station** to browse files.

---

## File Organization

Recommended structure:
```text linenums="1"
/home/NAS/homes/<username>/
├── projects/          # Your code
├── models/            # Trained models
└── results/           # Experiment results

/home/NAS/Data/
├── datasets/          # Shared datasets (read-only for most users)
└── shared/            # Shared project files
```

---

## Best Practices

### Storage Guidelines
- Store code and models on NAS (`/home/NAS/`)
- Use local scratch for temporary files (`/home/<username>`)
- Clean up scratch regularly - not backed up
- Share large datasets in `/home/NAS/Data/` instead of duplicating

### Performance Tips
- NAS is network storage - slower than local disk
- Load datasets to local scratch for training
- Write checkpoints to NAS for persistence
- Use `rsync` for large file transfers

Example workflow:
```bash linenums="1"
# Copy dataset to local scratch for faster access
rsync -av /home/NAS/Data/dataset/ /home/<username>/scratch/dataset/

# Run training (reads from local, writes checkpoints to NAS)
python train.py --data /home/<username>/scratch/dataset \
                --checkpoint-dir /home/NAS/homes/<username>/models/

# Clean up when done
rm -rf /home/<username>/scratch/dataset
```

---

## Permissions

### Home Directory
- Full access to your own home
- No access to other users' homes
- Readable by admins for support

### Shared Data
- `/home/NAS/Data/datasets/` - Read-only for most users
- `/home/NAS/Data/shared/` - Write access for team members
- Contact admin for permission changes

Check permissions:
```bash linenums="1"
ls -lah /home/NAS/homes/<username>
```

---

## Quotas

Check your disk usage:
```bash linenums="1"
du -sh /home/NAS/homes/<username>
```

Check NAS space:
```bash linenums="1"
df -h /home/NAS
```

If you hit quota limits, clean up:
- Old experiment results
- Unused model checkpoints
- Cached datasets

---

## Common Issues

### Cannot access NAS
Check if NAS is mounted:
```bash linenums="1"
ls /home/NAS/homes/<username>
```

If empty or error, contact admin.

### Permission denied
Verify you're accessing your own directory:
```bash linenums="1"
whoami  # Check your username
pwd     # Verify current path
```

### Slow file access
NAS is network storage. For I/O intensive work:
1. Copy data to local scratch
2. Run training/processing
3. Copy results back to NAS

---

## Technical Details

For hardware specs and configuration, see [Storage Infrastructure](../infrastructures/storage.md).
