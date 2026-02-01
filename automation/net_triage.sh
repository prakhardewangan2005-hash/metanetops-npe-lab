#!/usr/bin/env bash
set -euo pipefail

# MetaNetOps NPE Lab - Network Triage (Upgraded)
# Features:
#  - --json : NDJSON step logs + final summary for ingestion
#  - --runs N : repeat DNS/HTTPS checks N times and report p50/p95
#  - demo target : simulated incident, no real DNS required
#
# Usage:
#   bash automation/net_triage.sh <target> [port]
#   bash automation/net_triage.sh google.com 443 --runs 7
#   bash automation/net_triage.sh google.com 443 --json --runs 9
#   bash automation/net_triage.sh demo 443 --json

TARGET="${1:-}"
PORT="${2:-443}"

if [[ -z "${TARGET}" || "${TARGET}" == "--help" || "${TARGET}" == "-h" ]]; then
  echo "Usage: $0 <target> [port] [--json] [--runs N] [--timeout SEC]"
  echo "Examples:"
  echo "  $0 google.com 443"
  echo "  $0 google.com 443 --runs 7"
  echo "  $0 google.com 443 --json --runs 9"
  echo "  $0 demo 443 --json"
  exit 1
fi

# shift positional args (target + port) away, then parse flags
shift || true
shift || true

JSON_MODE=0
RUNS=5
TIMEOUT_SEC=5

while [[ $# -gt 0 ]]; do
  case "$1" in
    --json) JSON_MODE=1; shift ;;
    --runs) RUNS="${2:-5}"; shift 2 ;;
    --timeout) TIMEOUT_SEC="${2:-5}"; shift 2 ;;
    *) echo "Unknown arg: $1"; exit 2 ;;
  esac
done

# ---------- helpers ----------
now_iso() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

# milliseconds since epoch (works in most Linux images)
now_ms() {
  # Prefer GNU date with %3N; fallback to seconds*1000 if not supported
  if date +%s%3N >/dev/null 2>&1; then
    date +%s%3N
  else
    echo $(( $(date +%s) * 1000 ))
  fi
}

