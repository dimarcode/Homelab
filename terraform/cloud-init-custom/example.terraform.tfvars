virtual_environment_endpoint = "https://your-pve-node-ip:8006/"

# Choose one authentication method:
virtual_environment_token = "terraform@pve!terraform=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# OR
virtual_environment_username = "terraform@pve!terraform"
# virtual_environment_password = "virtual_environment_password"

vm_passwords = {
  ansible_password      = "change-me"
  time_machine_password = "change-me"
}

vms = {
  time-machine = {
    name           = "time-machine"
    node_name      = "proxmox-bertha"
    cpu_cores      = 2
    memory_mb      = 2048
    disk_gb        = 20
    disk_datastore = "flash"
    network_bridge = "vmbr0"
    ip             = "dhcp"
  }

  # plex = {
  #   name           = "plex"
  #   node_name      = "proxmox-bertha"
  #   cpu_cores      = 4
  #   memory_mb      = 8192
  #   disk_gb        = 32
  #   disk_datastore = "flash"
  #   network_bridge = "vmbr0"
  #   ip             = "dhcp"
  # }
}
