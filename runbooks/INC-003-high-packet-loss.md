> 🔧 **Linked Automation**
>
> This incident uses shared network triage automation before deeper investigation.
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
> - If this fails, stop and fix transport before proceeding
>
> Related index: `runbooks/INDEX.md`
>
> ---

# High Packet Loss Incident Runbook

## Incident Description
Sustained packet loss observed impacting customer traffic,
potentially caused by interface errors, congestion, or upstream issues.

---

## Detection Triggers
- Packet loss > 1% for 3+ minutes
- Latency spikes
- Customer reports of degraded performance
- Monitoring alert (SEV-1 / SEV-2)

---

## Initial Assessment
Identify:
- Affected region / POP
- Scope (single interface vs multiple)
- Control-plane vs data-plane impact

Key Questions:
- Is loss inbound, outbound, or both?
- Is loss consistent or bursty?
- Any recent config or maintenance?

---

## Immediate Triage
Commands:
- show interfaces counters errors
- show interfaces utilization
- ping <destination> size 1500 repeat 100
- traceroute <destination>

Look for:
- CRC / input errors
- Queue drops
- Microbursts
- Asymmetric paths

---

## Root Cause Isolation

### Possible Causes
- Faulty optics or cable
- Interface congestion
- ECMP imbalance
- Upstream provider issues

---

## Mitigation
- Shift traffic away from affected link
- Rate-limit non-critical traffic
- Replace optics if errors present
- Escalate to provider if external

⚠️ Avoid:
- Interface shutdown without confirmation
- Global routing changes

---

## Validation
- Packet loss < 0.1%
- Latency stabilized
- Interface counters clean

---

## Communication
- Update incident channel
- Notify stakeholders if customer-facing

---

## Post-Incident
- File postmortem
- Add monitoring improvements
- Review capacity thresholds
