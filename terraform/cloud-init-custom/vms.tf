data "local_file" "ssh_public_key" {
  filename = pathexpand(var.ansible_ssh_public_key_path)
}

locals {
  cloud_init_template_vars = merge(
    {
      ssh_public_key = trimspace(data.local_file.ssh_public_key.content)
    },
    var.vm_passwords,
  )
}

resource "proxmox_virtual_environment_file" "cloud_init" {
  for_each = var.vms

  content_type = "snippets"
  datastore_id = var.cloud_init_datastore_id
  node_name    = each.value.node_name

  source_raw {
    data      = templatefile("${path.module}/cloud-init/${each.key}.yaml", local.cloud_init_template_vars)
    file_name = "user-data-${each.key}.yaml"
  }
}

resource "proxmox_virtual_environment_vm" "vm" {
  for_each = var.vms

  name      = each.value.name
  node_name = each.value.node_name

  agent {
    enabled = true
  }

  cpu {
    cores = each.value.cpu_cores
  }

  memory {
    dedicated = each.value.memory_mb
  }

  disk {
    datastore_id = each.value.disk_datastore
    import_from  = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = each.value.disk_gb
  }

  initialization {
    # uncomment and specify the datastore for cloud-init disk if default `local-lvm` is not available
    # datastore_id = "local-lvm"

    ip_config {
      ipv4 {
        address = each.value.ip
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_init[each.key].id
  }

  network_device {
    bridge = each.value.network_bridge
  }
}

moved {
  from = proxmox_virtual_environment_vm.ubuntu_vm
  to   = proxmox_virtual_environment_vm.vm["time-machine"]
}

moved {
  from = proxmox_virtual_environment_file.user_data_cloud_config
  to   = proxmox_virtual_environment_file.cloud_init["time-machine"]
}

output "vm_ipv4_addresses" {
  description = "Primary IPv4 address per VM (requires qemu-guest-agent)"
  value = {
    for name, vm in proxmox_virtual_environment_vm.vm :
    name => try(vm.ipv4_addresses[1][0], null)
  }
}
