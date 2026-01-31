# manage-ssh-keys

[www.ssh.com](https://www.ssh.com/academy/ssh/copy-id)

## generate ssh key

With [OpenSSH](https://www.ssh.com/academy/ssh/openssh), an SSH key is created using [ssh-keygen](https://www.ssh.com/academy/ssh/keygen). In the simplest form, just run `ssh-keygen` and answer the questions. The following example illustates this.

```bash
ssh-keygen
```

Creating a key pair (public key and private key) only takes a minute. The key files are usually stored in the `~/.ssh` directory.

### example

Create an ssh key with custom name *id_ed25519_ansible* with comment "*ansible-control*":

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_ansible -C "ansible-control"
```

## transfer ssh key to server

Once an SSH key has been created, the `ssh-copy-id` command can be used to install it as an [authorized key](https://www.ssh.com/academy/ssh/authorized-key) on the server. Once the key has been authorized for SSH, it grants access to the server without a password.

Use a command like the following to copy SSH key:

```bash
ssh-copy-id -i ~/.ssh/mykey user@host
```

## test the new key

Once the key has been copied, it is best to test it:

```bash
ssh -i ~/.ssh/mykey user@host
```

The login should now complete without asking for a password. Note, however, that the command might ask for the passphrase you specified for the key.

## view fingerprint generated from ssh key

```bash
ssh-keygen -lf /path/to/ssh/key
```
