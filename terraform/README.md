# Terraform Project

## Install terraform

Go to [[https://developer.hashicorp.com/terraform/install#linux]] and download for your specific cpu architecture:

- Copy link address for achitecture

```bash
cd ~ && wget <paste-download-url-here>
```

- Unzip the package (must have unzip installed)

```bash
unzip <name-of-package>
```

- Change permissions of terraform install

```bash
sudo chown root:root terraform
```

- Move to /usr/local/bin

```bash
sudo mv terraform /usr/local/bin
```

- Test correct directory

```bash
command -v terraform
```

- Should print /usr/local/bin/terraform

## Commands

**terraform plan**: shows execution plan

```bash
terraform plan
```

**terraform apply**: creates resources

```bash
terraform apply
```

**terraform destroy**: destroys resources

```bash
terraform destroy
```

**terraform init**: initialize a working directory containing Terraform configuration files

```bash
terraform init
```

## Required role permissions (Proxmox 8)

```bash
Datastore.AllocateSpace
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
VM.Migrate
VM.Monitor
VM.PowerMgmt
```
