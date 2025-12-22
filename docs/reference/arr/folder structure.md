# Folder Structure

Taken from [TRaSH Guides](https://trash-guides.info/File-and-Folder-Structure/)

```bash
mkdir -p torrents/{books,movies,music,tv} && mkdir -p usenet/incomplete && mkdir -p usenet/complete/{books,movies,music,tv} && mkdir -p media/{books,movies,music,tv}
```

```
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

```bash
mkdir -p docker/servarr/{gluetun,qbittorrent,nzbget,prowlarr,sonarr,radarr,lidarr,bazarr,readarr}
```
