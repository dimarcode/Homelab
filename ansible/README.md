# Useful links

- [Ansible docs](https://docs.ansible.com/)
- [Setup Ansible](reference/ansible-setup.md)
- [Bitwarden-Ansible integration](reference/bitwarden-ansible-integration)

## Easy way to install packages/collections/roles:

### Install python packages from file

Activate the venv

```bash
source .venv/bin/activate
```

After filling in **requirements.txt**, run the following commands within the root of the ansible project directory:

```bash
pip install -r requirements.txt
```

### Install Ansible collections and roles

After filling in **roles.yml** and **collections.yml**, run the following commands within the root of the ansible project directory:

Commands

```bash
mkdir {collections,roles,inventory}
```

```bash
ansible-galaxy role install -r roles.yml && ansible-galaxy collection install -r collections.yml
```