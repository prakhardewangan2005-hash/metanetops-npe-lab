# Monitoring

Monitoring provides early detection and context
for network incidents before customer impact increases.

---

## 📈 Monitoring Coverage

### Control Plane
- BGP session state
- Flap frequency
- Prefix stability

### Data Plane
- Traffic loss
- Packet loss & latency
- Reachability

---

## 🚨 Alert Severity Model

| Severity | Meaning |
|--------|--------|
| SEV-1 | Customer traffic impact |
| SEV-2 | Degraded redundancy |
| SEV-3 | Informational |

---

## 🎯 Monitoring Goals
- Fast detection
- Low false positives
- Clear operator signals

## 📈 Live Monitoring (Prometheus + Grafana)

Spin up a local/codespaces monitoring stack with a BGP health dashboard.

```bash
cd monitoring/stack
docker compose up -d --build

## Access

Grafana is exposed on port 3000 (Codespaces: via Forwarded Address in PORTS tab).

Default credentials: admin / admin
