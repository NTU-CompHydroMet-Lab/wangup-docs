# SSH & Remote Access

## What is SSH?

SSH (Secure Shell) is the standard way to securely connect to remote Linux servers. You'll use SSH to access all of our lab's computing resources.

[Content to be added: Simple explanation of SSH]

## Generating SSH Keys

SSH keys provide secure, password-less authentication to servers.

### On Windows

[Content to be added: Using PowerShell or WSL to generate keys]

### On macOS/Linux

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

[Content to be added: Full walkthrough with explanations]

### Understanding Your Keys

[Content to be added: Public vs private key, security best practices]

## Uploading Your Public Key

Once you've generated your SSH key pair, you need to upload your **public key** to the LDAP Account Manager.

### Steps

1. [Content to be added: Log in to LDAP Account Manager]
2. [Content to be added: Navigate to SSH keys section]
3. [Content to be added: Paste your public key]
4. [Content to be added: Save and verify]

!!! warning
    Never share your private key! Only upload your public key (the `.pub` file).

## Configuring Your SSH Config File

The SSH config file makes connecting to servers much easier by storing connection settings.

### Location

- **Linux/macOS**: `~/.ssh/config`
- **Windows**: `C:\Users\YourUsername\.ssh\config`

### Example Configuration

```
# GPU Server 1 - i7 + 3080 Ti
Host gpu1
    HostName [IP or hostname]
    User your-username
    IdentityFile ~/.ssh/id_ed25519

# GPU Server 2 - i9 + 4090
Host gpu2
    HostName [IP or hostname]
    User your-username
    IdentityFile ~/.ssh/id_ed25519

# GPU Server 3 - 5950 + 3090
Host gpu3
    HostName [IP or hostname]
    User your-username
    IdentityFile ~/.ssh/id_ed25519

# Threadripper - CPU Server
Host threadripper
    HostName [IP or hostname]
    User your-username
    IdentityFile ~/.ssh/id_ed25519
```

[Content to be added: More detailed explanation]

## Connecting to Servers

Once your SSH keys are uploaded and config is set up:

```bash
ssh gpu1
```

[Content to be added: Troubleshooting common issues]

## First Connection

[Content to be added: What to expect on first login, accepting host key]

## Troubleshooting

### Permission Denied (publickey)

[Content to be added: Common fixes]

### Connection Timeout

[Content to be added: Network issues, VPN requirements if any]

### Host Key Verification Failed

[Content to be added: How to handle host key changes]

---

**Next Step**: Set up [VSCode for Remote Development](vscode.md)
