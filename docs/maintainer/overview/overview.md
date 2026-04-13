# Maintainer Overview

Reference for maintaining WangUp lab infrastructure — compute, storage, services, sensors, and cloud.

---

## Infrastructure

### Compute

See [Machines](../hardwares/machines/machines.md) for hardware details and [Network](../hardwares/network/network.md) for topology.

| Hostname | CPU | GPU | RAM | External IP | Internal IP |
|----------|-----|-----|-----|-------------|-------------|
| **up3080** | Intel i7-11700 | RTX 3080 Ti | 126 GB | 140.112.13.236 | — |
| **up4090** | Intel i7-12700 | RTX 4090 | 126 GB | 140.112.13.91 | 192.168.250.91 |
| **up3090** | AMD Ryzen 9 5950X | RTX 3090 | 78.5 GB | 140.112.13.64 | 192.168.250.64 |
| **ripper** | AMD Threadripper 7965WX | — | 256 GB | — | 192.168.250.100 |

### Storage

| Unit | Capacity | Internal IP | Mounts |
|------|----------|-------------|--------|
| [DS923+](../services/nas/nas-webui.md) | 83.7 TB | 192.168.250.139 | `homes` → `/home/NAS/homes`, `data` → `/home/NAS/data` |
| [DS1823xs+](../services/nas/nas-webui.md) | 35 TB | 192.168.250.182 | `homes` → `/home/NAS/house` (primary user home) |

NAS volumes are NFS-mounted on all compute nodes via autofs.

### Network Topology

![Topology](../../infrastructures/infra-topo.svg)

---

## Services

All services run on the internal network. External access is via Traefik.

| Service | Purpose | Docs |
|---------|---------|------|
| OpenLDAP + PLA | Central user authentication | [LDAP Server](../services/ldap/ldap-server.md) |
| Synology DSM | Storage management | [NAS Web UI](../services/nas/nas-webui.md) |
| Traefik | Reverse proxy + TLS termination | [Traefik](../services/traefik/traefik.md) |
| Harbor | Container image registry | [Harbor](../services/harbor/harbor-registry.md) |
| InfluxDB | Sensor time-series storage | [InfluxDB](../services/influx/influx.md) |
| PostgreSQL | Relational database | [Postgres](../services/postgres/pg.md) |
| EMQX | MQTT broker for sensor ingestion | [EMQX](../services/emqx/emqx.md) |
| Discord Bot | Lab notifications | [Discord](../services/discord/discord.md) |

---

## Identity & Access

All compute nodes authenticate via **SSSD → OpenLDAP**. Manage users through [PLA](https://account.lab.wangup.org).

- **User accounts** — defined in LDAP, propagate to all nodes automatically via SSSD.
- **NAS access** — must be granted per-user in DSM. Group permissions are not inherited inside rootless Podman containers.
- **Rootless Podman** — every user needs `subuid`/`subgid` ranges configured on each compute node.

---

## Cloud Dependencies

| Provider | Role | Docs |
|----------|------|------|
| Cloudflare | DNS + Let's Encrypt DNS-01 challenge for Traefik TLS | [Cloudflare](../cloud/cloudflare/cloudflare.md) |
| Google GCP | — | [GCP](../cloud/gcp/gcp.md) |
| SquareSpace | — | [SquareSpace](../cloud/sspace/sspace.md) |

---

## Sensors

Weather sensors push data over MQTT to [EMQX](../services/emqx/emqx.md), stored in [InfluxDB](../services/influx/influx.md).

| Device | Model | Docs |
|--------|-------|------|
| Disdrometer | OTT Parsivel2 | [Parsivel](../hardwares/sensors/parsivel.md) |
| Rain gauge (large) | OTT Pluvio L | [Pluvio L](../hardwares/sensors/pluviol.md) |
| Rain gauge (small) | OTT Pluvio S | [Pluvio S](../hardwares/sensors/pluvios.md) |
| Weather station | Lufft WS100 | [WS100](../hardwares/sensors/ws100.md) |
| Ultrasonic wind | Theis Ultrasonic 3D | [Ultrasonic 3D](../hardwares/sensors/ultra.md) |
| Power backup | UPS | [UPS](../hardwares/ups/ups.md) |
