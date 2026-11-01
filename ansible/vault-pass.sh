#!/usr/bin/env bash
# Prints the Ansible Vault password, fetched from Bitwarden Secrets Manager.
# ansible.cfg points vault_password_file here, so every ansible/ansible-playbook/
# ansible-vault command runs this automatically.
#
# Needs on the controller:
#   - bws (Bitwarden Secrets Manager CLI) on PATH
#   - a machine account access token in $BWS_TOKEN_FILE (default ~/.config/bws/token), mode 600
#
# The secret ID is not sensitive (it is useless without the access token), so it lives here.
set -euo pipefail

BWS_VAULT_SECRET_ID="${BWS_VAULT_SECRET_ID:-REPLACE_WITH_SECRET_ID}"
BWS_TOKEN_FILE="${BWS_TOKEN_FILE:-$HOME/.config/bws/token}"

fail() {
  echo "vault-pass.sh: $*" >&2
  exit 1
}

[[ "$BWS_VAULT_SECRET_ID" != "REPLACE_WITH_SECRET_ID" ]] \
  || fail "set BWS_VAULT_SECRET_ID in $0 to the vault password's secret ID"
command -v bws >/dev/null || fail "bws not found on PATH"
[[ -r "$BWS_TOKEN_FILE" ]] || fail "access token file $BWS_TOKEN_FILE is missing or unreadable"

perms="$(stat -c '%a' "$BWS_TOKEN_FILE")"
[[ "$perms" == "600" || "$perms" == "400" ]] \
  || fail "$BWS_TOKEN_FILE has mode $perms; run: chmod 600 $BWS_TOKEN_FILE"

# Exported rather than passed with --access-token so it never shows up in `ps`
BWS_ACCESS_TOKEN="$(<"$BWS_TOKEN_FILE")"
export BWS_ACCESS_TOKEN

bws secret get "$BWS_VAULT_SECRET_ID" --output json \
  | python3 -c 'import json, sys; print(json.load(sys.stdin)["value"])'
