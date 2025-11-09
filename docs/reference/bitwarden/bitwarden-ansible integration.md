# bitwarden-ansible integration

- https://bitwarden.com/help/ansible-integration/

## Install the Bitwarden Ansible collection

Install SDK for your user account (doing this because I already had ansible running):

```bash
pip install --user bitwarden-sdk
```

```bash
ansible-galaxy collection install bitwarden.secrets
```

## Fetch Bitwarden secrets

### Set access token in local environment

Set your access token environment variable:

```bash
export BWS_ACCESS_TOKEN=<ACCESS_TOKEN_VALUE>
```

Example for how to use lookup plugin to populate variables in a playbook:

```bash
  vars:
        database_password: "{{ lookup('bitwarden.secrets.lookup', '<SECRET_ID>') }}" 
```

### Supply access token in playbook

- Avoids setting the `BWS_ACCESS_TOKEN` env variable
- Allows multiple access tokens to be referenced in a single playbook

```bash
vars:
    password_with_a_different_access_token: "{{ lookup('bitwarden.secrets.lookup', '<SECRET_ID_VALUE>', 
access_token='<ACCESS_TOKEN_VALUE>') }}"
```

### Set access token in venv

- Create .env file in .venv folder and add:

```bash
export BWS_ACCESS_TOKEN="<your-token-here>"
```

- Edit ~/path/to/.venv/bin/activate

```bash
sudo nano ~/Homelab/ansible/.venv/bin/activate
```

Add:

```bash
deactivate () {
...
unset BWS_ACCESS_TOKEN
...
}
```

and towards the end of the file:

```bash
if [ -f "$VIRTUAL_ENV/.env" ]; then
    . "$VIRTUAL_ENV/.env"
fi
```
