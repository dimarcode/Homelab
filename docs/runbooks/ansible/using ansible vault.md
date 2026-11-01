# using ansible vault

Secrets are stored encrypted in `vault.yml` files that **are committed to git**. The only thing that unlocks them is the vault password, which lives in Bitwarden Secrets Manager. `ansible.cfg` points `vault_password_file` at `vault-pass.sh`, which fetches it with `bws` every time Ansible needs it, so there's no password prompt and nothing secret on disk except the `bws` access token.

Tree:

```bash
ansible/
├── ansible.cfg              # vault_password_file = ./vault-pass.sh
├── vault-pass.sh            # prints the vault password from Bitwarden
├── setup.sh                 # venv + galaxy installs + pre-commit hook + bws check
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

## One-time setup in Bitwarden

1. Generate the vault password:

```bash
openssl rand -base64 48
```

2. In the Bitwarden web app, switch to **Secrets Manager**:
	- Create a project: `homelab-ansible`
	- Create a secret in it: `ansible-vault-password`, value = the password from step 1
	- Copy the secret's **ID** (needed for `vault-pass.sh`)
3. **Machine accounts → New**: `ansible-controller`
	- **Projects** tab: give it **Can read** on `homelab-ansible` only
	- **Access tokens** tab: create a token and copy it (it's only shown once)
4. Also save the vault password as a normal item in your Bitwarden password vault. That's the fallback if Secrets Manager or the token ever breaks:

```bash
ansible-playbook --ask-vault-pass <playbook>
```

## Controller setup

Install `bws` from the [releases page](https://github.com/bitwarden/sdk-sm/releases) (`bws-x86_64-unknown-linux-gnu-*.zip`) and put it on your PATH, e.g. `~/.local/bin/bws`.

>[!note] EU Bitwarden accounts need `bws` pointed at the EU server. See `bws config --help`.

Save the access token:

```bash
mkdir -p ~/.config/bws && chmod 700 ~/.config/bws
install -m 600 /dev/null ~/.config/bws/token
nano ~/.config/bws/token
```

Put the secret ID in `ansible/vault-pass.sh` (replace `REPLACE_WITH_SECRET_ID`). The ID isn't sensitive; it's useless without the token, so commit it.

Run setup:

```bash
cd ~/Homelab/ansible && ./setup.sh
```

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

The old layout kept `inventory.yml`, `playbooks/host_vars/` and `playbooks/group_vars/all/vault.yml` gitignored, with the vault password in `~/.ansible/.vault_pass`. After pulling this change on the controller:

```bash
cd ~/Homelab/ansible
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
