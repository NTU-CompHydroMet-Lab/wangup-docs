# New Compute Node Setup

Following need to be configured for a new node:
1. SSSD for LDAP user and sudo permission and ssh keys

/etc/sssd/sssd.conf chmod to 600
```/etc/sssd/sssd.conf
[sssd]
# 在 services 加入 ssh
services = nss, pam, ssh, sudo
domains = wangup

[domain/wangup]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldaps://ldap.lab.wangup.org
ldap_search_base = dc=wangup
entry_cache_timeout = 0
cache_credentials = True

# 使用ssh-reader 帳號來讀取所有資料
ldap_default_bind_dn = uid=reader,ou=people,dc=wangup
ldap_default_authtok = danisocute
ldap_network_timeout = 3

# 指定 SSH Key 的屬性名稱 (OpenLDAP 預設是 sshPublicKey)
ldap_user_ssh_public_key = sshPublicKey

# 其他標準設定
ldap_schema = rfc2307
ldap_tls_reqcert = never
ldap_id_use_start_tls = False

# Sudo Provider 設定
sudo_provider = ldap
ldap_sudo_search_base = ou=sudoers,dc=wangup
ldap_sudo_full_refresh_interval = 300
ldap_sudo_smart_refresh_interval = 60
```
edit /etc/nsswitch.conf
```/etc/nsswitch.conf
# /etc/nsswitch.conf
#
# Example configuration of GNU Name Service Switch functionality.
# If you have the `glibc-doc-reference' and `info' packages installed, try:
# `info libc "Name Service Switch"' for information about this file.

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
```
2. Add new node IP in the whitelist in Core Server
4. Add new node IP in the whitelist in NAS 
3. Autofs for NAS NFS mount
- **安裝**: `sudo apt install autofs`
    
- **編輯主設定檔 `/etc/auto.master`**： 告訴系統：「當有人存取 `/home/NAS` 底下的東西時，去讀取 `/etc/auto.nas` 的規則。」
    
    Bash
    
    ```
    # 加入這一行
    /home/NAS  /etc/auto.nas
    ```
    
- **建立對應檔 `/etc/auto.nas`**： 告訴系統：「`data` 資料夾掛載到哪裡，`homes` 資料夾掛載到哪裡。」
    
    Bash
    
    ```
    # 格式: <目錄名> <掛載參數> <NFS路徑>
    data    -fstype=nfs,rw,hard,intr,rsize=8192,wsize=8192  192.168.x.x:/volume1/data
    homes   -fstype=nfs,rw,hard,intr,rsize=8192,wsize=8192  192.168.x.x:/volume1/homes
    ```
    
- **重啟服務**: `sudo systemctl restart autofs`
5. subuid/subgid
6. Internet (Public IP, Internal Switch IP)
7. Change ssh port and turn off password ssh 

