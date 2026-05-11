#!/usr/bin/env bash
#
# Mock POST to Dr Kampes B2B quiz Make.com webhook.
# Mirrors payload shape produced by sections/lp-b2b-quiz-form.liquid.
#
# Usage:
#   ./test-quiz-webhook.sh                       # send default "hot lead" payload
#   ./test-quiz-webhook.sh cold                  # send predefined cold-lead variant
#   ./test-quiz-webhook.sh warm                  # warm-lead variant
#   ./test-quiz-webhook.sh --url <url>           # override webhook URL
#   ./test-quiz-webhook.sh --file payload.json   # send custom JSON file
#   ./test-quiz-webhook.sh --dry                 # print payload, don't send
#   ./test-quiz-webhook.sh --verbose             # show full curl trace
#

set -euo pipefail

WEBHOOK_URL="https://hook.eu2.make.com/rih8pps134g4thgp8ufk5ad5v1k14yvz"
PRESET="hot"
DRY_RUN=0
VERBOSE=0
PAYLOAD_FILE=""

# Colors
RED=$'\033[0;31m'
GRN=$'\033[0;32m'
YLW=$'\033[0;33m'
BLU=$'\033[0;34m'
DIM=$'\033[2m'
RST=$'\033[0m'

# ─── Parse args ───
while [[ $# -gt 0 ]]; do
  case "$1" in
    --url)     WEBHOOK_URL="$2"; shift 2 ;;
    --file)    PAYLOAD_FILE="$2"; shift 2 ;;
    --dry)     DRY_RUN=1; shift ;;
    --verbose) VERBOSE=1; shift ;;
    -h|--help)
      sed -n '2,/^$/p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    hot|warm|cold|partial) PRESET="$1"; shift ;;
    *)
      echo "${RED}Unknown arg: $1${RST}" >&2
      echo "Run with -h for usage." >&2
      exit 1
      ;;
  esac
done

# ─── Build payload ───
TIMESTAMP="$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"

if [[ -n "$PAYLOAD_FILE" ]]; then
  if [[ ! -f "$PAYLOAD_FILE" ]]; then
    echo "${RED}Payload file not found: $PAYLOAD_FILE${RST}" >&2
    exit 1
  fi
  PAYLOAD="$(cat "$PAYLOAD_FILE")"
else
  case "$PRESET" in
    hot)
      PAYLOAD=$(cat <<EOF
{
  "ruolo": "Titolare / socio",
  "azienda": "Trasporti Rossi srl (TEST)",
  "provincia": "TV",
  "camion": "11-20",
  "autisti": "21-50",
  "fornitore": "Le fornisce l'azienda",
  "problema": ["Costano troppo nel tempo", "Gli autisti le trovano scomode"],
  "vantaggio": ["Personalizzazione con colori/logo aziendale", "Fast Wear per scendere dal camion con più praticità"],
  "soluzione": "Versione personalizzata",
  "test": "Sì, mi interessa",
  "nome": "Mario Rossi",
  "whatsapp": "+39 333 1234567",
  "email": "mario.rossi+test@trasporti-rossi.it",
  "messaggio": "Vorremmo vedere un campione personalizzato prima del test.",
  "meta": {
    "submittedAt": "$TIMESTAMP",
    "pageUrl": "https://drkampes.com/pages/b2b",
    "pageTitle": "Dr Kampes — B2B",
    "userAgent": "Mozilla/5.0 (test-quiz-webhook.sh)",
    "referrer": "",
    "source": "lp-b2b-quiz",
    "preset": "hot"
  }
}
EOF
)
      ;;
    warm)
      PAYLOAD=$(cat <<EOF
{
  "ruolo": "Responsabile parco mezzi",
  "azienda": "Logistica Padana SpA (TEST)",
  "provincia": "MI",
  "camion": "5-10",
  "autisti": "11-20",
  "fornitore": "Dipende dai casi",
  "problema": ["Durano poco", "Gestire le taglie è complicato"],
  "vantaggio": ["Maggiore comfort per gli autisti", "Gestione taglie e storico ordini"],
  "soluzione": "Prima voglio capire quale soluzione è più adatta",
  "test": "Sì, ma vorrei prima parlare con voi",
  "nome": "Luca Bianchi",
  "whatsapp": "+39 348 9876543",
  "email": "luca.bianchi+test@logisticapadana.it",
  "messaggio": "",
  "meta": {
    "submittedAt": "$TIMESTAMP",
    "pageUrl": "https://drkampes.com/pages/b2b",
    "pageTitle": "Dr Kampes — B2B",
    "userAgent": "Mozilla/5.0 (test-quiz-webhook.sh)",
    "referrer": "",
    "source": "lp-b2b-quiz",
    "preset": "warm"
  }
}
EOF
)
      ;;
    cold)
      PAYLOAD=$(cat <<EOF
{
  "ruolo": "Autista",
  "azienda": "(TEST)",
  "provincia": "RM",
  "camion": "1-4",
  "autisti": "1-4",
  "fornitore": "Ogni autista compra le proprie",
  "problema": ["Nessun problema particolare"],
  "vantaggio": ["Fast Wear per scendere dal camion con più praticità"],
  "soluzione": "Versione nera",
  "test": "Per ora voglio solo informazioni",
  "nome": "Giuseppe Verdi",
  "whatsapp": "+39 320 0001111",
  "email": "giuseppe.verdi+test@gmail.com",
  "messaggio": "",
  "meta": {
    "submittedAt": "$TIMESTAMP",
    "pageUrl": "https://drkampes.com/pages/b2b",
    "pageTitle": "Dr Kampes — B2B",
    "userAgent": "Mozilla/5.0 (test-quiz-webhook.sh)",
    "referrer": "",
    "source": "lp-b2b-quiz",
    "preset": "cold"
  }
}
EOF
)
      ;;
    partial)
      PAYLOAD=$(cat <<EOF
{
  "ruolo": "Responsabile acquisti",
  "azienda": "Test Partial srl",
  "provincia": "TO",
  "camion": "21-50",
  "autisti": "21-50",
  "fornitore": "",
  "problema": [],
  "vantaggio": ["Risparmio sul costo reale nei 2 anni"],
  "soluzione": "",
  "test": "Forse, dipende dalla proposta",
  "nome": "Anna Neri",
  "whatsapp": "+39 333 0000000",
  "email": "anna.neri+test@example.com",
  "messaggio": "Payload incompleto per test edge case.",
  "meta": {
    "submittedAt": "$TIMESTAMP",
    "pageUrl": "https://drkampes.com/pages/b2b",
    "pageTitle": "Dr Kampes — B2B",
    "userAgent": "Mozilla/5.0 (test-quiz-webhook.sh)",
    "referrer": "",
    "source": "lp-b2b-quiz",
    "preset": "partial"
  }
}
EOF
)
      ;;
  esac
