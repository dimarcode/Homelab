# exit code 100 when running apt-get update

Links:
- https://pve.proxmox.com/wiki/Package_Repositories

You are seeing this because your system is still pointing to the **Proxmox Enterprise repository**, which requires a valid subscription. Without a subscription, apt correctly returns **401 Unauthorized** and then blocks updates because the repo cannot be verified.

To resolve this, disable the enterprise repo and enable the **no-subscription** repo.

## 1. Disable the enterprise repository

Edit the enterprise repo file:

```bash
nano /etc/apt/sources.list.d/pve-enterprise.list
```

Comment out the existing line by adding `#` at the front:

```bash
deb https://enterprise.proxmox.com/debian/pve trixie pve-enterprise
```

Save and exit.

## 2. Enable the _no-subscription_ repository

Create or edit this file:

```bash
nano /etc/apt/sources.list.d/pve-no-subscription.list
```

Add:

```bash
deb http://download.proxmox.com/debian/pve trixie pve-no-subscription
```

Save and exit.

## 3. Update packages again

```bash
apt-get update
```

## 4. (Optional) Disable the enterprise repo for Ceph too

```bash
nano /etc/apt/sources.list.d/ceph.list
```

Comment out any enterprise lines.
