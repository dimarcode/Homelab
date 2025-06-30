# HP-ENVY-Desktop

## Overview

Recycled HP tower repurposed as a dedicated Proxmox Backup Server.

## Specifications

[HP Part Surfer Entry](https://partsurfer.hp.com/?searchtext=2MO1302B3B)

- **Product Name:** HP ENVY Desktop TE01-1154 PC
- **Product #:** 319J4AA
- **CPU:** [Intel Core i3-10100T](https://www.intel.com/content/www/us/en/products/sku/199284/intel-core-i310100t-processor-6m-cache-up-to-3-80-ghz/specifications.html)  
  *Note: Actual CPU differs from what’s listed on HP's product page.*
- **RAM:** GNRC RAM UDIMM 16GB DDR4 3200MHz (L93627-800)
- **Motherboard:** [Baker H470](https://support.hp.com/us-en/document/c06638240) (L75365-601)
- **PSU:** 180W ENT20 Gold (L81008-800)
- **Case Size:** 13.28" x 6.12" x 11.97"
- **Date Acquired:** Spring 2025 (already a few years old at that point)

## Role in the Homelab

- **Proxmox Backup Server:** Hosts a bare metal installation of PBS, providing dedicated, reliable storage for VM and LXC backups. Running this separately from the main hypervisor increases fault tolerance and keeps backup tasks isolated.

## Integration / Placement

Placed next to a small UPS for surge protection and safe shutdown during outages, and located beside the network rack for direct connectivity to the main switch.
