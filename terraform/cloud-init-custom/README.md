# README

## Setup

### Input secrets in terraform.tfvars**

```bash
cp example.tfvars .tfvars && nano .tfvars
```

## Run it:

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

## Define a new OS

Requires updating [images.tf](./images.tf), and specifying the OS using the image_key variable in [vms.tf](./vms.tf)