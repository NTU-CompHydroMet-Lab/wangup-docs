# Weather Sensor Systems

!!! warning "Maintainer Documentation"
    This section is intended for system administrators and future maintainers.

## Overview

The lab operates several weather sensors that collect real-time meteorological data. Data flows through MQTT (EMQX) and is stored in InfluxDB.

## Sensor Inventory

[Content to be added: List of all sensors]

### Sensor 1: [Type]

- **Location**: [To be added]
- **Model**: [To be added]
- **Measurements**: Temperature, humidity, pressure, etc.
- **Data Rate**: [To be added]
- **Status**: Active/Inactive

### Sensor 2: [Type]

[Content to be added]

## Data Flow Architecture

```
┌──────────┐      MQTT       ┌──────────┐      ┌──────────────┐
│ Sensors  │ ───────────────>│  EMQX    │────> │  InfluxDB    │
└──────────┘                  └──────────┘      └──────────────┘
                                   │
                                   ▼
                           ┌──────────────┐
                           │ Subscribers  │
                           │ (Processing) │
                           └──────────────┘
```

## EMQX Configuration

### MQTT Topics

[Content to be added: Topic structure]

```
lab/weather/sensor1/temperature
lab/weather/sensor1/humidity
lab/weather/sensor2/temperature
...
```

### ACL Rules

[Content to be added: Who can publish/subscribe]

### Authentication

[Content to be added: How sensors authenticate to MQTT]

## Data Acquisition System

### Architecture

[Content to be added]

- How data is collected from sensors
- Data preprocessing
- Publishing to MQTT

### Container Configuration

**Location**: [To be added]

[Content to be added: Docker compose configuration]

### Code Repository

[Content to be added: Where the acquisition system code is stored]

## InfluxDB Storage

### Database Structure

[Content to be added]

- Database name
- Measurement names
- Tags and fields
- Retention policies

### Querying Data

```sql
-- Example queries
SELECT * FROM "weather_data"
WHERE time > now() - 24h

SELECT mean("temperature")
FROM "sensor_readings"
WHERE time > now() - 7d
GROUP BY time(1h)
```

## Sensor Maintenance

### Physical Maintenance

[Content to be added]

- Cleaning schedule
- Calibration procedures
- Battery replacement (if applicable)

### Software Maintenance

[Content to be added]

- Firmware updates
- Configuration backups
- Testing procedures

## Adding a New Sensor

[Content to be added: Step-by-step procedure]

1. Physical installation
2. Network configuration
3. MQTT topic assignment
4. Update data acquisition system
5. Configure InfluxDB measurements
6. Testing and verification

## Troubleshooting

### Sensor Not Reporting

[Content to be added]

- Check network connectivity
- Verify MQTT connection
- Check sensor logs
- Physical inspection

### Data Gaps

[Content to be added]

- Identifying missing data
- Investigation procedures
- Backfilling if possible

### MQTT Issues

[Content to be added]

- Connection problems
- Authentication failures
- Topic subscription issues

## Data Access

### Real-Time Monitoring

[Content to be added: Dashboard or monitoring tools]

### Historical Data

[Content to be added: How to query historical data]

### Data Export

[Content to be added: Procedures for exporting data]

## Backup and Recovery

[Content to be added]

- InfluxDB backup procedures
- Configuration backups
- Disaster recovery plan

---

**Next**: [Service Dockerfiles & Design](dockerfiles.md)
