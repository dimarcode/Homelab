# exit code 100 when running apt-get update

Links:
- https://pve.proxmox.com/wiki/Package_Repositories

Your system is pointing to the **Proxmox Enterprise repository**

To resolve this, disable the enterprise repo and enable the **no-subscription** repo.

## Before anything complicated, check the UI

**[pve-node] > updates > repositories**

- Click `File: /etc/apt/sources.list.d/pve-enterprise.sources` and disable
- Run `apt-get update` again

If for whatever reason you need to use the CLI, here are the steps:

## Using the CLI/shell

### 1. Disable the enterprise repository

Edit the enterprise repo file:

```bash
nano /etc/apt/sources.list.d/pve-enterprise.list
```

Comment out the existing line by adding `#` at the front:

```bash
deb https://enterprise.proxmox.com/debian/pve trixie pve-enterprise
```

### 2. Enable the _no-subscription_ repository

Create or edit this file:

```bash
nano /etc/apt/sources.list.d/pve-no-subscription.list
```

Add:

```bash
deb http://download.proxmox.com/debian/pve trixie pve-no-subscription
```

Save and exit.

### 3. Update packages again

```bash
apt-get update
```

### 4. (Optional) Disable the enterprise repo for Ceph too

```bash
nano /etc/apt/sources.list.d/ceph.list
```

Comment out any enterprise lines.
