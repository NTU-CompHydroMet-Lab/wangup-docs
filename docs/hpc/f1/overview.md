# Forerunner 1

NCHC "創進一號" — a large CPU cluster (x86 + ARM) with a small GPU partition.

| | |
|-|-|
| Access | [iService](../iservice.md) account |
| Login node | x86 `f1-ilgn01/02.nchc.org.tw`, ARM `f1-nlgn01/02.nchc.org.tw` (port 22) |
| Transfer node | `f1-dtn01/02.nchc.org.tw` (port 22, SFTP) |
| Scheduler | [Slurm](../slurm.md), with job arrays |

## Hardware (per node)

| Node type | Count | CPU | GPU | RAM |
|-----------|-------|-----|-----|-----|
| x86 CPU | 552 | 2× Xeon Platinum 8480+ (112 cores) | — | 512 GB |
| x86 GPU | 6 | 2× Xeon Platinum 8480+ (112 cores) | 2× NVIDIA A40 | 512 GB |
| ARM CPU | 40 | 2× NVIDIA Grace (144 cores) | — | 240 GB |

## Storage

| Path | Total | Default quota | Notes |
|------|-------|---------------|-------|
| `/home` | 0.5 PiB (x86), 40 TiB (ARM) | 100 GB (50 GB trial) | personal files |
| `/work1`, `/work2` | 2 PiB each | 1.5 TB (plan-dependent) | **purged after 28 days idle; not backed up** |

Quotas expand up to 1 TB `/home` and 200 TB `/work`. Keep important files in `/home` — purged `/work` data is unrecoverable.

## Partitions

!!! warning
    This information can change. Always check the [official manual](https://man.twcc.ai/@f1-manual/manual) for current values.

| Queue | Cores | Max walltime | Concurrent jobs | Mem/core |
|-------|-------|--------------|-----------------|----------|
| `vscode` | 1–112 | 2 h | 1 | 4.3 GB |
| `jupyter` | 1–112 | 2 h | 1 | 4.3 GB |
| `rstudio` | 1–112 | 2 h | 1 | 4.3 GB |
| `desktop` | 1–112 | 2 h | 1 | 4.3 GB |
| `visual-dev` | 1–112 | 2 h | 1 | 4.3 GB |
| `visual` | 1–448 | 48 h | 1 | 4.3 GB |
| `development` | 1–1120 | 8 h | 1 | 4.3 GB |
| `ct112` | 1–112 | 96 h | 28 | 4.3 GB |
| `ct448` | 113–448 | 96 h | 24 | 4.3 GB |
| `ct1k` | 449–1120 | 64 h | 6 | 4.3 GB |
| `ct2k` | 1121–2240 | 48 h | 4 | 4.3 GB |
| `ct4k` | 2241–4480 | 48 h | 1 | 4.3 GB |
| `ct8k` | 4481–8960 | 48 h | 1 | 4.3 GB |
| `cf112` | 1–112 | 96 h | 14 | 8.9 GB |
| `cf448` | 113–448 | 96 h | 12 | 8.9 GB |
| `cf1k` | 449–1120 | 64 h | 3 | 8.9 GB |
| `cf2k` | 1121–2240 | 48 h | 2 | 8.9 GB |
| `cf4k` | 2241–4480 | 48 h | 1 | 8.9 GB |
| `hm112` | 1–112 | 96 h | 2 | 18.13 GB |
| `hm448` | 113–448 | 96 h | 1 | 18.13 GB |
| `arm-dev` | 1–1440 | 2 h | 1 | ARM (pilot) |
| `arm144` | 1–144 | 48 h | 10 | ARM (pilot) |
| `arm576` | 145–576 | 48 h | 4 | ARM (pilot) |
| `arm1440` | 577–1440 | 48 h | 2 | ARM (pilot) |
