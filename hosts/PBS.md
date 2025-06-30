# Proxmox Backup Server

## Overview

Using PBS on separate hardware (a recycled HP tower) creates a separation of concerns, so that if PVE goes down, I do not lose access to my backups. Using PBS also allows for file-level backup access, and a significant reduction in the use of storage resources. PBS has a significant deduplication factor, and only stores the differences between the initial and subsequent backups. 

## Info

- **Type:** Client-Server Backup software
- **OS:** Proxmox Backup Server
- **Host:** Self

## Resources

[[HP-ENVY-Desktop_(PBS)]]

## Storage

| Type | Drives                                | Usable Size                       | Use                |
| ---- | ------------------------------------- | --------------------------------- | ------------------ |
| ext4 | 1 x IPSG 256GB PRO SATA SSD           | 256GB for OS / 0GB for non-system | OS                 |
| ext4 | 1 x 1TB (NVMe) WDC WDS100T2B0C-00PXH0 | 1TB                               | PVE Backup Storage |

### Datastores

- **pbs-hp-1:** main datastore for VM and LXC backups

## Role in Homelab

- **Local Backups**