is_ip() {
  [[ "${1}" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]
}

# percentile from a list of numbers (ms), newline separated
# p in {50,95}
percentile() {
  local p="$1"
  local n
  n=$(wc -l | tr -d ' ')
  if [[ "$n" -le 0 ]]; then echo "null"; return; fi

  # nearest-rank method: rank = ceil(p/100 * n)
  local rank
  rank=$(awk -v p="$p" -v n="$n" 'BEGIN{ r=int((p*n+99)/100); if(r<1) r=1; if(r>n) r=n; print r }')
  # print the rank-th item (1-indexed) from sorted list
  sort -n | sed -n "${rank}p"
}

rand_ms() {
  # poor-man random in range [min,max]
  local min="$1" max="$2"
  local r=$(( RANDOM % (max - min + 1) + min ))
  echo "$r"
}

REQ_ID="$(head -c 16 /dev/urandom 2>/dev/null | od -An -tx1 | tr -d ' \n' | head -c 16 || echo "$(now_ms)")"

log_step_text() {
  local step="$1" msg="$2"
  echo "$msg"
}

log_step_json() {
  local step="$1" status="$2" msg="$3" extra_json="${4:-{}}"
  # extra_json must be a JSON object string
  printf '{"ts":"%s","request_id":"%s","step":"%s","status":"%s","message":%s,"extra":%s}\n' \
    "$(now_iso)" "$REQ_ID" "$step" "$status" "$(printf '%s' "$msg" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')" "$extra_json"
}

# ---------- output wrappers ----------
emit_step() {
  local step="$1" status="$2" msg="$3" extra="${4:-{}}"
  if [[ "$JSON_MODE" -eq 1 ]]; then
    log_step_json "$step" "$status" "$msg" "$extra"
  else
    log_step_text "$step" "$msg"
  fi
}

fail() {
  local step="$1" msg="$2" extra="${3:-{}}"
  emit_step "$step" "fail" "$msg" "$extra"
  exit 1
}

pass() {
  local step="$1" msg="$2" extra="${3:-{}}"
  emit_step "$step" "pass" "$msg" "$extra"
}

# ---------- demo mode ----------
if [[ "$TARGET" == "demo" ]]; then
  emit_step "dns_lookup" "pass" "[1/4] DNS Lookup (DEMO) ✅" '{"mode":"demo"}'
  emit_step "tcp_connect" "pass" "[2/4] TCP Connect (DEMO) ✅" '{"mode":"demo","port":443}'
  emit_step "https_check" "fail" "[3/4] HTTPS Check (DEMO) ❌ simulated TLS handshake error" '{"mode":"demo","error":"tls_handshake_failed"}'

  # generate fake latencies
  DNS_LIST=""
  HTTPS_LIST=""
  for _ in $(seq 1 "$RUNS"); do
    DNS_LIST+=$'\n'"$(rand_ms 6 22)"
    HTTPS_LIST+=$'\n'"$(rand_ms 80 210)"
  done

  DNS_P50=$(printf "%s\n" "$DNS_LIST" | sed '/^$/d' | percentile 50)
  DNS_P95=$(printf "%s\n" "$DNS_LIST" | sed '/^$/d' | percentile 95)
  HTTPS_P50=$(printf "%s\n" "$HTTPS_LIST" | sed '/^$/d' | percentile 50)
  HTTPS_P95=$(printf "%s\n" "$HTTPS_LIST" | sed '/^$/d' | percentile 95)

  emit_step "egress_summary" "pass" "[4/4] Docker Egress Summary (DEMO)" '{"mode":"demo","note":"ICMP may be blocked; prefer DNS/TCP/HTTP checks."}'

  # final summary
  if [[ "$JSON_MODE" -eq 1 ]]; then
    printf '{"ts":"%s","request_id":"%s","result":"FAIL","target":"%s","port":%s,"runs":%s,"latency_ms":{"dns":{"p50":%s,"p95":%s},"https":{"p50":%s,"p95":%s}}}\n' \
      "$(now_iso)" "$REQ_ID" "$TARGET" "$PORT" "$RUNS" "$DNS_P50" "$DNS_P95" "$HTTPS_P50" "$HTTPS_P95"
  else
    echo ""
    echo "=== Latency (DEMO) ==="
    echo "DNS   p50=${DNS_P50}ms  p95=${DNS_P95}ms"
    echo "HTTPS  p50=${HTTPS_P50}ms  p95=${HTTPS_P95}ms"
    echo ""
    echo "=== Result: FAIL ❌ (demo incident) ==="
  fi
  exit 0
fi

# ---------- real checks ----------
# Step 1: DNS Lookup (repeat RUNS times)
emit_step "dns_lookup" "info" "[1/4] DNS Lookup"
DNS_LAT_MS=()
DNS_OK=0
DNS_ERR=""

for i in $(seq 1 "$RUNS"); do
  start="$(now_ms)"
  # nslookup is widely available; fallback to getent if missing
  if command -v nslookup >/dev/null 2>&1; then
    if nslookup "$TARGET" >/dev/null 2>&1; then
      DNS_OK=1
    else
      DNS_ERR="NXDOMAIN or resolver error"
    fi
  elif command -v getent >/dev/null 2>&1; then
    if getent hosts "$TARGET" >/dev/null 2>&1; then
      DNS_OK=1
    else
      DNS_ERR="getent lookup failed"
    fi
  else
    DNS_ERR="no dns tool (nslookup/getent missing)"
  fi
  end="$(now_ms)"
  DNS_LAT_MS+=($(( end - start )))
done

DNS_P50=$(printf "%s\n" "${DNS_LAT_MS[@]}" | percentile 50)
DNS_P95=$(printf "%s\n" "${DNS_LAT_MS[@]}" | percentile 95)

if [[ "$DNS_OK" -ne 1 ]]; then
  fail "dns_lookup" "❌ DNS lookup failed for $TARGET (${DNS_ERR:-unknown})" \
    "$(printf '{"target":"%s","runs":%s,"latency_ms":{"p50":%s,"p95":%s}}' "$TARGET" "$RUNS" "$DNS_P50" "$DNS_P95")"
else
  pass "dns_lookup" "✅ DNS resolved for $TARGET" \
    "$(printf '{"target":"%s","runs":%s,"latency_ms":{"p50":%s,"p95":%s}}' "$TARGET" "$RUNS" "$DNS_P50" "$DNS_P95")"
fi

# Step 2: TCP Connect (single attempt)
emit_step "tcp_connect" "info" "[2/4] TCP Connect"
TCP_OK=0
TCP_ERR=""
TCP_LAT="null"

# Use bash /dev/tcp if available
start="$(now_ms)"
if (echo >/dev/tcp/"$TARGET"/"$PORT") >/dev/null 2>&1; then
  TCP_OK=1
else
  TCP_ERR="connect_failed"
fi
end="$(now_ms)"
TCP_LAT=$(( end - start ))

if [[ "$TCP_OK" -ne 1 ]]; then
  fail "tcp_connect" "❌ TCP connect failed to $TARGET:$PORT" \
    "$(printf '{"target":"%s","port":%s,"latency_ms":%s,"error":"%s"}' "$TARGET" "$PORT" "$TCP_LAT" "$TCP_ERR")"
else
  pass "tcp_connect" "✅ TCP connect ok to $TARGET:$PORT" \
    "$(printf '{"target":"%s","port":%s,"latency_ms":%s}' "$TARGET" "$PORT" "$TCP_LAT")"
fi

# Step 3: HTTPS Check (repeat RUNS times)
emit_step "https_check" "info" "[3/4] HTTPS Check"
HTTPS_LAT_MS=()
HTTPS_OK=0
HTTPS_ERR=""

CURL_FLAGS=(-sS -o /dev/null -L --connect-timeout "$TIMEOUT_SEC" --max-time "$TIMEOUT_SEC")
# For raw IP targets, TLS verification will likely fail (cert mismatch). Allow -k.
if is_ip "$TARGET"; then
  CURL_FLAGS+=(-k)
fi

URL="https://${TARGET}:${PORT}/"
for i in $(seq 1 "$RUNS"); do
  # curl can output timing; but we also keep wall-time fallback
  if command -v curl >/dev/null 2>&1; then
    t="$(curl "${CURL_FLAGS[@]}" -w '%{time_total}' "$URL" 2>/dev/null || echo "")"
    if [[ -n "$t" ]]; then
      # seconds float -> ms int
      ms="$(awk -v s="$t" 'BEGIN{ printf("%d", s*1000) }')"
      HTTPS_LAT_MS+=("$ms")
      # consider HTTP ok if curl exit is 0 (we used -o /dev/null)
      HTTPS_OK=1
    else
      # measure wall-time if needed
      start="$(now_ms)"
      if curl "${CURL_FLAGS[@]}" "$URL" >/dev/null 2>&1; then
        HTTPS_OK=1
      else
        HTTPS_ERR="curl_failed"
      fi
      end="$(now_ms)"
      HTTPS_LAT_MS+=($(( end - start )))
    fi
  else
    HTTPS_ERR="curl_missing"
    HTTPS_LAT_MS+=("0")
  fi
done

HTTPS_P50=$(printf "%s\n" "${HTTPS_LAT_MS[@]}" | percentile 50)
HTTPS_P95=$(printf "%s\n" "${HTTPS_LAT_MS[@]}" | percentile 95)

if [[ "$HTTPS_OK" -ne 1 ]]; then
  fail "https_check" "❌ HTTPS check failed for $URL" \
    "$(printf '{"url":"%s","runs":%s,"latency_ms":{"p50":%s,"p95":%s},"error":"%s"}' "$URL" "$RUNS" "$HTTPS_P50" "$HTTPS_P95" "${HTTPS_ERR:-unknown}")"
else
  pass "https_check" "✅ HTTPS OK ($URL)" \
    "$(printf '{"url":"%s","runs":%s,"latency_ms":{"p50":%s,"p95":%s}}' "$URL" "$RUNS" "$HTTPS_P50" "$HTTPS_P95")"
fi

# Step 4: Egress Summary (informational)
emit_step "egress_summary" "pass" "[4/4] Docker Egress Summary - ICMP (ping) may be blocked; prefer DNS/TCP/HTTP checks." \
  '{"note":"ICMP may be blocked; prefer DNS/TCP/HTTP checks."}'

# Final summary
if [[ "$JSON_MODE" -eq 1 ]]; then
  printf '{"ts":"%s","request_id":"%s","result":"PASS","target":"%s","port":%s,"runs":%s,"latency_ms":{"dns":{"p50":%s,"p95":%s},"https":{"p50":%s,"p95":%s},"tcp_connect":%s}}\n' \
    "$(now_iso)" "$REQ_ID" "$TARGET" "$PORT" "$RUNS" "$DNS_P50" "$DNS_P95" "$HTTPS_P50" "$HTTPS_P95" "$TCP_LAT"
else
  echo ""
  echo "=== Latency ==="
  echo "DNS   p50=${DNS_P50}ms  p95=${DNS_P95}ms   (runs=$RUNS)"
  echo "TCP   ${TCP_LAT}ms"
  echo "HTTPS p50=${HTTPS_P50}ms  p95=${HTTPS_P95}ms  (runs=$RUNS)"
  echo ""
  echo "=== Result: PASS ✅ ==="
fi
