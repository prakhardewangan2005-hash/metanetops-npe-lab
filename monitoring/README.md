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

## Access

Grafana is exposed on port **3000**.

### Codespaces
- Open **PORTS** tab in the Codespaces bottom panel
- Find port **3000 (grafana)**
- Click **Open in Browser** to get the live Grafana URL

### Local
- https://shiny-fortnight-wvg4x6p6px9c9p4q-3000.app.github.dev/?orgId=1

**Default credentials**
- Username: `admin`
- Password: `admin`

