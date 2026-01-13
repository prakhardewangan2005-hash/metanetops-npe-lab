# Alert → Runbook Mapping

This document maps production alerts to the correct runbooks
to ensure fast and consistent incident response.

---

## Alert Mapping Table

| Alert Name | Severity | Primary Signal | Runbook |
|-----------|----------|----------------|---------|
| BGP Neighbor Down | SEV-2 | BGP session state | runbooks/INC-001-bgp-session-drop.md |
| BGP Session Flap | SEV-2 | Flap count | runbooks/INC-001-bgp-session-drop.md |
| Route Leak Suspected | SEV-1 | Prefix spike | runbooks/INC-002-route-leak-suspected.md |
| High Packet Loss | SEV-1 | Packet loss % | runbooks/INC-003-high-packet-loss.md |
| Latency Spike | SEV-2 | RTT increase | runbooks/INC-003-high-packet-loss.md |

---

## Usage Guidelines
- Always follow the mapped runbook first
- Escalate only after initial triage
- Document deviations clearly

---

## Ownership
Maintained by Network Operations
