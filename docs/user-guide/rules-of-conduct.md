# Rules of Conduct

Guidelines for shared computing resources.

---

## Core Rule

Lab servers are shared. Your actions affect everyone's research.

**Before using resources:**

1. Check availability (`htop`, `nvidia-smi`, `who`)
2. Use what you need, not what's available
3. Monitor your jobs
4. Clean up when done

---

## Resource Usage

| Resource | Check Command | Rule |
|----------|---------------|------|
| GPU | `nvidia-smi` | Check before starting jobs |
| CPU | `htop` | Don't use all cores without checking |
| RAM | `free -h` | Monitor memory usage |
| Disk | `df -h`, `ncdu` | Keep usage under quota |

Kill stuck processes:
```bash linenums="1"
ps aux | grep <username>
kill <PID>
```

---

## Storage

Monitor your home directory usage:
```bash linenums="1"
du -sh /home/NAS/homes/<username>
ncdu /home/NAS/homes/<username>
```

**Keep NAS usage under control:**

- Clean up temporary files regularly
- Remove old experiment results
- Don't copy shared datasets from `/home/NAS/data/` to your home

---

## Security

**Don't:**

- Share credentials
- Commit passwords/API keys
- Leave sessions unlocked
- Run untrusted code

**Do:**

- Use `.gitignore` for secrets
- Keep SSH keys secure
- Log out when done

---

## Communication

**Announce in lab chat:**

- Multi-day jobs
- Using all GPUs
- Server issues

**For help:**

- Technical issues: Contact admin
- Resource conflicts: Talk to users directly

---

## Violations

**Minor:** Friendly reminder, guidance

**Serious:** Repeated violations, resource hogging, security breaches

**Consequences:** Access restriction, or revocation

---

## Summary

Check first. Use what you need. Clean up. Communicate.
