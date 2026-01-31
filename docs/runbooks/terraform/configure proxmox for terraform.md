# Terraform for Proxmox

## Prerequisites:

- Working Proxmox node
- [Create Debian VM Template](../proxmox/Create%20Debian%20VM%20Template.md)
- URL for main Proxmox node
- Name of VM template


https://proxmox-bertha:8006

### Proxmox group, role, and user with the necessary permissions for Terraform

Create terraform user

```bash
pveum useradd terraform@pve
```

Set password for terraform user

```bash
pveum passwd terraform@pve
```

Add TerraformProvision role with necessary permissions

```bash
pveum roleadd TerraformProvision -privs "Datastore.Allocate Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate SDN.Use Sys.Audit Sys.Console Sys.Modify Sys.PowerMgmt VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.CPU VM.Config.Cloudinit VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.GuestAgent.Audit VM.Migrate VM.PowerMgmt"
```

## Required role permissions (Proxmox 9)

```bash
Datastore.Allocate
Datastore.AllocateSpace
Datastore.AllocateTemplate
Datastore.Audit
Pool.Allocate
SDN.Use
Sys.Audit
Sys.Console
Sys.Modify
Sys.PowerMgmt
VM.Allocate
VM.Audit
VM.Clone
VM.Config.CDROM
VM.Config.CPU
VM.Config.Cloudinit
VM.Config.Disk
VM.Config.HWType
VM.Config.Memory
VM.Config.Network
VM.Config.Options
VM.GuestAgent.Audit
VM.Migrate
VM.PowerMgmt
```

Associate terraform user with TerraformProvision role

```bash
pveum aclmod / -user terraform@pve -role TerraformProvision
```

Create API token `terraform` for packer user

>[!warning] 
>Write down the token value!!!!

```bash
pveum user token add terraform@pve terraform --privsep 0
```
