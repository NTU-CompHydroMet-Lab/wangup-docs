# Hydrometerology Lab Computing Documentation

This repository contains the documentation for the Hydrometerology Lab's computing infrastructure, including guides for users and maintainers.

## Documentation Structure

- **Getting Started**: For new lab members
- **Basic Usage**: SSH, VSCode, Linux basics, data storage
- **Computing Resources**: GPU servers and Threadripper usage
- **Containerization**: Docker, Podman, and Harbor registry
- **HPC**: Using Taiwan's national HPC systems
- **Maintainer Documentation**: System administration guides
- **Reference**: Glossary, FAQ, quick reference, and resources

## Local Development

### Prerequisites

- Python 3.8 or higher
- [uv](https://github.com/astral-sh/uv) (recommended) or pip

### Setup with uv (Recommended)

```bash
# Install uv if you haven't already
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone the repository
git clone <repository-url>
cd wangup-doc

# Install dependencies
uv pip install -r pyproject.toml

# Serve the documentation locally
uv run mkdocs serve
```

The documentation will be available at `http://localhost:8000`

### Setup with pip

```bash
# Clone the repository
git clone <repository-url>
cd wangup-doc

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -e .

# Serve the documentation locally
mkdocs serve
```

## Building the Documentation

```bash
# With uv
uv run mkdocs build

# With pip (in activated venv)
mkdocs build
```

The built site will be in the `site/` directory.

## Deployment Options

### Option 1: GitHub Pages (Recommended for Public Access)

GitHub Pages provides free hosting with automatic HTTPS and is easy to set up:

**Pros:**
- Free hosting
- Automatic HTTPS
- Easy updates via git push
- Good for external access
- Built-in CI/CD with GitHub Actions

**Cons:**
- Repository must be public (or GitHub Pro for private)
- Depends on external service

**Setup:**

1. Update `mkdocs.yml` with your actual repository URL:
```yaml
repo_url: https://github.com/yourusername/wangup-doc
```

2. Deploy to GitHub Pages:
```bash
# With uv
uv run mkdocs gh-deploy

# With pip
mkdocs gh-deploy
```

3. Enable GitHub Pages in repository settings (Settings → Pages)

The documentation will be available at `https://yourusername.github.io/wangup-doc/`

### Option 2: Core Server Container (Recommended for Internal/Private Access)

Deploy as a container on your Core server alongside other services:

**Pros:**
- Complete control
- Private access (within lab network)
- Integrates with existing infrastructure
- Can use LDAP authentication if needed

**Cons:**
- Requires maintenance
- Need to manage updates manually
- Requires server resources

**Setup:**

1. Create `Dockerfile`:
```dockerfile
FROM nginx:alpine

# Copy built documentation
COPY site/ /usr/share/nginx/html/

# Expose port
EXPOSE 80
```

2. Add to your Docker Compose stack:
```yaml
# Add to your Core server's docker-compose.yml
services:
  docs:
    build: /path/to/wangup-doc
    container_name: lab-docs
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.docs.rule=Host(`docs.lab.example.com`)"
      - "traefik.http.services.docs.loadbalancer.server.port=80"
    networks:
      - traefik_network
    restart: unless-stopped
```

3. Build and deploy:
```bash
# Build the docs
uv run mkdocs build

# Build and start the container
docker-compose up -d docs
```

### Option 3: Hybrid Approach

- Use GitHub Pages for general user documentation
- Keep sensitive maintainer documentation in a separate private repository on your Core server

## Recommendation

**For your use case, I recommend GitHub Pages** because:

1. **Ease of Use**: Simple `mkdocs gh-deploy` command to update
2. **No Maintenance**: GitHub handles hosting, HTTPS, uptime
3. **Fast Access**: Global CDN, accessible from anywhere
4. **Version Control**: Documentation updates are tied to git commits
5. **Free**: No cost, no server resources needed

The maintainer documentation sections are clearly marked and can be in the same repository since they're just guides (not actual credentials or sensitive data). If you have truly sensitive information (passwords, internal IPs, etc.), keep those in a separate private document, not in this public-facing documentation.

**Use the Core server container only if:**
- You need LDAP authentication for documentation access
- Documentation must not be publicly accessible
- You want to integrate with internal services

## Contributing

When adding new content:

1. Create markdown files in the appropriate `docs/` subdirectory
2. Update `mkdocs.yml` navigation if adding new pages
3. Test locally with `mkdocs serve`
4. Commit and push changes

## Customization

- **Update URLs**: Search for `[To be added]` placeholders throughout the docs and fill in:
  - Server hostnames
  - Service URLs (Harbor, LDAP Account Manager, etc.)
  - Contact information

- **Add Content**: Many sections have `[Content to be added]` markers where you should add specific details about your infrastructure

- **Theme**: Modify colors and features in `mkdocs.yml` under the `theme` section

## License

[Add your license here]
