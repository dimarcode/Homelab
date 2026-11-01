#!/usr/bin/env bash
# Sets up this directory as an Ansible controller:
#   - Python venv with ansible-core (.venv)
#   - Galaxy roles and collections (roles/, collections/)
#   - pre-commit hook that blocks unencrypted vault files
#   - checks that vault-pass.sh can reach Bitwarden
# Safe to re-run.
set -euo pipefail

cd "$(dirname "$0")"

echo "==> Python venv"
# Check for pip, not just the folder, so a half-created venv gets rebuilt
[[ -x .venv/bin/pip ]] || python3 -m venv --clear .venv
.venv/bin/pip install --quiet --upgrade pip
.venv/bin/pip install --quiet -r requirements.txt

echo "==> Galaxy roles and collections"
.venv/bin/ansible-galaxy install -r requirements.yml

echo "==> pre-commit hook"
hooks_dir="$(git rev-parse --git-path hooks)"
hook="$hooks_dir/pre-commit"
if [[ -e "$hook" && ! -L "$hook" ]]; then
  echo "    $hook already exists and isn't ours; leaving it alone" >&2
else
  ln -sf "$PWD/hooks/pre-commit" "$hook"
  echo "    linked $hook"
fi

echo "==> Vault password from Bitwarden"
if ./vault-pass.sh >/dev/null; then
  echo "    OK"
else
  echo "    vault-pass.sh failed; see docs/runbooks/ansible/using ansible vault.md" >&2
  exit 1
fi

echo
echo "Done. Activate with: source .venv/bin/activate"
