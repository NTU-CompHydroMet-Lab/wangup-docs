# Harbor Registry

The lab registry, `registry.lab.wangup.org`.

Pin it to its internal address in each server's `/etc/hosts` (baked in at
provisioning) so pulls stay on the 10 GbE lab switch instead of routing out through
the campus gateway — the public path is ~60x slower.

```
192.168.250.62 registry.lab.wangup.org
```

Verify the path — want `192.168.250.62`:

```bash
curl -s -o /dev/null -w '%{remote_ip}\n' https://registry.lab.wangup.org/v2/
```

A cached `podman pull` finishes instantly without downloading, so it proves
nothing — check the IP, not the timing.

Not a `registries.conf` mirror: the cert has no IP SAN, so pointing at the IP would
force `insecure = true`; `/etc/hosts` keeps the name and TLS stays verified.
