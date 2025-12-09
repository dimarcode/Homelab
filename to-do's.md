# To-Do's

## Komodo / Ansible checklist

### Configure ansible control nodes

- Configure control nodes (media and servarr) to allow Komodo installation with Ansible role
- Install Komodo periphery on control nodes

### Create stacks in Komodo

- [Stacks checklist](#Stacks%20checklist)

1. Create stack in Komodo
2. Transfer compose.yaml from pre-existing stack located on vm/lxc
3. Update env variables in compose.yaml to be app specific
	1. Ex. TS_AUTHKEY -> IMMICH_TS_AUTHKEY
4. Create corresponding secrets in Komodo
5. Create corresponding env variables in Komodo

### Deploy stacks

TEST FIRST WITH EXISTING STACK SON TESTING LXC:


1. Create appdata folder for app data that compose files can point to
2. Transfer existing data to appdata folder
3. Deploy stacks after updating
4. Ensure functionality

### Next steps

- Webhooks
- Automate Komodo server installation

### Stacks checklist

#### Media vm

Path to docker files:

```
/opt/appdata/<app>
```

| App              | Host    | Stack created | compose.yaml | paths correct (`/opt/appdata/<app>`) | secrets | env variables |
| ---------------- | ------- | ------------- | ------------ | ------------------------------------ | ------- | ------------- |
| immich           | Media   | x             | x            | x                                    | x       | x             |
| jellyfin         | Media   | x             | x            | x                                    | x       | x             |
| karakeep         | Media   | x             | x            | x                                    | x       | x             |
| linkwarden       | Media   | x             | x            | x                                    | x       | x             |
| mealie           | Media   | x             | x            | x                                    | x       | x             |
| nextcloud        | Media   |               |              |                                      |         |               |
| paperless-ngx    | Media   |               |              |                                      |         |               |
| syncthing        | Media   | x             | x            | x                                    | x       | x             |
| tsdproxy         | Media   |               |              |                                      |         |               |
| backrest-media   | Media   | x             | x            | x                                    | x       | x             |
| backrest-ansible | Ansible | x             | x            | x                                    | x       | x             |
| homepage         | Ansible | x             | x            | x                                    | x       | x             |
| komodo           | Ansible |               |              |                                      |         |               |
| arr-stack        | Servarr |               |              |                                      |         |               |

### Ansible vm

Path to docker files:

```
/opt/appdata/<app>
```

| App              | Docker-compose | secrets | env variables |
| ---------------- | -------------- | ------- | ------------- |
| homepage         |                |         |               |
| komodo           |                |         |               |
| backrest-ansible |                |         |               |

### Servarr

Path to docker files:

```
/mnt/nvme-thin/docker
```

| App              | Docker-compose | secrets | env variables |
| ---------------- | -------------- | ------- | ------------- |
| arr-stack        |                |         |               |
| backrest-servarr |                |         |               |
