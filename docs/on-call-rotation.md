# On-Call Rotation Guide

## Objective
Ensure 24x7 coverage for production incidents
with clear ownership and escalation paths.

---

## On-Call Roles

### Primary On-Call
- Responds to alerts
- Performs initial triage
- Leads incident mitigation

### Secondary On-Call
- Assists primary
- Takes over if escalation needed

---

## Rotation Model
- Weekly rotation
- Follow-the-sun where possible
- Backup assigned for each shift

---

## Escalation Policy
- SEV-1: Immediate page to primary + secondary
- SEV-2: Page primary
- SEV-3: Slack notification

---

## Response Expectations
- Acknowledge alert ≤ 5 minutes
- Initial assessment ≤ 10 minutes
- Status update every 30 minutes (SEV-1)

---

## Handoff Process
- Use incident handoff template
- Highlight risks and pending actions
- Confirm ownership transfer

---

## Burnout Prevention
- Max 1 week continuous on-call
- Mandatory rest post SEV-1 incident
