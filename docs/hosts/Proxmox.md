# Proxmox Virtual Environment (Unified Server)

## Overview

This is the main server in my homelab, built from spare parts of previous PCs. It runs Proxmox Virtual Environment, which allows me to create and manage virtual machines and LXC containers. With it, I experiment with operating systems, configure Network Attached Storage (NAS), containerize applications, and test various self-hosted services.

## Info

- **Hostname:** Proxmox-Bertha
- **Type:** Hypervisor
- **OS:** Proxmox Virtual Environment 8
- **Host:** Self

## Hardware

- **Motherboard:** [Asus Tuf Gaming H570-PRO WIFI](https://www.asus.com/us/motherboards-components/motherboards/tuf-gaming/tuf-gaming-h570-pro-wifi/)
- **CPU:** [Intel 11400F](https://www.intel.com/content/www/us/en/products/sku/212271/intel-core-i511400f-processor-12m-cache-up-to-4-40-ghz/specifications.html) (6 cores, 12 threads)
- **GPU:** [GTX 1660 Ti](https://www.techpowerup.com/gpu-specs/msi-gtx-1660-ti-gaming-x.b6701)
- **RAM:** 4 x 8GB (32GB) [Corsair Vengeance LPX](https://www.corsair.com/us/en/p/memory/cmk16gx4m2d3600c16/vengeancea-lpx-16gb-2-x-8gb-ddr4-dram-3600mhz-c16-memory-kit-black-cmk16gx4m2d3600c16) 3600 CL16 DDR4 (UPC: 840006637165)
- **LAN:** Realtek 2.5GbE (wi-fi and ethernet built into motherboard)
- **PSU:** [MSI MPG A750GF](https://www.msi.com/Power-Supply/MPG-A750GF) (750W Gold)

## Storage

| Name  | Type | Drives                                        | Usable Size                                       | Use                                |
| ----- | ---- | --------------------------------------------- | ------------------------------------------------- | ---------------------------------- |
| pve   | LVM  | 1 x PC711 NVMe SK hynix 512GB                 | 512 GB total, 374 GB available for non-system use | OS, VM/LXC disks, and fast storage |
| flash | LVM  | 1 x Lexar_SSD_NS100_512GB                     | 512 GB                                            | VM/LXC disks and fast storage      |
| tank  | ZFS  | 2 x 14TB WDC_WUH721414ALE6L4 in Raid 1 mirror | 14TB                                              | Mass / cold storage                |

- **Local Backup:** Proxmox Backup Server
- **Remote Backup:** VM and LCX data backed up to Restic repository using Backrest GUI. Repo stored on Dropbox, made accessible using Rclone. The configuration of PVE itself is not backed up (yet).
