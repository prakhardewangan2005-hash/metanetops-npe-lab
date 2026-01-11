# INC-001 — BGP Session Drop / Flap

**Severity:** SEV-2 / SEV-3  
**Owner:** Network Production Engineering (NPE)  
**Scope:** Backbone / Datacenter / Edge  
**Last updated:** 2026-01-11

---

## 1. Problem Statement

BGP session(s) are dropping or rapidly flapping, causing route withdrawals and potential traffic loss, packet drops, or increased latency across one or more regions.

---

## 2. Detection Signals

### Alerts
- BGP neighbor DOWN / FLAP alert
- Route withdrawal spike
- Increased packet loss / latency in affected POP or DC

### Dashboards
- BGP session state
- Prefix count over time
- Interface errors / drops
- Traffic volume anomalies

---

## 3. Immediate Triage (First 5 Minutes)

### A. Check BGP neighbor state

``bash
# Vendor-specific commands vary; examples are conceptual
show bgp summary
show bgp neighbor <PEER_IP>
Look for:

Idle / Active state loops

Hold timer expirations

BGP NOTIFICATION reasons

Rapid session flaps

B. Scope the Impact
Which prefixes were withdrawn?

Is traffic failing in one region / POP / DC?

Any correlated interface errors or link flaps?

Single peer vs multiple peers?

4. Root Cause Isolation
A. Control Plane Checks
BGP NOTIFICATION codes (Cease, Hold Timer Expired)

Route policy changes

Max-prefix limit exceeded

MTU mismatch

B. Data Plane Checks
bash
Copy code
ping <PEER_IP>
traceroute <PEER_IP>
Packet loss?

Path changes?

Increased RTT?

C. Interface & Hardware Health
bash
Copy code
show interfaces counters errors
show interfaces status
Look for:

CRC errors

Link flaps

High utilization / congestion

5. Mitigation Steps
Option 1: Soft Reset (Preferred)
bash
Copy code
clear bgp neighbor <PEER_IP> soft
Option 2: Hard Reset (If stable alternative paths exist)
bash
Copy code
clear bgp neighbor <PEER_IP>
Option 3: Traffic Shift / Drain
Shift traffic to backup peers

Reduce local preference on unstable path

Apply temporary route dampening if required

6. Validation
BGP session returns to Established

Prefix count stable

Traffic restored (check dashboards)

No further session flaps for ≥15 minutes

7. Rollback (If Mitigation Fails)
Revert recent config or policy changes

Restore previous route-maps

Escalate to backbone / vendor team if hardware suspected

8. Communication
Notify incident channel with:

Affected peers / regions

Current status

Mitigation applied

Update status page if customer impact exists

9. Post-Incident Actions
File postmortem using /postmortems/PM-template.md

Add alert improvements if detection was delayed

Create follow-up task for:

Capacity review

Policy validation

Automation guardrails

10. References
RFC 4271 — BGP-4

Internal BGP Best Practices

Vendor troubleshooting guides
