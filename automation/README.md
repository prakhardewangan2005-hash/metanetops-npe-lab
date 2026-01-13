# Automation

This folder contains automation logic and design documents
used to reduce MTTR while maintaining safety.

---

## ⚙️ Automations

| Automation | Purpose |
|----------|--------|
| AUTO-001-bgp-session-guard.md | Detect & guard against unstable BGP sessions |

---

## 🛡️ Automation Principles
- Low-risk actions first
- Rate-limited execution
- Human escalation on uncertainty
- Disabled during maintenance windows

---

## 🚫 What Automation Will NOT Do
- Clear all BGP sessions
- Override operator intent
- Act without validation signals
