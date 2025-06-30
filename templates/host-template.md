# Hostname

## Overview

## Info

- **Type:** 
- **OS:** 
- **Host:**

## Resources

- **CPU**
- **GPU**
- **RAM:**
- **Storage:**

## Storage

| Storage Type | Drives | Usable Size | Use |
| ------------ | ------ | ----------- | --- |
| LVM          |        |             |     |

- **Local Backup:**
- **Remote Backup:**

## Apps

### Installed

| Name | Port(s) | Notes |
| ---- | ------- | ----- |
|      |         |       |
|      |         |       |

## Stacks

| Name | App(s) | Notes |
| ---- | ------ | ----- |
|      |        |       |
|      |        |       |

## Mounts

### Mount Example

- **Source:**
- **Mount Point:**
- **Notes:**

Mount command if using smb credentials file:
```bash
sudo mount -t cifs //<source-ip>/<source-path> /<local-path> -o credentials=/<path>/.smbcreds,uid=XXXX,gid=XXXX,defaults
```

Mount command if NOT using smb credentials file:
```
sudo mount -t cifs //<source-ip>/<source-path> /<local-path> -o username=<smb-username>,password=<smb-password>,uid=XXXX,gid=XXXX,defaults
```

### /etc/fstab

**SMB Mount Template:**
```bash
//<source-ip>/<source-path> /<local-path> cifs credentials=/<path>/.smbcreds,uid=XXXX,gid=XXXX,defaults 0 0
```

## Shares

### Share Example

| Destination | Share Path | Notes |
| ----------- | ---------- | ----- |
|             |            |       |

### /etc/samba/smb.conf

```bash
[sharename]
    path = /<source-path>
    browsable = yes
    read only = no
    guest ok = no
    valid users = <user>
```
