locals {
  vms = {
    test-ubuntu = {
      name           = "test-ubuntu"
      node_name      = "proxmox-bertha"
      cpu_cores      = 2
      memory_mb      = 2048
      disk_gb        = 20
      disk_datastore = "flash"
      network_bridge = "vmbr0"
      ip             = "dhcp"
      image_key      = "ubuntu"
    }
    test-debian = {
      name           = "test-debian"
      node_name      = "proxmox-bertha"
      cpu_cores      = 2
      memory_mb      = 2048
      disk_gb        = 20
      disk_datastore = "flash"
      network_bridge = "vmbr0"
      ip             = "dhcp"
      image_key      = "debian"
    }
  }
}
