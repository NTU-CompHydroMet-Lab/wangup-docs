# Shared Datasets

Shared datasets live on DS923+ at `/home/NAS/data`, mounted **read-only** on every server.

!!! warning "Never copy datasets into your home"
    They're large and shared. Reference them directly by path. Copy only a subset to local if you need it for I/O — see [Speed](overview.md#speed).

---

## What's There

!!! warning "Being reorganized"
    `/home/NAS/data` is mid-cleanup — the layout will change. Always check the directory directly for the current state:

    ```bash
    ls /home/NAS/data
    ```

Current top-level directories:

| Directory | Contents |
|-----------|----------|
| `RadarData` | Weather radar |
| `SatelliteData` | Satellite imagery |
| `GaugeData` | Rain-gauge records |
| `Nimrod` | UK Met Office Nimrod radar |
| `Projects` | Shared project data |
| `_Bronze`, `_Silver` | Layered data pipeline — see below |

### Bronze / Silver

New data follows a layered convention:

- **`_Bronze`** — raw, exactly as ingested from the source. Never modified.
- **`_Silver`** — cleaned and standardized, ready for analysis.

---

## Inspecting a Dataset

There is no central metadata catalog. Most scientific formats are self-describing — read the metadata straight from the file:

```bash linenums="1"
ncdump -h file.nc          # netCDF header: variables, dimensions, attributes
```

```python linenums="1"
import xarray as xr
xr.open_dataset("/home/NAS/data/RadarData/file.nc").info()   # netCDF or zarr

import zarr
print(zarr.open("/home/NAS/data/.../store.zarr").info)       # zarr store
```

---

## Using a Dataset

Reference paths directly in your scripts:

```python linenums="1"
import xarray as xr
ds = xr.open_dataset("/home/NAS/data/RadarData/sample.nc")
```

For faster random access during training, copy the subset you need to local, then remove it when done:

```bash linenums="1"
rsync -avP /home/NAS/data/RadarData/subset/ /home/$USER/subset/
```

---

## Requesting a Dataset

Contact the admin with the dataset name, source URL, and estimated size. Large downloads need approval and a place in the Bronze/Silver layout.
