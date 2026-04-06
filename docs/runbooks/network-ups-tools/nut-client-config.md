# nut-config

Resources:
- https://technotim.com/posts/NUT-server-guide/

##


This is a WORK IN PROGRESS and has not been implemented. At this moment, it should only be considered notes.

**1. On the HA NUT add-on side**, make sure you have a user configured with `upsmon` set to `slave`:

```yaml
users:
  - username: upslave
    password: yourpassword
    upsmon: slave
```

>[!note] Note the hostname shown on the add-on's Info tab — you'll need it.

**2. On your server**, install NUT client:

```bash
sudo apt install nut-client
```

**3. Configure `/etc/nut/upsmon.conf`** on your server:

```bash
MONITOR myups@<HA-hostname>:3493 1 upslave yourpassword slave
SHUTDOWNCMD "/sbin/shutdown -h now"
```

**4. Set `/etc/nut/nut.conf`** on your server:

```bash
MODE=netclient
```

**5. Start and enable the service:**

```bash
sudo systemctl enable nut-client
sudo systemctl start nut-client
```
