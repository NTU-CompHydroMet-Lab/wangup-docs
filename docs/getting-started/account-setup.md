# Getting Your Account

## Account Creation Process

[Content to be added: Step-by-step process for new users to get an account]

### Prerequisites

[Content to be added: What information/approvals needed]

### Request Process

[Content to be added: Who to contact, what information to provide]

## Understanding Your Account

### Username and Password

[Content to be added: Username format, initial password, how to change]

### Your Two Home Directories

Every user in the lab has two home directories:

#### 1. Local Home
- **Location**: On each computing server (`/home/your-username`)
- **Characteristics**: Fast local storage
- **Best for**: Temporary files, active work, cache
- **Note**: Not shared between servers

#### 2. NAS Home
- **Location**: On the NAS (`/nas/homes/your-username`)
- **Characteristics**: Network storage, shared across all servers
- **Best for**: Important files, long-term storage, shared data
- **Note**: Accessible from all servers

!!! warning
    Important files should be stored in your NAS home to ensure they're backed up and accessible from all servers.

## Web Portal Access

[Content to be added: How to access the web portal]

### Enabling NAS Access

[Content to be added: Steps to enable NAS home directory access via web portal]

## LDAP Account Manager

The LDAP Account Manager is a web interface where you can:

- Change your password
- Upload SSH public keys
- View account information
- [Content to be added: Other capabilities]

**URL**: [To be added]

## Initial Setup Checklist

- [ ] Receive account credentials
- [ ] Log in to web portal
- [ ] Enable NAS access
- [ ] Change initial password
- [ ] Generate SSH keys (see [SSH Setup](../basic-usage/ssh-setup.md))
- [ ] Upload SSH public key to LDAP Account Manager

---

**Next Step**: Set up [SSH & Remote Access](../basic-usage/ssh-setup.md)
