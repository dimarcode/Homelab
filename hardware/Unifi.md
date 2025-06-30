# UniFi Network Infrastructure

## Overview

This document outlines the Ubiquiti UniFi hardware used across my homelab and home network. These devices provide wired switching, PoE delivery, wireless access, and gateway-level routing for both homelab and personal traffic.

## UCG-Fiber

Desktop 10G Cloud Gateway with integrated 4-port 2.5 GbE switch, selectable NVR storage, and full UniFi application support.

- **Model:** [Cloud Gateway Fiber](https://store.ui.com/us/en/category/cloud-gateways-compact/collections/cloud-gateway-fiber/products/ucg-fiber)
- **Role:** Primary internet gateway, host for UniFi Console, and DHCP/DNS provider for the home network
- **Placement:** Mounted at entry point near modem
- **Power:** Powered via adapter
- **Notes:** Eliminates the need for a Cloud Key, Dream Machine, or third-party device for UniFi Console

## USW Flex 2.5G PoE

Flexible, 8-port 2.5 GbE PoE++ switch with a 10 GbE RJ45/SFP+ combination uplink port that can be powered with PoE+++ or an AC power adapter.

- **Model:** [Switch Flex 2.5G PoE](https://store.ui.com/us/en/category/switching-utility/products/usw-flex-2-5g-8-poe?variant=usw-flex-2dot5g-8-poe)
- **Role:** Core PoE switch for homelab and network backbone
- **Placement:** Mounted in networking rack
-  **Ports:**
	- 1 x 10GbE RJ45 with PoE+++ (input)
	- 1 x 10G SFP+ (uplink to UCG-Fiber)
	- 8 x 2.5GbE RJ45 with PoE+++ (output)
- **Power (input):** TRENDnet 10G PoE++ Injector ([TPE-319GI](https://www.trendnet.com/products/10g-poe-injector/10g-poeplusplus-injector-TPE-319GI)), which is then connected to APC UPS for power backup
- **Power (output):** 
	- 76W with current POE injector
	- Powers:
		- U7-IW
		- Flex Mini 2.5G
		- Flex Mini 1G

## Access Point U7 In-Wall

Wall-mounted WiFi‎ 7 AP with 4 spatial streams and an integrated 2.5 GbE PoE switch designed for hospitality environments.

- **Model:** [UniFi U7 In-Wall](https://store.ui.com/us/en/category/wifi-wall/products/u7-iw?variant=u7-iw-us)
- **Role:** Wireless access point with POE+ input and output
- **Placement:** Installed on bookshelf (stand from [this seller](https://www.etsy.com/shop/SimpliMadeUK?section_id=1), sold out at the time of this edit)
- **Power:** Powered via PoE+ from USW Flex 2.5G PoE
- **Features:**
  - Wi-Fi 7 support
  - 1 x 2.5 GbE uplink (PoE in)
  - Built-in 2-port switch (including 1 PoE out)
- **Notes:** I live in a 1BR apartment so cutting a whole in my wall was not an option. It turns out the screw-holes on the mounting plate on the U7 match the U6-IW, so I purchased one of those.

## USW Flex Mini 2.5G

- **Model:** [Switch Flex Mini 2.5G](https://store.ui.com/us/en/category/switching-utility/products/usw-flex-2-5g-5?variant=usw-flex-2dot5g-5)
- **Role:** Compact desktop switch for local devices
- **Placement:** On desk for routing traffic between PC, printer, and Raspberry Pi
- **Power:** PoE from USW Flex 2.5G PoE
- **Ports:** 5 x 2.5GbE (Including 1 for PoE and uplink)

## USW Flex Mini

- **Model:** [Switch Flex Mini](https://store.ui.com/us/en/category/switching-utility/products/usw-flex-mini?variant=usw-flex-mini)
- **Role:** Small-form switch for low-bandwidth devices
- **Placement:** Behind media center for TV, console, and streaming box
- **Power:** PoE from USW Flex 2.5G PoE
- **Ports:** 5 x 1GbE (including 1 for uplink)

## Network Layout Notes

- All devices are managed via UniFi Controller on Cloud Gateway Fiber.
- VLANs are configured for homelab isolation, IoT devices, and guest Wi-Fi.
- USW Flex 2.5G PoE serves as primary PoE distributor for AP and Pi5.
