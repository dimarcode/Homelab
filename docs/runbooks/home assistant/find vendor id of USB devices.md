# find vendor id of UPS devices

### Checking Vendor ID and Product ID on Linux

Linux users have multiple ways to identify their USB devices using terminal commands:

#### Method 1: Using lsusb Command

**1. Open Terminal:** Connect your USB device and open a terminal window.

**Run** `lsusb`:  

```bash
lsusb
```

This will display a list of connected USB devices. 

The output might look like:  

```yaml
Bus 002 Device 003: ID 1234:5678 Manufacturer_Name Product_Name
```

2. The **ID 1234:5678** contains the **Vendor ID (1234)** and **Product ID (5678)**.

#### Method 2: Using dmesg Command

You can also use the dmesg command to get detailed system messages:

**Run** dmesg:  
bash  
Copy code  
dmesg | grep -i usb

1. This will display USB-related system messages, which can include VID and PID information for connected devices.
