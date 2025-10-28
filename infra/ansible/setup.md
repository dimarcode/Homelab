# setup

## Setup ansible

### Create inventory file

```bash
[all:vars]
ansible_ssh_common_args='-o StrictHostKeyChecking=no'

[web_servers]
123.456.789.999
```

## Configure hosts in inventory

>[!note] must be done on all hosts you want to manage with ansible

### Add ansible system user:

```bash
sudo adduser --system --group --home /home/ansible ansible
```

### Configure password-less sudo for new ansible user:

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
