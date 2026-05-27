# Proxmox VMs (cloud-init)

Terraform provisions Ubuntu VMs on Proxmox from a shared cloud image. Each VM has:

- **Sizing and network** in the `vms` map in `terraform.tfvars`
- **First-boot config** in `cloud-init/<vm-key>.yaml` (cloud-config templates)

## Layout

```
cloud-init-custom/
├── provider.tf              # Provider configuration
├── variables.tf             # Variable definitions
├── main.tf                  # Shared Ubuntu cloud image download
├── vms.tf                   # VMs and cloud-init snippets (for_each over vms)
├── cloud-init/
│   ├── time-machine.yaml    # cloud-config for time-machine
│   └── plex.example.yaml    # Copy to plex.yaml when adding that VM
├── example.terraform.tfvars
└── terraform.tfvars         # Your secrets (not committed)
```

## Setup

Copy the example vars and edit secrets and VM definitions:

```bash
cp example.terraform.tfvars terraform.tfvars
nano terraform.tfvars
```

## Run

```bash
terraform init
terraform plan
terraform apply
```

## Add a VM

1. Create `cloud-init/<name>.yaml` (see `plex.example.yaml`).
2. Add any new `${...}` template variables to `vm_passwords` in `terraform.tfvars`.
3. Add a `<name>` entry to the `vms` map in `terraform.tfvars`.
4. `terraform plan` and `terraform apply`.

The map key, `vms.<key>.name`, Proxmox VM name, and `cloud-init/<key>.yaml` should all match for clarity.
