# Useful links

- [Ansible docs](https://docs.ansible.com/)
- [Setup Ansible](ansible%20setup.md)
- [Using Ansible Vault](using%20ansible%20vault.md)

## Easy way to install packages/collections/roles:

Run from the root of the ansible project directory. It creates `.venv`, installs **requirements.txt** and **requirements.yml**, links the pre-commit hook and checks the vault password:

```bash
./setup.sh
```

Then activate the venv:

```bash
source .venv/bin/activate
```

### Doing it by hand

```bash
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

**requirements.yml** holds both roles and collections:

```bash
ansible-galaxy install -r requirements.yml
```

# Useful Roles

```bash
ansible-galaxy role install bpbradley.komodo
```

```bash
ansible-galaxy role install geerlingguy.docker
```

```bash
ansible-galaxy role install geerlingguy.nginx
```

```bash
ansible-galaxy role install geerlingguy.apache
