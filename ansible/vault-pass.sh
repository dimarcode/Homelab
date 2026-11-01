#!/usr/bin/env bash
# Prints the Ansible Vault password from Bitwarden Secrets Manager.
# ansible.cfg points vault_password_file here, so every ansible/ansible-playbook/
# ansible-vault command runs this automatically.
set -euo pipefail

dir="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=bitwarden.conf
source "$dir/bitwarden.conf"

if [[ -z "${BWS_VAULT_SECRET_ID:-}" ]]; then
  echo "vault-pass.sh: set BWS_VAULT_SECRET_ID in $dir/bitwarden.conf" >&2
  exit 1
fi

exec "$dir/bws-get.sh" "$BWS_VAULT_SECRET_ID"
