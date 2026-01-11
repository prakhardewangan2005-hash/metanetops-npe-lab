# MetaNetOps — Network Production Engineering (NPE) Reliability Lab

Docs-first portfolio lab aligned with **Meta Network Production Engineer (Intern)** responsibilities: operating large-scale backbone/datacenter networks, building monitoring & automation, and running incident response with strong reliability habits.

---

## What this repo demonstrates (JD mapping)

- **Multi-vendor / multi-protocol operations** → runbooks + checklists for common failures  
- **Monitoring & alerting** → signal taxonomy, SLO/SLA thinking, dashboards, alert rules  
- **Automation & continuous improvement** → scripts + “toil → automate” playbooks  
- **Routing fundamentals (BGP / ISIS)** → failure scenarios, triage, safe mitigation paths  
- **UNIX + TCP/IP fundamentals** → debugging workflow: `mtr`, `traceroute`, `tcpdump`, `iperf`

---

## Repository structure

- [`runbooks/`](./runbooks) — Incident runbooks (detect → triage → mitigate → validate → rollback)
- [`postmortems/`](./postmortems) — Blameless postmortems + action-item tracking templates
- [`monitoring/`](./monitoring) — Signals, SLIs/SLOs, alerting rules, dashboards (docs-first)
- [`automation/`](./automation) — Scripts and automation notes (toil reduction, safe deploy)
- [`backbone/`](./backbone) — Backbone scenarios: routing, capacity, failure domains
- [`datacenter/`](./datacenter) — DC scenarios: link/ToR, ECMP, congestion, optics

---

## Status

✅ Scaffolding complete  
🔜 Adding first runbook + first postmortem + monitoring baseline

---

## “Signals I care about” (starter set)

- **Latency** (p50/p95/p99), **packet loss**, **drops**, **retransmits**
- **Interface errors** (CRC, FCS), **flaps**, **BGP session churn**
- **Queue / buffer** (microbursts), **link utilization**, **hotspots**
- **Customer impact proxy**: failed requests, timeouts, degraded throughput

---

## How to use this repo (interviewer-friendly)

Pick a scenario:
1) Read the relevant **runbook**  
2) Use the **postmortem template** to simulate an incident write-up  
3) Review **monitoring** to see what would have detected it earlier  
4) Check **automation** to reduce repeat toil

---

## Quick links

- Runbooks → `runbooks/README.md`
- Postmortems → `postmortems/README.md`
- Monitoring → `monitoring/README.md`
