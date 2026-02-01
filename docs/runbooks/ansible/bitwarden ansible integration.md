# bitwarden-ansible integration

- [Bitwarden docs](https://bitwarden.com/help/ansible-integration/)
- [Install the Bitwarden Ansible collection](bitwarden%20ansible%20integration.md#Install%20the%20Bitwarden%20Ansible%20collection)
- [Fetch Bitwarden secrets](bitwarden%20ansible%20integration.md#Fetch%20Bitwarden%20secrets)
	- [Set access token in local environment](bitwarden%20ansible%20integration.md#Set%20access%20token%20in%20local%20environment)
	- [Supply access token in playbook](bitwarden%20ansible%20integration.md#Supply%20access%20token%20in%20playbook)
	- [Set access token in venv](bitwarden%20ansible%20integration.md#Set%20access%20token%20in%20venv)

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

Add (anywhere in middle of file)...:

```bash
deactivate () {
...
unset BWS_ACCESS_TOKEN
...
}
```

...and towards the end of the file:

```bash
if [ -f "$VIRTUAL_ENV/.env" ]; then
    . "$VIRTUAL_ENV/.env"
fi
```

### Reference in playbook

To use bitwarden-ansible integration, first install then:

- create secrets.yml and add: 

```yaml
ansible_become_pass: "{{ lookup('bitwarden.secrets.lookup', '<bitwarden-secret-UUID>') }}"
```

- Then in any playbooks that require the become password, add:

```yaml
vars_files:
    - group_vars/secrets.yml
  vars:
    ansible_become_pass: "{{ ansible_become_pass_id }}"
```
