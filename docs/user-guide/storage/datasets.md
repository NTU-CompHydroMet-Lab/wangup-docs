# Shared Datasets

Shared datasets are stored on DS923+ at `/home/NAS/data` and mounted read-only on all servers.

!!! warning "Never copy datasets to your home directory"
    Datasets are large. Copying them wastes quota and NAS space. Reference them directly by path in your scripts.

---

## Available Datasets

| Dataset | Path | Description |
|---------|------|-------------|
| ERA5 | `/home/NAS/data/ERA5` | ECMWF reanalysis data |
| IMERG | `/home/NAS/data/IMERG` | GPM precipitation data |

---

## How to Use

Reference paths directly in your scripts:

```python linenums="1"
import xarray as xr

ds = xr.open_dataset("/home/NAS/data/ERA5/era5_2020.nc")
```

If you need to preprocess a dataset for faster I/O during training, copy only the subset you need to local storage:

```bash linenums="1"
rsync -av /home/NAS/data/ERA5/era5_2020.nc /home/$USER/era5_2020.nc
```

Remove it when done.

---

## Requesting a New Dataset

Contact the lab administrator with the dataset name, source URL, and estimated size. Large datasets require approval before download.
