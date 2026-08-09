# To-Do's

- Automation with terraform -> ansible
- [Packer](https://developer.hashicorp.com/packer)
- Configure [ssh-agent forwarding](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding) with Forward Agent in ssh-config

## Komodo / Ansible checklist

### Configure ansible control nodes

- [x] Configure control nodes (media and servarr) to allow Komodo installation with Ansible role
- [x] Install Komodo periphery on control nodes
- [ ] Webhooks
- [ ] Automate Komodo server installation

## Ansible

- [ ] Samba
- [ ] Mount network shares
- [ ] Network shares for db backups

## Pi

### NUT server on new pi?

**Goals:**

- [HA OS on pi](https://www.home-assistant.io/installation/raspberrypi)
- [NUT integration for HA OS](https://www.home-assistant.io/integrations/nut/)
- Automate smooth shutdown

**Other links:**
https://www.home-assistant.io/docs/energy/

## Changelog

- In the middle of configuring ansible to create network shares
- Added group_vars files for media server and backup server groups to use when adding samba shares.
