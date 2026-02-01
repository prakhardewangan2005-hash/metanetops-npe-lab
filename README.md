# 🛰️ MetaNetOps NPE Lab
Production-grade Network Operations, Incident Triage & Reliability Automation

![network-triage](https://img.shields.io/badge/network--triage-demo--pass-brightgreen)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Docs](https://img.shields.io/badge/Docs-Complete-blue.svg)
![Network Ops](https://img.shields.io/badge/Domain-Network%20Operations-purple.svg)

Production-grade Network Operations & Reliability workflows inspired by real-world Network Production Engineer (NPE) environments.

This repository demonstrates incident response, automation, monitoring, and postmortem culture for large-scale networks.

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
| runbooks/ | Step-by-step incident response guides |
| automation/ | Automated guardrails & response logic |
| monitoring/ | Metrics, alerts & dashboards |
| postmortems/ | Blameless incident reviews |

---

## 🚨 Incident Lifecycle (How Everything Connects)

1. Detection → Monitoring alerts trigger
2. Triage → Runbook followed by on-call
3. Mitigation → Manual or automated action
4. Validation → Stability & traffic recovery
5. Communication → Status updates
6. Postmortem → Root cause & follow-ups

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

---

## 🔧 Working Automation

This repository includes runnable, production-style automation designed for Network Production Engineering (NPE) workflows.

### Network Incident Triage
Baseline checks to quickly validate transport and application reachability.

bash automation/net_triage.sh

---

## 🚀 Quick Demo (Safe / No External DNS)

One-command deterministic demo for recruiters, engineers, or hiring managers.

bash automation/net_triage.sh demo --json | tee triage_run.ndjson

Verify output file:

tail -n 5 triage_run.ndjson

---

## 🧾 Postmortem Auto-Generation

Generate a structured, blameless postmortem from automation outputs.

bash postmortems/generate_postmortem.sh INC-003 runbooks/INC-003-high-packet-loss.md

---

## 📊 Live Monitoring (Prometheus + Grafana)

Includes a complete monitoring stack:
- Prometheus (metrics collection)
- Custom BGP exporter
- Grafana dashboards

Run locally or in Codespaces:

cd monitoring/stack  
docker compose up -d

---

## ⭐ Why This Project Matters
Most projects stop at scripts. This one demonstrates:
- How engineers think during outages
- How reliability systems are designed, not hacked
- How incidents become learning loops, not failures

This reflects real internal tooling expectations at large-scale infrastructure teams.

---

## ⚠️ Disclaimer
All incidents, domains, and failures are simulated for learning purposes.
This project is not affiliated with Meta or any other company.
