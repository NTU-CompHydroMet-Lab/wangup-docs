# Quickstart

🚧

The fast path from an account to a running GPU job. This is the shape of every job on our HPC systems — for the exact login node, partition, and module names, see your machine's page (e.g. [Nano4](nano4/overview.md)) and its linked manual.

!!! note "Before you start"
    You need an [iService account](iservice.md). Placeholders like `<login-node>`, `<partition>`, and `<project>` come from your machine's manual.

---

## 1. Connect

```bash linenums="1"
ssh <username>@<login-node>
```

You land on a **login node** — for editing, submitting jobs, and light tasks only. Never run heavy compute here; that is what compute nodes are for.

---

## 2. See what's available

```bash linenums="1"
sinfo                      # partitions (queues) and node states
squeue -u $USER            # your queued and running jobs
```

---

## 3. Run interactively (quick tests)

Grab a GPU node for an interactive session:

```bash linenums="1"
salloc -A <project> -p <partition> --gres=gpu:1 -t 01:00:00
# ...you are now on a compute node...
nvidia-smi                 # confirm the GPU
```

Run `exit` to release the node.

---

## 4. Submit a batch job (real runs)

Put the job in a script:

```bash linenums="1" title="job.sh"
#!/bin/bash
#SBATCH -A <project>          # billing project
#SBATCH -p <partition>        # queue
#SBATCH --gres=gpu:1          # 1 GPU
#SBATCH -c 4                  # CPU cores
#SBATCH -t 02:00:00           # walltime HH:MM:SS
#SBATCH -o out.%j.log         # stdout (%j = job ID)

module load <module-you-need>
python train.py
```

Submit and watch it:

```bash linenums="1"
sbatch job.sh              # returns a job ID
squeue -u $USER            # PD = pending, R = running
tail -f out.<jobid>.log    # follow output
scancel <jobid>            # cancel if needed
```

---

## 5. Containers

HPC uses **Apptainer** (formerly Singularity), not Podman. Run your lab image as a `.sif`:

```bash linenums="1"
apptainer exec --nv myimage.sif python train.py   # --nv exposes the GPU
```

You build the `.sif` on a lab machine — you have no root on HPC — then transfer it over with [rsync](../user-guide/storage/transfer.md). Start from a [lab image](../user-guide/containers/building.md).

---

## Next

- [iService](iservice.md) — get and manage your account
- [Slurm](slurm.md) — full command and directive reference
- Your machine: [Nano4](nano4/overview.md) · [Nano5](nano5/overview.md) · [Forerunner1](f1/overview.md) · [Twnia3](twnia3/overview.md) · [TWCC](twcc/overview.md)
