# SLO → Alert Mapping

This document maps Service Level Objectives (SLOs)
to concrete monitoring alerts to ensure actionable reliability signals.

---

## SLO Definitions

| SLO | Target |
|---|---|
| Network Availability | 99.95% |
| Packet Loss | < 0.1% |
| BGP Session Stability | 99.9% |

---

## Alert Mapping Table

| SLO | Alert | Threshold | Severity |
|---|---|---|---|
| Network Availability | Traffic Drop Alert | > 5% traffic loss | SEV-1 |
| Packet Loss | Packet Loss Alert | > 1% for 3 min | SEV-1 |
| Packet Loss | Packet Loss Warning | > 0.5% for 5 min | SEV-2 |
| BGP Stability | BGP Session Down | Session down > 2 min | SEV-2 |
| BGP Stability | BGP Flap Alert | > 3 flaps / 10 min | SEV-2 |

---

## Alert Philosophy
- Alerts must map to user impact
- Avoid noisy alerts without SLO relevance
- Page humans only when SLOs are at risk

---

## Review Cadence
- Monthly SLO vs alert review
- Post-incident alert tuning
