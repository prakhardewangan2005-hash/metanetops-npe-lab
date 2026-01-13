# BGP Session Guard Automation

## Objective
Automatically detect unstable BGP sessions and apply safe, predefined mitigation
to reduce customer impact and mean-time-to-recovery (MTTR).

---

## Trigger Conditions
Automation is triggered when **any** of the following occur:

- BGP neighbor DOWN events > 3 times in 10 minutes
- Hold timer expiration detected
- Prefix count drop > 20%
- Control-plane CPU spike correlated with BGP events

---

## Signal Sources
- Streaming telemetry (BGP state changes)
- SNMP traps (bgpPeerState)
- Syslog (BGP NOTIFICATION messages)
- Traffic analytics (prefix reachability)

---

## Automation Flow

### Step 1: Validate Signal
- Confirm alert is not duplicate / stale
- Verify peer state from at least two independent signals
- Check if maintenance window is active

### Step 2: Impact Classification
- Single peer vs multiple peers
- Single POP / DC vs regional impact
- Control-plane only vs data-plane impact

### Step 3: Automated Actions (Low Risk First)
1. Capture diagnostic snapshot:
   - BGP neighbor state
   - Prefix count
   - Interface counters
2. Rate-limit session resets (cooldown ≥ 10 min)
3. Suppress alert flapping noise
4. Auto-shift traffic using alternate peers (if policy allows)

### Step 4: Human Escalation
Page on-call engineer if:
- More than 2 peers affected
- Customer traffic impacted
- Automation confidence < threshold

---

## Safeguards
- Never clear all BGP sessions automatically
- Max 1 automated action per peer per 30 minutes
- Automation disabled during backbone maintenance

---

## Success Criteria
- BGP session stabilizes ≥ 15 minutes
- Prefix count restored
- Packet loss < 0.1%

---

## Failure Handling
- Roll back automation action
- Escalate to Network On-call
- Attach automation logs to incident ticket

---

## References
- RFC 4271 (BGP-4)
- Internal Traffic Engineering Guidelines
