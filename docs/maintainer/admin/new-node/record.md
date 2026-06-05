sudo apt update
sudo apt upgrade
sudo apt install stow net-tools uidmap
sudo apt install nfs-common autofs sssd sssd-tools libnss-sss libpam-sss libsss-sudo sssd-ldap ldap-utils 
edit /etc/sssd/sssd.conf ##Notice that different use different autofs configuration in LDAP
make sure sssd.conf is chmod 600
edit /etc/nsswitch.conf
```
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the `glibc-doc-reference' and `info' packages installed, try:
# `info libc "Name Service Switch"' for information about this file.
#
passwd:         files systemd sss
group:          files systemd sss
shadow:         files systemd sss
gshadow:        files systemd

hosts:          files dns
networks:       files

protocols:      db files
services:       db files sss
ethers:         db files
rpc:            db files

netgroup:       nis sss
automount:      sss
sudoers:        files sss
subid:          sss
```
edit /etc/pam.d/common_session
```
session optional pam_mkhomedir.so skel=/etc/skel umask=0077
```
edit /etc/ssh/sshd_config
```
AuthorizedKeysCommand /usr/bin/sss_ssh_authorizedkeys %u
AuthorizedKeysCommandUser root
PasswordAuthentication no
```
sudo systemctl restart sssd
sudo systemctl restart sshd
# Ubuntu 26.04 use sudo-rs which doesn't support sudoers from sssd
sudo update-alternatives --set sudo /usr/bin/sudo.ws
sudo systemctl restart autofs
sudo automount -m 
sudo apt-get -y install podman podman-compose
sudo ubuntu-drivers install --gpgpu
Find a correct version of `nvidia-utils-xxx-server` for the nvidia-smi and sudo apt install nvtop
sudo reboot

# NVIDIA Container Toolkit — allows Podman to pass GPU into containers via CDI
# URLs below may change, check: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
  sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update
sudo apt install nvidia-container-toolkit

# Verify CDI spec was generated (needed for nvidia.com/gpu=all in compose)
nvidia-ctk cdi list
# If empty, generate manually:
# sudo nvidia-ctk cdi generate --output=/var/run/cdi/nvidia.yaml
sudo add-apt-repository -y ppa:apptainer/ppa
sudo apt install -y apptainer
