#!/usr/bin/env bash
# Prints the value of one Bitwarden Secrets Manager secret: ./bws-get.sh <secret-id>
#
# Needs on this machine:
#   - bws on PATH or in ~/.local/bin (setup.sh installs it)
#   - a machine account access token in $BWS_TOKEN_FILE (default ~/.config/bws/token), mode 600
set -euo pipefail

BWS_TOKEN_FILE="${BWS_TOKEN_FILE:-$HOME/.config/bws/token}"

fail() {
  echo "bws-get.sh: $*" >&2
  exit 1
}

[[ $# -eq 1 && -n "$1" ]] || fail "usage: $0 <secret-id>"

# ~/.local/bin isn't on PATH in cron or in a shell started before setup.sh ran
bws="$(command -v bws || true)"
[[ -n "$bws" ]] || bws="$HOME/.local/bin/bws"
[[ -x "$bws" ]] || fail "bws not found; run ./setup.sh"

[[ -r "$BWS_TOKEN_FILE" ]] || fail "access token file $BWS_TOKEN_FILE is missing or unreadable; run ./setup.sh"
perms="$(stat -c '%a' "$BWS_TOKEN_FILE")"
[[ "$perms" == "600" || "$perms" == "400" ]] \
  || fail "$BWS_TOKEN_FILE has mode $perms; run: chmod 600 $BWS_TOKEN_FILE"

# Exported rather than passed with --access-token so it never shows up in `ps`
BWS_ACCESS_TOKEN="$(<"$BWS_TOKEN_FILE")"
export BWS_ACCESS_TOKEN

json="$("$bws" secret get "$1" --output json)" || fail "bws couldn't read secret $1 (bad token, no access, or wrong ID)"
python3 -c 'import json, sys; print(json.loads(sys.argv[1])["value"])' "$json"
