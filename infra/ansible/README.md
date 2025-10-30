# Setup ansible

[Ansible docs](https://docs.ansible.com/)
1. Install ansible: [Ansible Installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
2. Generate ssh key: [manage-ssh-keys](../../reference/ssh/manage-ssh-keys.md)
### Install ansible

### Generate ssh key

#### Transfer ssh key to hosts in inventory you'd like to manage

### Create ansible github repo

### Create inventory file

```bash
nano /infra/ansible/inventory.yml
```

#### Contents:

```bash
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[web_servers]
123.456.789.999
```

## Create playbook (example)

## Configure managed nodes

### Add ansible system user

```bash
sudo adduser --system --group --home /home/ansible ansible
```

### Configure password-less sudo for new ansible user

```bash
sudo nano /etc/sudoers.d/ansible
```

#### Add this line:

```bash
ansible ALL=(ALL) NOPASSWD: ALL
```

### Set proper permissions

```bash
sudo chmod 440 /etc/sudoers.d/ansible
```
