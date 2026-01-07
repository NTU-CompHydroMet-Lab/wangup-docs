# Hardware & Resources Overview

## Infrastructure Diagram

[Content to be added: Consider adding a network/infrastructure diagram here]

## Core Server

**Role**: Central services and authentication

The Core server is the backbone of our infrastructure. It runs:

- **LDAP**: User authentication system
- **Harbor Registry**: Private container registry
- **EMQX**: MQTT broker for sensor data
- **LDAP Account Manager**: Web-based user management
- **InfluxDB**: Time-series database for sensor data
- **Traefik**: Reverse proxy for web services

!!! note
    Regular users don't directly interact with the Core server. It runs behind the scenes to provide services.

## Storage Systems

### Current NAS (80TB)

**Hostname**: [To be added]

Two main directories:

- **`/data`**: Shared datasets (ERA5, IMERG, radar, satellite, gauge data)
- **`/homes`**: User home directories (NAS home)

### Future Data NAS (18-bay)

[Content to be added: Plans for dedicated data NAS]

## Computing Servers

### GPU Servers - Simple Tasks

#### Server 1: i7 + RTX 3080 Ti
- **Hostname**: [To be added]
- **Purpose**: Initial verification, basic experiments
- **GPU**: NVIDIA RTX 3080 Ti
- **Special Notes**: Users have sudo access (via dedicated sudo account)

#### Server 2: i9 + RTX 4090
- **Hostname**: [To be added]
- **Purpose**: Heavier experiments, deep learning
- **GPU**: NVIDIA RTX 4090
- **Special Notes**: Users have sudo access (via dedicated sudo account)

#### Server 3: AMD 5950 + RTX 3090
- **Hostname**: [To be added]
- **Purpose**: General computation and experiments
- **GPU**: NVIDIA RTX 3090
- **Special Notes**: Users have sudo access (via dedicated sudo account)

### CPU Server - Data Processing

#### Threadripper 7965
- **Hostname**: [To be added]
- **Purpose**: CPU-intensive data processing
- **CPU**: AMD Threadripper 7965 (24 cores)
- **Special Notes**:
    - **No sudo access** for regular users
    - Use **rootless Podman** for containerized workflows
    - Sudo available inside your own containers

## Understanding the Two-Home System

Each user has two home directories:

1. **Local Home**: On each computing server (faster, but not shared)
2. **NAS Home**: On the NAS (shared across all servers, mounted via NFS)

[Content to be added: More details about when to use each]

## When to Use Which Server?

| Task | Recommended Server |
|------|-------------------|
| Quick data exploration | Any GPU server |
| Initial model training | GPU servers (i7, i9, or 5950) |
| Heavy deep learning | GPU servers with 4090 or 3090 |
| Large-scale data processing | Threadripper |
| Production runs | Taiwan HPC |

---

**Next Step**: Learn how to [Get Your Account](account-setup.md)
