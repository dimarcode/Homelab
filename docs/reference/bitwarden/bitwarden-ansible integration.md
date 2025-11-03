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
