# Quick Reference

Fast lookup for addresses, paths, and common commands. Follow the links for detail.

---

## Servers

| Alias | Public IP | Internal IP | GPU |
|-------|-----------|-------------|-----|
| `up3080` | 140.112.13.236 | 192.168.250.236 | RTX 3080 Ti (12 GB) |
| `up3090` | 140.112.13.64 | 192.168.250.64 | RTX 3090 (24 GB) |
| `up4090` | 140.112.13.91 | 192.168.250.91 | RTX 4090 (24 GB) |
| `ripper` | — | 192.168.250.100 | — (Threadripper) |

`ripper` has no public IP — reach it with `ProxyJump up3090`. Full detail: [Specification](../infrastructures/computing-specs.md).

---

## Storage Paths

| Path | What it is |
|------|-----------|
| `/home/NAS/house/<user>` | Primary NAS home (wangup26) — shared across servers |
| `/home/NAS/data` | Shared datasets (wangup) — read-only |
| `/home/<user>` | Local SSD — fast, private, **disposable** |
| `/home/NAS/homes/<user>` | Legacy NAS home (wangup) — being phased out |

NAS is **not** backed up — keep code in git. See [Storage Overview](storage/overview.md).

---

## Lab Images

| Image | Address |
|-------|---------|
| Base | `registry.lab.wangup.org/library/devel:0.9-cuda13.1.1` |
| Maintainer | `registry.lab.wangup.org/kilin/devel:0.17-cuda13.1.1` |

Source: [containerfiles repo](https://github.com/NTU-CompHydroMet-Lab/containerfiles).

---

## Container Commands

| Task | Command |
|------|---------|
| Login to registry | `podman login registry.lab.wangup.org` |
| Pull an image | `podman pull <image>` |
| One-off shell | `podman run --rm -it <image> bash` |
| Start / stop compose | `podman compose up -d` / `podman compose down` |
| Shell into running container | `podman exec -it <name> bash` |
| List containers | `podman ps -a` |
| Follow logs | `podman logs -f <name>` |
| Install Python deps (inside) | `uv sync` |
| Build image | `podman build -t <name>:<tag> .` |
| Push to Harbor | `podman push registry.lab.wangup.org/<project>/<name>:<tag>` |
| Free disk (local) | `podman system prune` |

Full workflow: [Using Podman](containers/use-podman.md).

---

## Transfer

| Task | Command |
|------|---------|
| Copy large / repeated | `rsync -avP <src>/ <host>:<dest>/` |
| Copy one file | `scp <file> <host>:<dest>` |

See [Transferring Data](storage/transfer.md).

---

## Services

| Service | URL |
|---------|-----|
| Harbor registry | [registry.lab.wangup.org](https://registry.lab.wangup.org) |
| Account management (LDAP) | [account.lab.wangup.org](https://account.lab.wangup.org) |
| GitHub org | [NTU-CompHydroMet-Lab](https://github.com/NTU-CompHydroMet-Lab) |
| Synology wangup26 (home) | [QuickConnect](https://quickconnect.to/wangup26) |
| Synology wangup (data) | [QuickConnect](https://quickconnect.to/wangup) |
