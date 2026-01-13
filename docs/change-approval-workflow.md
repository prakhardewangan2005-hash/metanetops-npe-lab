# Change Approval Workflow

## Objective
Ensure production network changes are reviewed,
approved, and executed safely.

---

## Change Categories

| Type | Risk |
|---|---|
| Documentation only | Low |
| Config change (single device) | Medium |
| Routing / policy change | High |

---

## Approval Flow

1. Engineer drafts change
2. Risk assessment completed
3. Peer review required
4. Approval by senior engineer (High-risk)
5. Change scheduled in maintenance window
6. Pre-change checklist completed
7. Change executed
8. Post-change validation

---

## Required Artifacts
- Change description
- Rollback plan
- Impact assessment
- Monitoring plan

---

## Emergency Changes
- Allowed only for SEV-1 incidents
- Retroactive approval required
- Mandatory postmortem

---

## Change Freeze
- Activated during SLO budget exhaustion
- Lifted only after reliability review
