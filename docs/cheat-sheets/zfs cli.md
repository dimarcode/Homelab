# ZFS Cheat-Sheet

## File System Management

| Command                                          | Description                    |
| ------------------------------------------------ | ------------------------------ |
| `zfs list`                                       | List ZFS file systems          |
| `zfs create <pool>/<filesystem>`                 | Create a ZFS file system       |
| `zfs set <property>=<value> <pool>/<filesystem>` | Set ZFS file system properties |
| `zfs get <property> <pool>/<filesystem>`         | Get ZFS file system properties |
| `zfs destroy <pool>/<filesystem>`                | Destroy a ZFS file system      |

## Pool Management

| Command | Description |
| --- | --- |
| `zpool list` | List ZFS pools |
| `zpool create <pool> <device>` | Create a ZFS pool |
| `zpool destroy <pool>` | Destroy a ZFS pool |
| `zpool iostat` | Display ZFS pool I/O statistics |
| `zpool status` | Display ZFS pool status |
| `zpool history` | Display ZFS pool history |
| `zpool events` | Display ZFS pool events |
| `zpool scrub <pool>` | Scrub a ZFS pool |
| `zpool clear <pool>` | Clear ZFS pool errors |
| `zpool trim <pool>` | Trim a ZFS pool |
| `zpool add <pool> <device>` | Add a device to a ZFS pool |
| `zpool remove <pool> <device>` | Remove a device from a ZFS pool |
| `zpool replace <pool> <device>` | Replace a device in a ZFS pool |
| `zpool offline <pool> <device>` | Offline a device in a ZFS pool |

## Snapshots

| Command | Description |
| --- | --- |
| `zfs list -t snapshot` | List ZFS snapshots |
| `zfs snapshot <pool>/<filesystem>@<snapshot>` | Create a ZFS snapshot |
| `zfs rollback <pool>/<filesystem>@<snapshot>` | Rollback a ZFS snapshot |
| `zfs diff <pool>/<filesystem>@<snapshot_1> <pool>/<filesystem>@<snapshot_2>` | Compare ZFS snapshots |
| `zfs send <pool>/<filesystem>@<snapshot>` | Send ZFS snapshots |
| `zfs receive <pool>/<filesystem>` | Receive ZFS snapshots |

## Clones

| Command | Description |
| --- | --- |
| `zfs clone <pool>/<filesystem>@<snapshot> <pool>/<filesystem>` | Create a ZFS clone |
| `zfs promote <pool>/<filesystem>` | Promote a ZFS clone |
| `zfs rollback <pool>/<filesystem>` | Rollback a ZFS clone |
| `zfs destroy <pool>/<filesystem>` | Destroy a ZFS clone |

## Add mirror to existing zfs pool

- [ ] Wipe/remove existing disk partitions
- [ ] Initialize disk with gpt
- [ ] Create zfs partition on new disk
- [ ] Find partition ID's

```bash
zpool status
```

![[Pasted image 20241101005449.png]]

### Example: 

Syntax:

```bash
zpool attach <new pool name> dev/disk/by-id/<id of existing partition> /dev/disk/by-id/<id of new partition>
```

Pool name: `vault`
Existing partition id (/dev/sdb): `/dev/disk/by-id/wwn-0x5000cca2a3f2dbba-part1`


New partition id (/dev/sda):  `/dev/disk/by-id/wwn-0x5000cca258c166d8

Command:

```bash
zpool attach vault dev/disk/by-id/wwn-0x5000cca2a3f2dbba /dev/disk/by-id/wwn-0x5000cca258c166d8
```

---

```bash
Disk /dev/sda: 12.73 TiB, 14000519643136 bytes, 27344764928 sectors
Disk model: WDC  WUH721414AL
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 6D723F3D-1EE3-4E7F-A35F-41FA6608D42D

Device     Start         End     Sectors  Size Type
/dev/sda1   2048 27344764894 27344762847 12.7T Solaris root


Disk /dev/sdb: 12.73 TiB, 14000519643136 bytes, 27344764928 sectors
Disk model: WDC  WUH721414AL
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 45DBA085-F130-D249-B312-4BB0156AFF81

Device     Start         End     Sectors  Size Type
/dev/sdb1   2048 27344762879 27344760832 12.7T Solaris /usr & Apple ZFS
```

```bash

/dev/sda1: PARTLABEL="zfs-e25f9d12cdd4728e" PARTUUID="3aad12cc-8d94-604a-9b02-cfdff2ad3e16"

/dev/sdb1: LABEL="vault" UUID="4588322229203443646" UUID_SUB="1085432657440638000" BLOCK_SIZE="4096" TYPE="zfs_member" PARTUUID="43d16fbc-b55a-4449-a1da-6a410e09c562"
root@proxmox-bertha:~# 

```

```bash
zpool attach vault /dev/disk/by-partuuid/43d16fbc-b55a-4449-a1da-6a410e09c562 /dev/disk/by-partuuid/3aad12cc-8d94-604a-9b02-cfdff2ad3e16
```
