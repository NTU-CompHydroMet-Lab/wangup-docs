# Environment Modules

## What are Environment Modules?

HPC systems use environment modules to manage different software versions. Instead of installing software yourself, you load pre-installed modules.

## Basic Commands

### `module avail` - See Available Modules

```bash
module avail
```

Lists all available modules.

```bash
module avail python
```

Lists modules matching "python".

### `module load` - Load a Module

```bash
module load python/3.10
module load cuda/11.8
module load singularity
```

### `module list` - Show Loaded Modules

```bash
module list
```

### `module unload` - Unload a Module

```bash
module unload python/3.10
```

### `module purge` - Unload All

```bash
module purge
```

Unloads all modules (useful for clean start).

## Common Modules

[Content to be added: Specific to Taiwan HPC]

### Python

```bash
module load python/3.10
```

### CUDA

```bash
module load cuda/11.8
```

### Singularity/Apptainer

```bash
module load singularity
```

## Using Modules in Job Scripts

```bash
#!/bin/bash
#SBATCH --job-name=my_job
#SBATCH --time=01:00:00

# Load required modules
module purge
module load python/3.10
module load cuda/11.8
module load singularity

# Run your job
singularity exec --nv my_image.sif python script.py
```

## Module vs Containers

### When to Use Modules

- Quick tasks using standard software
- Software already optimized for the HPC
- Simple preprocessing

### When to Use Containers

- Complex dependency chains
- Reproducible research
- Software not available as module
- Same environment as your lab work

### Combining Both

You can use both! Load the singularity module, then run your container:

```bash
module load singularity
singularity exec my_container.sif python script.py
```

## Creating Module Loading Scripts

For convenience, create a script:

```bash
# save as setup.sh
module purge
module load python/3.10
module load cuda/11.8
module load singularity

# Use it in your jobs
source setup.sh
```

## Checking Module Details

```bash
# Show what a module does
module show python/3.10
```

---

**Next**: Explore [Maintainer Documentation](../maintainer/core-server.md) (for system administrators)
