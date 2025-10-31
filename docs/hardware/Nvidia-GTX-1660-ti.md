# Nvidia GTX 1660 Ti

## Overview

The Nvidia GTX 1660 Ti is a GPU with 6GB of GDDR6 VRAM. It provides video out for my main server, and is also capable of transcoding, and smaller machine learning tasks.

## Specifications

- **Date Acquired:** Summer 2024
- **Model Name:**  GeForce GTX 1660 Ti GAMING X 6G
- **UPC:** 0824142178553
- [More Info](https://us.msi.com/Graphics-Card/GeForce-GTX-1660-Ti-GAMING-X-6G/Specification)

## Purpose in the Homelab

- **Hardware-Accelerated Machine Learning:** Reduces CPU load by performing accelerated machine learning tasks (e.g. Facial Recognition) for apps like Immich
- **Transcoding:** Reduces CPU load by performing accelerated transcoding for apps such as Immich and Jellyfin
- **Graphics Processing for Game Servers:** The Single Player Tarkov dedicated client runs much better with access to a GPU. This requires installing the NVIDIA Container Toolkit.
- **Video Out:** Original purpose, to provide graphics for 11400F, which has no iGPU

## Integration / Placement

This GPU is installed in my main Proxmox server.
