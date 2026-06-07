# Taiwania 3

NCHC flagship CPU supercomputer.

| | |
|-|-|
| Access | [iService](../iservice.md) account |
| Login node | Intel `twnia3.nchc.org.tw`, AMD `twnia3a.nchc.org.tw` (port 22) |
| Transfer node | `t3-x1/t3-x2.nchc.org.tw` — SFTP, SCP, rsync |
| Scheduler | [Slurm](../slurm.md) |

## Hardware (per node)

| Node type | Count | CPU | GPU | RAM |
|-----------|-------|-----|-----|-----|
| Intel | 900 | 2× Xeon Platinum 8280L (56 cores) | — | 384 GB (780) / 768 GB (120) |
| AMD | 16 | 2× EPYC 7773X (128 cores) | — | 1 TB |

InfiniBand HDR interconnect. GPU nodes are not documented in the manual.

## Storage

| Path | Free quota | Notes |
|------|-----------|-------|
| `/home` | 100 GB | personal files |
| `/work` | 1.5 TB | scratch — **regularly auto-purged, not for long-term storage** |

Check usage: `/usr/lpp/mmfs/bin/mmlsquota -u $USER --block-size auto fs01 fs02`.

## Partitions

!!! warning
    This information can change. Always check the [official manual](https://man.twcc.ai/@TWCC-III-manual/H1bEXeGcu) for current values.

| Queue | Cores | Max walltime | Concurrent jobs |
|-------|-------|--------------|-----------------|
| `ctest` | 1–1120 | 2 h | 2 |
| `ct56` | 1–56 | 96 h | 25 |
| `ct224` | 57–224 | 96 h | 15 |
| `ct560` | 225–560 | 96 h | 10 |
| `ct2k` | 561–2240 | 72 h | 4 |
| `ct8k` | 2241–8400 | 72 h | 2 |
| `ct2k-amd` | 128–2048 | 168 h | 3 |

AMD jobs must use the `ct2k-amd` queue.
