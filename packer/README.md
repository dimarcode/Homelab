# Packer Project 

## Prerequisites

### Proxmox group, role, and user with the necessary permissions for Packer

Create packer user

```bash
pveum useradd packer@pve
```

Set password for packer user

```bash
pveum passwd packer@pve
```

Add PackerProvision role with necessary permissions

```bash
pveum roleadd PackerProvision -privs "VM.Audit VM.Allocate VM.Console VM.PowerMgmt VM.Config.CPU VM.Config.Memory VM.Config.Disk VM.Config.Network VM.Config.Options VM.Config.CDROM VM.Config.HWType Datastore.Audit Datastore.AllocateSpace Datastore.AllocateTemplate Sys.Audit Sys.Modify"
```

Associate packer user with PackerProvision role

```bash
pveum aclmod / -user packer@pve -role PackerProvision
```

Create API token `packer` for packer user

>[!warning] 
>Write down the token value!!!!

```bash
pveum user token add packer@pve packer --privsep 0
```

### Install Packer

