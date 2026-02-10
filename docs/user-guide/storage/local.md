# Local Storage

Fast local disk for temporary work.

---

## Overview

Each server has local disk storage for temporary, high-performance work.

| Feature | Value |
|---------|-------|
| Path | `/home/<username>` |
| Backup | No |
| Quota | None (be considerate) |
| Shared | No (unique per server) |
| Speed | SSD speed (~500MB/s) |

**Important:** Local storage is NOT backed up and NOT shared between servers.

---

## When to Use Local

**Use local for:**
- Temporary processing files
- Dataset copies during training
- Cache files
- Intermediate results
- Build artifacts

**Use NAS for:**
- Important code
- Final results
- Long-term storage

---

## Directory Structure

Recommended organization:
```text linenums="1"
/home/<username>/
├── scratch/           # Temporary work
├── cache/             # Cached data
└── tools/             # Personal tools/scripts
```

Create scratch directory:
```bash linenums="1"
mkdir -p ~/scratch
```

---

## Performance Benefits

Local disk is faster for I/O intensive operations:

| Operation | NAS | Local |
|-----------|-----|-------|
| Sequential read | 110 MB/s | 500 MB/s |
| Random read | 50 MB/s | 300 MB/s |
| Latency | 5-10ms | <1ms |

**When it matters:**
- Loading training data
- Reading/writing checkpoints frequently
- Processing large files
- Compiling code

---

## Best Practices

### Using Local Effectively

Copy data to local before training:
```bash linenums="1"
# Copy dataset
rsync -av /home/NAS/data/dataset/ ~/scratch/dataset/

# Run training
python train.py --data ~/scratch/dataset

# Clean up
rm -rf ~/scratch/dataset
```

### Regular Cleanup

Local disk is limited. Clean regularly:
```bash linenums="1"
# Check usage
du -sh ~/*

# Remove old scratch files
rm -rf ~/scratch/*

# Clean package caches
conda clean --all
pip cache purge
```

### Storage Etiquette

- Don't fill up local disk
- Clean up after jobs finish
- Remove failed experiment files
- Check usage if disk space warnings appear

Check disk usage:
```bash linenums="1"
df -h /home
du -sh ~
ncdu ~
```

---

## Common Workflow

Typical pattern for training:
```bash linenums="1"
# 1. Copy data to local
rsync -av /home/NAS/data/dataset/ ~/scratch/dataset/

# 2. Run training (fast I/O from local)
python train.py \
  --data ~/scratch/dataset \
  --checkpoint-dir /home/NAS/homes/<username>/checkpoints/

# 3. Clean up
rm -rf ~/scratch/dataset
```

Benefits:
- Fast data loading during training
- Checkpoints saved to persistent NAS
- Clean local disk after completion

---

## Common Issues

### Disk full
Check what's using space:
```bash linenums="1"
du -sh ~/* | sort -h
ncdu ~
```

Clean up:
- Old scratch files
- Package caches
- Failed experiments

### Files not on other servers
Local storage is per-server. Files on `up4090:/home/username/` won't appear on `up3090:/home/username/`.

Use NAS for files needed across servers.

### Data loss
Local storage is not backed up. Important files must be on NAS.

---

## Storage Comparison

| Aspect | NAS | Local |
|--------|-----|-------|
| Speed | Slower | Faster |
| Backup | Yes | No |
| Shared | Yes | No |
| Persistent | Yes | Yes (but not backed up) |
| Quota | 100GB | None (be considerate) |

**Rule of thumb:** Important = NAS, Temporary = Local
