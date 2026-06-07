# Nano4

NCHC generative-AI cluster (Taichung).

| | |
|-|-|
| Access | [iService](../iservice.md) account |
| Login node | `nano4.nchc.org.tw` (port 22) |
| Transfer node | `nano4.nchc.org.tw` port 2222 — SFTP, rsync+ssh |
| Scheduler | [Slurm](../slurm.md) |

## Hardware (per node)

| Node | CPU | GPU | RAM |
|------|-----|-----|-----|
| H200 | 2× Xeon Platinum 8480+ | 8× NVIDIA H200 | 2 TB |

Each GPU may use up to 12 CPU cores and 200 GB RAM.

## Storage

| Path | Free quota | Notes |
|------|-----------|-------|
| `/home` | 100 GB | personal files |
| `/work` | 1.5 TB | scratch — **regularly auto-purged, not for long-term storage** |

## Partitions

!!! warning
    This information can change. Always check the [official manual](https://man.twcc.ai/@nano4-manual/S1gcaUewbe) for current values.

| Partition | Min GPUs | Max walltime | Running / pending per user |
|-----------|----------|--------------|----------------------------|
| `dev` | 1 | 4 h | 10 / 10 |
| `8gpus` | 1 | 48 h | 8 / 10 |
| `16gpus` | 8 | 48 h | 6 / 8 |
| `32gpus` | 16 | 24 h | 4 / 6 |
| `64gpus` | 32 | 24 h | 2 / 4 |

GPU cap per account: 32 (64 on `64gpus`).

