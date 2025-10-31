# VPN Fix for Unprivileged Proxmox LXC Containers

Edit `/etc/pve/lxc/<container number>.conf` and add:

```
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net dev/net none bind,create=dir
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```
