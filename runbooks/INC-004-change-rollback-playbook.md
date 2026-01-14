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

# Change Rollback Playbook

## Purpose
Provide a safe, structured rollback process for production
network changes to minimize customer impact.

---

## When to Roll Back
- Packet loss or latency increase post-change
- BGP sessions drop or flap
- Traffic blackholing
- Unexpected alerts triggered

---

## Rollback Preconditions
- Rollback plan approved
- Change owner available
- On-call engineer aware

---

## Rollback Procedure

### Step 1: Stabilize
- Stop further changes
- Freeze automation actions
- Communicate rollback start

### Step 2: Execute Rollback
- Revert configuration to last known good state
- Restore previous routing policies
- Avoid global clears unless escalated

### Step 3: Validate
- BGP sessions stable ≥ 15 min
- Packet loss < 0.1%
- Traffic restored to baseline

---

## Communication
- Update incident channel
- Notify stakeholders
- Record rollback timestamp

---

## Post-Rollback
- Continue monitoring for 30–60 min
- File postmortem if rollback triggered incident
- Update change documentation

---

## Do NOT
- Apply partial rollbacks without validation
- Chain multiple rollbacks rapidly
