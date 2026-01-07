# Using SLURM

## What is SLURM?

SLURM (Simple Linux Utility for Resource Management) is the job scheduler used on most HPC systems, including Taiwan's national systems.

Unlike lab servers where you SSH in and run commands directly, on HPC you submit jobs to a queue and SLURM schedules when they run.

## Basic Concepts

### Partition/Queue

[Content to be added: Different types of nodes (GPU, CPU, memory, etc.)]

### Job

[Content to be added: A script that SLURM runs for you]

### Node

[Content to be added: Individual server in the HPC cluster]

## Key Commands

### `sinfo` - Cluster Information

```bash
sinfo
```

Shows available partitions and node status.

### `squeue` - Queue Status

```bash
# See all jobs in queue
squeue

# See only your jobs
squeue -u your-username
```

### `sbatch` - Submit a Job

```bash
sbatch job_script.sh
```

Submits a job script to the queue.

### `scancel` - Cancel a Job

```bash
scancel job-id
```

### `sacct` - Job Accounting

```bash
sacct
```

Shows information about completed jobs.

## Job Scripts

A SLURM job script is a bash script with special directives:

### Basic Example

```bash
#!/bin/bash
#SBATCH --job-name=my_job
#SBATCH --output=output_%j.txt
#SBATCH --error=error_%j.txt
#SBATCH --time=02:00:00
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G

# Load modules or activate environment
module load singularity

# Run your containerized application
singularity exec --nv my_image.sif python my_script.py
```

### Common SBATCH Options

| Option | Description | Example |
|--------|-------------|---------|
| `--job-name` | Name for your job | `--job-name=data_proc` |
| `--output` | Output file | `--output=out_%j.txt` |
| `--error` | Error file | `--error=err_%j.txt` |
| `--time` | Max runtime | `--time=24:00:00` |
| `--partition` | Queue to use | `--partition=gpu` |
| `--gres` | Generic resources (GPUs) | `--gres=gpu:2` |
| `--cpus-per-task` | CPUs per task | `--cpus-per-task=8` |
| `--mem` | Memory | `--mem=32G` |
| `--nodes` | Number of nodes | `--nodes=2` |

[Content to be added: More options specific to Taiwan HPC]

## Using Containers in SLURM

### With Singularity

```bash
#!/bin/bash
#SBATCH --job-name=container_job
#SBATCH --output=output_%j.txt
#SBATCH --time=01:00:00
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1

# Use --nv flag for GPU access
singularity exec --nv \
  --bind /scratch:/scratch \
  my_image.sif \
  python /workspace/train_model.py
```

## Monitoring Jobs

### Check Status

```bash
squeue -u your-username
```

### View Output

```bash
# While running (if output file exists)
tail -f output_12345.txt

# After completion
cat output_12345.txt
```

### Job Efficiency

[Content to be added: Checking if you requested appropriate resources]

## Best Practices

### 1. Test First

[Content to be added: Test on lab servers before HPC]

### 2. Request Appropriate Resources

[Content to be added: Don't over-request, blocks others]

### 3. Use Array Jobs

[Content to be added: For many similar jobs]

```bash
#SBATCH --array=1-10
```

### 4. Save Results Regularly

[Content to be added: Checkpoint your work]

## Example Workflows

[Content to be added: Complete examples for common tasks]

---

**Next Step**: Learn about [Environment Modules](modules.md)
