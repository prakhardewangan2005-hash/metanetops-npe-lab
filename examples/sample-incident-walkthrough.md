# Sample Incident Walkthrough: BGP Session Flap

## Scenario
Automated monitoring triggers an alert indicating repeated BGP session
flaps with a transit provider in one region.

---

## Alert Trigger
- Alert: BGP Neighbor Flap Detected
- Severity: SEV-2
- Region: BOM-POP-01
- Peer: 203.0.113.1
- Flaps: 4 in 8 minutes

---

## Initial Assessment
- Scope limited to single peer
- No global prefix loss
- Minor packet loss observed
- No active maintenance

Decision: Follow INC-001 BGP Session Drop Runbook

---

## Triage Actions
Commands executed:
- show bgp summary
- show bgp neighbor 203.0.113.1
- show interfaces counters errors

Findings:
- Hold timer expirations observed
- Interface clean, no CRC errors
- Control-plane only impact

---

## Mitigation
- Avoided global BGP clear
- Temporarily de-preferenced affected peer
- Traffic shifted to alternate upstream

---

## Validation
- BGP session stable for 20 minutes
- Prefix count restored
- Packet loss normalized

---

## Communication
- Incident channel updated
- Status marked as mitigated
- Monitoring continued for 1 hour

---

## Post-Incident
- Postmortem filed: PM-001-bgp-session-flap.md
- Follow-up action created for automation tuning

---

## Outcome
- No customer-visible outage
- MTTR: 18 minutes
- Incident handled without escalation
