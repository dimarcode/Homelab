# Fix boot after adding nvme

## Preparation

In this instance, I had to boot from [SystemRescue](https://www.system-rescue.org/) installed on a bootable USB. After installing on the USB and booting to it:

>[!note] You may also want to stop any VM's from booting that have PCI passthrough configured. To do this, I had to remove the new nvme, boot into PVE and change the config.

## Step 1: Activate your LVM volumes

```bash
sudo vgchange -ay
```

## Step 2: Find your root logical volume

List block devices and LVM volumes:

```bash
lsblk
sudo lvs
```

Look for your root volume, usually `/dev/pve/root` or similar.

## Step 3: Mount your root filesystem

```bash
sudo mkdir /mnt/proxmox_root
sudo mount /dev/pve/root /mnt/proxmox_root
```

If you get an error, check `lsblk` output again and adjust the device path.

## Step 4: Update /etc/network/interfaces

Run `ip link` to get a list of the network cards currently detected.

```bash
ip link
```

You're looking for a line like this:
`2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast` etc...

Edit /etc/network/interfaces:

```bash
sudo nano /mnt/proxmox_root/etc/network/interfaces
```

Change the name of this device in the `/etc/network/interfaces` file where the old name occurs, and reboot the node

Example:

```bash
# /etc/network/interfaces:

auto lo
iface lo inet loopback

auto enp4s0
iface enp4s0 inet manual

auto vmbr0
iface vmbr0 inet static
        address 192.168.xx.xxx/24
        gateway 192.168.xx.xxx
        bridge-ports enp4s0
        bridge-stp off
        bridge-fd 0
```

(Change enp4so to enp5so)

## Important!! Unmount /mnt/proxmox_root

After editing, cleanly unmount:

```bash
sudo umount /mnt/proxmox_root
```

Reboot
