# Storage Infrastructure

Technical specifications for lab storage systems.

---

## NAS Overview

| Component | Specification |
|-----------|--------------|
| Model | Synology DS920+ |
| CPU | Intel Celeron J4125 |
| RAM | 8GB DDR4 (expandable to 20GB) |
| Network | 2x 1GbE |
| Capacity | 32TB usable (4x 10TB drives) |

---

## Disk Configuration

### Physical Disks

| Bay | Model | Capacity | Status |
|-----|-------|----------|--------|
| 1 | WD Red Plus | 10TB | Active |
| 2 | WD Red Plus | 10TB | Active |
| 3 | WD Red Plus | 10TB | Active |
| 4 | WD Red Plus | 10TB | Active |

### RAID Configuration
- **Type:** RAID 5 (Synology SHR-1)
- **Usable Capacity:** 32TB
- **Redundancy:** 1-disk fault tolerance
- **Performance:** ~110 MB/s sequential read/write

---

## Storage Volumes

| Volume | Mount Point | Size | Purpose |
|--------|-------------|------|---------|
| homes | `/home/NAS/homes/` | 10TB | User home directories |
| Data | `/home/NAS/Data/` | 20TB | Shared datasets |
| backup | - | 2TB | System backups |

---

## Network Configuration

### Mount Points
NAS accessed via NFS v4:
- Server: `192.168.250.250:/volume1`
- Protocol: NFSv4 over TCP
- Auto-mount on server boot

### Network Topology
```text linenums="1"
[NAS: 192.168.250.250]
        |
[Switch: 1GbE]
        |
[Compute Servers]
```

---

## Backup Strategy

### Automated Backups
- **Frequency:** Daily at 2:00 AM
- **Retention:** 7 daily, 4 weekly, 3 monthly
- **Method:** Synology Hyper Backup
- **Destination:** External USB drive (rotated weekly)

### Manual Snapshots
Admins can create snapshots before major changes.
Retention: 30 days

---

## Performance Metrics

### Throughput
- Sequential Read: 110 MB/s
- Sequential Write: 110 MB/s
- Random 4K Read: 50 MB/s
- Random 4K Write: 45 MB/s

### Latency
- Average: 5-10ms (network + disk)
- Peak hours: 15-20ms

---

## Monitoring

### Web Interface
Admin panel: [NAS Admin](https://wangup.synology.me:5001)

### Health Checks
```bash linenums="1"
# Check disk health
ssh admin@192.168.250.250
sudo mdadm --detail /dev/md2

# Check mount status on compute server
df -h /home/NAS
mount | grep NAS
```

---

## Maintenance

### Disk Health
- SMART tests: Weekly
- Scrubbing: Monthly
- Temperature monitoring: Continuous

### Capacity Planning
- Current usage: ~15TB / 32TB (47%)
- Growth rate: ~2TB/year
- Estimated full: 2032

---

## Disaster Recovery

### Hardware Failure
- 1 disk failure: RAID rebuilds automatically
- 2+ disk failure: Restore from backup
- NAS failure: Restore to new NAS from backup

### Data Recovery
Contact admin immediately if data loss occurs.
Do not write to the affected volume.

---

## Vendor Documentation

- [DS920+ Datasheet](https://www.synology.com/en-us/products/DS920+)
- [DSM User Guide](https://www.synology.com/en-us/support/download/DS920+#docs)
- [WD Red Plus Specs](https://www.westerndigital.com/products/internal-drives/wd-red-plus-sata-hdd)

---

## Admin Contacts

For storage issues:
- Hardware problems: Contact IT admin
- Permission issues: Contact lab manager
- Capacity requests: Contact lab manager
