> 🔧 **Linked Automation**
>
> This incident uses shared network triage automation before deep BGP debugging.
>
> **Run first:**
> ```bash
> bash automation/net_triage.sh
> ```
>
> **Failure demo (DNS):**
> ```bash
> bash automation/net_triage.sh does-not-exist-xyz-12345.invalid 443
> ```
>
> Expected:
> - DNS / TCP / HTTPS baseline verified
> - If this fails, stop and fix transport before BGP actions
>
> Related index: `runbooks/INDEX.md`
>
> ---

# BGP Session Flap / Neighbor Down Runbook

---

## 1. Incident Detection
**Triggers**
- BGP neighbor DOWN / FLAP alert
- Prefix drop
- Packet loss / latency spike
- Customer traffic impact

**Signals**
- Monitoring alerts
- Traffic dashboards
- User reports

---

## 2. Initial Assessment
Identify:
- Affected peer(s)
- Affected POP / DC / Region
- Time incident started
- Control-plane vs data-plane symptoms

Key questions:
- Single peer or multiple peers?
- Single region or global?
- Planned change ongoing?

---

## 3. Immediate Triage (First 5 Minutes)

### A. Check BGP Neighbor State
```bash
show bgp summary
show bgp neighbor <PEER_IP>
```

Look for:
- Idle / Active state loops
- Hold timer expirations
- BGP NOTIFICATION reasons
- Rapid session flaps

---

## 4. Scope the Failure
Determine blast radius:
- Which prefixes are withdrawn?
- Is traffic failing in one POP / DC / Region?
- Any correlated interface errors / CRC / drops?
- Control-plane vs data-plane impact?

```bash
show bgp ipv4 unicast
show interfaces counters errors
```

---

## 5. Check Physical & Transport Layer
Validate link health:
- Interface up/down events
- CRC / input errors
- Optics alarms
- Recent maintenance

```bash
show interfaces
show interfaces transceiver
```

---

## 6. Mitigation
Apply lowest-risk mitigation first:
- Clear single BGP session (only if safe)
- Disable problematic peer
- Shift traffic via alternate paths
- Roll back recent config change

```bash
clear bgp neighbor <PEER_IP>
```

Escalate if:
- Multiple peers impacted
- Backbone / DC-wide failure
- Customer-visible outage

---

## 7. Validation
Confirm recovery:
- BGP session stable ≥ 15 minutes
- Prefix count restored
- Packet loss / latency normalized

```bash
show bgp summary
ping <DESTINATION>
traceroute <DESTINATION>
```

---

## 8. Communication
Update:
- Incident channel
- On-call handoff notes
- Status page (if customer impact exists)

Include:
- Affected peers / regions
- Current status
- Mitigation applied
- Next update time

---

## 9. Post-Incident Actions
File postmortem in `/postmortems`:
- Root cause
- Timeline
- Detection gaps
- Mitigation effectiveness

Create follow-up tasks:
- Capacity review
- Policy validation
- Automation guardrails
- Alert tuning

---

## 10. References
- RFC 4271 — BGP-4
- Internal BGP Best Practices
- Vendor troubleshooting guides
