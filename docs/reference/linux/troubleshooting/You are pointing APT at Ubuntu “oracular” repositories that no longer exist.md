# You are pointing APT at Ubuntu “oracular” repositories that no longer exist

Error: 

```bash
Error: The repository 'http://archive.ubuntu.com/ubuntu oracular Release' no longer has a Release file.
Notice: Updating from such a repository can`t be done securely, and is therefore disabled by default.
Notice: See apt-secure(8) manpage for repository creation and user configuration details.
```

Solution:

## Step 1 — Confirm your OS codename

Run:

`lsb_release -a`

or:

`cat /etc/os-release`

Note the value of `VERSION_CODENAME=`.

## Step 2 - Move your system to new distro

Update your sources to noble:

```bash
sudo sed -i 's/oracular/noble/g' /etc/apt/sources.list
```

```bash
sudo sed -i 's/oracular/noble/g' /etc/apt/sources.list.d/*.list`
```

Then run:

```bash
sudo apt update && sudo apt full-upgrade
```

Reboot:

```bash
sudo reboot
```

Then check:

```bash
uname -a
cat /etc/os-release
```

Update if needed. This effectively migrates you to **24.04 LTS**.
