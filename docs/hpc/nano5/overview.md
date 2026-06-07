# Nano5

NCHC "AI-Pilot" cluster (Taichung), Red Hat Enterprise Linux.

| | |
|-|-|
| Access | [iService](../iservice.md) account |
| Login node | `nano5.nchc.org.tw` (port 22) |
| Transfer node | `nano5.nchc.org.tw` port 2222 — SFTP, rsync+ssh |
| Scheduler | [Slurm](../slurm.md) |

## Hardware (per node)

| Node | CPU | GPU | RAM |
|------|-----|-----|-----|
| H100 | 2× Xeon Platinum 8480+ | 8× NVIDIA H100 | 2 TB |
| H200 | 2× Xeon Platinum 8480+ | 8× NVIDIA H200 | 2 TB |

## Storage

| Path | Free quota | Notes |
|------|-----------|-------|
| `/home` | 100 GB | personal files |
| `/work` | 1.5 TB | scratch — **regularly auto-purged, not for long-term storage** |

## Partitions

!!! warning
    This information can change. Always check the [official manual](https://man.twcc.ai/@AI-Pilot/manual) for current values.

| Partition | GPU type | Cap / account | Max walltime | Concurrent jobs |
|-----------|----------|---------------|--------------|-----------------|
| `dev` | H100 | 8 | 2 h | 2 |
| `normal` | H100 | 16 | 48 h | 2 |
| `normal2` | H200 | 16 | 48 h | 2 |
| `4nodes` | H100 | 32 | 12 h | 2 |
