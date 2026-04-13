setting up nas
1. Inspect MAC address of network interface
2. Apply virtual IP for NAS
3. Connect to 10G switch (Optional)
4. Setting up LDAP client (Bind DN: uid=reader,ou=people,dc=wangup, Password=who is kawai?)
5. Enable home directory (Optional)
6. Setting group read permission
7. Setting user permission one by one (For podman container read permission, container don't have group permission when you ssh into it but user permission is inherit)
8. Enable NFSv4.1
9. Go to Control Panel -> Shared Folder -> Right click on Dir -> Edit -> Enable NFS Permission for machines
10. Setting up Firewall -> Enable NFS for specific machine -> Disable everything for every other machine.
11. For each machine. Edit autofs configuration that mount the new NAS.
12. Restart autofs (use systemctl reload autofs -> systemctl restart autofs)
13. Test accessibility
