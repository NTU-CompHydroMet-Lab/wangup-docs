# New Compute Node Setup

Provisioning checklist for a new lab compute node. Steps are ordered — later ones
assume earlier ones. Section 5 (GPU) applies to GPU nodes only.

---

## 1. Network & base system

1. **Hostname & DNS** — set the FQDN (`nodeXX.lab.wangup.org`). Pin critical infra
   in `/etc/hosts`: LDAP, NAS, and Harbor. Pin Harbor to its **internal** IP so
   image pulls take the 10 GbE path, not the slow public one DNS returns:

    ```title="/etc/hosts"
    192.168.250.62 registry.lab.wangup.org
    ```

2. **Connectivity** — configure both the public IP and the internal switch IP.
3. **Time sync** — chrony or systemd-timesyncd. Required: SSSD/LDAP auth fails on
   clock skew.
4. **Persistent logs** — `Storage=persistent` in `/etc/systemd/journald.conf`.
5. **Update and install base packages:**

    ```bash linenums="1"
    sudo apt update && sudo apt upgrade
    sudo apt install stow net-tools uidmap \
        nfs-common autofs \
        sssd sssd-tools sssd-ldap libnss-sss libpam-sss libsss-sudo ldap-utils
    ```

---

## 2. Identity & access (SSSD + LDAP)

SSSD serves LDAP users, sudo rules, and SSH keys to the node.

1. Write `/etc/sssd/sssd.conf`, then **`chmod 600`** — SSSD refuses to start if the
   file is group- or world-readable:

    ```ini title="/etc/sssd/sssd.conf" linenums="1"
    [sssd]
    services = nss, pam, ssh, sudo
    domains = wangup

    [domain/wangup]
    id_provider = ldap
    auth_provider = ldap
    ldap_uri = ldaps://ldap.lab.wangup.org
    ldap_search_base = dc=wangup
    entry_cache_timeout = 0
    cache_credentials = True

    # Read-only bind account for looking up users and keys
    ldap_default_bind_dn = uid=reader,ou=people,dc=wangup
    ldap_default_authtok = <reader-bind-password>   # secret — do NOT commit the real value
    ldap_network_timeout = 3

    # SSH public keys live on the sshPublicKey attribute
    ldap_user_ssh_public_key = sshPublicKey

    ldap_schema = rfc2307
    ldap_tls_reqcert = never
    ldap_id_use_start_tls = False

    # Sudo rules from LDAP
    sudo_provider = ldap
    ldap_sudo_search_base = ou=sudoers,dc=wangup
    ldap_sudo_full_refresh_interval = 300
    ldap_sudo_smart_refresh_interval = 60
    ```

2. Point NSS at SSSD in `/etc/nsswitch.conf`:

    ```title="/etc/nsswitch.conf" linenums="1"
    passwd:         files systemd sss
    group:          files systemd sss
    shadow:         files systemd sss
    gshadow:        files systemd
    hosts:          files mdns4_minimal [NOTFOUND=return] dns
    networks:       files
    protocols:      db files
    services:       db files sss
    ethers:         db files
    rpc:            db files
    netgroup:       nis sss
    sudoers:        files sss
    automount:      sss
    subid:          sss
    ```

3. Auto-create home directories on first login — `/etc/pam.d/common-session`:

    ```linenums="1"
    session optional pam_mkhomedir.so skel=/etc/skel umask=0077
    ```

4. Serve SSH keys from LDAP and disable password login — `/etc/ssh/sshd_config`.
   Also move SSH off port 22:

    ```linenums="1"
    AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys %u
    AuthorizedKeysCommandUser root
    PasswordAuthentication no
    ```

5. Restart both services:

    ```bash linenums="1"
    sudo systemctl restart sssd sshd
    ```

6. Whitelist the new node's IP on **both** the Core Server and the NAS — they
   reject unknown hosts.

!!! warning "Ubuntu 26.04: sudo-rs doesn't read SSSD sudoers"
    26.04 defaults to `sudo-rs`, which ignores sudo rules from SSSD. Switch back to
    classic sudo or users get no sudo:

    ```bash linenums="1"
    sudo update-alternatives --set sudo /usr/bin/sudo.ws
    ```

---

## 3. Storage (NAS over autofs)

Autofs mounts NAS shares on demand under `/home/NAS`.

1. `/etc/auto.master` — delegate `/home/NAS` to a map file:

    ```title="/etc/auto.master"
    /home/NAS  /etc/auto.nas
    ```

2. `/etc/auto.nas` — one line per share (replace `192.168.x.x` with the NAS
   internal IP):

    ```title="/etc/auto.nas" linenums="1"
    data    -fstype=nfs,rw,hard,intr,rsize=8192,wsize=8192  192.168.x.x:/volume1/data
    homes   -fstype=nfs,rw,hard,intr,rsize=8192,wsize=8192  192.168.x.x:/volume1/homes
    ```

3. Restart and verify the mounts resolve:

    ```bash linenums="1"
    sudo systemctl restart autofs
    sudo automount -m
    ```

---

## 4. Containers

1. **subuid / subgid** — required for rootless Podman to map container UIDs into a
   host range. SSSD serves these via the `subid: sss` line in `nsswitch.conf`;
   confirm each user resolves.
2. Install the runtime:

    ```bash linenums="1"
    sudo apt install -y podman podman-compose
    ```

3. **Apptainer** — for HPC-style `.sif` images:

    ```bash linenums="1"
    sudo add-apt-repository -y ppa:apptainer/ppa
    sudo apt install -y apptainer
    ```

4. **Harbor** — the `/etc/hosts` pin from step 1.1 already routes pulls over the
   internal network. See [Harbor Registry](../../services/harbor/harbor-registry.md).

---

## 5. GPU (GPU nodes only)

1. Driver — reboot after install. Match `nvidia-utils-<ver>-server` to the driver
   so `nvidia-smi` works:

    ```bash linenums="1"
    sudo ubuntu-drivers install --gpgpu
    sudo apt install nvtop
    sudo reboot
    ```

2. **NVIDIA Container Toolkit** — lets Podman pass the GPU into containers via CDI.
   URLs change; check the
   [install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html):

    ```bash linenums="1"
    curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey \
      | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
    curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list \
      | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' \
      | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
    sudo apt update && sudo apt install nvidia-container-toolkit
    ```

3. Verify the CDI spec exists — `nvidia.com/gpu=all` in compose needs it:

    ```bash linenums="1"
    nvidia-ctk cdi list
    # if empty, generate it:
    sudo nvidia-ctk cdi generate --output=/var/run/cdi/nvidia.yaml
    ```

---

## 6. Maintenance & operations

- Unattended security upgrades.
- Monitoring agents (`node_exporter`, `nvidia_gpu_exporter`).
- MOTD / login banner: node info, docs link, contact channel.
- Add to the lab inventory: hostname, IPs, specs, purchase date, warranty.

---

## 7. Baseline tooling

- Common tools: `build-essential git tmux htop nvtop ncdu rsync`.
- A Python environment manager (`uv` or `mambaforge`).
- Dotfiles via `stow` (installed in step 1.5).
