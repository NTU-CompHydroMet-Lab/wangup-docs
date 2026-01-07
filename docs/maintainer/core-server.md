# Core Server Architecture

!!! warning "Maintainer Documentation"
    This section is intended for system administrators and future maintainers. Regular users do not need this information.

## Overview

The Core server is the central infrastructure component that provides authentication, container registry, and sensor data services.

**Specifications**:
- CPU: Intel i9
- Role: Infrastructure services
- OS: [To be added]

## Services Architecture

### Service Stack

All services run in Docker containers, orchestrated via Docker Compose, with Traefik as the reverse proxy.

```
┌─────────────────────────────────────┐
│         Traefik (Reverse Proxy)     │
│         Port 80/443                 │
└──────────────┬──────────────────────┘
               │
       ┌───────┴───────────────┐
       │                       │
       ▼                       ▼
  ┌─────────┐           ┌──────────┐
  │ Harbor  │           │   LAM    │
  │ (8080)  │           │  (8081)  │
  └─────────┘           └──────────┘
       │                       │
       ▼                       ▼
  ┌─────────┐           ┌──────────┐
  │  EMQX   │           │ InfluxDB │
  │ (1883)  │           │  (8086)  │
  └─────────┘           └──────────┘
```

### LDAP Server

**Status**: Runs natively (not containerized)

[Content to be added]

- Installation method
- Configuration files
- Schema customizations
- Backup procedures

### Harbor Registry

**Container**: [To be added]
**Port**: 8080 (internal), proxied via Traefik

[Content to be added]

- Docker Compose configuration
- Volume mounts
- Database backend
- TLS configuration
- Backup and restore procedures
- Adding new projects
- User management

### EMQX (MQTT Broker)

**Container**: [To be added]
**Port**: 1883 (MQTT), 18083 (Dashboard)

[Content to be added]

- Purpose: Sensor data ingestion
- Configuration
- ACL rules
- Integration with InfluxDB
- Monitoring

### LDAP Account Manager (LAM)

**Container**: [To be added]
**Port**: 8081 (internal), proxied via Traefik

[Content to be added]

- Configuration
- LDAP connection settings
- User self-service features
- SSH key management

### Sensor Data Acquisition System

**Container**: [To be added]

[Content to be added]

- Architecture
- Data flow
- Integration with EMQX
- Data processing pipeline

### InfluxDB

**Container**: [To be added]
**Port**: 8086

[Content to be added]

- Purpose: Time-series storage for sensor data
- Configuration
- Retention policies
- Backup procedures
- Querying and visualization

### Traefik

**Container**: [To be added]
**Port**: 80, 443

[Content to be added]

- Configuration files
- Dynamic configuration
- TLS/SSL certificates (Let's Encrypt?)
- Routing rules
- Adding new services

## Network Architecture

[Content to be added]

- Network topology
- Firewall rules
- Port forwarding
- DNS configuration

## File System Structure

```
/opt/services/
├── harbor/
│   ├── docker-compose.yml
│   └── data/
├── emqx/
│   ├── docker-compose.yml
│   └── data/
├── influxdb/
│   ├── docker-compose.yml
│   └── data/
├── lam/
│   ├── docker-compose.yml
│   └── config/
└── traefik/
    ├── docker-compose.yml
    ├── traefik.yml
    └── dynamic/
```

[Content to be added: Actual structure]

## Docker Compose Files

### Example: Harbor

[Content to be added: Actual docker-compose.yml]

### Example: EMQX

[Content to be added: Actual docker-compose.yml]

## Backup Procedures

[Content to be added]

- What needs to be backed up
- Backup schedule
- Backup locations
- Restore procedures

## Monitoring

[Content to be added]

- Service health checks
- Logging
- Alerting

## Troubleshooting

[Content to be added]

- Common issues
- Log locations
- Service restart procedures
- Network connectivity issues

## Adding New Services

[Content to be added]

- Steps to add a new containerized service
- Traefik integration
- LDAP authentication integration

---

**Next**: [Server Administration](server-admin.md)
