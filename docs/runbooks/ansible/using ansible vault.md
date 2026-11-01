# using ansible vault

Secrets are stored encrypted in `vault.yml` files that **are committed to git**. The only thing that unlocks them is the vault password, which lives in Bitwarden Secrets Manager. `ansible.cfg` points `vault_password_file` at `vault-pass.sh`, which fetches it with `bws` every time Ansible needs it, so there's no password prompt and nothing secret on disk except the `bws` access token.

Tree:

```bash
ansible/
├── ansible.cfg              # vault_password_file = ./vault-pass.sh
├── bitwarden.conf           # Secrets Manager secret ID (not sensitive, committed)
├── bws-get.sh               # prints one secret from Bitwarden
├── vault-pass.sh            # prints the vault password (via bws-get.sh)
├── setup.sh                 # turns a fresh clone into a working controller
├── hooks/pre-commit         # blocks unencrypted vault.yml commits
└── inventory/
    ├── hosts.yml
    ├── group_vars/all/
    │   ├── vars.yml         # plain: komodo_passkey: "{{ vault_komodo_passkey }}"
    │   └── vault.yml        # encrypted: vault_komodo_passkey: "..."
    └── host_vars/<host>/
        ├── vars.yml
        └── vault.yml        # only if the host has secrets
```

## New controller (laptop, ansible node, anywhere)

```bash
git clone git@github.com:dimarcode/Homelab.git ~/Homelab
cd ~/Homelab/ansible && ./setup.sh
```

`setup.sh` installs `python3-venv` and `curl` if missing (asks for sudo), installs a checksum-verified `bws` into `~/.local/bin`, prompts once for this machine's access token, generates this machine's ansible SSH key if it doesn't have one, then builds `.venv` and installs the Galaxy roles and collections. Re-running it skips whatever is already done.

Each controller has its own SSH key at `~/.ssh/id_ed25519_ansible`; the private key never leaves the machine and isn't stored in Bitwarden. When `setup.sh` generates one it prints the public key. Add it to the `ansible` user's `authorized_keys` on your hosts yourself (for a brand-new host, `bootstrap-ansible-user.yml` installs the running controller's key).

Then:

```bash
source .venv/bin/activate
ansible all -m ping
```

>[!note] EU Bitwarden accounts need `bws` pointed at the EU server. See `bws config --help`.

## One-time setup in Bitwarden

1. Generate the vault password:

```bash
openssl rand -base64 48
```

2. In the Bitwarden web app, switch to **Secrets Manager**. In your Ansible project, add one secret: `ansible-vault-password`, value = the password from step 1
3. Put the secret's **ID** in `ansible/bitwarden.conf` (`BWS_VAULT_SECRET_ID`) and commit it. IDs aren't sensitive; they're useless without a token.
4. Your Ansible **machine account**:
	- **Projects** tab: **Can read** on the Ansible project. It can read every secret in that project, so keep unrelated secrets elsewhere.
	- **Access tokens** tab: create **one token per machine**, named after it (`thinkpad`, `ansible-node`, ...). Each token is only shown once; paste it into `setup.sh` on that machine. A lost or retired machine is then one revoked token.
5. Also save the vault password as a normal item in your Bitwarden password vault. That's the fallback if Secrets Manager or the token ever breaks:

```bash
ansible-playbook --ask-vault-pass <playbook>
```

>[!warning] If a machine is lost: revoke its token and remove its public key from your hosts. Revoking only stops future fetches; the machine keeps anything it already decrypted, so also `ansible-vault rekey` the vault files.

## Adding and using secrets

Edit the vault (decrypts in your editor, re-encrypts on save):

```bash
ansible-vault edit inventory/group_vars/all/vault.yml
```

Add secrets with a `vault_` prefix:

```yml
vault_komodo_passkey: "<key value>"
```

Map them to readable names in the plain `vars.yml` next to it:

```yml
komodo_passkey: "{{ vault_komodo_passkey }}"
```

Playbooks just use `{{ komodo_passkey }}`. No `vars_files` needed: anything in `inventory/group_vars` and `inventory/host_vars` loads automatically.

Create a new vault file for a host:

```bash
mkdir -p inventory/host_vars/<host>
ansible-vault create inventory/host_vars/<host>/vault.yml
```

Check a file is encrypted before committing (the pre-commit hook also checks this):

```bash
head -n 1 inventory/group_vars/all/vault.yml
```

You should see:

```bash
$ANSIBLE_VAULT;1.1;AES256
```

## Migrating from the old layout (one time)

The old layout kept `inventory.yml`, `playbooks/host_vars/` and `playbooks/group_vars/all/vault.yml` gitignored, with the vault password in `~/.ansible/.vault_pass`. Do this on the machine that has those files, after the Bitwarden setup above.

Pull the change and run setup, so `bws`, the token and `.venv` are in place:

```bash
cd ~/Homelab/ansible
./setup.sh
source .venv/bin/activate
```

Move the gitignored files into the new layout:

```bash
mv inventory.yml inventory/hosts.yml
mv playbooks/host_vars inventory/host_vars
mv playbooks/group_vars/all/vault.yml inventory/group_vars/all/vault.yml
```

Decrypt the vault with the **old** password, rename its keys to `vault_*` (`vault_komodo_passkey`, `vault_cody_samba_password`, `vault_svc_backup_samba_password`, ...), then re-encrypt with the new one from Bitwarden:

```bash
ansible-vault decrypt --vault-password-file ~/.ansible/.vault_pass inventory/group_vars/all/vault.yml
nano inventory/group_vars/all/vault.yml
ansible-vault encrypt inventory/group_vars/all/vault.yml
```

Look for plaintext secrets in host_vars and move any into `host_vars/<host>/vault.yml`:

```bash
grep -n -i -E 'pass|secret|token|key' inventory/host_vars/*.yml
```

Check everything works, then remove the old password file:

```bash
ansible-inventory --graph
ansible all -m ping
rm ~/.ansible/.vault_pass
```
