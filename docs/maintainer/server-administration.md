# Server Administration

!!! warning "Maintainer Documentation"
    This section is intended for system administrators and future maintainers.

## Computing Servers Overview

All computing servers (GPU servers and Threadripper) share a similar configuration:

- Ubuntu [version to be added]
- SSSD for LDAP authentication
- NFS mount for NAS
- Centralized user management

## SSSD Configuration

SSSD (System Security Services Daemon) connects the servers to the central LDAP server for authentication.

### Configuration File

Location: `/etc/sssd/sssd.conf`

[Content to be added: Actual configuration]

```ini
[sssd]
services = nss, pam
config_file_version = 2
domains = lab.example.com

[domain/lab.example.com]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldap://core.example.com
ldap_search_base = dc=lab,dc=example,dc=com
...
```

### Troubleshooting SSSD

```bash
# Check SSSD status
sudo systemctl status sssd

# Restart SSSD
sudo systemctl restart sssd

# Clear SSSD cache
sudo sss_cache -E

# Test user lookup
getent passwd username

# Debug mode
sudo sssd -i -d 9
```

## NFS Configuration

The NAS is mounted via NFS on all computing servers.

### Mount Configuration

Location: `/etc/fstab`

[Content to be added: Actual mount configuration]

```
nas.example.com:/volume1/homes  /nas/homes  nfs  defaults  0  0
nas.example.com:/volume1/data   /data       nfs  ro,defaults  0  0
```

### NFS Troubleshooting

```bash
# Check mounts
mount | grep nfs

# Remount
sudo mount -a

# Check NFS server connectivity
showmount -e nas.example.com
```

## User Management

### Adding a New User

Users are managed centrally in LDAP:

1. Use LDAP Account Manager web interface
2. Create user with appropriate groups
3. Set initial password
4. User will appear on all servers automatically via SSSD

[Content to be added: Detailed steps]

### User Home Directories

Each user gets:

1. **Local home**: Created automatically on first login
2. **NAS home**: Must be created manually on NAS

[Content to be added: Script or procedure for creating NAS homes]

### Disabling a User

[Content to be added: Procedure for disabling users]

## Sudo Access Management

### GPU Servers

GPU servers have a dedicated sudo account that students can access:

[Content to be added]

- How the sudo account is configured
- How users access it
- Limitations and restrictions

### Threadripper

No sudo access for regular users. Rootless Podman is used instead.

## GPU Management

### NVIDIA Driver Installation

[Content to be added]

- Driver version
- CUDA version
- Installation procedure
- Updating drivers

### Monitoring GPU Usage

```bash
# Install monitoring tools
sudo apt install nvtop

# Real-time monitoring
nvidia-smi -l 1
```

## System Updates

### Regular Updates

[Content to be added]

- Update schedule
- Testing procedure
- Notification to users

### Kernel Updates

[Content to be added]

- Special considerations for NVIDIA drivers
- Testing before applying

## Storage Management

### Disk Quotas

[Content to be added]

- Are quotas enabled?
- Quota limits
- Enforcing quotas

### Cleaning Up

[Content to be added]

- Finding large files
- Cleaning temp directories
- User notification procedures

## Network Configuration

[Content to be added]

- IP address assignments
- DNS configuration
- Firewall rules (if any)

## Security

### SSH Configuration

[Content to be added]

- Key-only authentication
- Port configuration
- Fail2ban or similar

### Firewall

[Content to be added]

- iptables/ufw configuration
- Allowed ports

## Monitoring and Logging

[Content to be added]

- Log locations
- Monitoring tools
- Alerting setup

## Common Administrative Tasks

### Restarting a Server

[Content to be added]

- Pre-restart checklist
- Notifying users
- Post-restart verification

### Adding New Software

[Content to be added]

- System-wide installations
- Managing conflicts

### Performance Tuning

[Content to be added]

- CPU governor settings
- Network tuning
- Disk I/O optimization

---

**Next**: [Weather Sensor Systems](sensors.md)
