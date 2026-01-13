# Postmortem: BGP Session Flap Incident

## Incident Summary
- Incident ID: INC-001
- Start Time: <UTC>
- End Time: <UTC>
- Duration: <X minutes>
- Severity: SEV-1 / SEV-2
- Impacted Regions: <List>

---

## Customer Impact
- % of traffic affected
- Services degraded
- Number of customers impacted

---

## Detection
- Alert that triggered incident
- Time to detection
- Detection gaps (if any)

---

## Root Cause
Primary Cause:
- e.g. Transport instability, misconfiguration, hardware fault

Contributing Factors:
- Missing alert
- Automation gap
- Human error

---

## Timeline (UTC)

| Time | Event |
|----|-----|
| T0 | First BGP flap detected |
| T0 + 5m | Alert fired |
| T0 + 8m | On-call acknowledged |
| T0 + 12m | Mitigation applied |
| T0 + 25m | Session stabilized |

---

## Mitigation & Resolution
- Actions taken
- Why chosen
- Effectiveness

---

## What Went Well
- Fast detection
- Clear ownership
- Automation assistance

---

## What Went Wrong
- Late escalation
- Insufficient monitoring
- Manual dependency

---

## Action Items

| Item | Owner | Priority |
|----|------|--------|
| Improve flap detection | NPE | High |
| Add automation guardrail | NetOps | Medium |
| Update runbook | NPE | Low |

---

## Preventive Measures
- Better monitoring
- Safer rollout process
- Pre-change validation

---

## Lessons Learned
- Early signal correlation is critical
- Automation must fail safe
- Clear runbooks reduce MTTR
