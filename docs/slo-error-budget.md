# Service Level Objectives & Error Budget

## Purpose
Define reliability targets and quantify acceptable risk
to balance velocity and stability.

---

## Service Definition
- Network connectivity between POPs
- External reachability
- Control-plane stability

---

## SLOs

| Metric | SLO |
|-----|----|
| Network Availability | 99.95% |
| Packet Loss | < 0.1% |
| BGP Session Stability | 99.9% |

---

## Error Budget
Error Budget = 100% - SLO

Example:
- 99.95% availability → ~22 minutes downtime / month

---

## Error Budget Policy
- Changes frozen if error budget exhausted
- Root cause analysis required for budget burn
- Reliability improvements prioritized

---

## Measurement
- Based on monitoring data
- Reviewed monthly
- Adjusted post major incidents

---

## Usage
- Guide release velocity
- Inform risk decisions
- Support postmortems
