# move to root packer directory, remove 'example' from filename, replace credentials

proxmox_api_url = "https://change-me:8006/api2/json"  # Your Proxmox IP Address

# proxmox_api_token_id = "root@pam!packer"  # API Token ID
# proxmox_api_token_secret = "your-api-token-secret"

proxmox_username = "root@pam"
proxmox_password = "your-pve-password"

proxmox_node_name = "proxmox-bertha"
ssh_id_ed25519_pub_key = "your-public-key"