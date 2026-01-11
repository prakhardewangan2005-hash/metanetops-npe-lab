# NetPulse — Network Production Engineering Reliability Lab (Meta-style)

Docs-first portfolio lab for **Network Production Engineering (NPE)**:
runbooks, postmortems, monitoring signals, and automation notes for large-scale
datacenter + backbone networks.

## Why this exists
Meta-scale networks fail in *interesting* ways (loss, latency, BGP churn, link saturation).
This repo focuses on **reliability, operational excellence, and safe automation**.

## Focus areas (aligned with NPE Intern JD)
- **Incident response:** latency / packet loss / drops
- **Failure modes:** DNS, BGP/ISIS, link saturation, flaky optics
- **Monitoring:** golden signals, SLO thinking, alert tuning
- **Automation:** repeatable checks + safe mitigations (guardrails, rollback)
- **Runbooks & postmortems:** detection → triage → mitigation → validation

## Repository map
- `runbooks/` — incident runbooks (step-by-step)
- `postmortems/` — postmortem templates + examples
- `monitoring/` — dashboards/alerts and signal definitions
- `automation/` — scripts, tooling, and checklists (WIP)
- `backbone/` — backbone-specific notes (BGP/ISIS, peering, capacity)
- `datacenter/` — DC fabrics, ToR/leaf-spine, failure scenarios

## Status
🚧 Initial scaffolding — continuously evolving with new scenarios + tooling.

## Quick credibility checklist (what I’m adding next)
- 3 incident scenarios + timelines
- 2 runbooks with “verify/rollback” steps
- 1 monitoring dashboard spec + alerts
- 1 automation script (health checks) + safe execution notes
