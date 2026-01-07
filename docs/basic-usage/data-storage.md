# Data Storage & Organization

## Overview

Understanding our storage structure is crucial for efficient work and collaboration in the lab.

## NAS Structure

### `/data` - Shared Datasets

This directory contains shared datasets that everyone in the lab can access:

```
/data/
├── ERA5/           # ERA5 reanalysis data
├── IMERG/          # GPM IMERG precipitation data
├── radar/          # Weather radar data
├── satellite/      # Satellite observations
├── gauge/          # Rain gauge measurements
└── [other datasets]
```

**Characteristics**:
- Read-only for most users (or write-protected)
- Organized by data source
- [Content to be added: Access permissions, update frequency]

**Best Practices**:
- Don't copy large datasets to your home directory
- Reference data directly from `/data` in your scripts
- [Content to be added: More guidelines]

### `/homes` - User Directories

Each user has a home directory on the NAS:

```
/nas/homes/your-username/
```

**Characteristics**:
- Your personal space on the NAS
- Shared across all computing servers
- [Content to be added: Quota information]
- [Content to be added: Backup policy]

## Local Home Directories

Each computing server also has a local home directory:

```
/home/your-username/
```

**Characteristics**:
- Faster access (local SSD)
- Not shared between servers
- [Content to be added: Backup policy]

## Where to Store What?

| Data Type | Location | Reason |
|-----------|----------|--------|
| Raw datasets (ERA5, IMERG, etc.) | `/data` | Shared, no duplication |
| Your analysis scripts | NAS home | Accessible from all servers |
| Your processed results | NAS home | Long-term storage |
| Temporary processing files | Local home | Faster I/O |
| Active code being developed | Either | Your preference |
| Large intermediate files | Local home | Faster, but clean up when done |

## Best Practices

### 1. Don't Duplicate Large Datasets

❌ **Don't do this**:
```bash
cp -r /data/ERA5/2023/ ~/my_analysis/
```

✅ **Do this instead**:
```python
# In your analysis script
data_path = '/data/ERA5/2023/'
```

### 2. Organize Your Projects

[Content to be added: Suggested directory structure for research projects]

### 3. Clean Up Temporary Files

[Content to be added: Importance of cleaning up, disk quota]

### 4. Use Symbolic Links

[Content to be added: How to use symlinks to reference data]

## Checking Your Disk Usage

```bash
# Check your NAS home usage
du -sh /nas/homes/your-username

# Check your local home usage
du -sh ~

# See what's taking up space
du -h --max-depth=1 ~ | sort -h
```

## Data Transfer

### Between Your Computer and Servers

[Content to be added: Using scp, rsync, or VSCode]

### Between Servers

[Content to be added: Since NAS home is shared, files are automatically available]

## Future: Dedicated Data NAS

[Content to be added: Plans for 18-bay NAS to become primary data storage]

---

**Next Step**: Learn about [Simple GPU Servers](../computing/gpu-servers.md)
