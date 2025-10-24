# smb

## Server-side

Install samba:

```bash
apt update
apt install samba
```

Create a shared directory:

```bash
mkdir -p /srv/smb/shared
```

Configure `/etc/samba/smb.conf`:

```bash
sudo nano /etc/samba/smb.conf
```

```
[shared]
   path = /srv/smb/shared
   browseable = yes
   read only = no
   guest ok = yes
```

## Client-side

### Create .smbcredentials file

1. Create the file (usually in your home directory):

```bash
sudo nano ~/.smbcreds
```

2. Add these two lines inside:

```bash
username=your_samba_username
password=your_samba_password
```

3. Secure the file permissions:

```
chmod 600 ~/.smbcreds
```

### Mount the share

Mount command if using smb credentials file:

```bash
sudo mount -t cifs //<source-ip>/<source-share> /<local-path> -o credentials=/<path>/.smbcredentials,uid=XXXX,gid=XXXX,defaults
```

Mount command if NOT using smb credentials file:

```
sudo mount -t cifs //<source-ip>/<source-share> /<local-path> -o username=<smb-username>,password=<smb-password>,uid=XXXX,gid=XXXX,defaults
```
