# Hydrometerology Lab Computing Documentation

Welcome to the Hydrometerology Lab computing infrastructure documentation. This guide will help you get started with our computing resources and learn how to effectively use them for your research.

## Quick Navigation

### For New Users

If you're new to the lab, start here:

1. [Welcome & Introduction](getting-started/welcome.md) - Learn about our infrastructure
2. [Getting Your Account](getting-started/account-setup.md) - Set up your lab account
3. [SSH & Remote Access](basic-usage/ssh-setup.md) - Connect to lab servers
4. [Using VSCode](basic-usage/vscode.md) - Set up your development environment

### Common Tasks

- **Need to run a quick experiment?** Check out [Simple GPU Servers](computing/gpu-servers.md)
- **Processing large datasets?** See [CPU-Intensive Server](computing/threadripper.md)
- **Running jobs on HPC?** Start with [Preparing for Taiwan HPC](hpc/preparing.md)
- **Looking for specific commands?** Visit the [Quick Reference](reference/quick-ref.md)

### For Maintainers

System administration and infrastructure documentation can be found in the [Maintainer Documentation](maintainer/core-server.md) section.

## Infrastructure Overview

Our lab maintains several computing servers and storage systems:

- **Core Server**: Central authentication and services (LDAP, Harbor Registry, MQTT, etc.)
- **NAS Storage**: 80TB for data and home directories
- **GPU Servers**: Three servers with NVIDIA GPUs for deep learning and computation
- **Threadripper Server**: High-core-count CPU server for data processing
- **Taiwan HPC Access**: For large-scale computational tasks

## Getting Help

If you encounter issues or have questions:

- Check the [FAQ](reference/faq.md) for common problems
- Contact the lab system administrator
- Ask senior lab members

---

**Ready to get started?** Head to [Welcome & Introduction](getting-started/welcome.md) to begin!
