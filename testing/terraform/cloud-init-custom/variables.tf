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
}

variable "vm_passwords" {
  type      = map(string)
  sensitive = true
}

variable "vms" {
  type = map(object({
    name            = string
    node_name       = string
    cpu_cores       = number
    memory_mb       = number
    disk_gb         = number
    disk_datastore  = string
    network_bridge  = string
    ip              = string
  }))
}