fi

# ─── Sanity: valid JSON? ───
if command -v jq >/dev/null 2>&1; then
  if ! echo "$PAYLOAD" | jq -e . >/dev/null 2>&1; then
    echo "${RED}✗ Generated payload is not valid JSON${RST}" >&2
    echo "$PAYLOAD" >&2
    exit 1
  fi
fi

echo "${BLU}┌─ Dr Kampes B2B Quiz · Webhook Test${RST}"
echo "${BLU}├─${RST} URL:    ${DIM}$WEBHOOK_URL${RST}"
echo "${BLU}├─${RST} Preset: ${YLW}$PRESET${RST}${PAYLOAD_FILE:+ ${DIM}(overridden by --file $PAYLOAD_FILE)${RST}}"
echo "${BLU}└─${RST} Time:   ${DIM}$TIMESTAMP${RST}"
echo ""

if command -v jq >/dev/null 2>&1; then
  echo "${DIM}─── Payload ─────────────────────────────────────${RST}"
  echo "$PAYLOAD" | jq .
  echo "${DIM}─────────────────────────────────────────────────${RST}"
else
  echo "${DIM}─── Payload (raw, install jq for pretty print) ──${RST}"
  echo "$PAYLOAD"
  echo "${DIM}─────────────────────────────────────────────────${RST}"
fi
echo ""

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "${YLW}[--dry] Not sending.${RST}"
  exit 0
fi

# ─── Fire ───
echo "${BLU}→${RST} POST $WEBHOOK_URL"
START=$(date +%s)

CURL_ARGS=(
  --silent
  --show-error
  --max-time 20
  --connect-timeout 10
  --request POST
  --header "Content-Type: application/json"
  --header "User-Agent: drkampes-test-quiz-webhook.sh/1.0"
  --data "$PAYLOAD"
  --write-out "\n%{http_code}\n%{time_total}\n"
)
[[ "$VERBOSE" -eq 1 ]] && CURL_ARGS=(--verbose "${CURL_ARGS[@]}")

# Capture stdout+stderr separately so http_code stays parseable
TMP_OUT="$(mktemp)"
TMP_ERR="$(mktemp)"
trap 'rm -f "$TMP_OUT" "$TMP_ERR"' EXIT

if ! curl "${CURL_ARGS[@]}" "$WEBHOOK_URL" >"$TMP_OUT" 2>"$TMP_ERR"; then
  RC=$?
  echo "${RED}✗ curl failed (exit $RC)${RST}" >&2
  [[ -s "$TMP_ERR" ]] && cat "$TMP_ERR" >&2
  exit "$RC"
fi

END=$(date +%s)
ELAPSED=$((END - START))

# Last 2 lines of TMP_OUT are http_code + time_total (write-out format).
TIME_TOTAL="$(tail -n 1 "$TMP_OUT")"
HTTP_CODE="$(tail -n 2 "$TMP_OUT" | head -n 1)"
BODY="$(sed '$d' "$TMP_OUT" | sed '$d')"

echo ""
echo "${DIM}─── Response ────────────────────────────────────${RST}"
if [[ -n "$BODY" ]]; then
  if command -v jq >/dev/null 2>&1 && echo "$BODY" | jq -e . >/dev/null 2>&1; then
    echo "$BODY" | jq .
  else
    echo "$BODY"
  fi
else
  echo "${DIM}(empty body)${RST}"
fi
echo "${DIM}─────────────────────────────────────────────────${RST}"

if [[ "$HTTP_CODE" =~ ^2[0-9][0-9]$ ]]; then
  echo "${GRN}✓ HTTP $HTTP_CODE · curl time ${TIME_TOTAL}s · wall ${ELAPSED}s${RST}"
  exit 0
else
  echo "${RED}✗ HTTP $HTTP_CODE · curl time ${TIME_TOTAL}s · wall ${ELAPSED}s${RST}"
  exit 1
fi
