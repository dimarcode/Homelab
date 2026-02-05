# configure backrest

SOURCE: Clipped from https://www.linuxserver.io/blog/backup-your-data-to-b2-with-restic-and-backrest written by Josh Stark and originally published 19th-April-2025. I followed their instructions exactly, but I shortened their article.

This uses the following tools:

- [restic](https://restic.net/), a tool which has gained popularity for its configurablilty and performance. This manages the physical backups, including snapshots, ecnryption and file change detection.
- [Backrest](https://github.com/garethgeorge/backrest), a Web UI which orchestrates calls to restic, and allows for scheduled backup configuration.

## Set up Backrest

Backrest docker compose:

```yml
name: backrest-template # with rclone config
services:
  backrest-media:
    image: garethgeorge/backrest:latest
    container_name: backrest-media
    hostname: backrest-media
    volumes:
      - ./appdata/data:/data
      - ./appdata/config:/config
      - ./appdata/cache:/cache

      # Backup directories below here
      - /example-backup-directory:/userdata/example-backup-directory
    environment:
      - BACKREST_DATA=/data
      - BACKREST_CONFIG=/config/config.json # path for the backrest config file.
      - XDG_CACHE_HOME=/cache  improves performance.
      - TZ=America/New_York
    restart: unless-stopped
    ports:
      - 9898:9898
```

- I keep container configuration in the `/opt/appdata/<app>` directory
	- For this container `/opt/appdata/backrest`)
- Mount each directory you want to back up like:
	- `<folder-being-backed-up>:/userdata/<folder-being-backed-up>` 
- For example, if I want to back up `/home/dimarcode/documents` I would mount:
	- `/home/dimarcode/documents:/userdata/documents`

You may also wish to configure your `TZ` environment variable depending on your local time zone.

## Set up Backrest

### Set up an instance ID and user

![Screenshot%202025-04-15%20at%2016.42.33](https://www.linuxserver.io/user/pages/03.blog/backup-your-data-to-b2-with-restic-and-backrest/Screenshot%202025-04-15%20at%2016.42.33.png "Screenshot%202025-04-15%20at%2016.42.33")

When Backrest starts up for the first time, you will be prompted to set up and instance ID, and a set of users. For this example I've just created the classic admin:admin account (please, *please* use a strong password). The **instance ID** is required, and identifies this instance of backrest, I believe to help it create unique identifiers for restic plans etc.

Next: 
- [Backup your data to B2 with restic and Backrest - LinuxServer.io](Backup%20your%20data%20to%20B2%20with%20restic%20and%20Backrest%20-%20LinuxServer.io.md)
- Create a backup plan
