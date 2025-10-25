# Format and mount a hard disk

## Identify the new disk

```
lsblk
```

## Let's say it's /dev/sdb

```bash
sudo fdisk /dev/sdb
```

## create a new partition 

(n → p → accept defaults → w)

## Format it

```
sudo mkfs.ext4 /dev/sdb1
```

## Create mount point and mount

```bash
sudo mkdir -p /path/to/mount/point
```

### Mount

```bash
sudo mount /dev/sdb1 /path/to/mount/point
```

## Persist in /etc/fstab

Always make a backup before modifying:

**If you want to use UUID:**

Find UUID:

```bash
sudo blkid /dev/sdb1
```

You’ll get output like:

```
/dev/sdb1: UUID="1234-5678-abcd-ef01" TYPE="ext4"
```

- Copy the UUID and filesystem type

Always make a backup before modifying:

```bash
sudo cp /etc/fstab /etc/fstab.bak
```

```bash
sudo nano /etc/fstab
```

Add new line:

```bash
<dev/name-or-UUID> /path/to/mount/point <filesystem-type> defaults 0 2
```
