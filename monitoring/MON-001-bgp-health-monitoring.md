# BGP Health Monitoring

## Purpose
Provide real-time visibility into BGP session health,
prefix stability, and traffic impact across the network.

---

## Key Metrics

### Control Plane
- BGP session state (Idle / Active / Established)
- Session uptime
- Flap frequency
- Hold timer expirations

### Data Plane
- Prefix reachability
- Traffic drop percentage
- Packet loss and latency

### Infrastructure
- Interface errors (CRC, drops)
- Optics alarms
- CPU / memory utilization

---

## Dashboards

### BGP Overview Dashboard
- Total peers up vs down
- Top flapping peers
- Prefix count trends

### Regional Health Dashboard
- POP / DC wise session health
- Traffic shifts and reroutes

---

## Alerting Thresholds

| Signal | Threshold | Severity |
|------|---------|---------|
| BGP Down | > 2 mins | SEV-2 |
| Session Flap | > 3 / 10 min | SEV-2 |
| Prefix Drop | > 20% | SEV-1 |
| Traffic Loss | > 5% | SEV-1 |

---

## Alert Hygiene
- Alert deduplication enabled
- Cooldown window: 10 minutes
- Maintenance window suppression

---

## On-call Signals
- Pager alert for SEV-1
- Slack notification for SEV-2
- Dashboard banner for degraded state

---

## Validation Checks
- Correlate BGP alerts with traffic metrics
- Confirm alert not caused by config rollout
- Check historical baseline

---

## Monitoring Gaps
- False positives during maintenance
- Delayed detection of slow flaps

---

## Improvement Actions
- Tune flap detection thresholds
- Add predictive anomaly detection
- Improve correlation logic

---

## References
- Vendor BGP Monitoring Best Practices
- Internal Network Observability Standards
