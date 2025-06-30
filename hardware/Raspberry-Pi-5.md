# Raspberry Pi 5

## Overview

This Raspberry Pi 5 runs a bare metal installation of Home Assistant OS and functions as the primary smart home hub in my homelab.

## Specifications

- **Model Name:** Raspberry Pi 5 (8GB)
- **OS:** Home Assistant OS
- **CPU:** Broadcom BCM2712 – 2.4GHz quad-core 64-bit Arm Cortex-A76
- **GPU:** VideoCore VII, supporting OpenGL ES 3.1 and Vulkan 1.2
- **Memory:** 8GB LPDDR4X-4267 SDRAM
- **LAN:** Gigabit Ethernet
- **Power:** Supplied via PoE+ using a UniFi USW Flex 2.5G PoE switch  
- [More Info](https://www.raspberrypi.com/products/raspberry-pi-5/)

### Add-Ons

- **PoE+ HAT with M.2 NVMe (2280):** Provides power over Ethernet and adds NVMe storage.
- **Storage:** 500GB WD Red SN700 NVMe (WDS500G1R0C)

## Role in the Homelab

- **Smart Home Hub:** Runs Home Assistant OS to integrate, automate, and control a wide variety of IoT devices. Acts as a centralized controller for Govee lights, smart plugs, and other home automation hardware.

## Integration / Placement

Mounted on top of my mini-rack for easy PoE access via the USW Flex switch. Connected to various IoT devices on the network to provide responsive and centralized smart home functionality.
