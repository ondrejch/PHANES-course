#!/usr/bin/env bash
set -euo pipefail
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PHANES_ENV_FILE="${PHANES_ENV_FILE:-$SCRIPT_DIR/.env}"
if [[ ! -f "$PHANES_ENV_FILE" ]]; then
    echo "Copy shared/.env.example to shared/.env and fill in the issued settings." >&2
    exit 1
fi
# Only source a trusted environment file: this is shell syntax, not inert data.
set -a
source "$PHANES_ENV_FILE"
set +a
: "${PHANES_BASE_URL:?Missing PHANES_BASE_URL}"
: "${PHANES_API_KEY:?Missing PHANES_API_KEY}"
: "${PHANES_MODEL:?Missing PHANES_MODEL}"
if [[ -n "${PHANES_CA_FILE:-}" ]]; then
    export NODE_EXTRA_CA_CERTS="$PHANES_CA_FILE"
fi
umask 077
python3 "$SCRIPT_DIR/configure.py"
export OPENCODE_CONFIG="$SCRIPT_DIR/.generated/opencode.json"
if [[ "${1:-}" == "--check" ]]; then
    exec python3 "$SCRIPT_DIR/check_endpoint.py"
fi
# Preserve the current working directory so the TUI opens the intended project.
exec opencode "$@"
