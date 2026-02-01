# using ansible vault

## Create vault password file

Create `.vault_pass` file, and add password in plain text:

```bash
nano ~/.ansible/.vault_pass
```

Set proper permissions:

```bash
chmod 600 ~/.ansible/.vault_pass
```

Add to `ansible.cfg`:

```yml
[defaults]
vault_password_file = ~/.ansible/.vault_pass
...
```

**IMPORTANT - Add to .gitignore:**

>[!warning] DO NOT SKIP!!!!!

```bash
.vault_pass
*.vault_pass
```

## Create ansible vault file (`vault.yml`)

Tree:

```bash
ansible/playbooks directory:

playbooks/
├── group_vars/
│   ├── all/
│   │   ├── vars.yml
│   │   └── ****vault.yml****
│   ├── secrets.example.yml
│   └── secrets.yml
├── host_vars/
|	├── media.yml
```

```bash
nano playbooks/group_vars/all/vault.yml
```

Add your secrets like so:

```yml
ansible_user_pass: "<key value>"
```

## Encrypting and decrypting the file

Encrypting the file:

```bash
ansible-vault encrypt playbooks/group_vars/all/vault.yml
```

Test:

```bash
head -n 2 playbooks/group_vars/all/vault.yml
```

You should see:

```bash
$ANSIBLE_VAULT;1.1;AES256
```

## Editing and using the secrets

Editing:

```bash
ansible-vault edit playbooks/group_vars/all/vault.yml
```

Using the secret:

```yml
tasks:
    - group:
        name: ansible
        gid: 1005
        state: present
    - user:
        password: "{{ ansible_user_pass }}"
```
