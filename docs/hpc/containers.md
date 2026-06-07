# Containers on HPC

🚧

Run your lab image on HPC with Apptainer.

---

## Why Apptainer, not Podman

[HPC uses Apptainer (formerly Singularity). Rootless by design, reads Docker/OCI images, produces a single `.sif` file.]

## Build on the Lab, Run on HPC

[You have no root and no `--fakeroot` on HPC compute nodes — you cannot build images there. Build the `.sif` on a lab machine from a [lab image](../user-guide/containers/building.md), then transfer it over → [File Transfer](transfer.md).]

[commands: convert a lab image to `.sif`; what to bind-mount.]

## Running a Container

[`apptainer exec --nv image.sif <cmd>` (`--nv` exposes the GPU), `apptainer shell` to poke around, bind mounts for data.]

## Inside a Slurm Job

[Call `apptainer exec` from your `sbatch` script — see the [Quickstart](quickstart.md).]
