variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
}

variable "virtual_environment_token" {
  type        = string
  description = "The token for the Proxmox Virtual Environment API"
}

variable "virtual_environment_username" {
  type        = string
  description = "The username for the Proxmox Virtual Environment API"
  default     = null
}

variable "proxmox_node_name" {
  type        = string
  description = "Default Proxmox node for shared resources (cloud image download)"
  default     = "proxmox-bertha"
}

variable "image_datastore_id" {
  type        = string
  description = "Datastore for the downloaded Ubuntu cloud image"
  default     = "local"
}

variable "cloud_init_datastore_id" {
  type        = string
  description = "Datastore for cloud-init snippets"
  default     = "local"
}

variable "ubuntu_cloud_image_url" {
  type        = string
  description = "URL of the Ubuntu cloud image to import"
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}

variable "ansible_ssh_public_key_path" {
  type        = string
  description = "Path to the SSH public key injected into cloud-init for Ansible"
  default     = "~/.ssh/id_ed25519_ansible.pub"
}

variable "vm_passwords" {
  type        = map(string)
  description = "Passwords referenced in cloud-init/*.yaml templatefile variables"
  sensitive   = true
}

variable "vms" {
  type = map(object({
    name           = string
    node_name      = string
    cpu_cores      = number
    memory_mb      = number
    disk_gb        = number
    disk_datastore = string
    network_bridge = string
    ip             = string
  }))
  description = "VMs to provision; each key must match cloud-init/<key>.yaml"
}
