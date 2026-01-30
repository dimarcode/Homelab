# Create Debian VM Template

## Intro

Credit: Commands/directions are adapted and/or copied from [James Turland's guide](https://github.com/JamesTurland/JimsGarage/tree/main/Kubernetes/Cloud-Init) for making an Ubuntu VM template in proxmox: [youtube guide here](https://youtu.be/Kv6-_--y5CM?si=KRTo7RTKOuThMJJM). I just applied the directions to Debian because Debian doesn't offer a .img file for cloud images. Unlike with Ubuntu, you cannot download any of the available Debian file types directly to the ISO directory in Proxmox, because they available in a compatible file type for that storage. Instead, you have to use the CLI to download a .raw image, rename to .img image, then move it to the ISO directory manually.

There are two ways to download the disk img, based on your distro:
- For [Debian](Create%20Debian%20VM%20Template.md#Debian%20.img%20download)
- For [Ubuntu](#Ubuntu%20.img%20download)

The following steps are the same either way.

### Links:

Debian cloud images: https://cloud.debian.org/images/cloud/
Ubuntu cloud images: https://cloud-images.ubuntu.com/

## Debian .img download

### Download disk image file

#### CD to downloads directory

```bash
cd /<some-downloads-directory>
```

#### Download

```bash
wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.raw
```

### Rename to .img file

```bash
mv debian-12-generic-amd64.raw debian-12-generic-amd64.img
```

### Move .img file to Proxmox ISO directory

```bash
mv debian-12-generic-amd64.img /var/lib/vz/template/iso/
```

## Ubuntu .img download

### Download OS disk image for template

https://cloud-images.ubuntu.com/ > OS Version > Current > cloud-img-version

Right click link for disk, and then copy the link destination

In Proxmox GUI:

`Node` > `Local` (or whichever storage has your ISO files) > click  `Download from URL` > paste into `URL:` > click `Query URL` > `Download`

# Template creation

## Create VM in CLI

### Create VM

```bash
qm create <vm> --memory <memory-amount> --core <core-amount> --cpu host --balloon 0 --name <vm-name> --net0 virtio,bridge=<bridge-interface>
```

>[!note] (Bridge interface is usually `vmbr0`)

### Import disk img to VM

#### CD to Proxmox ISO directory

```bash
cd /var/lib/vz/template/iso
```

#### Import disk to VM

```bash
qm importdisk <vm> <disk-img> <storage>
```

### Attach the disk to the VM

```bash
qm set <vm> --scsihw virtio-scsi-pci --scsi0 <storage>:vm-<VM-ID>-disk-0
```

>[!note] This is like mounting the boot drive to a physical machine

### Resize the disk

```bash
qm disk resize <vm> scsi0 +6416M
```

### Add ssd emulation

```bash
qm set <vm> --scsi0 local-lvm:vm-<VM-ID>-disk-0,ssd=1
```

### Attach cloud-init

#### Attach virtual media drive with cloud-init disk inserted

```bash
qm set <vm> --ide2 <storage>:cloudinit
```

### Set boot drive

```bash
qm set <vm> --boot c --bootdisk scsi0
```

### Add serial interface

```bash
qm set <vm> --serial0 socket --vga serial0
```

>[!note] This is like pluggin in a VGA monitor

### Additional Cloud-Init Configuration

Steps:
- Username: `<some-username>`
- Password:`<some-password>`
- Add SSH keys
- Set IP Config > IPv4: DHCP

>[!Warning] DO NOT START THE VM!!!!!!!!!!!!!!!!

## Create VM template

Right click the VM in the GUI > Convert to template

## Cloning the VM

Right click VM template > Clone

Set:
- Mode: `Full Clone`
- VM ID: `<id>`
- Name: `<name>`
