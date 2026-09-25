# cheat sheet

Find your active interface name and ip

```shell
network info
```

Set a static ip and gateway

```shell
network update <interface> --ipv4-method static --ipv4-address <IP_ADDRESS/NETMASK> --ipv4-gateway <NEW_GATEWAY_IP> --ipv4-nameserver <DNS_IP>
```

Example

```shell
network update end0 --ipv4-method static --ipv4-address 192.168.50.100/24 --ipv4-gateway 192.168.50.1 --ipv4-nameserver 1.1.1.1
```
