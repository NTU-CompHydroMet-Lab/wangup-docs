# Glossary

## Infrastructure Terms

**LDAP** (Lightweight Directory Access Protocol)
: A protocol for accessing and managing directory information services. In our lab, LDAP provides centralized user authentication across all servers.

**NAS** (Network Attached Storage)
: A file-level storage device connected to a network. Our lab uses Synology NAS systems for shared data and user home directories.

**NFS** (Network File System)
: A distributed file system protocol that allows file access over a network. Used to mount NAS directories on computing servers.

**SSSD** (System Security Services Daemon)
: Software that allows Linux systems to authenticate against remote identity providers like LDAP.

**Traefik**
: A modern reverse proxy and load balancer that routes HTTP/HTTPS traffic to different services.

## Container Terms

**Container**
: A lightweight, standalone package that includes an application and all its dependencies.

**Image**
: A template used to create containers. Think of it as a snapshot of a filesystem.

**Docker**
: The most popular container platform. Requires root/sudo privileges.

**Podman**
: A Docker-compatible container tool that can run without root privileges (rootless).

**Rootless**
: Running containers without requiring administrator (root) privileges.

**Harbor**
: An open-source container registry. Our lab runs a private Harbor instance.

**Registry**
: A storage and distribution system for container images.

**Dockerfile**
: A text file with instructions for building a container image.

**Volume**
: Persistent storage for containers that survives container restarts/deletions.

## HPC Terms

**HPC** (High-Performance Computing)
: Large-scale computing systems designed for intensive computational tasks.

**SLURM**
: Simple Linux Utility for Resource Management - a job scheduler used on HPC systems.

**Job**
: A computational task submitted to an HPC scheduler.

**Queue/Partition**
: A group of nodes with specific characteristics (GPUs, memory, etc.) on an HPC system.

**Node**
: A single computer in an HPC cluster.

**Module**
: A system for managing different software versions on HPC systems.

**Singularity/Apptainer**
: A container platform designed for HPC environments (Apptainer is the new name for Singularity).

## Authentication Terms

**SSH** (Secure Shell)
: A protocol for secure remote login and command execution.

**SSH Key**
: A cryptographic key pair (public and private) used for authentication.

**Public Key**
: The shareable part of an SSH key pair, uploaded to servers.

**Private Key**
: The secret part of an SSH key pair, never shared.

**LDAP Account Manager (LAM)**
: A web-based interface for managing LDAP accounts and SSH keys.

## Networking Terms

**Port**
: A logical communication endpoint. Web servers typically use port 80 (HTTP) or 443 (HTTPS).

**Reverse Proxy**
: A server that forwards requests to other servers. Traefik is our reverse proxy.

**MQTT**
: A lightweight messaging protocol, used for our sensor data.

**EMQX**
: An MQTT broker (message server) used for collecting sensor data.

## Data Terms

**ERA5**
: A global atmospheric reanalysis dataset produced by ECMWF.

**IMERG**
: Integrated Multi-satellitE Retrievals for GPM - a NASA precipitation dataset.

**Time-Series Database**
: A database optimized for time-stamped data. InfluxDB is our time-series database.

**InfluxDB**
: An open-source time-series database used for storing sensor data.

## Linux Terms

**Terminal/Shell**
: A command-line interface for interacting with Linux.

**Bash**
: The most common Linux shell.

**Home Directory**
: A user's personal directory, usually `/home/username`.

**Root**
: The administrator account with full system privileges.

**Sudo**
: A command that allows running other commands with administrator privileges.

**Path**
: The location of a file or directory in the filesystem.

**Environment Variable**
: A named value that can affect how programs run.

## GPU Terms

**GPU** (Graphics Processing Unit)
: Originally for graphics, now widely used for parallel computing and AI.

**CUDA**
: NVIDIA's parallel computing platform and programming model.

**nvidia-smi**
: NVIDIA System Management Interface - a tool for monitoring GPU usage.

## Sensor Terms

**MQTT Topic**
: A hierarchical namespace for MQTT messages, like `lab/weather/sensor1/temperature`.

**Broker**
: A server that receives and forwards MQTT messages. EMQX is our broker.

**Publish/Subscribe**
: A messaging pattern where senders (publishers) send messages to topics, and receivers (subscribers) receive them.
