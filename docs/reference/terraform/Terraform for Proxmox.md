# Terraform for Proxmox

## Prerequisites:

- Working Proxmox node
- [Create Debian VM Template](../proxmox/Guides/Create%20Debian%20VM%20Template.md)
- URL for main Proxmox node
- Name of VM template


https://proxmox-bertha:8006

## Guide

### PVE Config

**Create Terraform user:**

- Datacenter > Users > Add
- User name: `terraform`

**Add roles:**

- Datacenter > Roles > Create
- Name: TerraformProvision
- [Privileges](terraform-provision-privileges.md)

**Add group:**

![](add-permissions.png)

**Add terraform user to new group:**

![](Pasted%20image%2020250810202713.png)

**Create API token:**

![](Pasted%20image%2020250810202939.png)

>[!note] Don't forget to uncheck Privilege Separation
