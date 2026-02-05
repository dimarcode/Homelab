# Runbook: Add UPS to Home Assistant (NUT)

## 1. Overview

This runbook documents how to:

1. Install and configure the **Network UPS Tools (NUT) Add-on**
2. Add the **NUT integration**
3. Create helper sensors for:
    - Real power calculation
    - Energy (kWh) tracking

**Home Assistant Version:** 2026.1.3
Reference: https://www.home-assistant.io/integrations/nut/

## 2. Prerequisites

- UPS connected via USB to Home Assistant host
- Vendor ID identified (see: [find vendor id of USB devices](find%20vendor%20id%20of%20USB%20devices.md))
- Wattage of your UPS identified
- Desired display name for UPS (used consistently below)

## 3. Install and Configure NUT Add-on

### 3.1 Install Add-on

Path:

`Settings > Add-ons > Add-on Store > Network UPS Tools > Install`

### 3.2 Configure Add-on

#### 3.2.1 Set Mode

**mode:** netserver

#### 3.2.2 Create User

##### YAML Configuration

```yml
users:
  - username: <nut_username>
    password: "<nut_password>"
    instcmds:
      - all
    actions: []

mode: netserver
shutdown_host: false
```

##### GUI Path

`Settings > Add-ons > Network UPS Tools > Configuration > Users > Add`

Required:
- Username
- Password

#### 3.2.3 Add UPS Devices

First, determine the Vendor ID:
- See: [find vendor id of USB devices](find%20vendor%20id%20of%20USB%20devices.md)

##### YAML example

```yaml
devices:
  - name: APC-BE600M1-BackUPS
    driver: usbhid-ups
    port: auto
    config:
      - vendorid = 051d

  - name: CyberPower-CP1500VA-UPS
    driver: usbhid-ups
    port: auto
    config:
      - vendorid = 0764
```

Optional: set `power value` to 1 if the UPS is powering the Home Assistant host

##### GUI Path

`Settings > Add-ons > Network UPS Tools > Configuration > Devices > Add`

### 3.3 Start Add-on

Click **Start** and confirm:
- Add-on status = Running
- No startup errors in logs

### 3.4 Record Hostname

Path:  
`Add-on > Info > Hostname`

You will need:
- Hostname
- Username
- Password
- Port (default: 3494)

## 4. Add NUT Integration

Path:  
`Settings > Devices & Services > Integrations > Add Integration > Network UPS Tools`

Configuration:
- **Host:** <addon_hostname>
- **Port:** 3494 (default)
- **Username:** <nut_username>
- **Password:** <nut_password>
- Select the UPS device(s) to add.
- Verify sensors populate under the device

## 5. Create Helper – Real Load Sensor

Purpose: Convert UPS load percentage to estimated real wattage.

Path:  
`Settings > Helpers > Create Helper > Template`

### 5.1 Configure Real Load Sensor

| Field               | Value                                                                              |
| ------------------- | ---------------------------------------------------------------------------------- |
| Name                | `<UPS Name> Real Load` <br><br>example:<br><br>`CyberPower-CP1500VA-UPS_Real-Load` |
| Unit of Measurement | W                                                                                  |
| Device Class        | Power                                                                              |
| State Class         | Measurement                                                                        |

#### State Template:

>[!important]
>You must adjust:
>- `sensor.<ups_name>_load` -> Replace with your actual UPS load sensor
>- Maximum UPS real power (in watts) -> Either enter manually or use the `nominal_real_power` sensor
>- Efficiency divisor (if you don't know, use 0.75) See explanation below

##### Option A — Manual Max Watt Rating

- Use this if your UPS does not expose `nominal_real_power`.
- Replace `<max_watts>` with the UPS real power rating (e.g., 330).

```yaml
{{ ( 
	states('sensor.<ups_name>_load') | float(0) 
	* 0.01 
	* <max_watts> 
	/ 0.90 
	) | round(2) }}
```

Example (330W UPS):

```yaml
{{ ( 
	states('sensor.<ups_name>_load') | float(0) 
	* 0.01 
	* 330
	/ 0.90 
	) | round(2) }}
```

##### Option B — Use UPS Nominal Real Power Sensor

- Use this if your UPS exposes `sensor.<ups_name>_nominal_real_power`:

```yaml
{{ ( 
	states('sensor.<ups_name>_load') | float(0) 
	* 0.01 
	* states('sensor.<ups_name>_nominal_real_power') | float(0) 
	/ 0.90 
	) | round(2) }}
```

**Availability Template:**

```yaml
{{ has_value('sensor.<ups_name>_load') }}
```

Verify the preview shows a numeric watt value:

![](assets/add%20ups%20to%20home%20assistant/file-20260204230540418.png)

## 6. Create Helper – Energy (kWh) Sensor

Purpose: Track total energy consumption over time.

Path:  
`Settings > Helpers > Create Helper > Integral Sensor`

### Configuration

| Field              | Value                        |
| ------------------ | ---------------------------- |
| Name               | `<UPS Name> Energy Consumed` |
| Metric Prefix      | k                            |
| Time Unit          | Hours                        |
| Input Sensor       | `<UPS Name> Real Load`       |
| Integration Method | Left Riemann Sum             |
| Precision          | 2                            |

Result: Energy tracked in kWh.

## 7. Add UPS to `Energy` page in Home Assistant

Path:
`Energy > edit dashboard > Grid consumption > + Add consumption`

Result: you should now see a graph of your overall electricity usage displayed on the `Energy` page
