#!/usr/bin/env bash
set -euo pipefail

INCIDENT_ID="${1:-INC-UNKNOWN}"
RUNBOOK="${2:-runbooks/INDEX.md}"
TRIAGE_FILE="triage_result.txt"
OUT_DIR="postmortems/generated"
OUT_FILE="${OUT_DIR}/${INCIDENT_ID}-postmortem.md"

mkdir -p "${OUT_DIR}"

echo "Generating postmortem for ${INCIDENT_ID}..."

# Read triage results if present
if [[ -f "${TRIAGE_FILE}" ]]; then
  TRIAGE_CONTENT=$(cat "${TRIAGE_FILE}")
else
  TRIAGE_CONTENT="No triage data available."
fi

cat > "${OUT_FILE}" <<EOF
# 📄 Postmortem — ${INCIDENT_ID}

**Date:** $(date -Is)  
**Status:** Closed  
**Severity:** TBD  

---

## 🔍 Summary
An incident (${INCIDENT_ID}) occurred and was investigated using standard runbooks
and automated triage.

---

## ⏱ Timeline
- T0: Alert triggered
- T+X: Engineer ran automated triage
- T+Y: Root cause analysis started
- T+Z: Mitigation applied

---

## 🧪 Automated Triage Results
\`\`\`
${TRIAGE_CONTENT}
\`\`\`

---

## 📘 Runbook Used
\`${RUNBOOK}\`

---

## 🧠 Root Cause
TBD — requires deeper investigation.

---

## 🛠 Corrective Actions
- Improve monitoring / alerting
- Add guardrails to prevent recurrence

---

## 📌 Learnings
- Automation reduced time-to-diagnosis
- Clear runbooks helped fast response

EOF

echo "✅ Postmortem generated at ${OUT_FILE}"
