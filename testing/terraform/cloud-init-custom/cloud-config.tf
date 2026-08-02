data "local_file" "ssh_public_key" {
  filename = pathexpand("~/.ssh/id_ed25519_ansible.pub")
}

resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = "proxmox-bertha"

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: test-ubuntu
    timezone: America/New_York
    users:
      - default
      - name: ansible
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - net-tools
      - curl
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}