# Copy to terraform.tfvars and fill in your secrets. VM definitions live in vms.tf.
#
#   cp example.tfvars terraform.tfvars

virtual_environment_endpoint = "https://your-pve-node-ip:8006/"

# Choose one authentication method:
virtual_environment_token = "terraform@pve!terraform=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
# OR
virtual_environment_username = "terraform@pve!terraform"
# virtual_environment_password = "virtual_environment_password"

# Optional — not currently used by cloud-init
# vm_passwords = {
#   ansible_password = "your-password-here"
# }

# OR
# virtual_environment_auth_ticket = "virtual_environment_auth_ticket"
# virtual_environment_csrf_prevention_token = "virtual_environment_csrf_prevention_token"
