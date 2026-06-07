# Slurm

🚧

Slurm schedules jobs across the cluster's compute nodes — you request resources, it runs your job when they're free. See the [Quickstart](quickstart.md) for the fast path.

---

## Core commands

| Command | What it does |
|---------|--------------|
| `sinfo` | Partitions and node states |
| `squeue -u $USER` | Your jobs (`PD` = pending, `R` = running) |
| `sbatch job.sh` | Submit a batch job |
| `salloc ...` | Get an interactive allocation |
| `srun ...` | Run a step (inside an allocation, or directly) |
| `scancel <jobid>` | Cancel a job |
| `sacct -j <jobid>` | Accounting / finished-job info |

## Batch script directives

| Directive | Meaning |
|-----------|---------|
| `#SBATCH -A <project>` | Billing project |
| `#SBATCH -p <partition>` | Queue |
| `#SBATCH --gres=gpu:N` | N GPUs |
| `#SBATCH -N <n>` | Nodes |
| `#SBATCH -n <n>` | Tasks |
| `#SBATCH -c <n>` | CPU cores per task |
| `#SBATCH -t HH:MM:SS` | Walltime |
| `#SBATCH -o out.%j.log` | Stdout (`%j` = job ID) |

## Interactive vs batch

[`salloc` for quick tests on a compute node; `sbatch` for real runs. → [Quickstart](quickstart.md).]

## Array jobs

[`#SBATCH --array=1-10` runs many copies of one script, varying `$SLURM_ARRAY_TASK_ID`. 🚧]

## Monitoring a running job

[`squeue`, then `ssh` to the allocated node (or `srun --jobid`) and run `nvidia-smi`. 🚧]
