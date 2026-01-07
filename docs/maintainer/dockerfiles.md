# Service Dockerfiles & Design

!!! warning "Maintainer Documentation"
    This section is intended for system administrators and future maintainers.

## Philosophy

Our service architecture follows these principles:

1. **Containerization**: All services (except LDAP) run in containers
2. **Reproducibility**: Services can be rebuilt and redeployed from configuration
3. **Traefik Integration**: All web services are proxied through Traefik
4. **Data Persistence**: Data is stored in volumes, not containers
5. **Simplicity**: Keep configurations straightforward and well-documented

## Repository Structure

[Content to be added: Where service configurations are stored]

```
/opt/services/
├── docker-compose.yml         # Main compose file?
├── harbor/
│   ├── docker-compose.yml
│   └── config/
├── emqx/
│   ├── docker-compose.yml
│   └── config/
├── influxdb/
│   ├── docker-compose.yml
│   └── config/
└── traefik/
    ├── docker-compose.yml
    ├── traefik.yml
    └── dynamic/
```

## Traefik Configuration

Traefik acts as the reverse proxy for all web services.

### Main Configuration

File: `traefik.yml`

[Content to be added: Actual configuration]

```yaml
entryPoints:
  web:
    address: ":80"
  websecure:
    address: ":443"

providers:
  docker:
    exposedByDefault: false
  file:
    directory: /etc/traefik/dynamic

certificatesResolvers:
  letsencrypt:
    acme:
      email: admin@example.com
      storage: /letsencrypt/acme.json
      httpChallenge:
        entryPoint: web
```

### Dynamic Configuration

[Content to be added: How services register with Traefik]

## Harbor Configuration

### Docker Compose

[Content to be added: Actual docker-compose.yml]

```yaml
version: '3'
services:
  harbor:
    image: goharbor/harbor:latest
    container_name: harbor
    volumes:
      - harbor_data:/data
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.harbor.rule=Host(`harbor.example.com`)"
      - "traefik.http.services.harbor.loadbalancer.server.port=8080"
    networks:
      - traefik_network

volumes:
  harbor_data:

networks:
  traefik_network:
    external: true
```

### Design Rationale

[Content to be added]

- Why these specific configurations
- Volume mount decisions
- Security considerations

## EMQX Configuration

### Docker Compose

[Content to be added]

### Design Rationale

[Content to be added]

- Why EMQX over other MQTT brokers
- Configuration choices
- Integration with InfluxDB

## InfluxDB Configuration

### Docker Compose

[Content to be added]

### Design Rationale

[Content to be added]

- Retention policies
- Data organization
- Backup integration

## LDAP Account Manager

### Docker Compose

[Content to be added]

### Design Rationale

[Content to be added]

- LDAP connection security
- User self-service features enabled

## Sensor Data Acquisition

### Custom Service

[Content to be added]

- Dockerfile for the service
- Python/Node.js code structure
- Why certain libraries were chosen

### Dockerfile

[Content to be added: Actual Dockerfile]

```dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/

CMD ["python", "src/main.py"]
```

### Design Rationale

[Content to be added]

## Network Architecture

### Docker Networks

[Content to be added]

```yaml
networks:
  traefik_network:
    name: traefik_network
  backend:
    name: backend
    internal: true
```

### Why This Design

[Content to be added]

- Separation of public and internal services
- Security boundaries

## Secrets Management

[Content to be added]

- How secrets are stored
- Environment variables
- Docker secrets
- Rotation procedures

## Backup Strategy

[Content to be added]

- What gets backed up
- Backup automation
- Volume snapshots
- Configuration backups

## Deployment Procedures

### Initial Deployment

[Content to be added]

```bash
# Clone configurations
git clone ...

# Set up environment
cp .env.example .env
vim .env

# Start services
docker-compose up -d
```

### Updating Services

[Content to be added]

- Rolling updates
- Downtime considerations
- Rollback procedures

## Monitoring and Logging

### Log Collection

[Content to be added]

- Where logs are stored
- Log rotation
- Centralized logging (if implemented)

### Health Checks

[Content to be added]

- Docker health checks
- External monitoring

## Troubleshooting

### Common Issues

[Content to be added]

#### Service Won't Start

[Content to be added]

#### Network Connectivity

[Content to be added]

#### Volume Permission Issues

[Content to be added]

---

**Next**: [Storage Infrastructure](storage.md)
