![Network Triage](https://img.shields.io/badge/network--triage-demo--pass-brightgreen)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Docs](https://img.shields.io/badge/Docs-Complete-blue.svg)
![Network Ops](https://img.shields.io/badge/Domain-Network%20Operations-purple.svg)

# MetaNetOps NPE Lab 🛰️
Production-grade Network Operations & Reliability workflows inspired by
real-world Network Production Engineer (NPE) environments.

This repository demonstrates **incident response, automation, monitoring,
and postmortem culture** for large-scale networks.

---

## 🔍 What This Repo Demonstrates
- BGP incident troubleshooting & mitigation
- Safe automation with guardrails
- Monitoring & alerting design
- Structured postmortems
- Operational excellence mindset

---

## 📁 Repository Structure

| Folder | Description |
|------|------------|
| [`runbooks/`](./runbooks) | Step-by-step incident response guides |
| [`automation/`](./automation) | Automated guardrails & response logic |
| [`monitoring/`](./monitoring) | Metrics, alerts & dashboards |
| [`postmortems/`](./postmortems) | Blameless incident reviews |

---

## 🚨 Incident Lifecycle (How Everything Connects)

1. **Detection** → Monitoring alerts trigger
2. **Triage** → Runbook followed by on-call
3. **Mitigation** → Manual or automated action
4. **Validation** → Stability & traffic recovery
5. **Communication** → Status updates
6. **Postmortem** → Root cause & follow-ups

---

## 🧠 Skills Demonstrated
- BGP (RFC 4271) troubleshooting
- Control-plane vs data-plane analysis
- Automation safety & escalation design
- Production monitoring strategy
- Post-incident analysis

---

## 📌 Intended Audience
- Network Production Engineer
- Network Reliability Engineer
- SRE (Networking)
- Infrastructure Operations

## 🔧 Working Automation

This repository includes **runnable, production-style automation** designed for
Network Production Engineering (NPE) workflows.

### Network Incident Triage
Baseline checks to quickly validate transport and application reachability.

```bash
bash automation/net_triage.sh


## 🧾 Postmortem Auto-Generation

Incidents can generate a **structured markdown postmortem** automatically using
automation outputs and runbook references.

### Generate a postmortem
```bash
bash postmortems/generate_postmortem.sh INC-003 runbooks/INC-003-high-packet-loss.md

## 🚀 Quick Start

```bash
# Run baseline triage
bash automation/net_triage.sh

# Simulate a failure
bash automation/net_triage.sh does-not-exist-xyz-12345.invalid 443

# Generate a postmortem
bash postmortems/generate_postmortem.sh INC-001 runbooks/INC-001-bgp-session-drop.md



---

## 📎 Disclaimer
All incidents and data are simulated for learning purposes.
This project is not affiliated with Meta or any other company.

---

## ✅ Working Proof (Runnable)

This repository includes runnable workflows executed directly inside GitHub Codespaces.

### Quick Smoke Test
```bash
make hello

---

## 🔧 Working Automation: Network Incident Triage

This repository includes a runnable **incident triage script** that validates
DNS, TCP connectivity, and HTTPS reachability from a containerized environment
(GitHub Codespaces compatible).

### Run
```bash
bash automation/net_triage.sh

## Live Monitoring (Prometheus + Grafana)

This repository includes a fully working monitoring stack:

- Prometheus (metrics collection)
- Custom BGP exporter
- Grafana (pre-provisioned dashboards)

### Run locally / in Codespaces
```bash
cd monitoring/stack
docker compose up -d
