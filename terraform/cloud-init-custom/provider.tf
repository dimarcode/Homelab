terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.93.0" # x-release-please-version
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.virtual_environment_endpoint
  api_token = var.virtual_environment_token
  insecure  = true # <- disables certificate verification
  ssh {
    agent    = true
    username = "root"
  }
}
