## Setup

### Input secrets in terraform.tfvars

```bash
cp cp terraform.tfvars.example terraform.tfvars && nano terraform.tfvars
```

### Maybe: add ssh key to ssh-agent

#### Start ssh-agent
```bash
eval "$(ssh-agent -s)"
```

#### Add your private key
```bash
ssh-add ~/.ssh/id_ed25519_terraform
```

#### Verify
```bash
ssh-add -L
```

## To-Do:

- Verify whether actually using ssh to connect