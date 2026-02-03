# add ups to home assistant

## Add Network UPS Tools Addon

First, [find vendor id of UPS devices](find%20vendor%20id%20of%20UPS%20devices.md)

## Add Network UPS Tools Integration

## Create Helper - Sensor Template for UPS

Settings > Helpers > Create Helper > Template

**Name:** [Descriptive name for your UPS] Real Load

**State (may be under `template options`):**

```yml
{{ ( states('sensor.[Descriptive name for your UPS]_load')|float(0) * 0.01 * 330 /0.75 )|round(2) }}
```

**Unit of measurement:** W

**Device Class:** Power

**State Class:** Measurement

**Device:** UPS you integrated during [Add Network UPS Tools Integration](#Add%20Network%20UPS%20Tools%20Integration)

**Advanced options > Availability template:**

```yml
{{ has_value('sensor.[Same descriptive name for your UPS]_load') }}
```

Preview should look like this:

![](../../../assets/add%20ups%20to%20home%20assistant/Pasted%20image%2020260202223543-add%20ups%20to%20home%20assistant-20260202223543734.jpg)

## Create Helper - Integral Sensor for UPS

Settings > Helpers > Create Helper > Integral Sensor

**Name:** [Descriptive name for your ups] UPS

**Input Sensor:** Sensor you configured during [Create Helper - Sensor Template for UPS](#Create%20Helper%20-%20Sensor%20Template%20for%20UPS)
- In this example, `Proxmox UPS Real Load`

**Integration method:** Left Riemann sum

**Precision:** 2

**Metric prefix:** k (kilo)

**Time unit:** Hours
