#!/usr/bin/env bash
# Turns a fresh clone of this repo into a working Ansible controller:
#   1. system packages (python3-venv, curl) via apt
#   2. bws (Bitwarden Secrets Manager CLI) into ~/.local/bin, checksum-verified
#   3. this machine's bws access token (prompted once, stored in ~/.config/bws/token)
#   4. checks the vault password can be fetched
#   5. this machine's own ansible SSH key, generated here if missing (you add the .pub to hosts)
#   6. Python venv with ansible-core, Galaxy roles and collections
#   7. pre-commit hook that blocks unencrypted vault files
# Safe to re-run; finished steps are skipped.
set -euo pipefail

cd "$(dirname "$0")"
# shellcheck source=bitwarden.conf
source ./bitwarden.conf

BWS_VERSION="2.1.0"
# From bws-sha256-checksums-2.1.0.txt on the GitHub release (static musl builds)
declare -A BWS_SHA256=(
  [x86_64]="f59ee150e42b82128d437087e9bac920053c6bfddcb960d20ce9386e5ac9bba6"
  [aarch64]="eb0f1ae61d1c3b74244d2841233276e05c77e8be4da197ed90fc6248387005e1"
)
BWS_TOKEN_FILE="${BWS_TOKEN_FILE:-$HOME/.config/bws/token}"
SSH_KEY="$HOME/.ssh/id_ed25519_ansible" # keep in sync with ansible.cfg private_key_file

fail() {
  echo "setup.sh: $*" >&2
  exit 1
}
step() { echo "==> $*"; }
info() { echo "    $*"; }

step "System packages"
missing=()
python3 -c 'import ensurepip' 2>/dev/null || missing+=(python3-venv)
command -v curl >/dev/null || missing+=(curl)
if ((${#missing[@]})); then
  command -v apt-get >/dev/null || fail "install these yourself: ${missing[*]}"
  info "installing ${missing[*]} (needs sudo)"
  sudo apt-get update -qq
  sudo apt-get install -y -qq "${missing[@]}"
else
  info "OK"
fi

step "bws $BWS_VERSION"
if command -v bws >/dev/null || [[ -x "$HOME/.local/bin/bws" ]]; then
  info "already installed"
else
  arch="$(uname -m)"
  [[ -n "${BWS_SHA256[$arch]:-}" ]] || fail "no bws build listed for $arch; install bws yourself"
  zip="bws-${arch}-unknown-linux-musl-${BWS_VERSION}.zip"
  tmp="$(mktemp -d)"
  trap 'rm -rf "$tmp"' EXIT
  curl -fsSL -o "$tmp/$zip" \
    "https://github.com/bitwarden/sdk-sm/releases/download/bws-v${BWS_VERSION}/$zip"
  echo "${BWS_SHA256[$arch]}  $tmp/$zip" | sha256sum --check --quiet - \
    || fail "checksum mismatch for $zip; not installing"
  python3 -m zipfile -e "$tmp/$zip" "$tmp/x"
  mkdir -p "$HOME/.local/bin"
  install -m 755 "$(find "$tmp/x" -type f -name bws | head -n 1)" "$HOME/.local/bin/bws"
  info "installed to ~/.local/bin/bws"
fi

step "Bitwarden config"
[[ -n "${BWS_VAULT_SECRET_ID:-}" ]] \
  || fail "set BWS_VAULT_SECRET_ID in bitwarden.conf (see docs/runbooks/ansible/using ansible vault.md)"
info "OK"

step "bws access token"
new_token=0
if [[ -s "$BWS_TOKEN_FILE" ]]; then
  info "found $BWS_TOKEN_FILE"
else
  [[ -t 0 ]] || fail "no token at $BWS_TOKEN_FILE and no terminal to prompt for one"
  read -rsp "    Paste this machine's bws access token: " token
  echo
  [[ -n "$token" ]] || fail "no token entered"
  mkdir -p "$(dirname "$BWS_TOKEN_FILE")"
  chmod 700 "$(dirname "$BWS_TOKEN_FILE")"
  # Remove first: writing into an existing (e.g. empty) file would keep its old, looser mode
  rm -f "$BWS_TOKEN_FILE"
  (umask 077 && printf '%s\n' "$token" >"$BWS_TOKEN_FILE")
  unset token
  new_token=1
  info "saved to $BWS_TOKEN_FILE"
fi

step "Vault password"
if ! ./vault-pass.sh >/dev/null; then
  if ((new_token)); then
    # Don't keep a token that doesn't work, or every re-run would fail the same way
    rm -f "$BWS_TOKEN_FILE"
    fail "couldn't fetch the vault password; removed the token you entered, re-run to try again"
  fi
  fail "couldn't fetch the vault password; check BWS_VAULT_SECRET_ID, or delete $BWS_TOKEN_FILE and re-run to enter a new token"
fi
info "OK"

step "Ansible SSH key"
# Each controller has its own key, and the private half never leaves this machine.
# Adding the public half to hosts is done by hand.
if [[ -f "$SSH_KEY" ]]; then
  info "found $SSH_KEY"
else
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  ssh-keygen -q -t ed25519 -N '' -C "ansible@$(hostname -s)" -f "$SSH_KEY"
  info "generated $SSH_KEY. Add this public key to the ansible user on your hosts:"
  info "  $(cat "$SSH_KEY.pub")"
fi

step "Python venv"
# Check for pip, not just the folder, so a half-created venv gets rebuilt
[[ -x .venv/bin/pip ]] || python3 -m venv --clear .venv
.venv/bin/pip install --quiet --upgrade pip
.venv/bin/pip install --quiet -r requirements.txt
info "OK"

step "Galaxy roles and collections"
.venv/bin/ansible-galaxy install -r requirements.yml

step "pre-commit hook"
hook="$(git rev-parse --git-path hooks)/pre-commit"
if [[ -e "$hook" && ! -L "$hook" ]]; then
  info "$hook already exists and isn't ours; leaving it alone"
else
  ln -sf "$PWD/hooks/pre-commit" "$hook"
  info "linked $hook"
fi

echo
echo "Done. Next:"
echo "  source .venv/bin/activate"
echo "  ansible all -m ping"
