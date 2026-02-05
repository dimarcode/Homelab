# nmap

Normal scan with no arguments:

```shell
nmap <your public ip>
```

Scan all 1000 commonly used ports, while bypassing ping test:

```shell
nmap -Pn <your public ip>
```

Do the same, but check ports 80 (http) and 443 (https) specifically

```shell
nmap -Pn -p 80,443 <your_public_ip>
```
