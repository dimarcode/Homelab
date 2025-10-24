# User Management

Other than a few small additions, all credit for this cheat-sheet goes to [Christian Lempa](https://github.com/ChristianLempa/cheat-sheets)

| Command                                  | Description                                                      |
| ---------------------------------------- | ---------------------------------------------------------------- |
| `sudo adduser <user>`                    | Create a new user                                                |
| `sudo userdel <user>`                    | Delete a user                                                    |
| `sudo usermod -aG <group> <user>`        | Add a user to group                                              |
| `sudo useradd <user> -u <UID> -g <GID> ` | Add a user with specified UID and GID (group must already exist) |
| `sudo deluser <user> <group>`            | Remove a user from a group                                       |
| `mkhomedir_helper <user>`                | Create a home directory (must not already exist)                 |
| `passwd`                                 | Set password (self)                                              |
| `passwd <user>`                          | Set password for specified user (must be root)                   |

# Group Management

| Command                          | Description                           |
| -------------------------------- | ------------------------------------- |
| `sudo groupadd -g <GID> <group>` | Create a new group with specified GID |
