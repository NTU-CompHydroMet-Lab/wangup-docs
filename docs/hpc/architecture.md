# Architecture

🚧

How a cluster is organized and how your work runs across it. Read this once before [Slurm](slurm.md).

---

## Login vs Compute Nodes

[Login node = where you land: edit, submit jobs, light tasks only. Compute nodes = where jobs actually run. Never run heavy compute on the login node.]

## The Scheduler

[Jobs wait in a queue; Slurm picks compute nodes for you. You request resources, it allocates them when free. → [Slurm](slurm.md).]

## Nodes, Cores, and Tasks

[What a node is. Cores / CPUs. A task = one process. The `-N` (nodes) / `-n` (tasks) / `-c` (cores per task) mental model.]

## Parallelism

### Multiple GPUs (one node)

[`--gres=gpu:N` to grab several GPUs on a single node; data-parallel training.]

### Multiple Nodes (MPI)

[When one node isn't enough; processes communicate across nodes via MPI. Most lab work does not need this.]

## Shared Filesystem

[Home and scratch are shared across all nodes. Where to stage data, where scratch lives, what's purged.]
