# Quick Reference

---

## Containers

**Registries and repos**

| Resource | Link |
|----------|------|
| Lab Harbor (web UI) | [registry.lab.wangup.org](https://registry.lab.wangup.org) |
| Containerfiles repo | [NTU-CompHydroMet-Lab/containerfiles](https://github.com/NTU-CompHydroMet-Lab/containerfiles) |

**Lab images**

| Image | Address |
|-------|---------|
| Base | `registry.lab.wangup.org/library/devel:0.6-cuda13.1.1` |
| Maintainer | `registry.lab.wangup.org/kilin/devel:0.6-cuda13.1.1` |

**Common commands**

| Task | Command |
|------|---------|
| Login to lab registry | `podman login registry.lab.wangup.org` |
| Pull an image | `podman pull <image>` |
| One-off shell | `podman run --rm -it <image> bash` |
| Start compose | `podman compose up -d` |
| Stop compose | `podman compose down` |
| Shell into running container | `podman exec -it <name> bash` |
| List containers | `podman ps -a` |
| Follow logs | `podman logs -f <name>` |
| Build image | `podman build -t <name>:<tag> .` |
| Push to Harbor | `podman push registry.lab.wangup.org/<project>/<name>:<tag>` |
| Prune unused images | `podman system prune` |

---

## Storage

**Key paths on all servers**

| Path | What it is |
|------|-----------|
| `/home/NAS/house/<user>` | Your wangup NAS home — persists across all servers |
| `/home/NAS/home/<user>` | Your wangup26 NAS home — persists across all servers |
| `/home/NAS/data` | Shared read-only datasets |
| `/home/<user>` | Local home — fast but not shared |

---

## Services

| Service | Link | Docs |
|---------|------|------|
| Harbor Registry | [registry.lab.wangup.org](https://registry.lab.wangup.org) | [Harbor](services/harbor.md) |
| GitHub Organization | [NTU-CompHydroMet-Lab](https://github.com/NTU-CompHydroMet-Lab) | [GitHub](services/github.md) |
| Account Management (LDAP) | [account.lab.wangup.org](https://account.lab.wangup.org) | [LDAP](services/ldap.md) |
| Synology NAS wangup | — | [Synology](storage/synology.md) |
| Synology NAS wangup26  
