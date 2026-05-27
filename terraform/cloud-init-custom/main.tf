resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = var.image_datastore_id
  node_name    = var.proxmox_node_name
  url          = var.ubuntu_cloud_image_url
  # need to rename the file to *.qcow2 to indicate the actual file format for import
  file_name = "jammy-server-cloudimg-amd64.qcow2"
}
