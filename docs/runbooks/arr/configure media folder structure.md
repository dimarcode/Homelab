# Folder Structure

Taken from [TRaSH Guides](https://trash-guides.info/File-and-Folder-Structure/)

```bash
data
├── torrents
│   ├── books
│   ├── movies
│   ├── music
│   └── tv
├── usenet
│   ├── incomplete
│   └── complete
│       ├── books
│       ├── movies
│       ├── music
│       └── tv
└── media
    ├── books
    ├── movies
    ├── music
    └── tv
```

## Create folders via CLI

From within root of media folder:

```bash
mkdir -p torrents/{books,movies,music,tv} && mkdir -p usenet/incomplete && mkdir -p usenet/complete/{books,movies,music,tv} && mkdir -p media/{books,movies,music,tv}
```

From root of wherever docker stack will go:

```bash
mkdir -p servarr/{gluetun,qbittorrent,nzbget,prowlarr,sonarr,radarr,lidarr,bazarr,readarr}
```
