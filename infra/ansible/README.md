# Setup ansible

[Ansible docs](https://docs.ansible.com/)

## Control node configuration

### Install ansible: [Ansible Installation guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

### Generate ssh key: [manage-ssh-keys](../../reference/ssh/manage-ssh-keys.md)

```bash
`ssh-keygen -t ed25519 -C "ansible@$(hostname)" -f ~/.ssh/ansible`
```

### Transfer ssh key to managed nodes

```bash
ssh-copy-id -i ~/.ssh/ansible.pub user@target-host
```

### Create GitHub repo or pull an existing one

>[!note] Link: [Create New Local Repo and Push to Github](../../reference/git/Create%20New%20Local%20Repo%20and%20Push%20to%20Github.md)

```bash
git clone 
```

### Create `inventory.yaml` and add hosts

>[!note] More info:  [How to build your inventory](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html) 

```bash
nano ~/Homelab/infra/ansible/inventory.yml
```

Leaving this here for now until I can look into it more. This was taken from [this article](https://www.learnlinux.tv/complete-ansible-semaphore-tutorial-from-installation-to-automation/)

```bash
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

### Configure with `ansible.cfg`

#### Create the file:

>[!important] The contents of this file will override any other `ansible.cfg` files you might have on your node. For example, the default `/etc/ansible/ansible.cfg`

```bash
sudo nano ~/Homelab/infra/ansible/ansible.cfg
```

#### Add the following:

```bash
[defaults]
inventory = inventory.yaml
private_key_file = ~/.ssh/ansible
```

>[!note] This simplifies your ansible commands:
>
>Ad-hoc commands:
>- OLD: `ansible <target> --key-file ~/.ssh/ansible -i inventory -m <command>`
>- NEW: `ansible <target> -m <command>`
>
>Example:
>```bash
>ansible testing -m ping
>```
>
>Ansible-playbook commands:
>- Old: `ansible-playbook...`
>- New: `ansible-playbook...`
>
>Example:
>```bash
>example
>```

### Start creating [playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html#playbook-syntax) or add [roles](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_reuse_roles.html)

## Configure managed nodes

1.  Add new system user that you'd like to run ansible on managed node (ex. ansible)

```bash
sudo adduser --system --group --home /home/ansible ansible
```

2.  Configure password-less sudo for new ansible user

```bash
sudo nano /etc/sudoers.d/ansible
```

3. Add this line:

```bash
ansible ALL=(ALL) NOPASSWD: ALL
```

4. Set proper permissions:

```bash
sudo chmod 440 /etc/sudoers.d/ansible
```
