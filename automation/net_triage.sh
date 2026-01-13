#!/usr/bin/env bash
set -euo pipefail

TARGET_HOST="${1:-httpbin.org}"
TARGET_PORT="${2:-443}"

echo "=== Net Triage Report ==="
echo "Time: $(date)"
echo "Target: ${TARGET_HOST}:${TARGET_PORT}"
echo

echo "[1/4] DNS Lookup"
docker run --rm alpine sh -c "apk add --no-cache bind-tools >/dev/null && nslookup ${TARGET_HOST}" || {
  echo "❌ DNS lookup failed"
{
  echo "time=$(date -Is)"
  echo "target=${TARGET_HOST}:${TARGET_PORT}"
  echo "result=FAIL"
  echo "reason=DNS"
} > triage_result.txt
exit 2

}
echo "✅ DNS OK"
echo

echo "[2/4] TCP Connect Test"
docker run --rm alpine sh -c "apk add --no-cache busybox-extras >/dev/null && nc -vz ${TARGET_HOST} ${TARGET_PORT}" || {
  echo "❌ TCP connect failed"
  exit 3
}
echo "✅ TCP OK"
echo

echo "[3/4] HTTPS GET (Application-level)"
docker run --rm curlimages/curl -sS "https://${TARGET_HOST}/get" | head -n 30 || {
  echo "❌ HTTPS GET failed"
  exit 4
}
echo "✅ HTTPS OK"
echo

echo "[4/4] Docker Egress Summary"
echo "- ICMP (ping) may be blocked in Codespaces; prefer DNS/TCP/HTTP checks."
echo
echo "=== Result: PASS ✅ ==="

# Write machine-readable summary (for CI / postmortems)
SUMMARY_FILE="triage_result.txt"
{
  echo "time=$(date -Is)"
  echo "target=${TARGET_HOST}:${TARGET_PORT}"
  echo "result=PASS"
} > ${SUMMARY_FILE}
