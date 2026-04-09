# Storage Infrastructure

!!! warning "Maintainer Documentation"
    This section is intended for system administrators and future maintainers.

## Overview

The lab storage infrastructure consists of two Synology NAS systems with different roles.

## Current NAS (80TB)

**Model**: [To be added]
**Capacity**: 80TB
**Role**: User homes and shared data

### Storage Pool Configuration

[Content to be added]

- RAID configuration
- Drive configuration
- Performance characteristics

### Shared Folders

#### `/homes`

**Purpose**: User home directories

[Content to be added]

- Quota settings
- Permissions
- Backup policy
- Access controls

#### `/data`

**Purpose**: Shared research datasets

[Content to be added]

- Organization structure
- Access permissions (read-only for most users)
- Dataset inventory
- Update procedures

**Current Datasets**:

- ERA5 reanalysis data
- IMERG precipitation data
- Weather radar data
- Satellite observations
- Rain gauge measurements
- [Add more as applicable]

### NFS Configuration

[Content to be added]

- NFS version
- Export configuration
- Client permissions
- Performance tuning

```
# Example /etc/exports on NAS
/volume1/homes    *(rw,sync,no_subtree_check,root_squash)
/volume1/data     *(ro,sync,no_subtree_check)
```

### Backup Strategy

[Content to be added]

- What is backed up
- Backup schedule
- Backup destination
- Retention policy
- Restore procedures

## Future NAS (18-bay)

**Model**: [To be added]
**Capacity**: [To be added]
**Role**: Primary data storage
**Status**: Not yet configured

### Migration Plan

[Content to be added]

The goal is to split storage by function:

- **Old NAS (80TB)**: User homes
- **New NAS (18-bay)**: Research datasets

#### Migration Steps

[Content to be added]

1. Physical setup and RAID configuration
2. Data transfer planning
3. Service interruption scheduling
4. Data migration
5. NFS reconfiguration on compute servers
6. Testing and verification
7. Old data cleanup

#### Considerations

[Content to be added]

- Downtime requirements
- Data integrity verification
- User notification
- Rollback plan

## Synology Administration

### DSM Access

[Content to be added]

- Web interface URL
- Admin credentials storage
- 2FA setup

### Storage Manager

[Content to be added]

- Monitoring disk health
- RAID scrubbing schedule
- Hot spare configuration

### Package Management

[Content to be added]

- Installed packages
- NFS server configuration
- LDAP client configuration (if used)

## Dataset Management

### Adding New Datasets

[Content to be added]

Procedures for adding new data sources:

1. Determine storage location
2. Create directory structure
3. Set permissions
4. Update documentation
5. Notify users

### Data Update Procedures

[Content to be added]

For regularly updated datasets (ERA5, IMERG, etc.):

- Update frequency
- Automated update scripts (if any)
- Verification procedures
- Version management

### Data Retention

[Content to be added]

- Policies for old data
- Archival procedures
- Deletion procedures

## Monitoring

### Disk Health

[Content to be added]

```bash
# Example SMART monitoring
smartctl -a /dev/sdX
```

### Capacity Management

[Content to be added]

- Monitoring disk usage
- Alert thresholds
- Cleanup procedures

### Performance Monitoring

[Content to be added]

- I/O statistics
- Network throughput
- Identifying bottlenecks

## Backup and Disaster Recovery

### Backup Infrastructure

[Content to be added]

- Backup destination
- Backup software/method
- Schedule
- What is backed up

### Restore Procedures

[Content to be added]

- File-level restore
- Full system restore
- Testing restore procedures

### Disaster Recovery Plan

[Content to be added]

- What to do if NAS fails
- Data redundancy
- Recovery time objectives
- Recovery point objectives

## Troubleshooting

### Common Issues

[Content to be added]

#### Disk Failure

[Content to be added]

#### NFS Mount Issues

[Content to be added]

#### Performance Problems

[Content to be added]

#### Access Permission Issues

[Content to be added]

## Maintenance Tasks

### Regular Maintenance

[Content to be added]

- RAID scrubbing
- Firmware updates
- Backup verification
- Disk health checks

### Capacity Planning

[Content to be added]

- Growth rate analysis
- Forecasting capacity needs
- Expansion planning

---

**Next**: [Future Roadmap & Maintenance](roadmap.md)
