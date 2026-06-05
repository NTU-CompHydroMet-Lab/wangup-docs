# New Compute Node Setup

Following need to be configured for a new node:

## Network & Base System
1. Hostname and DNS resolution (set FQDN, e.g. `nodeXX.lab.wangup.org`; pin critical infra in `/etc/hosts`: LDAP, NAS, Harbor)
2. Internet connectivity (Public IP, Internal Switch IP)
3. Time synchronization (chrony or systemd-timesyncd) — required for LDAP/SSSD
4. Persistent journald logging (`Storage=persistent`)

## Identity & Access
5. SSSD for LDAP user, sudo permission, and SSH keys
   - Edit `/etc/sssd/sssd.conf` (chmod 600)
   - Edit `/etc/nsswitch.conf`
6. Add new node IP to whitelist on Core Server **and** NAS
7. Change SSH port and disable password SSH login
8. Firewall rules (ufw/nftables) — allow custom SSH port, restrict to internal subnet

## Storage
9. Autofs for NAS NFS mount (`/etc/auto.master`, `/etc/auto.nas`)
10. Local scratch directory convention (e.g. `/scratch`) separated from NAS

## Containers
11. subuid / subgid (for rootless Podman)
12. Container runtime install (Podman / Docker)
13. Harbor registry client setup (trust CA, login, default registry)

## GPU (GPU nodes only)
14. NVIDIA driver
15. nvidia-container-toolkit
16. nvidia-persistenced enabled

## Maintenance & Operations
17. Unattended security upgrades
18. Monitoring agent (node_exporter, nvidia_gpu_exporter)
19. MOTD / login banner (node info, docs link, contact channel)
20. Add to lab inventory (hostname, IP, specs, purchase date, warranty)

## Quality of Life (baseline image)
21. Common tools: `build-essential, git, tmux, htop, nvtop, ncdu, rsync`
22. Python environment manager pre-installed (`uv` or `mambaforge`)
