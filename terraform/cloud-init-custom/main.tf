resource "proxmox_virtual_environment_vm" "vm" {
  for_each  = local.vms
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
    import_from  = proxmox_virtual_environment_download_file.cloud_image[each.value.image_key].id
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

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config[each.key].id
  }

  network_device {
    bridge = each.value.network_bridge
  }
}

resource "proxmox_virtual_environment_download_file" "cloud_image" {
  for_each = local.cloud_images

  content_type = "import"
  datastore_id = "local"
  node_name    = "proxmox-bertha"
  url          = each.value.url
  # need to rename the file to *.qcow2 to indicate the actual file format for import
  file_name = each.value.file_name
}

output "vm_ipv4_addresses" {
  value = { for k, vm in proxmox_virtual_environment_vm.vm : k => vm.ipv4_addresses[1][0] }
}
