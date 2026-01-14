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

# Route Leak Suspected Runbook

## Incident Description
Unexpected increase in prefix advertisements indicating a possible
route leak from a peer or downstream AS.

---

## Detection Triggers
- Sudden spike in prefix count
- Unexpected AS paths
- Traffic blackholing or suboptimal routing
- External reports of reachability issues

---

## Initial Assessment
Identify:
- Suspected peer
- Affected regions
- Abnormal prefixes
- Customer impact

Key Questions:
- Is leak internal or external?
- Is peer a customer, transit, or IX?
- Is this ongoing or transient?

---

## Immediate Triage
Commands:
- show bgp ipv4 unicast summary
- show bgp neighbors <PEER> received-routes
- show bgp neighbors <PEER> advertised-routes

Look for:
- Prefixes exceeding expected limits
- Invalid AS_PATHs
- Missing prefix filters

---

## Containment (High Priority)
- Apply prefix-limit shutdown (if configured)
- Temporarily disable offending peer
- Reject leaked prefixes using route-policy

⚠️ Do NOT:
- Clear all BGP sessions
- Apply broad filters without validation

---

## Validation
- Prefix count returns to baseline
- No further leak detected
- Traffic paths normalized

---

## Communication
- Escalate to backbone team if transit impacted
- Notify peer NOC if external leak
- Update incident channel

---

## Post-Incident
- File postmortem
- Audit prefix filters
- Improve monitoring thresholds

---

## References
- RFC 7908 (Route Leak Prevention)
- MANRS Best Practices
